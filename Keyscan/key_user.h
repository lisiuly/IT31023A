#ifndef _KEY_USER_H
#define _KEY_USER_H

/* Resource Info C File GPL815PX*/
//; ==============================================
//; Function	name: F_Flash_Dot 
//; Purpose	    : Make a dot flash 
//; Parameter		: X
//; Return    	: 
//; Destroy	    : 
//; Stack depth	: 2
//; =============================================		
extern	void	F_InitialKeyBorad(void);
////; ==============================================
////; Function	name: F_Disp_NO_Digital 
////; Purpose	    : show digital 
////; Parameter		: A  display icon ,X  dispaly index
////; Return    	: 
////; Destroy	    : 
////; Stack depth	: 2
////; =============================================
//extern	void	F_InputProc(void);
extern	void	F_KeepPA3InputPulldown(void);

extern	void	F_KeyScan(void);
extern	void	F_CodeSwitchScan(void);
////; ==============================================
////; Function	name: F_Flash_PandTime_Dot 
////; Purpose	    : Make a dot flash 
////; Parameter		: X
////; Return    	: 
////; Destroy	    : 
////; Stack depth	: 2
////; =============================================		
//extern	void	F_Operation_Count_Proc(void);
extern	void	F_DC_Det(void); 
extern	void	F_Charge(void);	
//extern	void		F_OpenData(void);
//extern	void		F_DelayReadyData(void);
//extern unsigned char	R_KeyState;
//	#define		D_HasKey		0x01
//	#define		D_NewKey		0x02
//	#define		D_Debounce		0x04
//	#define		D_Long_Key		0x08
//	#define		D_Key_Release	0x10
extern unsigned char	R_KeyTemp;
extern unsigned char	R_CodeIOValue;
extern unsigned char	R_KeyValue;
//extern unsigned char	R_KeyCode;
extern unsigned char	R_DebounceCnt;
extern unsigned char	R_LongKeyTime;
extern unsigned char	R_CodeDebounce;
//extern unsigned char	R_Key_time;
extern unsigned char	R_SleepTime;

extern unsigned char	R_KeyFlag;
#define D_EnableFastAdd 0x01
#define D_LCDOFF        0x02
#define D_KeyTone       0x04
#define D_KeyRelDis     0x08
#define D_UpdateBAT     0x10
extern unsigned char	R_SnoozeTime;
#define	C_SnoozeTime1min		60
//#define C_SnoozeTime5min		5
//extern unsigned char	RB_Option_Count;
//	#define		C_Option_Overtime	0X14
//
extern unsigned char	R_Charge;	 
#define	D_LowPower 	0x01
#define	D_Charge 	0x02 
#define	D_Full 		0x04

extern unsigned char	R_CurrentSong;	

extern unsigned char	R_TimerFlag;
#define	D_Timerstatus_just	0x01
#define	D_Timerstatus		0x02	
#define	TIMER_START_FLAG	0x04
#define	D_TimerSetstatus		0x08
#define	D_Timerstatus_justpause	0x10
#define D_TimerPausedCountDown	0x20
extern unsigned char	R_SetBack;
extern unsigned char	R_TimeFlashSet;
extern unsigned char	R_AlmTimeFlashSet;

extern unsigned char	R_TimerFlashSet;

//extern void F_OpenBacklight(void);
//extern void F_CheckBacklight(void);

extern unsigned char	R_CurrentVolume;
extern unsigned char	SetVolumeAndPlayAlarm1_flag;

extern unsigned char	R_DelayTemp;

extern unsigned char	R_OtherFlag;	
#define	D_Urat_Open			0x02
#define	D_EnableSnooze		0x04
#define	D_ToneDIS			0x08
#define	D_AlarmingStatus	0x10
#define	D_Timering			0x20
#define	D_Alarming			0x40
#define	D_TimeringStatus	0x80

extern unsigned char R_KeepAwakeTimer;

extern unsigned char R_Uart_OpenTime;
extern	unsigned char	R_LVDStatus;
#define D_BatLevel1 	 0x01
#define D_BatLevel2 	 0x02
#define D_BatLevel3 	 0x04
#define D_BatLevel4 	 0x08

extern	unsigned char	R_VoiceFlag;
#define		D_OpenReady		0x01
#define		D_WakePlay		0x02	
extern	unsigned char	R_DelayOpen;
extern	void	Voice_PowerOn(void);
extern	void	F_SystemPowerOff(void);
extern unsigned char R_VoiceReq;
extern unsigned char R_AlarmViewFlag;
extern	void	Voice_PowerOn_Noxiaonao(void);
/* R_VoiceReq 位：由汇编设置，主循环处理 */
#define D_VOICE_ALARM_CHECK  0x01
#define D_VOICE_ALARM_SET    0x02
#define D_VOICE_DATE_SET     0x04
#define D_VOICE_TIME_SET     0x08
#define D_VOICE_BEEP         0x10
#define D_VOICE_TIMER_START  0x20
#define D_VOICE_TIMER_PAUSE  0x40
#define D_VOICE_TIMER_CONTINUE 0x80
#endif
