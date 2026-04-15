/* ======================================================================= */
/* File Name 		: 	isr.c       									   */
/* Description  : 	__interrupt service handler							   */
/* Body         : 	GPL815P series 6502 CPU						     	   */
/* Toolchain    : 	gp65cc Compiler V0.9x								   */
/* Date         : 	2014/09/09											   */
/* Author       :  														   */
/* Version      :   1.1.0       										   */
/* ======================================================================= */

#include "GPL815P.h"
#include "Variable.h"
#include "System.h"
#include "lcd\lcd_user.h"
#include	"UART\UART_Code.h"
#include	"UART\UART_Rx.h"
#include "KEYSCAN\key_user.h"

/* 语音模块固定使用 9 字节帧，接收超时后丢弃半包，避免旧字节残留。 */
#define UART_FRAME_LEN			9
#define UART_RX_TIMEOUT_TICKS	4

/* 128Hz 基准下的半包超时计数。 */
static unsigned char g_uart_rx_timeout_ticks = 0;
/*Declaratins*/
void V_IRQ_EXT1(void)	  __interrupt (IRQ_EXT1);	
void V_IRQ_EXT2(void)	  __interrupt (IRQ_EXT2);		
void V_IRQ_ADC(void)	  __interrupt (IRQ_ADC);	
void V_IRQ_TM0(void)	  __interrupt (IRQ_TM0);	
void V_IRQ_TM1(void)	  __interrupt (IRQ_TM1);
void V_IRQ_SWT(void)	  __interrupt (IRQ_SWT);	
void V_IRQ_TBH(void)	  __interrupt (IRQ_TBH);
void V_IRQ_TBL(void)	  __interrupt (IRQ_TBL);	
void V_IRQ_FP(void)		  __interrupt (IRQ_FP); 	
void V_IRQ_KEY(void)	  __interrupt (IRQ_KEY);	
void V_IRQ_SPI(void)	  __interrupt (IRQ_SPI); 
void V_IRQ_RFC_TM0(void)  __interrupt (IRQ_RFC_TM0);
void V_IRQ_RFC_TM1(void)  __interrupt (IRQ_RFC_TM1); 
void V_IRQ_UART(void)     __interrupt (IRQ_UART);
void V_IRQ_PWMTM(void)    __interrupt (IRQ_PWMTM); 
void V_IRQ_I2C(void)	  __interrupt (IRQ_I2C);
void V_IRQ_LVD(void)	  __interrupt (IRQ_LVD);
void V_IRQ_Capture(void)  __interrupt (IRQ_Capture);  


#pragma save
#pragma nooverlay
void V_NMI(void) __interrupt;

void V_IRQ_EXT1(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_EXT2(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_ADC(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_TM0(void) __interrupt
{
//	P_INT_TM0_Clear = 0;
//}	
}
void V_IRQ_TM1(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_SWT(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_TBH(void) __interrupt
{
	P_TIMER_TimeBase_Status = D_128Hz_Flag;
	P_INT_TBH_Clear = 0;
	RB_128hz_counter++;
    R_DebounceCnt     = (R_DebounceCnt > 0)     ? (R_DebounceCnt - 1)     : 0;
    R_LongKeyTime     = (R_LongKeyTime > 0)     ? (R_LongKeyTime - 1)     : 0;
    R_CodeDebounce    = (R_CodeDebounce > 0)    ? (R_CodeDebounce - 1)    : 0;	
	if(R_DelayOpen > 0)
	{
	R_DelayOpen--;
	   if (R_DelayOpen == 0)
		{	
			R_Uart_OpenTime = D_UI_Time;
			R_OtherFlag |= D_Urat_Open;
			R_VoiceFlag |= D_OpenReady;
			    CLOCK_FLAG_ASR = 1;	//语音标志位
			}
		}  
//	if(R_DelayTemp > 0)
//	{
//	R_DelayTemp--;
//	   if (R_DelayTemp == 0)
//		{	
//			R_SpecFlag |= D_DelayReady;
//			}
//		}

	if (R_KeepAwakeTimer > 0)
	{
		R_KeepAwakeTimer--;
	}

	if ((R_UART_CNT > 0) && (R_UART_CNT < UART_FRAME_LEN))
	{
		/* 只对半包数据计时，超时后直接清空，等下一帧重新开始。 */
		if (g_uart_rx_timeout_ticks > 0)
		{
			g_uart_rx_timeout_ticks--;
			if (g_uart_rx_timeout_ticks == 0)
			{
				R_UART_CNT = 0;
			}
		}
	}
	else
	{
		g_uart_rx_timeout_ticks = 0;
	}

	RB_128HzTo32Hz_count++;
	if (RB_128HzTo32Hz_count>3)
	{
		RB_128HzTo32Hz_count = 0;
		P_INT_Status2 = D_RFCTM0_Flag;		
		P_INT_Ctrl2 |= D_RFCTM0IntEn;
//		F_RfcIntSvc();	//32hz cdyh
	}
}
void V_IRQ_TBL(void) __interrupt
{
	P_TIMER_TimeBase_Status = D_2Hz_Flag;

	P_INT_TBL_Clear = 0;
	R_Second_Temp++;
	R_flash_Temp++;
	if (R_flash_Temp>1)
	{
		R_flash_Temp = 0;
	}
}
void V_IRQ_FP(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_KEY(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_SPI(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_RFC_TM0(void) __interrupt
{
// _WDT_Clear = 0x00;

// 	P_INT_Status2 = D_RFCTM0_Flag;
	
// 	P_INT_RFCTM0_Clear = D_RFCTM0_Flag;
	
//	F_RFC_ISR();		//data vxqu

//	R_Operating_Flag ^= 0x40;
	


}
void V_IRQ_RFC_TM1(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_UART(void) __interrupt
{
	P_INT_Status3 = D_UART_Flag;
		while(!(P_UART_Status2 & D_UARTRxFIFOEmpty))
		{
			P_WDT_Clear = 0x00;
//			StatusBuff[R_UART_CNT] = P_UART_RX_Status;
			if (R_UART_CNT < UART_FRAME_LEN)
			{
				/* 仅保留一帧长度，收到新字节就刷新半包超时窗口。 */
				UART_RxBuffer[R_UART_CNT] = P_UART_Data;
				R_UART_CNT++;
				g_uart_rx_timeout_ticks = UART_RX_TIMEOUT_TICKS;
			}
			else
			{
				/* 超过 9 字节的冗余数据直接丢弃，防止覆盖当前帧缓存。 */
				(void)P_UART_Data;
			}
		}
		
		F_UART_GetStatus();		
//==下面的status非必须，只是测试中拿来将状态保存下来观察通讯稳定性
		P_UART_RX_Status = D_OverrunErrorFlag | D_BreakErrorFlag | D_ParityErrorFlag | D_FrameErrorFlag;
		P_INT_Status3 = D_UART_Flag;
}


void V_IRQ_PWMTM(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_I2C(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_LVD(void) __interrupt
{
	/* Add your code here */
}
void V_IRQ_Capture(void) __interrupt
{
	/* Add your code here */
}
void V_NMI(void) __interrupt
{
	/* Add your code here */  
} 
#pragma restore

extern void V_RESET(void);
#pragma	xconstsec	INT_VEC
const int	Int_Vec[2] = {(int)&V_NMI, (int)&V_RESET};

