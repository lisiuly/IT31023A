;=================================================================================
;Module Name:	keyscan.asm
;Applied body:	GPL10x series
;Purpose:		Implement key scan function
;Programmer:	yanxiaodu
;Date:			2011-06-20
;Function list:
;
;=============================================================================
;==========================================
; Compiler parameter define
;==========================================
.SYNTAX 6502
.LINKLIST
.SYMBOLS

;==========================================
; Constant define area
;==========================================
C_Bell_duration:		.EQU		01H
C_Counter_adr1:			.EQU		F0H
C_Counter_adr2:			.EQU		F8H
C_time_set_show_time:	.EQU		0X01

C_Mode_changeshow_Delay_time:		.EQU		0X28			;48*7.8125MS

C_Option_Overtime:		.EQU		0X14


D_TIME_DATA_key:		.EQU		0X12
D_ALARM_key:			.EQU		0X24
D_UP_key:				.EQU		0X22
D_DOWN_key:				.EQU		0X02
;==========================================
; Include file area
;==========================================
.Include	GPL815P.inc
.INCLUDE	lcd\lcd_user.inc
.INCLUDE	calendar\calendar_user.inc
.INCLUDE	ADC\ADC_user.inc
.INCLUDE	SYS\Macro.inc
;.INCLUDE	GXHTV4\GXHTV4.inc
;.INCLUDE	I2c\D_I2C.inc
;==========================================
; External declare area
;==========================================
.EXTERNAL F_LCD_Initinal
.EXTERNAL F_UART_Initial
.EXTERNAL ADC_Init
.EXTERNAL _R_BacklightFlag
.EXTERNAL _R_BacklightLevel
.EXTERNAL _R_CurrentBrightness

;==========================================
; Public declare area
;==========================================
;.PUBLIC			F_InputProc
;.PUBLIC			F_InitialKeyBorad
.PUBLIC			F_KeyScan
;.PUBLIC			_F_InputProc
;.PUBLIC			_F_InitialKeyBorad
.PUBLIC			_F_KeyScan
;.PUBLIC			F_CodeSwitchScan
;.PUBLIC			_F_CodeSwitchScan
.PUBLIC			R_KeyValue
.PUBLIC			_R_KeyValue

;.PUBLIC 	   F_DC_Det 	 
;.PUBLIC		 _F_DC_Det 
.PUBLIC 	 	 F_Charge 
.PUBLIC		_F_Charge
;.PUBLIC			R_Key_time
;.PUBLIC			_R_Key_time
;.PUBLIC			F_OpenData
;.PUBLIC			_F_OpenData
;.PUBLIC			F_DelayReadyData
;.PUBLIC			_F_DelayReadyData
;.PUBLIC			R_KeyState
;.PUBLIC			_R_KeyState
.PUBLIC			R_KeyTemp
.PUBLIC			_R_KeyTemp
;.PUBLIC			R_KeyCode
;.PUBLIC			_R_KeyCode
.PUBLIC			R_CodeIOValue
.PUBLIC			_R_CodeIOValue
.PUBLIC			R_DebounceCnt
.PUBLIC			_R_DebounceCnt
;.PUBLIC			RB_Option_Count
;.PUBLIC			_RB_Option_Count
.PUBLIC		R_TimeFlashSet
.PUBLIC		_R_TimeFlashSet
.PUBLIC		R_AlmTimeFlashSet
.PUBLIC		_R_AlmTimeFlashSet
;.PUBLIC		R_VolumeFlashSet
;.PUBLIC		_R_VolumeFlashSet
.PUBLIC		R_TimerFlashSet
.PUBLIC		_R_TimerFlashSet
.PUBLIC		R_CodeDebounce	
.PUBLIC		_R_CodeDebounce
.PUBLIC		R_SleepTime
.PUBLIC		_R_SleepTime
.PUBLIC		R_SnoozeTime
.PUBLIC		_R_SnoozeTime
.PUBLIC		R_OtherFlag
.Public		_R_OtherFlag
.PUBLIC		R_CurrentVolume
.PUBLIC		_R_CurrentVolume
.PUBLIC		R_BacklightTimer
.PUBLIC		_R_BacklightTimer
;.PUBLIC		F_OpenBacklight
;.PUBLIC		_F_OpenBacklight
;.PUBLIC		F_CheckBacklight
;.PUBLIC		_F_CheckBacklight
.PUBLIC		R_CurrentSong
.PUBLIC		_R_CurrentSong
.PUBLIC		R_LongKeyTime
.PUBLIC		_R_LongKeyTime
.PUBLIC		R_KeyFlag
.PUBLIC		_R_KeyFlag
.PUBLIC		R_TimerFlag
.PUBLIC		_R_TimerFlag
.PUBLIC		R_SetBack
.PUBLIC		_R_SetBack
.PUBLIC		R_DelayTemp
.PUBLIC		_R_DelayTemp
.PUBLIC		SetVolumeAndPlayAlarm1_flag
.PUBLIC		_SetVolumeAndPlayAlarm1_flag
.PUBLIC		R_Charge
.PUBLIC		_R_Charge
.PUBLIC		R_LVDStatus
.PUBLIC		_R_LVDStatus
.PUBLIC		R_VoiceFlag
.PUBLIC		_R_VoiceFlag
.PUBLIC		R_DelayOpen
.PUBLIC		_R_DelayOpen
.PUBLIC		Voice_PowerOn
.PUBLIC		_Voice_PowerOn
.PUBLIC		Voice_PowerOn_Noxiaonao
.PUBLIC		_Voice_PowerOn_Noxiaonao
.PUBLIC		F_SystemPowerOff
.PUBLIC		_F_SystemPowerOff
.PUBLIC		_R_Uart_OpenTime
.PUBLIC		R_Uart_OpenTime
.PUBLIC		R_VoiceReq
.PUBLIC		_R_VoiceReq
.PUBLIC		_F_KeepPA3InputPulldown
.PUBLIC		F_KeepPA3InputPulldown
.PUBLIC		R_AlarmViewFlag
.PUBLIC		_R_AlarmViewFlag
;==========================================
;Variable RAM declare area
;==========================================
.PAGE0	;keyscanram:			.section	
R_DebounceCnt:			.DS		1
_R_DebounceCnt:		equ	R_DebounceCnt
C_KeyDebounce		equ		4 
;RB_Option_Count:		.DS		1
;_RB_Option_Count:		.equ	RB_Option_Count
R_CurrentSong		ds		1
_R_CurrentSong		equ		R_CurrentSong
R_CurrentVolume		ds		1
_R_CurrentVolume	equ		R_CurrentVolume
R_BacklightTimer	ds		1
_R_BacklightTimer	equ		R_BacklightTimer
C_BacklightTime		equ		10		; 10秒
SetVolumeAndPlayAlarm1_flag	ds	1
_SetVolumeAndPlayAlarm1_flag	equ		SetVolumeAndPlayAlarm1_flag

;--------------
R_SetBack			ds		1
_R_SetBack			equ		R_SetBack
C_SleepSec			equ		60		; 1分钟(60×1s=60s)
R_KeyValue			ds		1	;保存键值
_R_KeyValue:		equ	R_KeyValue	
R_KeyTemp			ds		1	
_R_KeyTemp:			equ	R_KeyTemp
R_OldKeyValue		ds		1	;原来的键值
_R_OldKeyValue:		equ	R_OldKeyValue
D_AlarmKey		equ		0x08	;闹钟设置键
D_TimerKey		equ	    0x10	;定时键加08
D_UpKey			equ		0x04	;加键正倒计时04
D_DownKey		equ		0x02	;减键闹钟02
D_TimeKey		equ		0x20	;时间设置键
D_PowerKey		equ		0x40		


;D_SleepKey		equ		0x80	;贪睡键

R_KeyFlag			ds		1
_R_KeyFlag		equ		R_KeyFlag
D_EnableFastAdd		equ	0x01
D_LCDOFF			equ	0x02
D_KeyTone			equ	0x04
D_KeyRelDis			equ	0x08
D_UpdateBAT			equ	0x10
;D_ToneOn			equ	0x20
;D_Alarming			equ	0x40
;D_LongKey			equ	0x80

R_LongKeyTime		ds		1
_R_LongKeyTime		equ		R_LongKeyTime
C_LongKey2Sec		equ		255
C_FastAdd			equ		16		;1秒加8次

AddOthers			equ		01H

R_OtherFlag			ds		1
_R_OtherFlag		equ		R_OtherFlag
;D_12Mode			equ		0x01	;0默认为24H，1为12H	
D_Urat_Open			equ		0x02
D_EnableSnooze		equ		0x04
D_ToneDIS			equ		0x08
D_AlarmingStatus	equ		0x10
;D_SetVolumeFlag		equ		0x20
D_Timering			equ		0x20
D_Alarming			equ		0x40
D_TimeringStatus	equ		0x80
R_TimeFlashSet		ds		1	;时间闪动
_R_TimeFlashSet		equ		R_TimeFlashSet
D_SetYear			equ	0x01
D_SetMonth			equ	0x02
D_SetDate			equ	0x04		
;D_Set12_24			equ	0x08
D_SetHour			equ	0x08
D_SetMinute			equ	0x10 
D_SetTimeMax		equ	0x20  
R_AlmTimeFlashSet		ds	1
_R_AlmTimeFlashSet	equ		R_AlmTimeFlashSet
D_SetAlm			equ	0x01	;闹钟开关
D_SetAlmHour		equ	0x02	;闹时
D_SetAlmMinute		equ	0x04	;闹分
D_SetAlmDay			equ	0x08	;闹
D_SetAlarmMax		equ	0x10   

R_TimerFlashSet		ds	1
_R_TimerFlashSet	equ		R_TimerFlashSet
D_TimerSet			equ	0x01	
D_SetTimerMax		equ	0x02

; R_VolumeFlashSet		ds	1
; _R_VolumeFlashSet	equ		R_VolumeFlashSet
; D_VolumeSet			equ	0x01	
; D_SetVolumeMax		equ	0x02

R_SleepTime			ds	1
_R_SleepTime		equ		R_SleepTime
R_SnoozeTime		ds	1
_R_SnoozeTime		equ		R_SnoozeTime
C_SnoozeTime1min	EQU		60
;C_SnoozeTime5min	equ		5

;R_Mode				ds	1
;D_TimeMode			equ	0x01
;D_AlarmMode			equ	0x02
;D_VolumeMode		equ	0x04	
L_TempBit		ds	1	

R_CodeValue		ds	1
R_CodeTemp		ds	1
R_CodeIOValue	ds	1
_R_CodeIOValue		equ		R_CodeIOValue
R_FirstValue	ds	1
R_SecondValue	ds	1
R_CodeDebounce	ds	1
_R_CodeDebounce		equ		R_CodeDebounce
R_SaveFirst		ds	1
R_OverTime		ds	1

R_CodeFlag		ds	1
D_GetCodeKey	equ	0x01
D_GetCodeFirst	equ	0x02

R_TimerFlag		ds	1
_R_TimerFlag			equ		R_TimerFlag
D_Timerstatus_just		equ		0x01
D_Timerstatus			equ		0x02
TIMER_START_FLAG		equ		0x04	
D_TimerSetstatus		equ		0x08
D_Timerstatus_justpause	equ		0x10
; 新增：倒计时被暂停标志（用于在继续时播放“继续计时”）
D_TimerPausedCountDown	equ		0x20
D_TimerModeCountdown	equ		0x40

R_DelayTemp		.ds	1
_R_DelayTemp	.equ		R_DelayTemp

R_Charge 	 	 .ds 	 1 
_R_Charge		equ		R_Charge
D_LowPower 	 	 equ 0x01;低电 
D_Charge 	 	 equ 0x02;充电中 
D_Full 	 	 	 equ 0x04;充满 

R_LVDStatus 	 .ds 	 1 
_R_LVDStatus     equ		R_LVDStatus		
D_BatLevel1 	 equ 	 01H 
D_BatLevel2 	 equ 	 02H 
D_BatLevel3 	 equ 	 04H 

R_DetCnt	     .ds     1
 
R_VoiceFlag		ds	1
_R_VoiceFlag	equ		R_VoiceFlag
D_OpenReady		equ		0x01
D_WakePlay		equ		0x02	; 按键唤醒后请求播放应答（由主循环处理）

R_DelayOpen		ds		1
_R_DelayOpen		equ		R_DelayOpen
R_VoiceReq		ds		1
_R_VoiceReq		equ		R_VoiceReq
; 标志：闹钟查看语音是否已在本次查看序列中播放
R_AlarmViewFlag	ds	1
_R_AlarmViewFlag	equ	R_AlarmViewFlag
D_AlarmView_Played	equ	0x01

R_Uart_OpenTime		ds		1
_R_Uart_OpenTime	equ		R_Uart_OpenTime		



D_VOICE_ALARM_CHECK	equ	0x01
D_VOICE_ALARM_SET		equ	0x02
D_VOICE_DATE_SET		equ	0x04
D_VOICE_TIME_SET		equ	0x08
D_VOICE_BEEP			equ	0x10
D_VOICE_TIMER_START		equ	0x20
D_VOICE_TIMER_PAUSE			equ	0x40
D_VOICE_TIMER_CONTINUE		equ	0x80


.ENDS
;==========================================
; code starting 
;; Purpose		: 按键初始化 
;; Parameter		: next 
;; Return		: none
;; Destroy		: none 
;; Stack depth	: none
;; =========================================
;
;keyscan:    .SECTION
.CODE
;F_InitialKeyBorad:
;_F_InitialKeyBorad:
;			LDA			#00H
;;			STA			R_KeyState
;			STA			R_KeyTemp
;			STA			R_KeyValue
;			STA			R_DebounceCnt
;			STA			R_LongKeyTime
;F_PE12_Input:			
;			LDA		#00000000b
;			STA		P_IO_PortB_Dir
;			LDA		#00000000b
;			STA		P_IO_PortB_Attrib
;			LDA		#00000000b
;			STA		P_IO_PortB_Data			
;			RTS
; ==============================================
; MACRO name	: %NeedKeyScan
; Purpose		:  DEbounceing? 
; Parameter		: next 
; Return		: none
; Destroy		: none 
; Stack depth	: none
; =============================================
%NeedKeyScan	.MACRO	NotNeed		
			LDA		R_KeyState
			AND		#D_Debounce
			BEQ		?L_Need#
			
			LDA		R_KeyScanInterval
			BNE		NotNeed
?L_Need#:	
			.ENDM
			
; ==============================================
; MACRO name	: %WaitDebounceOver
; Purpose		: DEBOUNCE shifou jieshu  
; Parameter		: next 
; Return		: none
; Destroy		: none 
; Stack depth	: none
; =============================================
%WaitDebounceOver	.MACRO	NotOver
			LDA	 R_DebounceCnt
			BNE	 NotOver
?L_Need#:		
	.ENDM

; =============================================
F_KeyScan:
_F_KeyScan:
		NOP	
		%btst R_KeyFlag, D_LCDOFF, ?PowerOffScan
		LDA	P_IO_PortB_Data
		AND	#(D_AlarmKey+D_TimerKey+D_UpKey+D_DownKey+D_PowerKey+D_TimeKey)
		JMP	?CheckKey
?PowerOffScan:
		LDA	P_IO_PortB_Data
		AND	#D_PowerKey
?CheckKey:
		BEQ	?ReleaseAllKey
		
		STA	R_KeyTemp
		LDA	R_KeyTemp
		CMP	R_KeyValue
		BEQ	?CheckKeyDebounce
		
		LDA	R_KeyTemp
		STA	R_KeyValue
		LDA	#C_KeyDebounce
		STA	R_DebounceCnt
		CLI
		RTS			
;按键释放-------------------------			
?ReleaseAllKey:
		NOP
		%btst R_KeyFlag, D_LCDOFF, ?Next1
		%btst	R_KeyFlag,D_KeyRelDis,?Next1
		LDA		R_OldKeyValue
		BEQ		?Next1

	?Skip_AlarmZzFunOff:		
;		%bits	R_KeyFlag,D_KeyTone	;按键音
	LDA		R_VoiceFlag
	AND		#D_OpenReady
	BEQ		?No_Beep
		%btst   R_KeyFlag,D_KeyTone,?No_Beep
		%bits	R_VoiceReq,D_VOICE_BEEP	;按键音
	?No_Beep:   	
		LDA		R_OldKeyValue	
		CMP		#D_TimeKey			
		BNE		$+5
		JMP		Enable_TimeKey		;时间设置键
		CMP		#D_AlarmKey			
		BNE		$+5
		JMP		Enable_AlarmKey		;闹钟设置键
		CMP		#D_PowerKey
		BNE		$+5		
		JMP		Enable_BackLEDKey		;背光调节键	
		CMP		#D_UpKey			;;+键
	    BNE		$+5
		JMP		Enable_UpKey		
		CMP		#D_DownKey			;;-键
		BNE		$+5
		JMP		Enable_DownKey
		CMP		#D_TimerKey			
		BNE		$+5
		JMP		Enable_TimerKey		;定时键:计时中按下可暂停/继续计时
		%bitr	R_VoiceReq,D_VOICE_BEEP	;按键音
	?Next1:			
		LDA	#00
		STA	R_OldKeyValue
		STA	R_KeyValue
		STA	R_KeyTemp
		%bitr	R_KeyFlag,(D_EnableFastAdd+D_KeyRelDis)
	?Next2:		
		RTS
		
?CheckKeyDebounce:
		LDA	R_DebounceCnt
		BEQ	?Key_Process		
		RTS			
	?Key_Process:		;按键是否新按下的按键
		LDA	R_KeyValue
		CMP	R_OldKeyValue
		BNE	$+5
		JMP	Hold_Key

Enable_NewKey:
		;新按下的按键处理
			%bitr	R_KeyFlag,(D_KeyRelDis+D_EnableFastAdd)
	?SkipKeyTone:
			LDA		#C_LongKey2Sec
			STA		R_LongKeyTime	;长按3秒开始计时			
			LDA		R_KeyValue
			STA		R_OldKeyValue
			; 如果按下的不是闹钟键，则刷新闹钟查看语音标志（允许下次短按播放）
			LDA		R_KeyValue
			CMP		#D_AlarmKey
			BEQ		?Skip_ClearAlarmView
			LDA		#00
			STA		R_AlarmViewFlag
		?Skip_ClearAlarmView:
				; 若语音模块已打开，刷新 UART 打开计时，用于保持语音唤醒状态
				LDA		R_VoiceFlag
				AND		#D_OpenReady
				BEQ		?NoRefreshUartOpen
				LDA		#D_UI_Time
				STA		R_Uart_OpenTime
	?NoRefreshUartOpen:
;	            %btst   R_KeyFlag,D_KeyTone,?NoBeep
;	            LDA     R_VoiceReq
;	            ORA     #D_VOICE_BEEP
;	            STA     R_VoiceReq
	?NoBeep:
	 ; --- 贪睡/闹铃响应处理 ---
	 ; 不响铃:检查是否贪睡等待中
	 %btsf	R_OtherFlag,D_Alarming,?L_Sno_NOYES
	 ; 响铃中:闹钟键->贪睡(仅闹钟), 其他键->关闭
	 %btsf	R_OtherFlag,D_Timering,?L_Next
	 %bitr	R_OtherFlag,D_Timering
	 %bits	R_OtherFlag,D_ToneDIS
	 JMP	?L_Sno_NOYES	
	 ?L_Next:
	 LDA	R_OldKeyValue
	 CMP	#D_AlarmKey
	 BNE	?L_HandleCancel
	 ; 正倒计时响铃不走贪睡
	?L_SnoozeCommon:
	 LDA	#C_SnoozeInterval
	 STA	R_SleepTime
	 %bits	R_OtherFlag,(D_EnableSnooze+D_ToneDIS)
	 %bitr	R_OtherFlag,D_Alarming		; 立即停止响铃,进入贪睡
	 JMP	?L_SnoozeDone
 	?L_Sno_NOYES:
	 %btst	R_OtherFlag,D_EnableSnooze,?L_HandleCancel
	 RTS
	?L_HandleCancel:
	 ; 取消贪睡/关闭闹钟
	 %bitr	R_OtherFlag,D_EnableSnooze
	?L_SnoozeDone:
	 	%bits	R_KeyFlag,D_KeyRelDis				
	 ?L_Exit:
			RTS

			
Enable_BackLEDKey:
		; 3档背光循环：1->2->3->1，过滤无效值         
		JSR		F_UpdateKey	
		LDA		_R_BacklightLevel
		CMP		#1
		BEQ		?BackLED_Set2
		CMP		#2
		BEQ		?BackLED_Set3
		CMP		#3
		BEQ		?BackLED_Set1
		; 其他非法值统一设为1
		LDA		#1
		STA		_R_BacklightLevel
		JMP		?BackLED_Done
?BackLED_Set2:
		LDA		#2
		STA		_R_BacklightLevel
		JMP		?BackLED_Done
?BackLED_Set3:
		LDA		#3
		STA		_R_BacklightLevel
		JMP		?BackLED_Done
?BackLED_Set1:
		LDA		#1
		STA		_R_BacklightLevel

?BackLED_Done:
;		JSR		F_OpenBacklight
		RTS

;====================================================================
; 背光控制函数
;====================================================================
;F_OpenBacklight:
;_F_OpenBacklight:
;		LDA		#C_BacklightTime	; 重置计时器 (10s)
;		STA		R_BacklightTimer
;		
;		LDA		#1
;		STA		_R_BacklightFlag	; 设置背光标志为开
;		RTS
;
;F_CheckBacklight:
;_F_CheckBacklight:
;		LDA		R_BacklightTimer
;		BEQ		?BacklightOff
;		DEC		R_BacklightTimer
;		BNE		?ExitBacklight
;		
;	?BacklightOff:
;		LDA		#0
;		STA		_R_BacklightFlag	; 设置背光标志为关
;	?ExitBacklight:
;		RTS
;
;====================================================================
; 长按键处理
;====================================================================
Hold_Key:	
		LDA	R_LongKeyTime
		BEQ	?next
		RTS
	?next:
	NOP
		LDA		R_KeyFlag
		AND		#D_EnableFastAdd
		BEQ		?L_SkipFast
		JMP		?Enable_Fast
	?L_SkipFast:
		LDA		R_KeyFlag
		AND		#D_KeyRelDis
		BEQ		?L_SkipExit
		JMP		?exit
	?L_SkipExit:
		%bits	R_KeyFlag,D_EnableFastAdd	
		; 计时键长按始终放行(倒计时设置态下需能退出或清零)
		LDA		R_OldKeyValue
		CMP		#D_TimerKey
		BNE		?L_NotTimerKey
		JMP		?Enable_TimerlongSetKey
	?L_NotTimerKey:
		; 其他键长按需检查是否在设置态(时间/闹钟/计时设置阻塞)
		LDA		R_TimeFlashSet
		ORA		R_AlmTimeFlashSet
		ORA		R_TimerFlashSet
		BEQ		?L_NotInSetup
		JMP		?exit4
	?L_NotInSetup:
		LDA		R_OldKeyValue	;进入设置
		CMP		#D_TimeKey
		BNE		?L_NotTimeKey
		JMP		?Enable_TimelongSetKey
	?L_NotTimeKey:
		CMP		#D_AlarmKey
		BNE		?L_Next
		JMP		?Enable_AlmlongSetKey

	?L_Next:	
		 LDA		R_OldKeyValue			
		CMP		#D_PowerKey
		BNE		$+5		
		JMP		?Enable_LongPowerKey			
			
	?exit4:
		%bits	RB_Lcd_Updata_Flag,D_LcdUpdate
		%bits	R_KeyFlag,D_KeyRelDis		
		RTS	
;快加快减-------------------------		
	?Enable_Fast:	
;	   	%bitr	R_KeyFlag,D_KeyTone	;没有按键音
		LDA		#C_FastAdd
		STA		R_LongKeyTime
		%bits	RB_Lcd_Updata_Flag,D_LcdUpdate
		LDA		R_OldKeyValue		
		CMP		#D_UpKey			;;＋
		BNE		$+5
		JMP		Enable_UpKey
	
		CMP		#D_DownKey			;;-
		BNE		$+5
		JMP		Enable_DownKey
	?exit:	
		%bits	R_KeyFlag,D_KeyRelDis
		%bitr	R_KeyFlag,D_EnableFastAdd
		RTS
		
?Enable_TimelongSetKey:
		JSR		F_UpdateKey		
		LDA		R_VoiceFlag
		AND		#D_OpenReady
		BNE		?Time_Set
		JSR		Voice_PowerOn_Noxiaonao  
	?Time_Set:	
		lda	#01
		sta	R_TimeFlashSet
		; 请求播放“日期设置”语音（由主循环播放）
		LDA		R_VoiceReq
		ORA		#D_VOICE_DATE_SET
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP	;按键音
		RTS	
		
?Enable_AlmlongSetKey:
		JSR		F_UpdateKey		
		LDA		R_VoiceFlag
		AND		#D_OpenReady
		BNE		?Alm_CheckOnOff
		JSR		Voice_PowerOn_Noxiaonao   
	?Alm_CheckOnOff:
		; 检查当前闹钟组是否已开启
		LDX		R_CurrentGroup
		LDA		BitMaskTable,X
		AND		R_AlarmOnOff
		BEQ		?Alm_EnterSet	; 关闭 -> 进入设置
		; 已开启 -> 关闭该闹钟组
		LDA		BitMaskTable,X
		EOR		#0FFH
		AND		R_AlarmOnOff
		STA		R_AlarmOnOff
		RTS
	?Alm_EnterSet:
		; 进入设置即开启该闹钟组
		LDX		R_CurrentGroup
		LDA		BitMaskTable,X
		ORA		R_AlarmOnOff
		STA		R_AlarmOnOff
		lda		#D_SetAlmHour
		sta		R_AlmTimeFlashSet
		; 请求播放闹钟设置语音
		LDA		R_VoiceReq
		ORA		#D_VOICE_ALARM_SET
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP	;按键音
		RTS	
?Enable_TimerlongSetKey:
		; 倒计时设置态 -> 退出不保存,清零
		LDA		R_TimerFlashSet
		CMP		#D_TimerSet
		BEQ		?L_ExitSetNoSave
		; 计时运行中或暂停中 -> 清零归零
		LDA		R_TimerFlag
		AND		#(D_Timerstatus_just+D_Timerstatus+D_Timerstatus_justpause+D_TimerPausedCountDown)
		BNE		?L_ClearTimer
		; 计时空闲(00:00) -> 启动正计时
		JSR		F_UpdateKey
		LDA		R_TimerFlag
		AND		#~(D_TimerModeCountdown+D_Timerstatus+D_Timerstatus_justpause+D_TimerPausedCountDown)
		ORA		#D_Timerstatus_just
		STA		R_TimerFlag
		LDA		#0
		STA		R_TimerMinute
		STA		R_TimerSecond
		LDA		R_VoiceReq
		AND		#1FH
		ORA		#D_VOICE_TIMER_START
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP
		RTS
	?L_ClearTimer:		; 长按清零:停止并归零
		JSR		F_UpdateKey
		LDA		#0
		STA		R_TimerMinute
		STA		R_TimerSecond
		STA		R_TimerFlashSet
		LDA		#~(D_Timerstatus_just+D_Timerstatus+D_Timerstatus_justpause+D_TimerPausedCountDown+D_TimerModeCountdown)
		AND		R_TimerFlag
		STA		R_TimerFlag
		RTS
	?L_ExitSetNoSave:	; 倒计时设置态长按退出不保存
		JSR		F_UpdateKey
		LDA		#0
		STA		R_TimerMinute
		STA		R_TimerSecond
		STA		R_TimerFlashSet
		LDA		#~(D_Timerstatus_just+D_Timerstatus+D_Timerstatus_justpause+D_TimerPausedCountDown+D_TimerModeCountdown)
		AND		R_TimerFlag
		STA		R_TimerFlag
		RTS
?Enable_LongPowerKey:
		JMP	Enable_LongPowerKey
		

		
Enable_LongPowerKey:
		JSR	F_UpdateKey
		LDA	R_KeyFlag
		EOR	#D_LCDOFF
		STA	R_KeyFlag
		
		%btst	R_KeyFlag,D_LCDOFF,?DoPowerOff
		
		; Power ON
		; 关中断，避免 TBH ISR 在外设半初始化时打断
	
		; 重新打开 LCD 偏压、电荷泵、VLCD 和显示驱动
		LDA	#00
		STA	P_WDT_Clear
		JSR	F_LCD_Initinal
		LDA	#00
		STA	P_WDT_Clear
		JSR	ADC_Init
		LDA	P_INT_Ctrl1
		ORA	#D_TM0IntEn
		STA	P_INT_Ctrl1
		LDA	P_TIMER_EN
		ORA	#D_TM0En
		STA	P_TIMER_EN
		LDA	#00
		STA	P_WDT_Clear
		SEI	
		JSR	F_UART_Initial
		LDA	#D_UARTReset+D_UARTEn+D_UARTRxIntEn
		STA	P_UART_Ctrl1
		LDA	P_UART_Data
		LDA	#D_UARTStopBit1+D_UARTDataBit8
		STA	P_UART_Ctrl2
		; 开中断，恢复正常调度
		CLI
		JSR	Voice_PowerOn_Noxiaonao	
		RTS
		
	?DoPowerOff:
		JSR	F_SystemPowerOff
		RTS

F_SystemPowerOff:
_F_SystemPowerOff:
		; 供按键长按关机和 C 端低电自动关机共用的统一关机入口
		%bits	R_KeyFlag,D_LCDOFF
		; Power OFF
		LDA	#00
		STA	P_LCD_Ctrl1	; 先关显示驱动
		STA	P_LCD_PUMP_Ctrl	; 关闭 LCD 电荷泵
		STA	P_LCD_VLCD_Ctrl	; 关闭 VLCD
		STA	P_LCD_BIAS_Ctrl	; 关闭偏压
		STA	P_LCD_Ctrl2	; 清除 LCD 附加显示控制
		STA	P_UART_Ctrl1	; 关闭 MCU 侧 UART
		STA	P_UART_Ctrl2
		STA	P_ADC_Ctrl1	; 关闭 ADC 模块
		STA	P_ADC_Ctrl2
		STA	P_ADC_VREF_Ctrl
		LDA	P_INT_Ctrl1
		AND	#11110111B	; 清除 TM0 中断使能
		STA	P_INT_Ctrl1
		LDA	P_TIMER_EN
		AND	#11111110B	; 清除 TM0 使能
		STA	P_TIMER_EN
		LDA	P_IO_PortA_Data
		ORA	#00100000B	; PA5 拉高，断开语音模块电源
		STA	P_IO_PortA_Data
			
		; 关机时同时关闭背光：禁用PWM并拉低PA1，设置当前亮度为0
		LDA	P_PWMIO_Ctrl
		AND	#11111101B	; 清除 D_PWMIO1En (bit1)
		STA	P_PWMIO_Ctrl
		LDA	P_IO_PortA_Data
		AND	#11111101B	; 拉低 PA1
		STA	P_IO_PortA_Data
		JSR	F_KeepPA3InputPulldown
		
		%bitr	R_OtherFlag,D_Alarming
		; 关机时清除串口/语音打开标志，确保语音通道关闭
		%bitr	R_OtherFlag,D_Urat_Open
		LDA	#00
		STA	R_DelayOpen
		STA	R_VoiceFlag
		%bitr	R_TimerFlag,(D_Timerstatus+D_Timerstatus_just)
		RTS
_F_KeepPA3InputPulldown:
F_KeepPA3InputPulldown:
		LDA	P_IO_PortA_Dir
		AND	#11110111B
		STA	P_IO_PortA_Dir
		LDA	P_IO_PortA_Attrib
		AND	#11110111B
		STA	P_IO_PortA_Attrib
		LDA	P_IO_PortA_Data
		AND	#11110101B	; 同时保持 PA1 数据锁存为 0，避免 PWM 极性被 PortA 读改写带反
		STA	P_IO_PortA_Data
		RTS
    
; 函数：Voice_PowerOn
Voice_PowerOn:
_Voice_PowerOn:
    LDA     P_IO_PortA_Data
    AND     #0x20            ; 检查 bit5
    BEQ     ?exit           ; 如果已是低电平，直接退出
    LDA     P_IO_PortA_Data
    AND     #11011111B            ; 清除 bit5
    STA     P_IO_PortA_Data
	JSR		F_KeepPA3InputPulldown
    LDA     #0x64
    STA     R_DelayOpen
    LDA     R_VoiceFlag
    AND     #~D_OpenReady   ; 清除准备就绪标志
    STA     R_VoiceFlag
		; 初始化：清除闹钟查看播放标志，避免上电时为随机值
		LDA     #00
		STA     R_AlarmViewFlag
 	; 请求主循环播放唤醒应答（汇编不能直接调用C）
	LDA		R_VoiceFlag
	ORA		#D_WakePlay
	STA		R_VoiceFlag   
?exit:
    RTS    		
; 函数：Voice_PowerOn
Voice_PowerOn_Noxiaonao:
_Voice_PowerOn_Noxiaonao:
    LDA     P_IO_PortA_Data
    AND     #0x20            ; 检查 bit5
    BEQ     ?exit           ; 如果已是低电平，直接退出
    LDA     P_IO_PortA_Data
    AND     #11011111B            ; 清除 bit5
    STA     P_IO_PortA_Data
	JSR		F_KeepPA3InputPulldown
    LDA     #0x64
    STA     R_DelayOpen
    LDA     R_VoiceFlag
    AND     #~D_OpenReady   ; 清除准备就绪标志
    STA     R_VoiceFlag

?exit:
    RTS    		
;F_OpenXiaonao:
;		%bits	R_OtherFlag,D_Urat_Open		;打开语音
;		LDA     #D_UI_Time
;		STA		R_Uart_UI
;		LDA		P_IO_PortA_Data
;		AND		#.NOT.0x22
;		STA		P_IO_PortA_Data
;		JSR		Voice_PowerOn
	;    P_IO_PortA_Data &= ~0x20;	//bit5 拉DI

;		RTS		
Enable_TimeKey:	
		LDA		R_TimerFlashSet
		ORA		R_AlmTimeFlashSet
		BNE		?L_Exit
		JSR		F_UpdateKey
		LDA		R_TimeFlashSet
		BNE		?L_NextSet	
		RTS
		?L_NextSet:
		clc
		rol		R_TimeFlashSet
		lda		R_TimeFlashSet
		cmp		#D_SetTimeMax
		BNE		?L_Exit
		lda		#00
		sta		R_TimeFlashSet
		; 请求播放“设置时间成功”语音（由主循环播放）
		LDA		R_VoiceReq
		ORA		#D_VOICE_TIME_SET
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP	;按键音
	?L_Exit:	
			; 如果处于时间设置的小时阶段，按下按键时请求播放“时间设置为”短提示
		LDA		R_TimeFlashSet
		AND		#D_SetHour
		BEQ		?Skip_TimeSetBeepUp
		LDA		R_VoiceReq
		ORA		#D_VOICE_TIME_SET
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP
	?Skip_TimeSetBeepUp:

		RTS	
.PUBLIC	BitMaskTable	
; 位掩码表
BitMaskTable:
    .DB $01, $02, $04, $08, $10, $20, $40, $80

; ===================== 核心：闹钟短按处理（精简分支+内联子函数） =====================
Enable_AlarmKey:
    JSR		F_UpdateKey        ; 更新按键状态	
	LDA		R_VoiceFlag
	AND		#D_OpenReady
	BNE		?Alarm_Cont
	JSR		Voice_PowerOn
	RTS
?Alarm_Cont:
	LDA		R_TimerFlashSet
	ORA		R_TimeFlashSet
	BNE		?L_Exit

    LDA		R_AlmTimeFlashSet
    BEQ		?L_NonSetMode      ; 非设置：循环查看
    
    ; --- 设置状态：时->分->天制->确认
    LDA     R_AlmTimeFlashSet
    CMP     #D_SetAlmHour    ; 时 -> 分
    BEQ     ?L_ToMinute
    CMP     #D_SetAlmMinute  ; 分 -> 天制
    BEQ     ?L_ToDay
    CMP     #D_SetAlmDay     ; 天制 -> 确认退出
    BEQ     ?L_ConfirmExit
    RTS

	; 非设置状态：循环切换组（内联精简）
	?L_NonSetMode:
		; 请求播放“闹钟查看”语音（由主循环播放），仅第一次短按播放
		LDA		R_AlarmViewFlag
		AND		#D_AlarmView_Played
		BNE		?Skip_AlarmViewPlay
		LDA		R_VoiceReq
		ORA		#D_VOICE_ALARM_CHECK
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP	;按键音
	?Skip_AlarmViewPlay:			
		; 标记已播放，后续短按不再播放
		LDA		R_AlarmViewFlag
		ORA		#D_AlarmView_Played
		STA		R_AlarmViewFlag	
		
		INC     R_CurrentGroup
		LDA		R_CurrentGroup
		CMP     #3
		BCC     ?L_Exit
		LDA     #0
		STA     R_CurrentGroup	
		


;		STA		R_VoiceReq
		RTS
	
		; 初始化：清除闹钟查看播放标志，避免上电时为随机值
		LDA	#00
		STA	R_AlarmViewFlag
	; 开关阶段：查表提取状态（精简边界检查）
	?L_HandleAlmSwitch:
		LDA     R_CurrentGroup
		TAX                     
		CPX     #3              ; 边界检查：超3则归0
		BCC     ?L_GetMask      
		LDX     #0              
	
	?L_GetMask:
		LDA     BitMaskTable,X  
		STA     L_TempBit       
		LDA     R_AlarmOnOff    
		AND     L_TempBit       
		BEQ     ?L_Exit ; 关闭：跳过组(此路径不再触发,保留兼容)
		
		LDA     #D_SetAlmHour   ; 开启：进小时设置
		STA     R_AlmTimeFlashSet
		JMP     ?L_Exit
	
	?L_ToMinute:	; 小时→分钟
		LDA     #D_SetAlmMinute
		STA     R_AlmTimeFlashSet
		RTS	
	?L_ToDay:	; 分钟→工作日
		LDA     #D_SetAlmDay
		STA     R_AlmTimeFlashSet
		RTS
	
	?L_ConfirmExit:		; 确认:保存并退出闹钟设置
		LDA		#00
		STA		R_AlmTimeFlashSet
	?L_Exit:
		RTS
;		BNE		e_VolumeKey:	;音量调节键
; 		LDA		R_TimeFlashSet
; 		ORA		R_AlmTimeFlashSet
; 		bne		?L_Exit
; 		JSR		F_UpdateKey
; 		LDA		R_VolumeFlashSet
; 		BEQ		?L_Next
; 		LDA		#00
; 		STA		R_VolumeFlashSet
; 		%bits	R_OtherFlag,D_ToneDIS
; 		RTS
; 	?L_Next:
; 		INC R_CurrentVolume
; 		LDA R_CurrentVolume
; 		CMP #3              ; 保持0-2范围
; 		BCC ?L_SetVolume
; 		LDA	#0
; 		STA R_CurrentVolume
; 	?L_SetVolume:	
; 		LDA	#1
; 		STA	SetVolumeAndPlayAlarm1_flag
; 	?L_Exit:
; 		RTS		
		

Enable_TimerKey:	;暂停和开始计时键
		JSR		F_UpdateKey		
		LDA		R_VoiceFlag
		AND		#D_OpenReady
		BNE		?Timer_Cont
		JSR		Voice_PowerOn
		RTS
	?Timer_Cont:
		; 若时间/闹钟设置态激活,短按计时键退出
		LDA		R_TimeFlashSet
		ORA		R_AlmTimeFlashSet
		BNE		?L_ClearOtherSet
		; --- 1.计时运行中 -> 暂停 ---
		LDA		R_TimerFlag
		AND		#(D_Timerstatus_just+D_Timerstatus)
		BEQ		?L_SkipPause
		JMP		?L_Pause
	?L_SkipPause:
		; --- 2.计时暂停中 -> 继续 ---
		LDA		R_TimerFlag
		AND		#(D_Timerstatus_justpause+D_TimerPausedCountDown)
		BEQ		?L_SkipResume
		JMP		?L_Resume
	?L_SkipResume:
		; --- 3.倒计时设置态 -> 开始倒计时 ---
		LDA		R_TimerFlashSet
		CMP		#D_TimerSet
		BNE		?L_SkipCdStart
		JMP		?L_StartCountdown
	?L_SkipCdStart:
		; --- 4.计时清零(00:00) -> 切换正/倒计时模式 ---
		LDA		R_TimerFlag
		EOR		#D_TimerModeCountdown
		STA		R_TimerFlag
		AND		#D_TimerModeCountdown
		BNE		?L_DoSetMode
		JMP		?L_Exit
	?L_DoSetMode:
		; 切到倒计时:进入设置态,默认60分钟
		LDA		#60
		STA		R_TimerMinute
		LDA		#0
		STA		R_TimerSecond
		LDA		#D_TimerSet
		STA		R_TimerFlashSet
		RTS
	?L_ClearOtherSet:	; 退出其他设置态
		LDA		#00
		STA		R_TimeFlashSet
		STA		R_AlmTimeFlashSet
		RTS
	?L_Pause:			; 倒计时运行->倒计时暂停
		%btst	R_TimerFlag,D_Timerstatus_just,?L_PauseFwd
		%bitr	R_TimerFlag,D_Timerstatus
		%bits	R_TimerFlag,D_TimerPausedCountDown
		LDA		R_VoiceReq
		AND		#1FH
		ORA		#D_VOICE_TIMER_PAUSE
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP
		RTS
	?L_PauseFwd:			; 正计时运行->正计时暂停
		%bitr	R_TimerFlag,D_Timerstatus_just
		%bits	R_TimerFlag,D_Timerstatus_justpause
		LDA		R_VoiceReq
		AND		#1FH
		ORA		#D_VOICE_TIMER_PAUSE
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP
		RTS
	?L_Resume:			; 倒计时暂停->倒计时运行
		%btst	R_TimerFlag,D_Timerstatus_justpause,?L_ResumeFwd
		%bitr	R_TimerFlag,D_TimerPausedCountDown
		%bits	R_TimerFlag,D_Timerstatus
		LDA		R_VoiceReq
		AND		#1FH
		ORA		#D_VOICE_TIMER_CONTINUE
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP
		RTS
	?L_ResumeFwd:		; 正计时暂停->正计时运行
		%bitr	R_TimerFlag,D_Timerstatus_justpause
		%bits	R_TimerFlag,D_Timerstatus_just
		LDA		R_VoiceReq
		AND		#1FH
		ORA		#D_VOICE_TIMER_CONTINUE
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP
		RTS
	?L_StartCountdown:	; 倒计时设置态短按->开始倒计时
		LDA		#0
		STA		R_TimerFlashSet
		LDA		R_TimerFlag
		AND		#~(D_Timerstatus_justpause+D_TimerPausedCountDown)
		ORA		#(D_Timerstatus+D_TimerModeCountdown)
		STA		R_TimerFlag
		LDA		R_VoiceReq
		AND		#1FH
		ORA		#D_VOICE_TIMER_START
		STA		R_VoiceReq
		%bitr	R_VoiceReq,D_VOICE_BEEP
	?L_Exit:			; 切回正计时模式,仅更新图标
		RTS
;===============================================		
F_UpdateKey:						
		%bits	R_KeyFlag,D_KeyRelDis	
F_UpdateKey2:							
		LDA		#C_SleepSec
		STA		R_SetBack
		%bits	RB_Lcd_Updata_Flag,D_LcdUpdate			
		RTS


; ==============================================
; Function	name	: L_UP_Key
; Purpose			: SELECT Clock or Alarm Clock Hour Minu second
; Parameter			: none 
; Return			: Hour Minu second registers
; Destroy			: none 
; Stack depth		: none
; ==============================================
Enable_UpKey:
		JSR		F_UpdateKey	
		LDA		R_VoiceFlag
		AND		#D_OpenReady
		BNE		?Up_Cont
		JSR		Voice_PowerOn
		RTS
	?Up_Cont:

		LDA		R_TimeFlashSet
		ORA		R_AlmTimeFlashSet
		ORA		R_TimerFlashSet
		BNE		?L_settup_check
; 	?L_NotSetUp:		;调节倒计时时间1-99分钟
; 		%btst	R_TimerFlag,(D_Timerstatus_just+D_Timerstatus),?L_Exit	
; 	  	%bitr	R_TimerFlag,D_Timerstatus_justpause
; 		%bits	R_TimerFlag,D_TimerSetstatus
; ;		LDA		#32d
; ;		STA		R_POINT 
; 		inc		R_TimerMinute
; 		LDA		R_TimerMinute
; 		CMP		#60d
; 		BCC		?L_Exit_Up
; 	?L_GV_0_minu_time_timer:
; 		LDA		#0d
; 		STA		R_TimerMinute
; ;		STA		R_POINT 
; 	?L_Exit_Up:	
; 		LDA		#00
; 		STA		R_TimerSecond   
;	?L_Exit:
;		RTS
	; 增加音量调节逻辑
		LDA		R_CurrentVolume
		CMP		#2
		BCS		?L_Exit		; 如果已经是最大音量(2)，则不处理
		INC		R_CurrentVolume
	?L_Exit:
		LDA		#1
		STA		SetVolumeAndPlayAlarm1_flag	
		RTS

	?L_settup_check:
		LDA		R_TimeFlashSet
		CMP		#D_SetYear
		BEQ		L_UP_Date_Year_setup
		CMP		#D_SetMonth
		BEQ		L_UP_Date_Month_setup
		CMP		#D_SetDate
		BEQ		L_UP_Date_Day_setup
;		CMP		#D_Set12_24
;		BEQ		L_UP_12_24_setup
		CMP		#D_SetHour
		BEQ		L_UP_Time_Hour_setup
		CMP		#D_SetMinute
		BEQ		L_UP_Time_Minute_setup
		
		LDA		R_AlmTimeFlashSet
		CMP		#D_SetAlm
		BEQ		?L_UP_AlarmFlog_set
		CMP		#D_SetAlmHour
		BEQ		?L_UP_Alarm_Hour_setup
		CMP		#D_SetAlmMinute
		BEQ		?L_UP_Alarm_Minute_setup
		CMP		#D_SetAlmDay
		BEQ		?L_UP_Alarm_Day_setup
	
		LDA		R_TimerFlashSet
		CMP		#D_TimerSet
		BEQ		?L_UP_Timer_setup
		RTS	

	?L_UP_AlarmFlog_set:
		jmp		L_UP_AlarmFlog_set	
	?L_UP_Alarm_Hour_setup:
		JMP		L_UP_Alarm_Hour_setup
	?L_UP_Alarm_Minute_setup:
		JMP		L_UP_Alarm_Minute_setup
	?L_UP_Alarm_Day_setup:
		JMP		L_UP_Alarm_Day_setup
	?L_UP_Timer_setup:
		JMP		L_UP_Timer_setup
	L_UP_12_24_setup:
		LDA		RB_12_24_Status
		EOR		#D_12H
		STA		RB_12_24_Status
		RTS			
;====================================		
	L_UP_Time_Hour_setup:
		INC		R_DateHour
		LDA		R_DateHour
		CMP		#24d
		BCC		?L_Show_hour_up
	?L_GV_0_hour_time:
		LDA		#0D
		STA		R_DateHour
		STA		R_LCDHourBuff		
	?L_Show_hour_up:
		; JSR		F_Settup_Hour_LCD_Disp
		; JSR		F_Qlvi_Show
		RTS	
;====================================		
	L_UP_Time_Minute_setup:
		INC		R_DateMinute
		LDA		R_DateMinute
		CMP		#61d
		BCS		?L_GV_0_minu_time
		JMP		L_Dateminu_show
	?L_GV_0_minu_time:
		LDA		#0D
		STA		R_DateMinute
		STA		R_LCDMinuBuff
	L_Dateminu_show:
		; JSR		F_Settup_Minute_LCD_Disp
		; JSR		F_Qlvi_Show
		RTS		
;====================================		
	L_UP_Date_Year_setup:
		INC		R_Year
		LDA		R_Year
		CMP		#99d
		BCS		?L_Gv_0
		JMP		L_Calc_week_up_lcd_show
	?L_Gv_0:
		LDA		#00D
		STA		R_Year
	L_Calc_week_up_lcd_show:
		; JSR		F_Settup_Year_LCD_Disp
	L_Calc_week_up:
		jsr		F_JudegLeapYear
		JSR		F_JudgeWeek
		; JSR		F_Qlvi_Show
		RTS	
;====================================		
	L_UP_Date_Month_setup:
		INC		R_Month
		LDA		R_Month
		CMP		#13d
		BCC		L_Calc_week_up_head
	?L_Gv_0_month:
		LDA		#1d
		STA		R_Month
		JMP		L_Calc_week_up_head


;====================================		
	L_UP_Date_Day_setup:
		INC		R_Day
		LDA		R_Day
		LDX		R_Month
 	    JSR     F_GetMonthDays ; 获取该月天数 -> A
 	    CMP     R_Day          ; 比较当前天数与该月总天数
 	    BCC     ?ResetDay      ; 如果R_Day > 月份天数，重置
 	    JMP     L_Calc_week_up
	?ResetDay:		
;		CMP		T_key_Month_Table,x
; 		BEQ		?L_VGIH
; 		BCS		?L_Check_gv_0_day
; ?L_VGIH:
; 		; JSR		F_Settup_day_LCD_Disp
; 		JMP		L_Calc_week_up
; ?L_Check_gv_0_day:
		LDA		#01h
		STA		R_Day
		; JSR		F_Settup_day_LCD_Disp
		JMP		L_Calc_week_up
; ==============================================
; 函数名：L_Calc_week_up_head
; 功能：调节月份后，检查并修正日期
; 说明：切换月份后，若当前日期 > 该月最大天数，重置为该月最大天数
; ==============================================		
L_Calc_week_up_head:
		LDX     R_Month             ; 载入当前调节后的月份到X
		JSR     F_GetMonthDays      ; A = 该月最大天数（已处理2月闰年）
		
		CMP     R_Day               ; 比较：当月最大天数(A) vs 当前日期(R_Day)
		BCC     ?ResetDay           ; 若A < R_Day（日期超限），跳转重置
		JMP     L_Calc_week_up      ; 日期合法，执行后续逻辑
		
	?ResetDay:
		; 直接使用之前获取的A值（当月最大天数）重置日期，无冗余操作
		STA     R_Day               ; 核心：将日期重置为当月最大天数
		JMP     L_Calc_week_up      ; 重置后执行后续逻辑  
		
;====================================	
	L_UP_AlarmFlog_set:
		LDX	R_CurrentGroup
	 	LDA BitMaskTable,X
   		EOR R_AlarmOnOff
   		STA R_AlarmOnOff
   		RTS
;====================================	
; L_UP_Alarm_Hour_setup:
; 		INC		R_AlarmHour
; 		LDA		R_AlarmHour
; 		CMP		#24d
; 		BCC		?L_GV_0_alarm_hour_show
; ?L_GV_0_alarm_hour:
; 		LDA		#0D
; 		STA		R_AlarmHour		
; ?L_GV_0_alarm_hour_show:
; 		; JSR		F_Settup_alarmhour_LCD_Disp
; 		; JSR		F_Qlvi_Show
; 		RTS		
 L_UP_Alarm_Hour_setup:
    ; 根据当前组别选择闹钟小时存储位置
    LDA     R_CurrentGroup
    CMP     #0
    BEQ     ?Group0
    CMP     #1
    BEQ     ?Group1   
    ; 组2 - 使用R_AlarmHour+2
    INC     R_AlarmHour+2
    LDA     R_AlarmHour+2
    CMP     #24d
    BCC     ?UpdateDisplay
    LDA     #0
    STA     R_AlarmHour+2
	rts
 ?Group0:
    ; 组0 - 使用R_AlarmHour
    INC     R_AlarmHour
    LDA     R_AlarmHour
    CMP     #24d
    BCC     ?UpdateDisplay
    LDA     #0
    STA     R_AlarmHour
	rts
 ?Group1:
    ; 组1 - 使用R_AlarmHour+1
    INC     R_AlarmHour+1
    LDA     R_AlarmHour+1
    CMP     #24d
    BCC     ?UpdateDisplay
    LDA     #0
    STA     R_AlarmHour+1
 ?UpdateDisplay:
    RTS
	
;====================================		
 L_UP_Alarm_Minute_setup:
    ; 根据当前组别选择闹钟分钟存储位置
    LDA     R_CurrentGroup
    CMP     #0
    BEQ     ?Group0
    CMP     #1
    BEQ     ?Group1
    
    ; 组2 - 使用R_AlarmMinute+2
    INC     R_AlarmMinute+2
    LDA     R_AlarmMinute+2
    CMP     #60d
    BCC     ?UpdateDisplay
    LDA     #0
    STA     R_AlarmMinute+2
    RTS
 ?Group0:
    ; 组0 - 使用R_AlarmMinute
    INC     R_AlarmMinute
    LDA     R_AlarmMinute
    CMP     #60d
    BCC     ?UpdateDisplay
    LDA     #0
    STA     R_AlarmMinute
	rts
 ?Group1:
    ; 组1 - 使用R_AlarmMinute+1
    INC     R_AlarmMinute+1
    LDA     R_AlarmMinute+1
    CMP     #60d
    BCC     ?UpdateDisplay
    LDA     #0
    STA     R_AlarmMinute+1
 ?UpdateDisplay:
    RTS
;====================================
L_UP_Alarm_Day_setup:
    LDX     R_CurrentGroup
    LDA     R_DispAlmDay,X
    CLC
    ADC     #1
    CMP     #3
    BCC     ?Store
    LDA     #0
?Store:
    STA     R_DispAlmDay,X
    RTS
;  L_UP_Volume_setup:
;  		%bits	R_OtherFlag,D_SetVolumeFlag
; 		INC     R_CurrentSong      ; 直接加1
; 		LDA     R_CurrentSong
; 		CMP     #7
; 		BCC     ?Send_Song          
; 		LDA     #0                 ; 否则重置为0
; 		STA     R_CurrentSong	
; 	?Send_Song:	
; 		RTS
L_UP_Timer_setup:		;调节倒计时时间1-99分钟
		%btst	R_TimerFlag,(D_Timerstatus_just+D_Timerstatus),?L_Exit	
	  	%bitr	R_TimerFlag,D_Timerstatus_justpause
		%bits	R_TimerFlag,D_TimerSetstatus
;		LDA		#32d
;		STA		R_POINT 
		inc		R_TimerMinute
		LDA		R_TimerMinute
		CMP		#60d
		BCC		?L_Exit_Up
	?L_GV_0_minu_time_timer:
		LDA		#0d
		STA		R_TimerMinute
;		STA		R_POINT 
	?L_Exit_Up:	
		LDA		#00
		STA		R_TimerSecond   
	?L_Exit:
		RTS
		
; ==============================================
; Function	name	: L_Down_Key
; Purpose			: Select Alarm Or Clock seting Mode 
; Parameter			: none 
; Return			: Flgs
; Destroy			: none 
; Stack depth		: none
; ==============================================
Enable_DownKey:
		JSR		F_UpdateKey	
		LDA		R_VoiceFlag
		AND		#D_OpenReady
		BNE		?Down_Cont
		JSR		Voice_PowerOn
		RTS
	?Down_Cont:

		LDA		R_TimeFlashSet
		ORA		R_AlmTimeFlashSet
		ORA		R_TimerFlashSet
		BNE		?L_settup_check
	?L_NotSetUp:		;调节倒计时时间1-99分钟
;		%btst   R_TimerFlag,(D_Timerstatus_just+D_Timerstatus),?L_Exit
;		%bitr	R_TimerFlag,D_Timerstatus_justpause
;		%bits	R_TimerFlag,D_TimerSetstatus
;;		LDA		#32d
;;		STA		R_POINT 
;		DEC		R_TimerMinute
;		LDA		R_TimerMinute
;		BEQ		?L_0mintime_timer
;		BMI		?L_GV_0_minu_time_timer
;		JMP		?L_Exit_Down
;?L_0mintime_timer:
;;		LDA		#00
;;		STA		R_POINT 	
;		JMP		?L_Exit_Down	
;?L_GV_0_minu_time_timer:
;		LDA		#60D	
;		STA		R_TimerMinute
;?L_Exit_Down:
;		LDA		#00
;		STA		R_TimerSecond
;	?L_Exit:	
;		RTS

	; 减少音量调节
		LDA		R_CurrentVolume
		BEQ		?L_Exit		; 如果已经是最小音量(0)，则不处理
		DEC		R_CurrentVolume
	?L_Exit:
		LDA		#1
		STA		SetVolumeAndPlayAlarm1_flag	
		RTS

?L_settup_check:
		LDA		R_TimeFlashSet
		CMP		#D_SetYear
		BEQ		?L_Down_Date_Year_setup
		CMP		#D_SetMonth
		BEQ		?L_Down_Date_Month_setup
		CMP		#D_SetDate
		BEQ		?L_Down_Date_Day_setup
;		CMP		#D_Set12_24
;		BEQ		?L_Down_12_24_setup
		CMP		#D_SetHour
		BEQ		L_Down_Time_Hour_setup
		CMP		#D_SetMinute
		BEQ		L_Down_Time_Minute_setup
		
		LDA		R_AlmTimeFlashSet
		CMP		#D_SetAlm
		BEQ		?L_Down_AlarmFlog_set
		CMP		#D_SetAlmHour
		BEQ		?L_Down_Alarm_Hour_setup
		CMP		#D_SetAlmMinute
		BEQ		?L_Down_Alarm_Minute_setup
		CMP		#D_SetAlmDay
		BEQ		?L_Down_Alarm_Day_setup
	
		LDA		R_TimerFlashSet
		CMP		#D_TimerSet
		BEQ		?L_Down_Timer_setup
		
		RTS	
?L_Down_Date_Year_setup
		JMP		L_Down_Date_Year_setup
?L_Down_Date_Month_setup:
		JMP		L_Down_Date_Month_setup
?L_Down_Date_Day_setup:
		JMP		L_Down_Date_Day_setup
?L_Down_12_24_setup:
		JMP		L_UP_12_24_setup
?L_Down_AlarmFlog_set:
		JMP		L_UP_AlarmFlog_set
?L_Down_Alarm_Hour_setup:
		JMP		L_Down_Alarm_Hour_setup
?L_Down_Alarm_Minute_setup:	
		JMP		L_Down_Alarm_Minute_setup
?L_Down_Alarm_Day_setup:
		JMP		L_Down_Alarm_Day_setup
?L_Down_Timer_setup:
		JMP		L_Down_Timer_setup
		
;====================================
L_Down_Time_Hour_setup:
		DEC		R_DateHour
		LDA		R_DateHour
;		BMI		?L_GV_23_time
		BPL		?L_Hour_show_down
?L_GV_23_time:
		LDA		#23D
		STA		R_DateHour
?L_Hour_show_down:
		STA		R_LCDHourBuff
		; JSR		F_Settup_Hour_LCD_Disp
		; JSR		F_Qlvi_Show
		RTS	
;====================================
L_Down_Time_Minute_setup:
		DEC		R_DateMinute
		LDA		R_DateMinute
		BMI		?L_GV_60
		STA		R_LCDMinuBuff
		rts
?L_GV_60:
		LDA		#59D
		STA		R_DateMinute
		STA		R_LCDMinuBuff
		RTS


;====================================
L_Down_Date_Year_setup:
		DEC		R_Year
		LDA		R_Year
		BMI		?L_Gv_0
;		JMP		L_Calc_week_up_lcd_show
		JMP		L_Calc_week
?L_Gv_0:
		LDA		#99D
		STA		R_Year
		JMP		L_Calc_week_up_lcd_show
L_Calc_week:
		jsr		F_JudegLeapYear
		JSR		F_JudgeWeek
		; JSR		F_Qlvi_Show
		RTS	
;====================================
L_Down_Date_Month_setup:
		DEC		R_Month
		LDA		R_Month
		BEQ		?L_Gv_12
		JMP		L_Calc_week_up_head
?L_Gv_12:
		LDA		#12d
		STA		R_Month
		JMP		L_Calc_week_up_head

; ==============================================
; 函数名：F_GetMonthDays
; 功能：获取指定月份的天数（自动处理闰年二月）
; 输入：X = 月份 (1-12)
; 输出：A = 该月的天数
; 破坏的寄存器：A
; ==============================================
F_GetMonthDays:
    CPX     #2          ; 检查是否是2月
    BNE     ?NotFebruary ; 不是2月，跳转到查表处理
    ; 处理2月 - 检查闰年标志
    LDA     R_Hejira_LeapYear_CalendarFlag
    AND     #D_LeapYear
    BNE     ?LeapYear  
    ; 平年2月
    LDA     #28
    RTS 
?LeapYear:
    ; 闰年2月
    LDA     #29
    RTS
?NotFebruary:
    ; 其他月份 - 直接查表
    LDA     T_key_Month_Table, x
    RTS

;====================================
L_Down_Date_Day_setup:
		DEC		R_Day
		LDA		R_Day
		BNE		L_Calc_week	
?L_Check_gv:
		LDX		R_Month
;		LDA		T_key_Month_Table,x
		JSR		F_GetMonthDays
		STA		R_Day
		JMP		L_Calc_week
;====================================
L_Down_Alarm_Hour_setup:
    ; 根据当前组别选择闹钟小时存储位置
    LDA     R_CurrentGroup
    CMP     #0
    BEQ     ?Group0
    CMP     #1
    BEQ     ?Group1
    
    ; 组2 - 使用R_AlarmHour+2
    DEC     R_AlarmHour+2
    LDA     R_AlarmHour+2
    BPL     ?UpdateDisplay
    LDA     #23d
    STA     R_AlarmHour+2
    JMP     ?UpdateDisplay
?Group0:
    ; 组0 - 使用R_AlarmHour
    DEC     R_AlarmHour
    LDA     R_AlarmHour
    BPL     ?UpdateDisplay
    LDA     #23d
    STA     R_AlarmHour
    JMP     ?UpdateDisplay
?Group1:
    ; 组1 - 使用R_AlarmHour+1
    DEC     R_AlarmHour+1
    LDA     R_AlarmHour+1
    BPL     ?UpdateDisplay
    LDA     #23d
    STA     R_AlarmHour+1
?UpdateDisplay:
		; JSR		F_Settup_alarmhour_LCD_Disp
		; JSR		F_Qlvi_Show
		RTS			
;====================================
L_Down_Alarm_Minute_setup:
    ; 根据当前组别选择闹钟分钟存储位置
    LDA     R_CurrentGroup
    CMP     #0
    BEQ     ?Group0_Min
    CMP     #1
    BEQ     ?Group1_Min
    
    ; 组2 - 使用R_AlarmMinute+2
    DEC     R_AlarmMinute+2
    LDA     R_AlarmMinute+2
    BPL     ?UpdateDisplay_Min
    LDA     #59d
    STA     R_AlarmMinute+2
    JMP     ?UpdateDisplay_Min
?Group0_Min:
    ; 组0 - 使用R_AlarmMinute
    DEC     R_AlarmMinute
    LDA     R_AlarmMinute
    BPL     ?UpdateDisplay_Min
    LDA     #59d
    STA     R_AlarmMinute
    JMP     ?UpdateDisplay_Min
?Group1_Min:
    ; 组1 - 使用R_AlarmMinute+1
    DEC     R_AlarmMinute+1
    LDA     R_AlarmMinute+1
    BPL     ?UpdateDisplay_Min
    LDA     #59d
    STA     R_AlarmMinute+1
?UpdateDisplay_Min:
		; JSR		F_Settup_alarmminu_LCD_Disp
		; JSR		F_Qlvi_Show
		RTS	
;====================================
L_Down_Alarm_Day_setup:
    LDX     R_CurrentGroup
    LDA     R_DispAlmDay,X
    SEC
    SBC     #1
    BPL     ?Store
    LDA     #2
?Store:
    STA     R_DispAlmDay,X
    RTS
; L_Down_Volume_setup:
	; 	%bits	R_OtherFlag,D_SetVolumeFlag
	; 	DEC     R_CurrentSong      
	; 	LDA     R_CurrentSong
	; 	BPL     ?L_Exit     ; 非0则继续发送
	; 	LDA     #6                ; 减到0则重置为7
	; 	STA     R_CurrentSong				
	; ?L_Exit:
	; 	RTS	
L_Down_Timer_setup:
		%btst   R_TimerFlag,(D_Timerstatus_just+D_Timerstatus),?L_Exit
		%bitr	R_TimerFlag,D_Timerstatus_justpause
		%bits	R_TimerFlag,D_TimerSetstatus
;		LDA		#32d
;		STA		R_POINT 
		DEC		R_TimerMinute
		LDA		R_TimerMinute
		BEQ		?L_0mintime_timer
		BMI		?L_GV_0_minu_time_timer
		JMP		?L_Exit_Down
?L_0mintime_timer:
;		LDA		#00
;		STA		R_POINT 	
		JMP		?L_Exit_Down	
?L_GV_0_minu_time_timer:
		LDA		#60D	
		STA		R_TimerMinute
?L_Exit_Down:
		LDA		#00
		STA		R_TimerSecond
?L_Exit:		
		RTS
		

T_key_Month_Table:
	DB	0xFF
	DB 	31		;一月
	DB	28		;二月
	DB	31		;三月
	DB	30		;四月
	DB	31		;五月
	DB	30		;六月
	DB	31		;七月
	DB	31		;八月
	DB	30		;九月
	DB	31		;十月
	DB	30		;十一月
	DB	31		;十二月
		
;
;
;	
;;------------------------------------------
;; 函数：F_OpenData
;; 功能：I2C读取温度传感器数据 → 计算摄氏度 → 阈值判断 → 数据打包
;; 入口：无
;; 出口：R_DispTemper=打包温度；R_SpecFlag=状态标志
;;------------------------------------------
;F_OpenData:
;_F_OpenData:
;        ; 1. I2C写命令：读取温度传感器
;        LDX  #F6H        ; 传感器读取命令（根据你的传感器调整）
;        LDA  #00H         ; 寄存器地址
;        JSR  F_I2C_WriteData
;        
;        ; 2. 延时10ms等待数据就绪
; ;       JSR  F_Delay10ms
; 		LDA	 #2
; 		STA  R_DelayTemp
;        ; 3. I2C读取6字节原始数据到R_SaveData
; 		RTS
; 
;F_DelayReadyData:
;_F_DelayReadyData:
;		%btsf R_SpecFlag,D_DelayReady,?L_Exit
;        LDA  #00H
;        JSR  F_I2C_ReadData
;        %bitr R_SpecFlag,D_DelayReady
;        	%bits	RB_Lcd_Updata_Flag,D_LcdUpdate	
; 		 ; 步骤2：初始化状态标志（先清零）
;		LDA  #00H
;		STA  R_SpecFlag           	
;        ; 4. 计算摄氏度（核心）
;        JSR  F_CalculTempC
; 		JSR		F_CalculHum
; 		
;;		%bits	R_TimeStatus,AddOthers  
; 	?L_Exit:
;        RTS
;
;;湿度计算
;F_CalculHum:
;			;调用输入CNT4，CNT5
;			LDA		R_SaveData+3
;			STA		CNT4
;			LDA		R_SaveData+4
;			STA		CNT5
;			JSR	CAL_IC_HUM
;			LDX	#00
;			LDA	HUM
;			JSR	F_CAL_HEX_BCD2
;			
;			LDA		OUT_L
;			STA		R_DispHum
;					
;			RTS
;;------------------------------------------
;; 函数：F_CalculTempC
;; 功能：原始数据转摄氏度 → 正负判断 → 阈值判断 → 打包到R_DispTemper
;; 依赖：CAL_IC_TEMP（温度换算子程序，需外部提供）
;;------------------------------------------
;     
;F_CalculTempC:
;        ; 4.1 准备参数：R_SaveData[0/1] → CNT4/CNT5
;        LDA  R_SaveData+0
;        STA  CNT4
;        LDA  R_SaveData+1
;        STA  CNT5
;        JSR  CAL_IC_TEMP  ; 调用传感器温度换算，结果→TEMP_INTEGAH/L
;				   
;        	
;        ; 4.2 温度正负判断（符号位在TEMP_INTEGAH最高位）
;        LDA  TEMP_INTEGAH
;        AND  #80H         ; 提取符号位（bit7=1→负数）
;        BEQ  ?Positive    ; 符号位=0 → 正数分支
;        
;?Negtive:
;        ; 负温度处理：置位D_Neg，清除符号位取绝对值
;        %bits R_SpecFlag, D_Neg
;        LDA  TEMP_INTEGAH
;        AND  #7FH         ; 清除符号位，保留数值部分 	
;        STA  TEMP_INTEGAH
;        ; 跳转到阈值判断
;        JMP  ?CheckThreshold
;
;?Positive:
;        ; 正温度处理：清除D_Neg标志
;   ;     %bitr R_SpecFlag, D_Neg
;        ; 直接进入阈值判断
;
;?CheckThreshold:
;		LDX  #00H         ; F_CAL_HEX_BCD2输入：X=高位（0），A=温度绝对值
;		LDA  TEMP_INTEGAL
;		JSR  F_CAL_HEX_BCD2  ; 输出：OUT_M=BCD十位，OUT_L=BCD个位	
;        ; 4.3 温度阈值判断（TEMP_INTEGAH为温度绝对值）
;    
;    ; 步骤5：基于BCD码判断阈值（核心修正！）
;    ; 5.1 判断是否>70℃（BCD：十位>7 或 十位=7且个位>0）
;    LDA  OUT_M
;    CMP  #C_TEMP_HH  ; 比较十位（7）
;    BCS  ?SetTempHH        ; 十位>7 → 肯定>70℃
;    JMP  ?CheckTempLL
;?SetTempHH:
;    %bits R_SpecFlag, D_TempHH  ; 置位>70℃标志
;    JMP  ?PackTemp
;    
;    ; 5.2 判断是否<-9℃（仅负数+BCD绝对值>9）
;?CheckTempLL:
;    %btsf R_SpecFlag, D_Neg, ?PackTemp  ; 正数跳过低温判断
;    ; 负数：判断BCD绝对值是否>9（个位>9 或 十位≥1）
;    LDA  OUT_M
;    BNE  ?SetTempLL        ; 十位≥1 → 绝对值≥10 >9
;    LDA  OUT_L
;    CMP  #C_TEMP_LL  ; 个位>9 → 绝对值>9
;    BCS  ?SetTempLL
;    JMP  ?PackTemp
;?SetTempLL:
;    %bits R_SpecFlag, D_TempLL  ; 置位<-9℃标志
;    
;    ; 步骤6：温度数据打包（1字节）
;?PackTemp:
;    LDA  OUT_M
;    AND  #0FH          ; 确保十位是0~9（BCD范围）
;    ASL  A             ; 左移1位
;    ASL  A             ; 左移2位
;    ASL  A             ; 左移3位 → 移到bit3~0 → 再调整到bit6~4
;    ASL  A             ; 左移4位 → 十位进入bit4~7（后续只保留bit6~4）
;    STA  R_DispTemper
;
;    ; 6.4 打包BCD个位（OUT_L → bit3~0）
;    LDA  OUT_L
;    AND  #F0H          ; 确保个位是0~9
;    ROR	 A	
;    ROR	 A	 
;    ROR	 A	
;    ROR	 A	
;    
;    ORA  R_DispTemper  ; 合并个位到bit3~0
;    STA  R_DispTemper  ; 最终打包完成
;    
;    RTS
;==========================================================	
;F_Delay10ms:
;		JSR		F_SendDataDelay
;		JSR		F_SendDataDelay
;		JSR		F_SendDataDelay
;		RTS
;		
;
;		
;.PUBLIC		F_SendDataDelay
;F_SendDataDelay:	
;			LDX		#1FH	
;	?Loop1:		
;			LDA		#3FH
;			STA		R_DelayTemp			
;	?Loop2:
;			DEC		R_DelayTemp
;			LDA		R_DelayTemp
;			BNE		?Loop2			
;			DEX
;			BNE		?Loop1			
;			RTS	        

; 
; ;=========================================================== 
; ;;低电检测 
; ;=========================================================== 
; F_DC_Det: 	 	 	 	 ;DC检测 	 ;低电压检测 
; _F_DC_Det:			
; 	 	 	 %btst 	 R_Charge,D_Charge,?ExitDet 	 ;在充电退出低电检测 
; 	 	 	 LDA 	 	 R_LVDStatus 
; 	 	 	 CMP 	 	 #D_BatLevel1 
; 	 	 	 BEQ 	 	 ?Judge3V3      ;检测是否低于3.3V
; 	 	 	 CMP 	 	 #D_BatLevel2 
; 	 	 	 BEQ 	 	 ?Judge3V0      ;检测是否低于3.0V
; 	 	 	 CMP 	 	 #D_BatLevel3 
; 	 	 	 BEQ 	 	 ?Judge2V4      ;检测是否低于2.4V
; 	 ?ExitDet: 
; 	 	 	 RTS 
;
; 	 ?Judge3V3: ;新增3.3V检测
; 	 	 	 LDA 	 	 P_LVD_Ctrl 
; 	 	 	 AND 	 	 #D_LVDStatus 
; 	 	 	 BEQ 	 	 ?Exit3V3 
; 	 	 	 INC 	 	 R_DetCnt 
; 	 	 	 LDA 	 	 R_DetCnt 
; 	 	 	 CMP 	 	 #5 
; 	 	 	 BCC 	 	 ?ExitDet 
; 	 	 	 LDA 	 	 #D_BatLevel2 
; 	 	 	 STA 	 	 R_LVDStatus 
; 	 	 	 %bits 	 R_KeyFlag,D_UpdateBAT 
; 	 	 	 LDA 	 	 #(D_LVDEn+D_LVD3P0V)      ;切换LVD检测电压为3.0V
; 	 	 	 STA 	 	 P_LVD_Ctrl 
; 	 	 ?Exit3V3: 
; 	 	 	 LDA 	 	 #00 
; 	 	 	 STA 	 	 R_DetCnt 
; 	 	 	 RTS 
; 	 	 	 
; 	 ?Judge3V0: ;原 Judge3V3
; 	 	 	 LDA 	 	 P_LVD_Ctrl 
; 	 	 	 AND 	 	 #D_LVDStatus 
; 	 	 	 BEQ 	 	 ?Exit3V0 
; 	 	 	 INC 	 	 R_DetCnt 
; 	 	 	 LDA 	 	 R_DetCnt 
; 	 	 	 CMP 	 	 #5 
; 	 	 	 BCC 	 	 ?ExitDet 
; 	 	 	 LDA 	 	 #D_BatLevel3 
; 	 	 	 STA 	 	 R_LVDStatus 
; 	 	 	 %bits 	 R_KeyFlag,D_UpdateBAT 
; 	 	 	 LDA 	 	 #(D_LVDEn+D_LVD2P4V)      ;切换LVD检测电压为2.4V
; 	 	 	 STA 	 	 P_LVD_Ctrl 
; 	 	 ?Exit3V0: 
; 	 	 	 LDA 	 	 #00 
; 	 	 	 STA 	 	 R_DetCnt 
; 	 	 	 RTS 
; 	 	 	 
; 	 ?Judge2V4: ;原 Judge2V7
; 	 	 	 LDA 	 	 P_LVD_Ctrl 
; 	 	 	 AND 	 	 #D_LVDStatus 
; 	 	 	 BEQ 	 	 ?Exit2V4 
; 	 	 	 INC 	 	 R_DetCnt 
; 	 	 	 LDA 	 	 R_DetCnt 
; 	 	 	 CMP 	 	 #5 
; 	 	 	 BCC 	 	 ?ExitDet 
; 	 	 	 LDA 	 	 #00 
; 	 	 	 STA 	 	 R_DetCnt 
; 	 	 	 LDA 	 	 #D_BatLevel3 
; 	 	 	 STA 	 	 R_LVDStatus 
; 	 	 	 %bits 	 R_Charge,D_LowPower 	 	 ;电量不足标志 (<2.4V)
; 	 	 	 %bits 	 R_KeyFlag,D_UpdateBAT 
; 	 	 ?Exit2V4: 
; 	 	 	 LDA 	 	 #00 
; 	 	 	 STA 	 	 R_DetCnt 
; 	 	 	 RTS 
 ;=========================================================== 
 ;充电检测 
 ;=========================================================== 
 F_Charge: 
 _F_Charge:
 	 	 LDA 	 	 P_IO_PortA_Data 
 	 	 AND 	 	 #D_Bit3 
	 	 BNE 	 	 ?GetDC_Charge 	 	 ; PA3=1 -> 有外电/充电中
 ?NotDC_Charge: 	 	 	 	 	 	 ;PA3=0 -> 未充电 
	 	 ; DC断开或无DC输入，确保清除充电与充满标志
	 	 %bitr 	 R_Charge,D_Charge
	 	 %bitr 	 R_Charge,D_Full
	 	 %bits 	 R_KeyFlag,D_UpdateBAT
	 	 RTS
 	 	 
 ?GetDC_Charge: 	 	 	 	 	 	 ;PA3=1 -> 在充电 
 	 	 LDA 	 	 R_Charge 
 	 	 AND 	 	 #D_Charge 
 	 	 BNE 	 	 ?JudgeChargeFull 	 ;在充电的时候判断是否充满 
 	 	 %bits 	 R_Charge,D_Charge 	 
 	 	 %bitr 	 R_Charge,D_LowPower 
 	 	 %bits 	 R_KeyFlag,D_UpdateBAT 
; 	 	 LDA 	 	 R_LVDStatus 
; 	 	 CMP 	 	 #D_BatLevel2 
; 	 	 BCC 	 	 ?NotLowBat 
; 	 	 LDA 	 	 #D_BatLevel2   ;如果处于极低电量(Level3)，恢复到Level2
; 	 	 STA 	 	 R_LVDStatus 	 	 
; 	 ?NotLowBat: 	 
 	 	 RTS 
 	 	 
 ?JudgeChargeFull: 	 	 	 	 	 ;判断充满 
	 	 ; 以 PB0 实测为准：PB0=0 表示充满，PB0=1 表示未充满（需要清除）
	 	 LDA 	 	 P_IO_PortB_Data    ; PB0 为充满指示，低有效
 	 	 AND 	 	 #D_Bit0
	 	 BNE 	 	 ?ClearFull        ; PB0=1 -> not full
	 	 ; PB0==0 -> full
 	 	 %bits 	 R_Charge,(D_Charge+D_Full)
; 	 	 LDA 	 	 #D_BatLevel1
; 	 	 STA 	 	 R_LVDStatus
; 	 	 ; 重置 LVD 为 3.3V 检测
; 	 	 LDA #(D_LVD3P3V+D_LVDEn)
; 	 	 STA P_LVD_Ctrl
 	 	 RTS

?ClearFull:
 	 	 ; 清除充满标志，不影响 D_Charge（仍保持为充电中状态）
 	 	 %bitr 	 R_Charge,D_Full
 	 	 %bits 	 R_KeyFlag,D_UpdateBAT
 	 	 RTS

 	 	 
		
.ENDS
;===========END=============================
