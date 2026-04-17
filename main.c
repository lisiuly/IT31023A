/* ======================================================================= */
/*    File Name   : main.c                                                 */
/*    Description : main function for user program                         */
/*    Body        : GPL815P series 6502 CPU                                */
/*    Toolchain   : gp65cc Compiler V0.9x                                  */
/*    Date        : 2014/09/09                                             */
/*    Author      :                                                        */
/*    Version     : 1.0.0                                                  */
/* ======================================================================= */

#include "GPL815P.h"
#include "System.h"
#include "calendar\calendar.h"
#include "lcd\lcd_user.h"
#include	"UART\UART_Code.h"
#include "KEYSCAN\key_user.h"
#include "Timer\Timer.h"
#include "UART\UART_Rx.h"
#include "ADC\ADC.h"

#define LOW_POWER_FLOW_IDLE            0x00
#define LOW_POWER_FLOW_WAIT_READY      0x01
#define LOW_POWER_FLOW_WAIT_PLAY_DONE  0x02
#define LOW_POWER_FLOW_POWERED_OFF     0x03
/* 128Hz 时基下固定等待 5 秒后关机。 */
#define LOW_POWER_SHUTDOWN_TICKS       640

unsigned char R_KeepAwakeTimer = 0; // 保活定时器

unsigned char RB_128hz_counter = 0x00;
unsigned char R_DateMiniSecond = 0;

unsigned char NsLi_Year[2] = {0,0};
unsigned char NsLi_Month = 0;
unsigned char NsLi_Day = 0;

unsigned char RB_128HzTo32Hz_count = 0;
unsigned char RB_RFC_30S_count = 0;
unsigned char RB_ADC_50S_count = 0;

static unsigned char g_low_power_flow = LOW_POWER_FLOW_IDLE;
/* 累计低电播报后的等待时长，不再依赖语音状态回包。 */
static unsigned int g_low_power_query_ticks = 0;
static unsigned char g_low_power_last_tick = 0;
static unsigned char g_recheck_battery_after_power_on = 0;

extern	unsigned char	R_Second_Temp;

static unsigned char F_IsSystemPowerOff(void)
{
	return (R_KeyFlag & D_LCDOFF) != 0;
}

static void F_ResetLowPowerFlow(void)
{
	/* 每次退出低电流程时同步复位等待计时基准。 */
	g_low_power_flow = LOW_POWER_FLOW_IDLE;
	g_low_power_query_ticks = 0;
	g_low_power_last_tick = RB_128hz_counter;
}

static void F_ProcessLowPowerShutdown(void)
{
	unsigned char elapsed_ticks;
	unsigned char is_low_power;

	if (F_IsSystemPowerOff())
	{
		F_ResetLowPowerFlow();
		g_voice_play_status = PLAY_STATUS_STOPPED;
		return;
	}

	/* 充电插入后立即取消低电自动关机，避免边充边被拉掉电。 */
	if (R_Charge & D_Charge)
	{
		F_ResetLowPowerFlow();
		return;
	}

	is_low_power = (R_Charge & D_LowPower) != 0;

	/*
	 * ADC 每秒都会重测一次，临界电压附近可能出现一次高、一次低。
	 * 如果这里直接按瞬时采样清流程，就会回到 IDLE，下一次低电又重新播报。
	 * 因此只在“尚未开始低电关机流程”时才接受低电恢复；
	 * 一旦已经开始播报/关机，就锁存到流程结束，避免重复报警。
	 */
	if (!is_low_power && (g_low_power_flow == LOW_POWER_FLOW_IDLE))
	{
		return;
	}

	/* 首次进入低电流程时，清掉其他待播请求，避免串音。 */
	if (g_low_power_flow == LOW_POWER_FLOW_IDLE)
	{
		g_low_power_flow = LOW_POWER_FLOW_WAIT_READY;
		g_low_power_query_ticks = 0;
		g_low_power_last_tick = RB_128hz_counter;
		R_VoiceReq = 0;
		R_VoiceFlag &= ~D_WakePlay;
		g_voice_play_status = PLAY_STATUS_STOPPED;
	}

	switch (g_low_power_flow)
	{
	case LOW_POWER_FLOW_WAIT_READY:
		/* 语音模块还没 ready 时先拉起模块，ready 后再真正播“低电报警”。 */
		if ((R_VoiceFlag & D_OpenReady) == 0)
		{
			if (R_DelayOpen == 0)
			{
				Voice_PowerOn_Noxiaonao();
			}
			return;
		}

		PlaySingle(didianbaojing_SP);
		g_voice_play_status = PLAY_STATUS_PLAYING;
		g_low_power_flow = LOW_POWER_FLOW_WAIT_PLAY_DONE;
		g_low_power_query_ticks = 0;
		g_low_power_last_tick = RB_128hz_counter;
		return;

	case LOW_POWER_FLOW_WAIT_PLAY_DONE:
		/* 发出低电报警后固定等待 5 秒关机，不等语音状态回包。 */
		elapsed_ticks = RB_128hz_counter - g_low_power_last_tick;
		if (elapsed_ticks != 0)
		{
			g_low_power_last_tick = RB_128hz_counter;
			g_low_power_query_ticks += elapsed_ticks;
		}

		if (g_low_power_query_ticks >= LOW_POWER_SHUTDOWN_TICKS)
		{
			g_low_power_flow = LOW_POWER_FLOW_POWERED_OFF;
			F_SystemPowerOff();
		}
		return;

	case LOW_POWER_FLOW_POWERED_OFF:
		return;

	default:
		F_ResetLowPowerFlow();
		return;
	}
}
//=======================================
void	F_InitDateTime(void)
{		
			R_Year[0] = 0x18;
			R_Year_temp[0] = 0x18;			
			R_Year[1] = 0x14;
			R_Year_temp[1] = 0x14;
			R_Month = 0x0a;
			R_Day = 0x14;
			R_DateSecond = 0;
			R_Second_Temp = 0;
			R_DateHour = 0x00;
			R_DateMinute = 0x00;
			R_AlarmHour[0] = 0x00;
			R_AlarmHour[1] = 0x00;
			R_AlarmHour[2] = 0x00;		
			R_AlarmMinute[0] = 0x00;	
			R_AlarmMinute[1] = 0x00;	
			R_AlarmMinute[2] = 0x00;
			
			SetVolumeAndPlayAlarm1_flag = 0x01;
			R_CurrentVolume	= 0x01;	
			R_BacklightLevel = 0x03;
			
//			R_CurrentSong = 0x01;				
//			R_Alarm_ENDIS_Flag = D_Alarm_EN;
			R_LVDStatus = D_BatLevel1;	
			RB_Lcd_Updata_Flag = D_LcdUpdate;			
			F_JudegLeapYear();
			F_JudgeWeek();	
}

void F_Cheak_VDC(void)
{
    // 如果 PA5 已经是高电平，则不重复写，避免频繁操作寄存器
    if (P_IO_PortA_Data & 0x20)
    {
        return;
    }

    if ((R_OtherFlag & (D_Alarming | D_Urat_Open | D_Timering)) == 0&& (R_DelayOpen == 0))
    {
        P_IO_PortA_Data |= 0x20;    // bit5 拉高：允许背光进入休眠暗光
		F_KeepPA3InputPulldown();
        R_VoiceFlag = 0;
        CLOCK_FLAG_ASR = 0;	//语音标志位
    }
}

void F_SecondRTC(void)
{
	if (R_Second_Temp>1)
	{
		F_DC_Det();
//		F_CheckBacklight();	// 背光超时检测 
		R_Second_Temp = 0;
		R_DateSecond++;		//hex
        F_24HourClock();        // 时钟更新(时分秒进位)	
        F_TimerUpdate();
//		update_progress_ring();	
		CheckAndStartTimer();
		Disable_Alarm();	
		if(R_Uart_UI != 0)
		{
		R_Uart_UI--;	
		}
			if (R_Uart_UI == 0)
			{
			RB_Lcd_Updata_Flag &= ~D_LcdChangeUpdate;
			RB_Lcd_Updata_Flag |= D_LcdUpdate;	
				}		
				// 处理串口打开时间
		if(R_Uart_OpenTime != 0)
		{
		R_Uart_OpenTime--;
			if (R_Uart_OpenTime == 0)
			{
		R_OtherFlag&= ~D_Urat_Open;		
				}		
		}
		if(R_SetBack != 0)
		{
		R_SetBack--;
		   if (R_SetBack == 0)
			{
				R_TimeFlashSet = 0;
				R_AlmTimeFlashSet = 0;
				R_TimerFlashSet	= 0;
				R_AlarmViewFlag = 0;
				RB_Lcd_Updata_Flag |= D_LcdUpdate;
//					if(R_VolumeFlashSet != 0)
//					{
//					R_VolumeFlashSet = 0;	
//					Voice_SendStopControlCmd();
//					}
				
			}		
		}
	}
}
int main(void)
{
	F_SYS_ClearPage0();// 清零Page0内存
	F_SYS_ClearNPage(); // 清零非分页内存

	F_InitDateTime();  // 初始化时间日期
	F_SYS_PowerOnCPUInitinal();// CPU上电初始化
	F_LVD_Init();		//低电初始化
	F_LCD_Initinal();// LCD完整上电初始化：打开偏压、电荷泵、VLCD和显示驱动
	F_InitPort();// ;端口初始化

    ADC_Init();	    // 初始化 ADC 模块（PB7 模拟输入，参考电压 2.0V）
    PWM_Backlight_Init(); // 初始化PWM背光
	/* 开机全显时强制唤醒背光：取消休眠暗光（清除 PA5），并设置为最高亮度 */
	P_IO_PortA_Data &= ~0x20; /* PA5 = 0 -> 非休眠 */
	F_KeepPA3InputPulldown();
	R_BacklightLevel = 3;    /* 档位设为最大 */
	PWM_SetBrightness(255);
	P_PWMIO_Ctrl |= D_PWMIO1En;
	R_CurrentBrightness = 255;
//	F_RFCInit_Value();
//	F_ADC_Init();
//	F_InitialKeyBorad();  // 键盘初始化
	F_InitIRQ();   // 中断初始化
	

	F_SYS_FillDPRAM();	
	P_WDT_Clear = 0;	
	
	disable_interrupt();

//	F_Clear_buffs();
	F_UART_Initial();	//UART初始化
	P_UART_Ctrl1 = D_UARTReset|D_UARTEn|D_UARTRxIntEn;
	
	temp = P_UART_Data;
	//D_UARTParityEn|D_UARTParityOdd|D_UARTFIFOEn
	P_UART_Ctrl2 = D_UARTStopBit1|D_UARTDataBit8;	

/*===== Rx background ===== */
	enable_interrupt();
//	F_OpenData();
 	while(R_Second_Temp < 4)
    {
       P_WDT_Clear = 0;    // 持续喂狗（适配硬件看门狗要求）
        nop_instruction();  // 空操作，减少CPU空耗
    }	
	F_SYS_ClearDPRAM(); //  清零DPRAM 

	while(1)
	{
		P_WDT_Clear = 0;

	    F_KeyScan();       // 按键处理
		if (F_IsSystemPowerOff())
		{
			/* 关机态复位低电流程，确保下次开机若仍低电会重新播报并关机。 */
			g_recheck_battery_after_power_on = 1;
			F_ResetLowPowerFlow();
			g_voice_play_status = PLAY_STATUS_STOPPED;
			/* 电源键还在去抖或长按计时中时，先别睡，让 128Hz 继续推进按键状态机。 */
			if ((R_KeyValue != 0) || (R_DebounceCnt != 0) || (R_LongKeyTime != 0))
			{
				F_SecondRTC();
				nop_instruction();
				continue;
			}
			/* 关机态进入休眠，由电源键或 2Hz 时基唤醒后再做最小处理。 */
			F_SecondRTC();			
			F_GreenMode();
			F_Afterwakeup_Proc();
			nop_instruction();
			continue;
		}

		if (g_recheck_battery_after_power_on)
		{
			/* 开机后的第一次循环先清掉旧低电状态，再重新测一次电池。 */
			g_recheck_battery_after_power_on = 0;
			R_Charge &= ~D_LowPower;
			F_ResetLowPowerFlow();
			F_DC_Det();
		}

	   	SetVolumeAndPlayAlarm1(R_CurrentVolume);	//设置声音大小
		F_CheckKeyTone();
        F_Backlight_Process(); // 背光逻辑轮询
        F_SecondRTC();       // 2hz处理
		Play_AlarmMusic_Stop();
	   F_Calc12Icon();	
//	   F_DC_Det();
	   F_Charge();		
        // LCD显示处理
       F_LCDDisplay();  // LCD主显示
   	   Check_UartData();  
		F_ProcessLowPowerShutdown();
		F_Cheak_VDC();	

		/* 低电关机流程进行时，屏蔽其它语音请求，避免打断低电报警 */
		if ((g_low_power_flow == LOW_POWER_FLOW_IDLE) && (R_VoiceFlag & D_WakePlay) && (R_VoiceFlag & D_OpenReady))
		{
			/* 清除请求位，避免重复播放 */
			R_VoiceFlag &= ~D_WakePlay;
			Play_Wake_Response();
		}

		/* 处理汇编设置的语音请求（R_VoiceReq），由主循环在语音就绪时触发播放 */
		if ((g_low_power_flow == LOW_POWER_FLOW_IDLE) && (R_VoiceReq != 0) && (R_VoiceFlag & D_OpenReady))
		{
			unsigned char req = R_VoiceReq;
			R_VoiceReq = 0; /* 清除请求 */

			if (req & D_VOICE_BEEP) PlaySingle(Di000_1_SP);
			if (req & D_VOICE_ALARM_CHECK) {
				unsigned char seq1[2] = {NaoZhong_SP, chakan_SP};
			PlaySequence(2, seq1);}
			if (req & D_VOICE_ALARM_SET) {
				unsigned char seq1[2] = {NaoZhong_SP, shezhi1_SP};
				PlaySequence(2, seq1);
			}
			if (req & D_VOICE_DATE_SET) {
				unsigned char seq2[2] = {riqi_SP,shezhi1_SP};
				PlaySequence(2, seq2);
			}
			if (req & D_VOICE_TIME_SET) {
				/* 如果仍在时间设置模式，播放“时间设置为”；否则播放完整的“设置成功”语音 */
				if (R_TimeFlashSet != 0) {
					unsigned char seq3[2] = {shijian_SP, shezhi1_SP};
					PlaySequence(2, seq3);
				} else {
					Play_SetTimeVoice_FromKey();
				}
			}
			if (req & (D_VOICE_TIMER_START | D_VOICE_TIMER_PAUSE | D_VOICE_TIMER_CONTINUE)) {
				Voice_SendStopControlCmd();
				if (req & D_VOICE_TIMER_CONTINUE) {
					unsigned char seq1[2] = {JiXu_SP, JiShi_SP};
					PlaySequence(2, seq1);
				} else if (req & D_VOICE_TIMER_PAUSE) {
					unsigned char seq1[2] = {ZanTing_SP, JiShi_SP};
					PlaySequence(2, seq1);
				} else {
					unsigned char seq1[2] = {KaiQi_SP, JiShi_SP};
					PlaySequence(2, seq1);
				}
			}
		}
		
	//    // 进入睡眠前的判断条件
    //     if ((R_KeyValue != 0) || (R_OtherFlag & (D_Alarming | D_Urat_Open | D_Timering)))
    //     {
    //         // 条件满足，不进入睡眠，继续循环
   	//    continue;
    //    }

		
        //		
		// F_GreenMode();
		// F_Afterwakeup_Proc();
		nop_instruction();
	}
	return 0;
}
