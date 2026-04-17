/* ======================================================================= */
/* File Name 		: 	isr.c       									   */
/* Description  : 	__interrupt service handler							   */
/* Body         : 	GPL815P series 6502 CPU						     	   */
/* Toolchain    : 	gp65cc Compiler V0.9x								   */
/* Date         : 	2024/09/09											   */
/* Author       :  														   */
/* Version      :   1.1.0       										   */
/* ======================================================================= */

#include "GPL815P.h"
#include "Variable.h"
#include "KEYSCAN\key_user.h"
#include "Timer\Timer.h"
#include "UART\UART_Rx.h"

#define CHARGE_WAKEUP_MASK    0x08
#define POWER_KEY_WAKEUP_MASK 0x40

unsigned char R_Temp = 0;
unsigned char R_Wakeup_Flag2 = 0;

static void F_ConfigChargeDetectPulldown(void)
{
	P_IO_PortA_Dir &= (unsigned char)(~CHARGE_WAKEUP_MASK);
	P_IO_PortA_Attrib &= (unsigned char)(~CHARGE_WAKEUP_MASK);
	P_IO_PortA_Data &= (unsigned char)(~CHARGE_WAKEUP_MASK);
}

//=================================================
void F_SYS_PowerOnCPUInitinal(void)
{
	P_TIMER_TimeBase_Ctrl2 = D_128HzEn|D_2HzEn;
	P_TIMER_TimeBase_Status = D_128Hz_Flag|D_2Hz_Flag;
	P_TIMER_TimeBase_Ctrl1 = D_TBRST;	//reset timebase counter		
	P_TIMER_TimeBase_Ctrl1 = D_TBRUN;		//start to timebase counter
	RB_128hz_counter = 0;
	P_INT_Ctrl2 = D_TBLIntEn|D_TBHIntEn;
	enable_interrupt();
	while (RB_128hz_counter<5)
	{
		nop_instruction();
	}
	P_CLK_IOSC_Ctrl = D_SYS2M|D_CPUSysClkDiv1;	
//	P_CLK_IOSC_Ctrl = D_SYS8M|D_CPUSysClkDiv1;
	P_IO_LCDPORT_Ctrl = D_PCEn;
}

//=================================================
void	F_SYS_ClearPage0()
{
	__asm
	LDX	#00H
	LDA	#00H
	
L_STA_LOOP:
	STA	$00,X
	INX
	BNE	L_STA_LOOP	

	__endasm;
	
}

//=================================================
void	F_SYS_ClearNPage()
{
	__asm
	LDX	#00H
	LDA	#00H
	
L_STA_LOOP2:
	STA	$200,X
	STA	$300,X
	STA	$400,X
	STA	$500,X
	STA	$600,X
	STA	$700,X
	STA	$800,X
	STA	$900,X
	STA	$A00,X
	STA	$B00,X
	INX
	BNE	L_STA_LOOP2	

	__endasm;
}
//=================================================
void	F_SYS_FillDPRAM()
{
	__asm
	LDX	#35H
	LDA	#FFH
	
L_STA_LOOPd:
	STA	$2000,X
	DEX
	BNE	L_STA_LOOPd
	STA	$2000
	__endasm;
}
//=================================================
void	F_SYS_ClearDPRAM()
{
	__asm
	LDX	#35H
	LDA	#00H
	
L_STA_LOOPd1:
	STA	$2000,X
	DEX
	BNE	L_STA_LOOPd1
	STA	$2000
	__endasm;
}
//=====================================================
/*
为了演示开了2hz 128hz中断，但是中断文件.c中未有任何动作，这里根据需要自行打开中断，形式不必保持一致。
*/
void	F_InitIRQ(void)
{
	disable_interrupt();
	P_INT_Ctrl2 = 0;
	P_INT_TBL_Clear = 0;
	P_INT_TBH_Clear = 0;
	P_INT_TM0_Clear = 0;
	P_INT_KEY_Clear = 0;
	
	P_TIMER_TimeBase_Ctrl2 = D_2HzEn | D_128HzEn;

	P_TIMER_TimeBase_Ctrl1 = D_TBRST;	//reset timebase counter		
	P_TIMER_TimeBase_Ctrl1 = D_TBRUN;		//start to timebase counter
	
	P_TIMER_TM0Data_LB = 0xC0;
    P_TIMER_TM0Data_HB = 0xF7;	
	//Enable TBL INT	key   TBH
	P_INT_Ctrl2 = 	D_TBLIntEn+D_TBHIntEn;
	P_INT_Ctrl1	=	D_TM0IntEn;	
	P_TIMER_EN	=	D_TM0En;
	
	enable_interrupt();
	
}
//====================================================
/*
这个函数是实现 前面所有事件处理完成符合要求进入 省电模式是 进入 32K 低频开， PLL关闭 LCD开的 halt省电模式，此模式会在按键或者TBL唤醒后退出此函数
此时F_Afterwakeup_Proc函数里面的内容则拿来判断是那个唤醒源唤醒了IC，你再决定你要做的事情，F_Afterwakeup_Proc函数里面的if2个分支则是这个判断作用，
形式不必一样，自行根据自己的功能添加删减。
*/
void F_GreenMode(void)		//	;>>>Go to green mode into sleep 	
{		
	disable_interrupt();
	// ===LCD Disable==
//	P_LCD_Ctrl1	= 0;
//Clear Wakeup Source. GPL833F all interrupt can wake up

		P_INT_Ctrl1 = 0;
		P_INT_Ctrl2 = 0;
		P_INT_Ctrl3 = 0;	
//=======Clear Key Wakeup==========		
		P_INT_Status2 = D_Key_Flag | D_TBL_Flag;
		P_INT_KEY_Clear = D_Key_Flag | D_TBL_Flag;
//		P_INT_TBL_Clear = D_Key_Flag | D_TBL_Flag;
//		P_INT_TBH_Clear = D_Key_Flag | D_TBL_Flag | D_TBH_Flag;

		
// //=====wakeup io keep input pull ====================
// 		P_IO_PortA_Dir = 0x02;     // PA1输出
// 		P_IO_PortA_Attrib = 0;
// 		P_IO_PortA_Data = 0x00;
		
//=======Key change enable===========
		F_ConfigChargeDetectPulldown();
		P_IO_KeyChange_Ctrl1 = 0;
		P_IO_PortB_Attrib = 0x00;
		P_IO_PortB_Dir = 0x00;
		P_IO_PortB_Data = 0x01;
		
		P_IO_KeyChange_Ctrl2 = POWER_KEY_WAKEUP_MASK;	// 关机态仅保留 PB6 电源键唤醒
		R_Temp = P_IO_PortA_Data;
		R_Temp = P_IO_PortB_Data;
//=========Enable TBL 2Hz,8HZ Wakeup	TMA======
	   /* 睡眠前关掉相关io*/
//       F_Backlight_Sleep(); // 清除背光逻辑状态
//        P_IO_PortA_Data |= 0x20;	//bit5拉高
//        ;
//   		P_PWMIO_Ctrl &= ~(0x01 << 1); // 1. 关PWM模块
//		P_IO_PortA_Data &= ~0x02;     // 2. 手动拉低 PA1  			
//		CLOCK_FLAG_ASR = 0;	//语音标志位
		P_TIMER_TimeBase_Ctrl2 = D_2HzEn;

		P_INT_Ctrl2	= D_TBLIntEn | D_KeyIntEn;
		
		
//===========Go into sleeping..======================
		

		P_CLK_IOSC_Ctrl = D_SYS32K | D_CPUSysClkDiv1;
		P_SLP_Ctrl = D_GreenMode;
		nop_instruction();
		nop_instruction();
		nop_instruction();
		P_WDT_Clear = 0;
//=========cpu wakeup   setup cpu 8Mhz================
		P_CLK_IOSC_Ctrl = D_SYS2M | D_CPUSysClkDiv1;		
//		P_CLK_IOSC_Ctrl = D_SYS8M | D_CPUSysClkDiv1;
		P_WDT_Clear = 0;

}	

//void F_GreenMode(void) {
//    disable_interrupt();
//    // === UART预处理：清空缓冲区+清除错误标志 ===
//    R_Temp = P_UART_Data; // 清空接收缓冲区
//    P_UART_RX_Status = 0x0F; // 清除所有接收错误标志
//    P_INT_Ctrl3 |= 0x04; // 启用UART总中断（关键缺失）
//    
//    // === 原有的LCD禁用、中断清理、KeyChange配置 ===
//    // P_LCD_Ctrl1 = 0; // 建议取消注释禁用LCD
//    P_INT_Ctrl1 = 0;
//    P_INT_Ctrl2 = 0;
//    P_INT_Ctrl3 = 0x04; // 保留UART总中断使能
//    P_INT_Status2 = D_Key_Flag | D_TBL_Flag;
//    P_INT_KEY_Clear = D_Key_Flag | D_TBL_Flag;
//    
//    P_IO_KeyChange_Ctrl2 = 0xff;
//    R_Temp = P_IO_PortB_Data;
//    P_TIMER_TimeBase_Ctrl2 = D_2HzEn;
//    P_INT_Ctrl2 = D_TBLIntEn | D_KeyIntEn;
//    
//    // === 进入Halt模式 ===
//    P_CLK_IOSC_Ctrl = D_SYS32K | D_CPUSysClkDiv1;
//    P_SLP_Ctrl = D_GreenMode; // 确保D_GreenMode=0xA5
//    nop_instruction();
//    nop_instruction();
//    nop_instruction();
//    P_WDT_Clear = 0;
//    
//    // === 唤醒后恢复UART ===
//    P_CLK_IOSC_Ctrl = D_SYS2M | D_CPUSysClkDiv1;
//    P_UART_RX_Status = 0x0F; // 再次清除错误标志
//    	R_Temp = P_UART_Data; // 主动清空无效的FF字节
//    P_WDT_Clear = 0;
//    enable_interrupt();
//}
//========================================================
/*
这个函数是实现 前面所有事件处理完成符合要求进入 省电模式是 进入 32K 低频关， PLL关闭 LCD关闭 standby省电模式电流正常是<1uA，此模式会在按键唤醒后退出此函数
此时F_Afterwakeup_Proc函数里面的内容则拿来判断是那个唤醒源唤醒了IC，你再决定你要做的事情，F_Afterwakeup_Proc函数里面的if2个分支则是这个判断作用，
形式不必一样，自行根据自己的功能添加删减。
*/
//========================================================
 #pragma nooverlay
void F_StandbyMode(void)		//>>>Go to Standby mode into sleep 	
{	
	disable_interrupt();
	// ===LCD Disable==
		P_LCD_Ctrl1	= 0;
//Clear Wakeup Source. GPL833F all interrupt can wake up

		P_INT_Ctrl1 = 0;
		P_INT_Ctrl2 = 0;
		P_INT_Ctrl3 = 0;	
//=======Clear Key Wakeup==========		
		P_INT_Status2 = D_Key_Flag;
		P_INT_KEY_Clear = D_Key_Flag;

//=====wakeup io keep input pull ====================
		// 保证 PA1 保持输出，防止 PWM 进入非预期输入态导致占空比反向  
		P_IO_PortA_Dir = 0x22;
		P_IO_PortA_Attrib = 0;
		P_IO_PortA_Data = 0x00;		
		
		
		
//=======Key change enable===========

		P_IO_KeyChange_Ctrl1 = 0xff;
		R_Temp = P_IO_PortA_Data;
//=========Enable TBL 2Hz,8HZ Wakeup	TMA======


		P_INT_Ctrl2	= D_KeyIntEn;
		
		
//===========Go into sleeping..======================
		

		P_CLK_IOSC_Ctrl = D_SYS32K | D_CPUSysClkDiv1;
		P_SLP_Ctrl = D_SleepMode;
		nop_instruction();
		nop_instruction();
		nop_instruction();
		P_WDT_Clear = 0;
//=========cpu wakeup   setup cpu 8Mhz================
		P_CLK_IOSC_Ctrl = D_SYS2M | D_CPUSysClkDiv1;
		P_WDT_Clear = 0;

}
 //========================================================
/*
IC唤醒后的判断函数，根据需要自己做添加删减。
*/
void	F_Afterwakeup_Proc(void)
{
//============wakeup check=======================
		R_Wakeup_Flag2 = P_INT_Status2;
		if (R_Wakeup_Flag2&D_TBL_Flag)
		{
			//========== thl wakeup cpu==================
//			P_IO_PortB_Data ^= 0X01;
//				R_Second_Temp++;
		}
		
		if(R_Wakeup_Flag2&D_Key_Flag)
		{
		//=======key=wakeup cpu===============
//			P_IO_PortB_Data ^= 0X02;
//			R_KeyTemp=1;
		}
		
		disable_interrupt();
		
		P_INT_Status2 = D_Key_Flag | D_TBL_Flag;
		P_INT_KEY_Clear = D_Key_Flag | D_TBL_Flag;
		P_INT_TBL_Clear = D_Key_Flag | D_TBL_Flag;
//		P_TIMER_TimeBase_Status = D_2Hz_Flag;

		P_TIMER_TimeBase_Ctrl2 = D_128HzEn | D_2HzEn;

		// 唤醒后先关闭PWM，避免在过渡时错误反向亮度
		P_PWMIO_Ctrl &= ~D_PWMIO1En;
		R_CurrentBrightness = 0;  // 触发 F_Backlight_Process 重新同步亮度

		P_INT_Ctrl2 = D_TBLIntEn+D_TBHIntEn;
		
		enable_interrupt();
}
//================================================
/*
初始化端口，根据需要自行设定IO的状态
*/
void	F_InitPort(void)
{	
		P_IO_PortB_Attrib = 0x00;
		P_IO_PortB_Dir = 0x00;
		P_IO_PortB_Data = 0x01;
		
//=====wakeup io keep input pull ====================
		P_IO_PortA_Dir = 0x22;
		P_IO_PortA_Attrib = 0;
		P_IO_PortA_Data = 0x20;
		F_ConfigChargeDetectPulldown();
		
		P_IO_PortC_Attrib = 0x00;
		P_IO_PortC_Dir = 0x00;
		P_IO_PortC_Data = 0x01;		
}

//=======================================
// 函数：LVD初始化（配置3V检测+NMI中断）
//=======================================
void F_LVD_Init(void)
{
    //  配置LVD：启用+3.0V检测阈值
    P_LVD_Ctrl = D_LVDEn | D_LVD3P0V;
}
