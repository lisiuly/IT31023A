.EXTERN		F_InitialKeyBorad
.EXTERN		F_KeyScan
;.EXTERN		F_InputProc
;.EXTERN		F_LongKeyService
;.EXTERN     PAGE0 R_KeyState
;	D_HasKey:			.EQU	01H
;	D_NewKey:			.EQU	02H
;	D_Debounce:			.EQU	04H
;	D_Long_Key:			.EQU	08H
;	D_Key_Release:		.EQU	10H	
;.EXTERN     PAGE0 R_KeyCode
;.EXTERN     PAGE0 R_DebounceCnt
;.EXTERN     PAGE0 R_Key_time
;.EXTERN     PAGE0			RB_Option_Count
;C_Option_Overtime:		.EQU		0X14
;; ==============================================
;; Function	name	: F_Operation_Count_Proc
;; Purpose			: EEPROM erea current data
;; Parameter			: none 
;; Return			: 
;; Destroy			: none 
;; Stack depth		: none
;; ==============================================						
;.EXTERNAL			F_Operation_Count_Proc
.EXTERN		R_SleepTime
.EXTERN		_R_SleepTime
.EXTERN		R_SnoozeTime
.EXTERN		_R_SnoozeTime
C_SnoozeTime1min	EQU		60
;C_SnoozeTime5min	equ		5
.EXTERN		R_OtherFlag
;D_12Mode			equ		0x01	;0默认为24H，1为12H	
D_Urat_Open			equ		0x02
D_EnableSnooze		equ		0x04
D_ToneDIS			equ		0x08
D_AlarmingStatus	equ		0x10
;D_SetVolumeFlag		equ		0x20
D_Timering			equ		0x20
D_Alarming			equ		0x40
D_TimerStatus		equ		0x80
.EXTERN		BitMaskTable
.EXTERN		R_TimeFlashSet
.EXTERN		R_AlmTimeFlashSet
.EXTERN		R_TimerFlashSet
AddOthers			equ		01H


.EXTERN		R_TimeFlashSet
D_SetYear			equ	0x01
D_SetMonth			equ	0x02
D_SetDate			equ	0x04		
;D_Set12_24			equ	0x08
D_SetHour			equ	0x08
D_SetMinute			equ	0x10 
D_SetTimeMax		equ	0x20  
.EXTERN		R_AlmTimeFlashSet	
_R_AlmTimeFlashSet	equ		R_AlmTimeFlashSet
D_SetAlm			equ	0x01	;闹钟开关
D_SetAlmHour		equ	0x02	;闹时
D_SetAlmMinute		equ	0x04	;闹分
D_SetAlmDay			equ	0x08	;闹
D_SetAlarmMax		equ	0x10   
.EXTERN		R_TimerFlashSet	
_R_TimerFlashSet	equ		R_TimerFlashSet
D_TimerSet			equ	0x01	
D_SetTimerMax		equ	0x02
.EXTERN		R_CurrentVolume
_R_CurrentVolume		equ	R_CurrentVolume
.EXTERN		R_CurrentSong
_R_CurrentSong		equ		R_CurrentSong

.EXTERN		R_KeyFlag		
_R_KeyFlag		equ		R_KeyFlag
D_EnableFastAdd		equ	0x01
D_LCDOFF			equ	0x02
D_KeyTone			equ	0x04
D_KeyRelDis			equ	0x08
D_UpdateBAT			equ	0x10

.EXTERN 	 	 R_Charge 
D_LowPower 	 	 equ 0x01;低电 
D_Charge 	 	 equ 0x02;充电中 
D_Full 	 	 	 equ 0x04;充满 
.EXTERN 	 	 R_LVDStatus 


.EXTERN		R_TimerFlag
_R_TimerFlag	equ		R_TimerFlag
D_Timerstatus_just	equ		0x01
D_Timerstatus		equ		0x02
TIMER_START_FLAG	equ		0x04	
D_TimerSetstatus	equ		0x08
D_Timerstatus_justpause	equ	0x10
D_TimerPausedCountDown	equ		0x20
;.EXTERN		F_OpenData

.EXTERN		SetVolumeAndPlayAlarm1_flag

.EXTERN		R_SetBack
_R_SetBack	equ		R_SetBack



.EXTERN	R_VoiceFlag	
_R_VoiceFlag	equ		R_VoiceFlag
D_OpenReady		equ		0x01
D_WakePlay		equ		0x02	; 按键唤醒后请求播放应答（由主循环处理）
.EXTERN	R_DelayOpen
.EXTERN	R_VoiceReq

; R_VoiceReq 位定义（由汇编置位，主循环处理）
D_VOICE_ALARM_CHECK	equ	0x01
D_VOICE_ALARM_SET		equ	0x02
D_VOICE_DATE_SET		equ	0x04
D_VOICE_TIME_SET		equ	0x08
D_VOICE_BEEP			equ	0x10
D_VOICE_TIMER_START		equ	0x20
D_VOICE_TIMER_PAUSE			equ	0x40
D_VOICE_TIMER_CONTINUE		equ	0x80
.EXTERN	Voice_PowerOn
.EXTERN	Voice_PowerOn_Noxiaonao
.EXTERN		R_Uart_OpenTime
.EXTERN		_R_Uart_OpenTime

D_BatLevel1 	 equ 	 01H 
D_BatLevel2 	 equ 	 02H 
D_BatLevel3 	 equ 	 04H 
; ==============================================
; MACRO name	: %DecDebounce
; Purpose		: DEBOUNCE 
; Parameter		: none 
; Return    	: none
; Destroy		: none 
; Stack depth	: none
; =============================================
%DecDebounce	.MACRO	
		    LDA	    R_DebounceCnt
		    BEQ	    ?L_Exit#
		    DEC	    R_DebounceCnt
?L_Exit#:	
    		.ENDM
;============================================
