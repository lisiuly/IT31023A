; or disclosed in whole in part without prior written permission.
;       (C) COPYRIGHT 2009   Generalplus TECHNOLOGY CO.                            
;                   ALL RIGHTS RESERVED
; The entire notice above must be reproduced on all authorized copies.
;==================================================================================
;==================================================================================
; Name                  : lcd.asm
; Applied Body          : GPL815PX
; Programmer            : yanxiaodu
; Description           : lcd function
; History version       : v1.0  2011/06/21 by yanxiaodu first modify
;==================================================================================

;==========================================
; Compiler parameter define
;==========================================
.SYNTAX 6502
.LINKLIST
.SYMBOLS

;==========================================
; Constant define area
;==========================================
C_Bit_0:				.EQU	%00000001
C_Bit_1:				.EQU	%00000010
C_Bit_2:				.EQU	%00000100
C_Bit_3:				.EQU	%00001000
C_Bit_4:				.EQU	%00010000
C_Bit_5:				.EQU	%00100000
C_Bit_6:				.EQU	%01000000
C_Bit_7:				.EQU	%10000000
C_HideHigh:				.EQU	%00001111
C_HideLow:				.EQU	%11110000

C_LCDBUFFER_LENGTH:		.EQU	30D


;==========================================
; Include file area
;==========================================
.include		GPL815P.inc
.INCLUDE    	lcd\lcd.tab
.INCLUDE		calendar\calendar_user.inc
.INCLUDE		KEYSCAN\keyscan_user.inc
;.INCLUDE		RFC\rfc.inc
;.INCLUDE		adc\adc_user.inc
;==========================================
; External declare area
;==========================================
.EXTERNAL R_IconCount
.EXTERNAL CLOCK_FLAG_ASR
;==========================================
; Public declare area
;==========================================
.PUBLIC		F_12DispFlag
.PUBLIC		_F_12DispFlag
.PUBLIC		F_DispFlag
.PUBLIC		F_NotDispFlag
.PUBLIC		_F_DispFlag
.PUBLIC		_F_NotDispFlag
;.PUBLIC		F_Settup_Hour_LCD_Disp
;.PUBLIC		F_Settup_Minute_LCD_Disp
;.PUBLIC		F_Settup_alarmhour_LCD_Disp
;.PUBLIC		F_Settup_alarmminu_LCD_Disp
;.PUBLIC		F_Settup_day_LCD_Disp
;.PUBLIC		F_Settup_Year_LCD_Disp
;.PUBLIC		F_Settup_month_LCD_Disp

;.PUBLIC		F_Flash_Dot
;.PUBLIC		_F_Flash_Dot
.PUBLIC		F_Disp_Digital
.PUBLIC		_F_Disp_Digital
;.PUBLIC		F_Fill_ALL_LCDDPRAM
;.PUBLIC		_F_Fill_ALL_LCDDPRAM
.PUBLIC		F_LCD_Initinal
.PUBLIC		_F_LCD_Initinal

.PUBLIC		F_LCDDisplay
.PUBLIC		_F_LCDDisplay
;.PUBLIC		F_LCDDisplay_Proc
;.PUBLIC		_F_LCDDisplay_Proc
.PUBLIC		F_SeetupDisplay_Proc
.PUBLIC		_F_SeetupDisplay_Proc
.PUBLIC		F_Flash_COL_Dot
.PUBLIC		_F_Flash_COL_Dot

;.PUBLIC		F_Fill_LCDDPRAM
;.PUBLIC		_F_Fill_LCDDPRAM

.PUBLIC		RB_Lcd_Updata_Flag
.PUBLIC		_RB_Lcd_Updata_Flag
.PUBLIC		R_LcdBuff
.PUBLIC		_R_LcdBuff
.PUBLIC		R_Temp0
.PUBLIC		R_Temp1
.PUBLIC		R_Temp2
.PUBLIC		R_Temp3
.PUBLIC		R_Temp4

.PUBLIC		R_flash_Temp
.PUBLIC		_R_flash_Temp
.PUBLIC		RB_Mode_Disp_Status
.PUBLIC		_RB_Mode_Disp_Status


.PUBLIC		RB_LCD_Display_change
.PUBLIC		_RB_LCD_Display_change
;.PUBLIC		RB_Temp_CF_Flag
;.PUBLIC		_RB_Temp_CF_Flag
.PUBLIC		RB_Setup_LCD_Status
.PUBLIC		_RB_Setup_LCD_Status
.PUBLIC		RB_Setup_Status
.PUBLIC		_RB_Setup_Status

.PUBLIC		R_POINT
.PUBLIC		_R_POINT

.PUBLIC		R_Uart_UI
.PUBLIC		_R_Uart_UI
.PUBLIC		R_Electricity
.PUBLIC		_R_Electricity

;.PUBLIC		R_DispTemper
;.PUBLIC		_R_DispTemper
;.PUBLIC		R_DispHum	
;.PUBLIC		_R_DispHum		
;.PUBLIC		R_SpecFlag	
;.PUBLIC		_R_SpecFlag			
;==========================================
;Variable RAM declare area
;==========================================
lcdram:	.section	.PAGE0
R_LcdBuff:		.DS		C_LCDBUFFER_LENGTH+1				; 5com   *48seg   5*6 30byte
_R_LcdBuff:		.equ	R_LcdBuff
R_Temp0:		.DS		1
R_Temp1:		.DS		1
R_Temp2:		.DS		1
R_Temp3:		.DS		1
R_Temp4:		.DS		1
R_Disp_Temp:	.DS		1
R_Disp_Index:	.DS		1
R_LCD32Temp:		.DS		1

RB_Lcd_Updata_Flag:		.DS		1
_RB_Lcd_Updata_Flag:		.equ		RB_Lcd_Updata_Flag
 D_LcdtimesetUpdate:	.EQU		10000000B
 D_LcdUpdate:			.EQU		40H
 D_LcdChangeUpdate:		.EQU		20H

 R_flash_Temp:		.ds		1
 _R_flash_Temp:		.equ	R_flash_Temp
 
 
 R_MathTemp:		.ds		1
RB_Mode_Disp_Status:		.ds		1
_RB_Mode_Disp_Status:		.equ	RB_Mode_Disp_Status
D_Mode_DispStatMsk:			.equ	0x07

RB_Temp_LCD_buffer:		.ds		3

RB_Setup_LCD_Status:		.ds		1
_RB_Setup_LCD_Status:		.equ	RB_Setup_LCD_Status
	D_Time_Minute_setup_lcd:		.equ	0
	D_Time_Hour_setup_lcd:			.equ	1
	D_Date_Year_setup_lcd:			.equ	2
	D_Date_Month_setup_lcd:			.equ	3
	D_Date_Day_setup_lcd:			.equ	4
	D_Alarm_Minute_setup_lcd:		.equ	5
	D_Alarm_Hour_setup_lcd:			.equ	6
	
RB_Setup_Status:		.ds		1
_RB_Setup_Status:		.equ	RB_Setup_Status
	D_Setting_flag:			.equ	0x80

R_POINT			DS		1		
_R_POINT	equ		R_POINT	

.ENDS
LCD_NRAM:			.section

RB_LCD_Display_change:		.ds		1
_RB_LCD_Display_change:		.equ		RB_LCD_Display_change

RB_Power_3cnt:		.ds		1
RB_Power_2cnt:		.ds		1
RB_Power_1cnt:		.ds		1
RB_Power_0cnt:		.ds		1


; RB_LCD_F_Temp_L:		.ds		1
; RB_LCD_F_Temp_M:		.ds		1
; RB_LCD_F_Temp_H:		.ds		1

; RB_Temp_CF_Flag:		.ds		1
; _RB_Temp_CF_Flag:		.equ	RB_Temp_CF_Flag
; 	D_F_Flag:			.equ	0x80
	
; R_DispTemper	ds		1	
; _R_DispTemper	equ		R_DispTemper
; R_DispHum		ds		1
; _R_DispHum		equ		R_DispHum
; R_SpecFlag		ds	1
; _R_SpecFlag		equ		R_SpecFlag
; ;R_TempMin_Sign	ds	1
; ;R_TempMax_Sign	ds	1
; ;R_HumMin_Sign	ds	1
; ;R_HumMax_Sign	ds	1
; D_HumHH				equ	0x80
; D_HumLL				equ	0x40
; D_TempHH			equ	0x20
; D_TempLL			equ	0x10
; D_Neg				equ 0x08	;负温度
; D_TF				equ 0x04	;华氏度
; D_DelayReady		equ 0x02	

R_Uart_UI		ds		1
_R_Uart_UI		equ		R_Uart_UI
R_TempBuf		ds		6

R_Electricity	ds	1
_R_Electricity	equ		R_Electricity
D_null		equ		0x01	;0001
D_one		equ		0x02	;0010
D_two		equ     0x03	;0100
D_three		equ     0x04	;1000
R_ChargeTickDone	ds		1

D_6COM		equ		05H
.ENDS
;==========================================
; code starting 
;==========================================
lcdasm:		.section		
.INCLUDE		lcd\lcd_define.inc


; ==============================================
; Function	name: F_Flash_COL_Dot 
; Purpose	    : Make a dot flash 
; Parameter		: X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; =============================================		
F_Flash_COL_Dot:		
_F_Flash_COL_Dot:
		NOP
		LDA		#01H
		BIT		R_flash_Temp
		BNE		?L_Not_show_col
 ?L_Flash:		
		LDX		#T_Col
		JSR		F_DispFlag
		RTS
 ?L_Not_show_col:
		LDX		#T_Col
		JSR		F_NotDispFlag		;col vu
		RTS
		
; ==============================================
; Function	name: F_LCD_Initinal 
; Purpose	    : Make a dot flash 
; Parameter		: X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; =============================================		
F_LCD_Initinal:
_F_LCD_Initinal:
  LDA #D_LCDBias3
  STA P_LCD_BIAS_Ctrl       ; 设置LCD偏置电压
  
  LDA #D_PumpEn+D_PumpClk8K
  STA P_LCD_PUMP_Ctrl       ; 启用电荷泵(8KHz)
  
  LDA #(((8192/80))/(D_6COM+1))-D_48SEG-5
  STA P_LCD_Clock           ; 设置LCD时钟频率
  LDA		#00h
  STA		P_LCD_Ctrl2
	
  LDA #D_6COM
  STA P_LCD_COM_Num         ; 5COM线配置
  LDA #D_48SEG
  STA P_LCD_SEG_Num         ; 48SEG线配置
  
  LDA #0Fh
  STA P_LCD_VLCD_Ctrl       ;，VLCD=4.5V
  
  ; 延时等待电荷泵稳定
  SEC
  LDA #0xff
 L_Delay?:
  SBC #0x01
  NOP
  NOP
  BNE L_Delay?
  
  LDA #00h
  STA P_LCD_StartAddr_LB    ; 设置起始地址
  LDA #D_LCDEn+D_DisplayOn
  STA P_LCD_Ctrl1           ; 启用LCD显示
  RTS

;;============================================================================
;Name:			F_SeetupDisplay_Proc
;Purpose:		LCD display service
;Parameters:	None
;Destroy:		A,X,Y
;Stack depth:	2 bytes
;============================================================================
F_SeetupDisplay_Proc:		;设置模式
_F_SeetupDisplay_Proc:
			%btst	RB_Lcd_Updata_Flag,D_LcdUpdate,?Update_Time_All
			%btst	R_KeyFlag,D_EnableFastAdd,?Update_Time_All	;判断是否需要更新所有时间的显示
			%btst	R_flash_Temp,AddOthers,?NoDisp_SetValue
			%bits	RB_Lcd_Updata_Flag,D_LcdUpdate
		?Update_Time_All:	
			JMP	Update_Disp

	?NoDisp_SetValue:
	TimeFlashSet:	
		LDX		#T_Col
		JSR		F_NotDispFlag	
		
		LDA		R_TimeFlashSet
		CMP		#D_SetYear
		BNE		$+5
		JMP		L_NoDisplayYear	
		CMP		#D_SetMonth
		BNE		$+5
		JMP		L_NoDisplayMonth
		CMP		#D_SetDate
		BNE		$+5
		JMP		L_NoDisplayDay	
;		CMP		#D_Set12_24
;		BNE		$+5
;		jmp		L_NoDisplay12_24
		CMP		#D_SetHour
		BNE		$+5
		JMP		L_NoDisplayHour
		CMP		#D_SetMinute
		BNE		$+5
		JMP		L_NoDisplayMinute	
		
	AlmTimeFlashSet:	
		LDA		R_AlmTimeFlashSet	
		CMP		#D_SetAlm
		BNE		$+5
		JMP		F_NoDispAlarmGroup				
		CMP		#D_SetAlmHour
		BNE		$+5
		JMP		F_NoDisplayAlmHour				
		CMP		#D_SetAlmMinute
		BNE		$+5
		JMP		F_NoDisplayAlmMinute			
		CMP		#D_SetAlmDay
		BNE		$+5
		JMP		F_NoDisplayAlarmDays
		
	TimerFlashSet:		
		LDA		R_TimerFlashSet	
		CMP		#D_TimerSet
		BNE		$+5
		JMP		L_NoDisplayTimer

		RTS
;		
	Update_Disp:
;		LDA		R_TimeFlashSet	
;		CMP		#D_Set12_24
;		BNE		$+5
;		JSR		L_Display12_24	
		
		; LDA		R_VolumeFlashSet	
		; CMP		#D_VolumeSet
		; BNE		$+5
		; JSR		F_DisplayVolume
		
		JMP		L_LCDDisplay
L_NoDisplayTimer:
		LDA		#aah
		LDY		#09h
		JSR		F_Disp_Digital		
		LDA		#aah
		LDY		#0Bh
		JSR		F_Disp_Digital
		RTS


;============================================================================
;Name:			F_LCDDisplay_Proc
;Purpose:		LCD display service
;Parameters:	None
;Destroy:		A,X,Y
;Stack depth:	2 bytes
;============================================================================
 F_LCDDisplay:
 _F_LCDDisplay:	
		JSR		F_Battery_Modu1	  ;电池
		JSR		L_SpeakDisp	
		LDA		R_TimeFlashSet
		ORA		R_AlmTimeFlashSet
		ORA		R_TimerFlashSet
		BEQ		F_LCDDisplay_Proc
		JMP		F_SeetupDisplay_Proc	
		RTS 		
		
F_LCDDisplay_Proc:			
		JSR		F_Flash_COL_Dot	
		JSR		F_SWatch_Modul 		
		%btst	RB_Lcd_Updata_Flag,D_LcdUpdate,L_LCDDisplay
		RTS
 L_LCDDisplay:				;1秒刷新
		LDA		RB_Lcd_Updata_Flag
		AND		#~D_LcdUpdate
		AND		#~D_LcdtimesetUpdate
		STA		RB_Lcd_Updata_Flag
		LDX		#T_Col
		JSR		F_DispFlag			
		JMP		F_DispTime
		
L_SpeakDisp:
	; 调用统一的语音图标显示子程序
	JSR	F_Disp_SpeakIcon
	JMP	L_MuDisp

; ==============================================
; Function: F_Disp_SpeakIcon
; Purpose : 根据 R_OtherFlag 中的 D_Urat_Open 和 R_Uart_OpenTime 控制
;           T_Speak 图标：若 D_Urat_Open=1 则显示；当 R_Uart_OpenTime <=5 时闪烁
; Params  : none (uses globals)
; Return  : none
; Destroy : A, X
; ==============================================
F_Disp_SpeakIcon:
	LDA	R_OtherFlag
	AND	#D_Urat_Open
	BEQ	?Speak_Hide		; 若没有打开语音则隐藏图标

	; 若打开语音，检查剩余时间是否小于等于5，若是则闪烁
	LDA	R_Uart_OpenTime
	CMP	#5
	BCS	?Speak_Show_Steady	; >=5 则常显

	; 闪烁（受 R_flash_Temp 控制）
	LDA	R_flash_Temp
	BEQ	?Speak_Hide
	LDX	#T_Speak
	JSR	F_DispFlag
	RTS

?Speak_Show_Steady:
	LDX	#T_Speak
	JSR	F_DispFlag
	RTS

?Speak_Hide:
	LDX	#T_Speak
	JSR	F_NotDispFlag
	RTS
L_MuDisp:		
		LDA		R_CurrentVolume	
		BEQ		?Display_Mute
		CMP		#1
		BEQ		?Display_VoiceL
		CMP		#2
		BEQ		?Display_VoiceH	
		RTS
		?Display_Mute:
		LDX		#T_Mute
		JSR		F_DispFlag	
		LDX		#T_VoiceL
		JSR		F_NotDispFlag
		LDX		#T_VoiceH
		JMP		F_NotDispFlag	
		
		?Display_VoiceL:
		LDX		#T_Mute
		JSR		F_NotDispFlag	
		LDX		#T_VoiceL
		JSR		F_DispFlag
		LDX		#T_VoiceH
		JMP		F_NotDispFlag	
				
		?Display_VoiceH:
		LDX		#T_Mute
		JSR		F_NotDispFlag	
		LDX		#T_VoiceL
		JSR		F_DispFlag
		LDX		#T_VoiceH
		JMP		F_DispFlag	
				
;============================================================================
;Name:			F_DispTime
;Purpose:		clear key  1500ms  display after key
;Parameters:	None
;Destroy:		A
;Return:		
;Stack depth:	
;============================================================================	
F_DispTime:
        JSR     F_SWatch_Modul   	
;		LDA		R_Uart_UI
;		BNE		?L_Display				
;		%btst	R_VolumeFlashSet,D_VolumeSet,?L_ExitDisplay	
	?L_Display:		
		JSR F_DATA_Modul      ; 日期显示模块
		JSR F_Week_Modul      ; 星期显示模块
;		LDA		R_Uart_UI
;		BNE		?L_HMDisplay	
;		%btst	R_TimeFlashSet,D_Set12_24,?L_HMNoDisplay
	?L_HMDisplay:	
		JSR F_Time_VU_Modul   ; 时间显示模块
	?L_HMNoDisplay:		
		JSR F_Alarm_Modul     ; 闹钟显示模块


	?L_ExitDisplay:    
		RTS
		

F_Battery_Modu1:
;;=========================================================	
F_DispBattery:
		LDA		R_Charge
		AND		#(D_Charge+D_Full)
		BEQ		?DispNormal
		CMP		#(D_Charge+D_Full)
		BEQ		?DispFull
?DispCharging:					;充电中
		JSR		F_Disp_Charge
		RTS
?DispFull:						;充满了
		JSR		F_Disp_FullFlashing
		RTS
?DispNormal:					;未在充电,根据电量显示
		JSR		F_Disp_CheckBattery
		RTS		
		
;;=========================================================	
F_Disp_LowPower:;低电 

	%btsf	R_Charge,D_LowPower,?Exit	;不低电退出
	
;	%btsf	R_TimeStatus,HalfSecToggle,?Disp_COL
	 	LDA		#01H
	 	BIT		R_flash_Temp
	 	BNE		?Disp_COL
		LDX		#T_T4
		JSR		F_NotDispFlag
		LDX		#T_T1
		JSR		F_NotDispFlag
		LDX		#T_T2
		JSR		F_NotDispFlag
		LDX		#T_T3
		JSR		F_NotDispFlag
		RTS
	?Disp_COL:	
		LDX		#T_T4
		JSR		F_DispFlag
		LDX		#T_T1
		JSR		F_NotDispFlag
		LDX		#T_T2
		JSR		F_NotDispFlag
		LDX		#T_T3
		JSR		F_NotDispFlag
		RTS
		
	?Exit:	
;		JSR		F_Disp_CheckBattery	
	?Exit00:
		RTS
;;=========================================================	
_F_Disp_Charge:
F_Disp_Charge:;充电中动画
	; 上升沿触发：仅在 R_flash_Temp 从 0 -> 1 时推进一帧
	LDA     R_flash_Temp
	BEQ     ?Clear_Tick        ; 若为0，清标志并返回

	LDA     R_ChargeTickDone
	CMP     #0
	BNE     ?Exit_NoAdvance    ; 本周期已推进过，直接返回
	LDA     #1
	STA     R_ChargeTickDone   ; 标记本周期已推进

	LDX     #T_T4                ; 电量框
	JSR     F_DispFlag

	LDA     R_Electricity
	CMP     #D_null
	BEQ     ?Disp_null
	CMP     #D_one
	BEQ     ?Disp_one
	CMP     #D_two
	BEQ     ?Disp_two
	CMP     #D_three
	BEQ     ?Disp_three

?Disp_null:
	LDX     #T_T3
	JSR     F_NotDispFlag
	LDX     #T_T2
	JSR     F_NotDispFlag
	LDX     #T_T1
	JSR     F_NotDispFlag
	LDA     #D_one
	STA     R_Electricity
	JMP     ?Exit

?Disp_one:
	LDX     #T_T1
	JSR     F_DispFlag
	LDX     #T_T2
	JSR     F_NotDispFlag
	LDX     #T_T3
	JSR     F_NotDispFlag
	LDA     #D_two
	STA     R_Electricity
	JMP     ?Exit

?Disp_two:
	LDX     #T_T1
	JSR     F_DispFlag
	LDX     #T_T2
	JSR     F_DispFlag
	LDX     #T_T3
	JSR     F_NotDispFlag
	LDA     #D_three
	STA     R_Electricity
	JMP     ?Exit

?Disp_three:
	LDX     #T_T3
	JSR     F_DispFlag
	LDX     #T_T2
	JSR     F_DispFlag
	LDX     #T_T1
	JSR     F_DispFlag
	LDA     #D_null
	STA     R_Electricity

?Exit_NoAdvance:
?Exit:
	RTS

?Clear_Tick:
	LDA     #0
	STA     R_ChargeTickDone
	RTS
	
;;=========================================================	
F_Disp_FullFlashing:;充满显示	三条杠同时闪烁
;		%btsf	R_TimeStatus,HalfSecToggle,?Disp_COL;0
	 	LDA		#01H
	 	BIT		R_flash_Temp
	 	BNE		?Disp_COL		
		LDX		#T_T4
		JSR		F_DispFlag
		LDX		#T_T1
		JSR		F_DispFlag
		LDX		#T_T2
		JSR		F_DispFlag
		LDX		#T_T3
		JSR		F_DispFlag
		RTS
	?Disp_COL:	
		LDX		#T_T4
		JSR		F_DispFlag
		LDX		#T_T1
		JSR		F_NotDispFlag
		LDX		#T_T2
		JSR		F_NotDispFlag
		LDX		#T_T3
		JSR		F_NotDispFlag
	?Exit:
		RTS
;==========================================================
;电量显示:根据电量变化3段，从左到右33%66%99%相同手机
;==========================================================
F_Disp_CheckBattery:
;		%btsf	R_KeyFlag,D_UpdateBAT,?Exit
;		%bitr	R_KeyFlag,D_UpdateBAT
		LDX		#T_T4		;电量框
		JSR		F_DispFlag
		
		LDA		R_LVDStatus
		CMP		#D_BatLevel3
		BEQ		?Battery_33percent
		CMP		#D_BatLevel2
		BEQ		?Battery_66percent
		CMP		#D_BatLevel1
		BEQ		?Battery_99percent
		RTS

	?Battery_33percent:	;1节
		LDX		#T_T3
		JSR		F_NotDispFlag
		LDX		#T_T2
		JSR		F_NotDispFlag
		LDX		#T_T1
		JSR		F_DispFlag
		RTS
		
	?Battery_66percent:	;2节
		LDX		#T_T3
		JSR		F_NotDispFlag
		LDX		#T_T2
		JSR		F_DispFlag
		LDX		#T_T1
		JSR		F_DispFlag
		RTS
		
	?Battery_99percent:	;3节
		LDX		#T_T1
		JSR		F_DispFlag
		LDX		#T_T2
		JSR		F_DispFlag
		LDX		#T_T3
		JSR		F_DispFlag
	?Exit:
		RTS

;====time==VU============
F_Time_VU_Modul:
;hour				
;		LDA		RB_12_24_Status
;		BMI		?L_12H
;		LDX		#T_AM
;		JSR		F_NotDispFlag
;		LDX		#T_PM
;		JSR		F_NotDispFlag		
		LDX		R_DateHour
		JSR		F_Hex_To_BCD
		JMP		?L_24H
; ?L_12H:		
;		LDX		R_DateHour
;		JSR		F_Hex_To_BCD
;		CMP		#12h
;		BCC		?L_AM_VU
;		LDX		#T_AM
;		JSR		F_NotDispFlag		
;		LDX		#T_PM
;		BNE		?L_AP_Show
; ?L_AM_VU:
;		LDX		#T_PM
;		JSR		F_NotDispFlag 
;		LDX		#T_AM
; ?L_AP_Show:
;		JSR		F_DispFlag
;	
;		LDX		R_DateHour
;		JSR		F_Hex_To_BCD
;		JSR		F_24TO12Change
 ?L_24H:
 		JSR		F_DisplayHLValue
 		BNE		?L_DispHBit
		LDA		#0AH
	?L_DispHBit:	
		LDY		#00h
		jsr		F_Disp_Digital_1	
		lda		R_TempBuf				
		LDY		#01h
		jsr		F_Disp_Digital_1	
;		LDY		#01h
;		JSR		F_Disp_Digital
		
;minu
		LDX		R_DateMinute
		JSR		F_Hex_To_BCD
		LDY		#03h
		JSR		F_Disp_Digital
		RTS
L_NoDisplayHour:
		LDA		#aah	
		LDY		#01h
		JSR		F_Disp_Digital
		RTS	
L_NoDisplayMinute:	
		LDA		#aah
		LDY		#03h
		JSR		F_Disp_Digital
		RTS	
;====================================================================
;			Display 12/24 Section
;===================================================================			
;L_Display12_24:
;	LDX		#T_AM
;	JSR		F_NotDispFlag
;	LDX		#T_PM
;	JSR		F_NotDispFlag
;	LDX		#T_Col
;	JSR		F_NotDispFlag
;	%btst	RB_12_24_Status,D_12H,?Display12Hr
;    LDA     #0x24                ;  强制显示24
;	LDY		#01h
;	JSR		F_Disp_Digital
;    LDA     #0xEc                 ; 'Hr'
;	LDY		#03h
;	JSR		F_Disp_Digital
;	RTS	
;    
;	?Display12Hr:	   
;    LDA     #0x12                 ;  强制显示12
;	LDY		#01h
;	JSR		F_Disp_Digital
;    LDA     #0xEc                 ; 'Hr'
;	LDY		#03h
;	JSR		F_Disp_Digital
;	RTS	
;
;L_NoDisplay12_24:
;	LDX		#T_AM
;	JSR		F_NotDispFlag
;	LDX		#T_PM
;	JSR		F_NotDispFlag		
;	JSR	L_NoDisplayHour
;	JSR	L_NoDisplayMinute
;	RTS				
;====Week==============
F_Week_Modul:
;		LDA		R_Week
;		BEQ		?Disp_7
;		LDY		#0bh
;		JSR		F_Disp_Digital	
;		RTS	
;	?Disp_7:	
;		LDA		#07
;		LDY		#0bh
;		JSR		F_Disp_Digital	
;		RTS	
		JSR	Display_Week
		
		; Check Sunday (0)
		LDA R_Week
		CMP #0
		BNE ?Off_SUN
		LDX #T_SUN1
		JSR F_DispFlag
		JMP ?Check_MON
	?Off_SUN:
		LDX #T_SUN1
		JSR F_NotDispFlag
		
	?Check_MON:
		LDA R_Week
		CMP #1
		BNE ?Off_MON
		LDX #T_MON1
		JSR F_DispFlag
		JMP ?Check_TUE
	?Off_MON:
		LDX #T_MON1
		JSR F_NotDispFlag

	?Check_TUE:
		LDA R_Week
		CMP #2
		BNE ?Off_TUE
		LDX #T_TUE1
		JSR F_DispFlag
		JMP ?Check_WED
	?Off_TUE:
		LDX #T_TUE1
		JSR F_NotDispFlag

	?Check_WED:
		LDA R_Week
		CMP #3
		BNE ?Off_WED
		LDX #T_WED1
		JSR F_DispFlag
		JMP ?Check_THU
	?Off_WED:
		LDX #T_WED1
		JSR F_NotDispFlag

	?Check_THU:
		LDA R_Week
		CMP #4
		BNE ?Off_THU
		LDX #T_THU1
		JSR F_DispFlag
		JMP ?Check_FRI
	?Off_THU:
		LDX #T_THU1
		JSR F_NotDispFlag

	?Check_FRI:
		LDA R_Week
		CMP #5
		BNE ?Off_FRI
		LDX #T_FRI1
		JSR F_DispFlag
		JMP ?Check_SAT
	?Off_FRI:
		LDX #T_FRI1
		JSR F_NotDispFlag

	?Check_SAT:
		LDA R_Week
		CMP #6
		BNE ?Off_SAT
		LDX #T_SAT1
		JSR F_DispFlag
		RTS
	?Off_SAT:
		LDX #T_SAT1
		JSR F_NotDispFlag
		RTS
Display_Week:	
			LDX	#T_SUN
			JSR	F_DispFlag
			LDX	#T_MON
			JSR	F_DispFlag
			LDX	#T_TUE
			JSR	F_DispFlag
			LDX	#T_WED
			JSR	F_DispFlag
			LDX	#T_THU
			JSR	F_DispFlag
			LDX	#T_FRI
			JSR	F_DispFlag
			LDX	#T_SAT
			JSR	F_DispFlag	
NoDisplay_Week:
			LDX	#T_SUN1
			JSR	F_NotDispFlag
			LDX	#T_MON1
			JSR	F_NotDispFlag
			LDX	#T_TUE1
			JSR	F_NotDispFlag
			LDX	#T_WED1
			JSR	F_NotDispFlag
			LDX	#T_THU1
			JSR	F_NotDispFlag
			LDX	#T_FRI1
			JSR	F_NotDispFlag
			LDX	#T_SAT1
			JSR	F_NotDispFlag			
			rts	
			
;====data==============
F_DATA_Modul:
;Year
	    LDX #T_YeH             ; "20"前缀
		JSR	F_DispFlag	
		
	    LDX R_Year           ; 获取年份
	    JSR F_Hex_To_BCD
	    LDY #11h             ; 新位置
	    JSR F_Disp_Digital   ; 显示年份低两位	  
		
;month
		LDX		R_Month    
		JSR		F_Hex_To_BCD
		JSR		F_DisplayHLValue
		BNE		?L_DispMonthHBit
		LDA		#0AH
	?L_DispMonthHBit:	
		LDY		#0eh
		jsr		F_Disp_Digital_1	
		lda		R_TempBuf				
		LDY		#0fh
		jsr		F_Disp_Digital_1
		
;day
		LDX		R_Day
		JSR		F_Hex_To_BCD
		JSR		F_DisplayHLValue
		BNE		?L_DispHBit
		LDA		#0AH
	?L_DispHBit:	
		LDY		#0ch
		jsr		F_Disp_Digital_1	
		lda		R_TempBuf				
		LDY		#0dh
		jsr		F_Disp_Digital_1				
		LDX		#T_MD		;M/D
		JSR		F_DispFlag	
		RTS
		
L_NoDisplayYear:
	    LDX #T_YeH             ; "20"前缀
		JSR	F_NotDispFlag
		LDA	#aah
		LDY #11h             ; 新位置
	    JSR F_Disp_Digital   ; 显示年份低两位
	    RTS
L_NoDisplayMonth:	
		LDA		#aah
		LDY		#0fh
		JSR		F_Disp_Digital
		RTS
L_NoDisplayDay:	
		LDA		#aah			
		LDY		#0dH
		JSR		F_Disp_Digital	
		RTS
		
;====alarm==============
F_Alarm_Modul:
;alarm hour	
		LDA		R_Uart_UI
		BNE		?L_Next
		LDA		R_SetBack
		BNE		?L_Next
		LDA		R_AlmTimeFlashSet
		BNE		$+5	
		JSR		FindNearestAlarm
	?L_Next:
		; Check if current alarm group is ON
		LDA		R_AlarmOnOff
		LDX		R_CurrentGroup
		BEQ		?CheckBit0
		DEX
		BEQ		?CheckBit1
		AND		#0x04			; Group 2 (Bit 2)
		JMP		?CheckResult
	?CheckBit0:
		AND		#0x01			; Group 0 (Bit 0)
		JMP		?CheckResult
	?CheckBit1:
		AND		#0x02			; Group 1 (Bit 1)
	?CheckResult:
		BNE		?L_ShowAlarmTime
		LDA		RB_Lcd_Updata_Flag
		AND		#D_LcdChangeUpdate
		BNE		?L_HideAlarmTime
		LDA		R_Uart_UI
		BNE		?L_ShowAlarmTime
	?L_HideAlarmTime:
		; Alarm is OFF - hide time (show 4 dashes or nothing)
		LDA		#0xAA        ; Nothing
		LDY		#05h
		JSR		F_Disp_Digital
		
		LDA		#0xAA        ; Nothing
		LDY		#07h
		JSR		F_Disp_Digital
		
		LDX		#T_ACol
		JSR		F_NotDispFlag ; Hide COL
		JMP		?L_SkipAlarmTime
		
	?L_ShowAlarmTime:
		LDX		#T_ACol
		JSR		F_DispFlag		;COL fu
		
;		LDA		RB_12_24_Status
;		BMI		?L_12H
;		LDX		#T_AAM
;		JSR		F_NotDispFlag
;		LDX		#T_APM
;		JSR		F_NotDispFlag		
	
 		LDX     R_CurrentGroup
		lda		R_AlarmHour,X	
		TAX			
		JSR		F_Hex_To_BCD
;		JMP		?L_24H
; ?L_12H:
; 		LDX     R_CurrentGroup
;		lda		R_AlarmHour,X	
;		TAX
;		JSR		F_Hex_To_BCD
;		CMP		#12h
;		BCC		?L_AM_fu
;		LDX		#T_AAM
;		JSR		F_NotDispFlag		
;		LDX		#T_APM
;		BNE		?L_AP_Show
; ?L_AM_fu:
;		LDX		#T_APM
;		JSR		F_NotDispFlag
;		LDX		#T_AAM
; ?L_AP_Show:
;		JSR		F_DispFlag
; 		LDX     R_CurrentGroup
;		lda		R_AlarmHour,X	
;		TAX	
;;		LDX		R_DateHour
;		JSR		F_Hex_To_BCD
;		JSR		F_24TO12Change
; ?L_24H:
  		JSR		F_DisplayHLValue
 		BNE		?L_DispHBit
		LDA		#0AH
	?L_DispHBit:	
		LDY		#04h
		jsr		F_Disp_Digital_1	
		lda		R_TempBuf				
		LDY		#05h
		jsr		F_Disp_Digital_1	
		
;alarm minute
        LDX     R_CurrentGroup      
        LDA     R_AlarmMinute,X   
 		TAX	       
		JSR		F_Hex_To_BCD
		LDY		#07H
		JSR		F_Disp_Digital
		
		LDX		#T_ACol		;alarm col
		JSR		F_DispFlag		
		
	?L_SkipAlarmTime:
		JSR		F_DispAlarmGroup     	; 显示当前闹钟组状态（图标/数字）
		JSR		F_DisplayAlarmDays		;显示闹钟天数
		RTS
F_NoDispAlarmGroup:
;		LDA		#aah
;		LDY		#1bH
;		jsr		F_Disp_Digital
;		LDX     #T_Alarm         
;		JSR     F_NotDispFlag		
		LDX		#T_Alarm1
		JSR     F_NotDispFlag
		LDX     #T_Alarm2           
		JSR     F_NotDispFlag
		LDX     #T_Alarm3           
		JMP     F_NotDispFlag
		
F_NoDisplayAlmHour:
		LDA		#aah
		LDY		#05h
		JSR		F_Disp_Digital
		RTS			
F_NoDisplayAlmMinute:
		LDA		#aah
		LDY		#07H
		JSR		F_Disp_Digital
		RTS

F_DispAlarmGroup:
        LDA     R_CurrentGroup       ;当前选择的闹钟组(0-2)
        CLC
        ADC     #1                   ;显示组号1-3
        STA     R_Temp0       
        ;显示组号数字
        LDA     R_Temp0
		CMP     #1                  ;判断数字1
		BEQ     ?Display_1
		CMP     #2                  ;判断数字2
		BEQ     ?Display_2
		CMP     #3                  ;判断数字3
		BEQ     ?Display_3
		RTS                         ;非1-3直接返回	
	?Display_1:
		LDX		#T_Alarm1
		JSR     F_DispFlag
		LDX     #T_Alarm2           
		JSR     F_NotDispFlag
		LDX     #T_Alarm3           
		JMP     F_NotDispFlag
	?Display_2:
		LDX		#T_Alarm1
		JSR     F_NotDispFlag
		LDX     #T_Alarm2           
		JSR     F_DispFlag
		LDX     #T_Alarm3           
		JMP     F_NotDispFlag
	?Display_3:
		LDX		#T_Alarm1
		JSR     F_NotDispFlag
		LDX     #T_Alarm2           
		JSR     F_NotDispFlag
		LDX     #T_Alarm3           
		JMP     F_DispFlag
		
;	 ?Display_123:
;		LDY		#1bH
;		jsr		F_Disp_Digital
;		LDX     #T_Alarm         
;		JSR     F_DispFlag		
;
;        LDX		R_CurrentGroup         	
;		LDA		BitMaskTable,X      
;		AND		R_AlarmOnOff         
;        BNE     ?ShowIcon       	
;        LDX     #T_AO        
;        JSR     F_NotDispFlag
;        RTS 
;	?ShowIcon:
;			LDX     #T_AO           
;			JSR     F_DispFlag
			RTS			

		
;==========================================
; 查找最近闹钟（复用R_CurrentGroup和R_TempBuf）
;==========================================
FindNearestAlarm:
	lda #0xFF
  	STA R_CurrentGroup      ; 初始化为无效值

 	ldx #0                  ; 遍历组0→1→2 			
 GroupLoop:
	; --- 检查闹钟是否开启 ---
	lda BitMaskTable,x      ; 复用组掩码表
	and R_AlarmOnOff
	beq ?SkipToNextGroup 

	; --- 检查星期匹配
	stx R_TempBuf+0           ; 临时存储组号
	lda R_DispAlmDay,x
	jsr F_CheckAlarmDayType ; 你的现有函数
	ldx R_TempBuf+0           ; 恢复组号
	bcc ?NextGroup

    ; --- 时间调整逻辑（处理次日情况）---
    lda R_AlarmHour,x
    cmp R_DateHour                   ; 比较当前小时
    bcc ?Adjust24                 ; 闹钟小时 < 当前小时 → 调整
    bne ?NoAdjust                 ; 闹钟小时 > 当前小时 → 不调整

    lda R_AlarmMinute,x             ; 小时相等时检查分钟
    cmp R_DateMinute
    bcc ?Adjust24                 ; 闹钟分钟 < 当前分钟 → 调整
    beq ?Adjust24                 ; 等于当前时间 → 调整
 ?NoAdjust:
    lda R_AlarmHour,x
    jmp ?StoreHour
    
  ?SkipToNextGroup:
  	JMP ?NextGroup
  	
 ?Adjust24:
    lda R_AlarmHour,x
    clc
    adc #36                     ; 加24小时处理次日

 ?StoreHour:
    sta R_TempBuf+1              ; 存储调整后小时
    lda R_AlarmMinute,x
    sta R_TempBuf+2              ; 存储原始分钟

    ; --- 时间有效性检查 ---
    lda R_TempBuf+1
    cmp R_DateHour
    bcc ?NextGroup                ; 调整后时间仍早于当前时间 → 无效
    bne ?ValidTime                ; 调整后小时 > 当前小时 → 有效

    lda R_TempBuf+2              ; 小时相等时比较分钟
    cmp	R_DateMinute
 ;   beq ?NextGroup                ; 时间完全相同 → 已过期
    bcc ?NextGroup                ; 分钟仍小于当前 → 无效

 ?ValidTime:
    ; --- 更新最近组逻辑 ---
    ldy R_CurrentGroup
    cpy #0xFF
    beq ?UpdateGroup

    ; Recalculate stored group's adjusted hour
    lda R_AlarmHour,y
    cmp R_DateHour
    bcc ?Adjust24_Stored
    bne ?NoAdjust_Stored
    lda R_AlarmMinute,y
    cmp R_DateMinute
    bcc ?Adjust24_Stored
    beq ?Adjust24_Stored
 ?NoAdjust_Stored:
    lda R_AlarmHour,y
    jmp ?Compare_Hours
 ?Adjust24_Stored:
    lda R_AlarmHour,y
    clc
    adc #36
 ?Compare_Hours:
    ; 比较调整后小时（A寄存器=已存储组调整后小时，R_TempBuf+1=当前组调整后小时）
    cmp R_TempBuf+1
    bcc ?NextGroup           ; 已存储组调整后小时 < 当前组 → 保留已存储组
    bne ?UpdateGroup         ; 已存储组调整后小时 > 当前组 → 更新为当前组

    ; 小时相同 → 比较原始分钟
    lda R_TempBuf+2          ; 当前组原始分钟
    cmp R_AlarmMinute,y         ; 已存储组原始分钟
    bcc ?UpdateGroup         ; 当前组分钟 < 已存储组 → 更新（更早）
    bne ?NextGroup           ; 当前组分钟 > 已存储 → 保留

    ; --- 分钟相同 → 比较组号 ---
    lda R_TempBuf+0          ; 当前组号 (TempBuf+0)
    cmp R_CurrentGroup       ; 已存储组号 (y寄存器)
    bcs ?NextGroup           ; 当前组号 ≥ 已存储 → 保留已存储组
    
 ?UpdateGroup:
    ldx R_TempBuf+0
    stx R_CurrentGroup

 ?NextGroup:
    inx
    cpx #3
    bcs ?ExitLoop
    jmp GroupLoop
 ?ExitLoop:
    lda R_CurrentGroup
    cmp #0xFF
    bne ?L_Exit
    lda #0                       ; 默认返回组0
    sta R_CurrentGroup
 ?L_Exit:	
	rts
			
;====================================================================
; 显示闹钟组天数类型（5/6/7天制）
; 输入：R_CurrentGroup = 当前组索引(0-2)
;       R_DispAlmDay = 天数类型数组(0=双休,1=单休,2=每天)
;====================================================================
F_DisplayAlarmDays:
        LDX     R_CurrentGroup
        LDA     R_DispAlmDay,X   ;获取天数设置(0=双休5天, 1=单休6天, 2=每天7天)
        CMP		#02
        BEQ		F_DisplayAlarm7Days
        CMP		#01
        BEQ		F_DisplayAlarm6Days
        JMP		F_DisplayAlarm5Days
		
F_DisplayAlarm7Days:
		LDX	#T_SUN2
		JSR	F_DispFlag
		LDX	#T_MON2
		JSR	F_DispFlag
		LDX	#T_TUE2
		JSR	F_DispFlag
		LDX	#T_WED2
		JSR	F_DispFlag
		LDX	#T_THU2
		JSR	F_DispFlag
		LDX	#T_FRI2
		JSR	F_DispFlag
		LDX	#T_SAT2
		JSR	F_DispFlag			
		rts	

F_DisplayAlarm6Days:
		LDX	#T_SUN2
		JSR	F_NotDispFlag
		LDX	#T_MON2
		JSR	F_DispFlag
		LDX	#T_TUE2
		JSR	F_DispFlag
		LDX	#T_WED2
		JSR	F_DispFlag
		LDX	#T_THU2
		JSR	F_DispFlag
		LDX	#T_FRI2
		JSR	F_DispFlag
		LDX	#T_SAT2
		JSR	F_DispFlag			
		RTS	

F_NoDisplayAlarmDays:
;		LDA		#0AH
;		LDY		#19H
;		jsr		F_Disp_Digital
;		RTS		
		LDX	#T_SUN2
		JSR	F_NotDispFlag
		LDX	#T_MON2
		JSR	F_NotDispFlag
		LDX	#T_TUE2
		JSR	F_NotDispFlag
		LDX	#T_WED2
		JSR	F_NotDispFlag
		LDX	#T_THU2
		JSR	F_NotDispFlag
		LDX	#T_FRI2
		JSR	F_NotDispFlag
		LDX	#T_SAT2
		JSR	F_NotDispFlag			
		rts	
F_DisplayAlarm5Days:
		LDX	#T_SUN2
		JSR	F_NotDispFlag
		LDX	#T_MON2
		JSR	F_DispFlag
		LDX	#T_TUE2
		JSR	F_DispFlag
		LDX	#T_WED2
		JSR	F_DispFlag
		LDX	#T_THU2
		JSR	F_DispFlag
		LDX	#T_FRI2
		JSR	F_DispFlag
		LDX	#T_SAT2
		JSR	F_NotDispFlag			
		rts		
;Display_LingZz:
;;	%btst	R_OtherFlag,D_EnableSnooze,?Disp_KeepZz	
;		ldx	#T_Zz
;		jsr	F_NotDispFlag
;		RTS
;	?Disp_KeepZz:	
;		ldx	#T_Zz
;		jsr	F_DispFlag
;		rts		
;;;=============temp==============
;F_Temp_Modul:				
;		ldx	#T_HCD
;		jsr	F_DispFlag
;		%btst	R_SpecFlag,D_TempHH,Display_TempHH
;		%btst	R_SpecFlag,D_TempLL,Display_TempLL	
;		LDA		R_DispTemper	
;		JSR		L_DisplayTemp
;		%btsf	R_SpecFlag,D_Neg,?Exit
;		LDA		R_DispTemper
;		BEQ		?Exit
;		LDA		#0BH
;		LDY		#08h
;		jsr		F_Disp_Digital_1
;	?Exit:	
;;		LDX		#T_TeReg
;;		JSR		NoDisplay_OneBit		
;		RTS						
;		
;Display_TempHH:
;		LDA		#0xEE	;Hi改为显示HH	
;		jmp		L_DisplayTemp	
;Display_TempLL:
;;		LDA		#0BH
;;		LDY		#08h
;;		jsr		F_Disp_Digital_1	
;;		LDA		#0x09	;LI改为显示	-9
;;		LDY		#09h			
;;		jmp		F_Disp_Digital_1
;		LDA		#0xDD	;显示LL	
;		jmp		L_DisplayTemp		
;L_DisplayTemp:		
;;		TAX
;;		AND	#0FH
;;		STA	R_TempBuf		;store low 4-bit
;;		TXA
;;		ROR	A
;;		ROR	A
;;		ROR	A
;;		ROR	A
;;		AND	#0FH
;		JSR		F_DisplayHLValue
;		BNE		?L_DispHBit
;		LDA		#0AH
;	?L_DispHBit:	
;		LDY		#08h
;		jsr		F_Disp_Digital_1	
;		lda		R_TempBuf				
;		LDY		#09h
;		jsr		F_Disp_Digital_1	
;		RTS	
;		
;		
;input value for A, output value H-->>A, L--->>TempBuf
F_DisplayHLValue:
			TAX
			AND	#0FH
			STA	R_TempBuf		;store low 4-bit
			TXA
			ROR	A
			ROR	A
			ROR	A
			ROR	A
			AND	#0FH
			RTS	
;
;Display_Hum:
;		LDA		R_DispHum		
;	?Display_Value:			
;		CMP		#$10
;		BCC		?L_Display_HumLO
;		CMP		#$99
;		BCS		?L_Display_HumHl		
;	?Display_Value_1:			
;		LDY		#17h
;		jsr		F_Disp_Digital
;		RTS			
;	?L_Display_HumLO:
;		LDA		#0xDD		;0x10
;		JMP		?Display_Value_1	
;	?L_Display_HumHl:	
;		LDA		#0xEE		;0x99
;		JMP		?Display_Value_1
;		
;F_NoDisplayTempHum:	
;		LDA		#aah
;		LDY		#09h
;		jsr		F_Disp_Digital
;		LDA		#aah
;		LDY		#17h
;		jsr		F_Disp_Digital	
;		RTS
		
; F_DisplayVolume:
; L_NoDisplayVolume:	
;		LDX		#T_AM
;		JSR		F_NotDispFlag
;		LDX		#T_PM
;		JSR		F_NotDispFlag
;		LDX		#T_ACol
;		JSR		F_NotDispFlag
;		LDX		#T_APM
;		JSR		F_NotDispFlag	
;		LDX		#T_AAM
;		JSR		F_NotDispFlag
;		LDX		#T_MD
;		JSR		F_NotDispFlag
;		
;		LDX		#T_AO
;		JSR		F_NotDispFlag	
;		LDX		#T_Alarm
;		JSR		F_NotDispFlag
;		LDX		#T_Zz
;		JSR		F_NotDispFlag
;		
;		LDX		#T_HCD
;		JSR		F_NotDispFlag
;		LDX		#T_T1
;		JSR		F_NotDispFlag	
;		LDX		#T_MoH
;		JSR		F_NotDispFlag
;		LDX		#T_YeH
;		JSR		F_NotDispFlag
;		
;		JSR		L_NoDisplayYear
;		JSR		L_NoDisplayMonth
;		JSR		L_NoDisplayDay	
;;		JSR		L_NoDisplay12_24
;		JSR		L_NoDisplayHour
;		JSR		F_NoDispAlarmGroup	
;		JSR		F_NoDisplayAlmHour		
;		JSR		F_NoDisplayAlmMinute	
;		JSR		F_NoDisplayAlarmDays
;		JSR		F_NoDisplayTempHum
;		LDA		#0ah
;		LDY		#0bh
;		JSR		F_Disp_Digital	
;;		RTS
;;F_DisplayVolume:		
;		LDA   	R_CurrentSong   ;显示1-7
;		ADC		#1		
;		LDY		#03h
;		jsr		F_Disp_Digital
		RTS


		
;====data==============
F_SWatch_Modul:
    ; 正计时运行或暂停中 -> 显示正计时图标
    %btst R_TimerFlag, (D_Timerstatus_just+D_Timerstatus_justpause), ?L_Check_CountUp
 ;   %btst R_TimerFlag, D_Timerstatus_justpause, ?L_Check_CountUp
    ; 倒计时运行或暂停中 -> 显示倒计时图标
    %btst R_TimerFlag, (D_Timerstatus+D_TimerPausedCountDown+D_TimerModeCountdown), ?L_CountDown_Display
 ;   %btst R_TimerFlag, D_TimerPausedCountDown, ?L_CountDown_Display
    ; 计时空闲(00:00) -> 根据模式标志位显示
 ;   %btst R_TimerFlag, D_TimerModeCountdown, ?L_CountDown_Display
    ; 默认:正计时模式
    JMP ?L_Check_CountUp

?L_CountDown_Display:
    ; ===========================
    ; 倒计时模式处理 (Count Down)
    ; ===========================
    ; 1. 显示 T_Timer 图标 (常亮)
    LDX #T_Timer
    JSR F_DispFlag
    
    ; 2. 不显示 T_TimerUp 图标
    LDX #T_TimerUp
    JSR F_NotDispFlag
    
    ; 3. 显示 T_TCol 冒号 (常亮，不闪烁)
    LDX #T_TCol
    JSR F_DispFlag
    
    JMP ?L_Common_Process

?L_Check_CountUp:
    ; ===========================
    ; 正计时模式处理 (Count Up)
    ; ===========================
    ; 1. 不显示 T_Timer 图标
    LDX #T_Timer
    JSR F_NotDispFlag
    
    ; 2. 显示 T_TimerUp 图标 (常亮)
    LDX #T_TimerUp
    JSR F_DispFlag
    
    ; 3. 冒号闪烁处理
    ; 检查是否处于暂停状态 (D_Timerstatus_justpause)
    %btst R_TimerFlag, D_Timerstatus_justpause, ?L_Col_On ; 暂停时常亮
    %btsf R_TimerFlag, D_Timerstatus_just, ?L_Col_On ; 暂停时常亮   
    ; 正常走时，检查是否闪烁 (通过 R_flash_Temp 控制)
    LDA #01H
    BIT R_flash_Temp
    BNE ?L_Col_Off
    
?L_Col_On:
    LDX #T_TCol
    JSR F_DispFlag
    JMP ?L_Common_Process

?L_Col_Off:
    LDX #T_TCol
    JSR F_NotDispFlag

?L_Common_Process:
    ; ===========================
    ; 公共处理部分 (计算显示点数)
    ; ===========================
	    LDA R_TimerMinute
        STA R_LCD32Temp     
        
        LDA R_TimerMinute
        ORA R_TimerSecond
        BEQ ?L_TimeEnd      
        
        LDA R_LCD32Temp
        CLC
        ADC #01H
        JMP ?L_DoDisplay
        
?L_TimeEnd:
        LDA #00H            

?L_DoDisplay:
        JSR F_32DispFlag    
        JSR	F_12DispFlag
		LDX		R_TimerMinute
		JSR		F_Hex_To_BCD
		LDY		#09h
		JSR		F_Disp_Digital		
		LDX		R_TimerSecond
		JSR		F_Hex_To_BCD
		LDY		#0Bh
		JSR		F_Disp_Digital
		RTS


; ==============================================
; MACRO		name: F_Hex_To_BCD 
; Purpose	    : change hex to bcd
; Parameter		: X
; Return    	: A,R_DisplayBuf
; Destroy	    : NONE
; Stack depth	: NONE
; =============================================
F_Hex_To_BCD:
_F_Hex_To_BCD:
	LDA		#0
	STA		R_MathTemp
 ?LOOP0#:
	TXA
	CMP		#0AH
	BCS		?DEC10#
	CLC
	ADC		R_MathTemp
	STA		R_MathTemp
	;TAX
	RTS
 ?DEC10#:
	SBC		#0AH
	TAX
	LDA		#10H
	CLC
	ADC		R_MathTemp
	STA		R_MathTemp
	JMP		?LOOP0#
 ?L_Hex_To_BCD_END#:
	RTS	
		
F_Disp_Digital_1:
_F_Disp_Digital_1:
		STY		R_Disp_Index
		LDX		R_Disp_Index
		STA		R_Disp_Temp
		AND		#0Fh
		JSR		F_DispTheSevenSegChar
		RTS
; ==============================================
; Function	name: F_Disp_Digital 
; Purpose	    : show digital 
; Parameter		: A  display icon ,X  dispaly index
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; =============================================
F_Disp_Digital:
_F_Disp_Digital:
		STY		R_Disp_Index
		LDX		R_Disp_Index
		STA		R_Disp_Temp
		AND		#0Fh
		JSR		F_DispTheSevenSegChar
		LDA		R_Disp_Temp
		AND		#F0h
		CLC
		ROR		A
		ROR		A
		ROR		A
		ROR		A
		DEC		R_Disp_Index
		LDX		R_Disp_Index
		JSR		F_DispTheSevenSegChar
;		JMP		F_Fill_LCDDPRAM
		RTS
;========================================================
;////////////////////////////////////////////////////////
; not use in this demo
;=================
;T_LCDMatrixMapTab:
;		DB	R_LcdBuff+0,R_LcdBuff+1,0,0
;		DB	R_LcdBuff+2,R_LcdBuff+3,0,0
;		DB	R_LcdBuff+4,R_LcdBuff+5,0,0
;		DB	R_LcdBuff+6,R_LcdBuff+7,0,0
;A:char. X:pos index
; ==============================================
; Function	name: F_DispTheSevenSegChar 
; Purpose	    : show SevenSegChar 
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
F_DispTheSevenSegChar:
		STX		R_Temp1
		TAX 	
		LDA		T_SevenSegCharBitMapTab,X
		LDX		R_Temp1
		STA		R_Temp1								;R_Temp1存放字符的位映射 将刚刚找出的7段码放置在这里
		TXA 	
		CLC 	
		ROL		A
		TAX 	
		LDA		T_SevenSegCharPosIndexTab,X
		STA		R_Temp3
		LDA		T_SevenSegCharPosIndexTab+1,X	;取字符的显示映射表的地址
		STA		R_Temp4
;------
;dot start addr:R_Temp3,R_Temp4. disp byte:R_Temp1.
; ==============================================
; Function	name: F_DispByte 
; Purpose	    : show Byte R_Temp1中要显示的数进行七段码点亮处理
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
F_DispByte:
		LDX		#00H
		LDA		(R_Temp3,X)
		BMI		?L_Check_80_8x
		BPL		?L_Sta_temp2
 ?L_Check_80_8x:
		AND		#07h
		BEQ		L_Not_show_0			;0x80
 ?L_Check_0_NO_FLAG:
		LDA		R_Temp1
		CMP		#3fh
		BEQ		L_Not_show_0
		LDX		#00H
		LDA		(R_Temp3,X)
 ?L_Sta_temp2:
		AND		#07h
		STA		R_Temp2
		
		
 		INC		R_Temp3
		BNE		L_DispByte_1
		INC		R_Temp4
 L_DispByte_1:
		LDX		#00H
		LDA		(R_Temp3,X)
		STA		R_Temp0
 		INC		R_Temp3
		BNE		L_DispByte_1_0
		INC		R_Temp4
 L_DispByte_1_0:
		LDA		(R_Temp3,X)
		INC		R_Temp3
		BNE		L_DispByte_1_1
		INC		R_Temp4
 L_DispByte_1_1:
		LDX		R_Temp0
		ROR		R_Temp1
		BCS		L_DispByte_1_1_1
 L_DispByte_1_1_0:
		NOP
;		%F_ClearByteBit
		STA	R_Temp0
		LDA	$2000,X
		ORA	R_Temp0
		EOR	R_Temp0
		STA	$2000,X
		DEC		R_Temp2
		BNE		L_DispByte_1
		RTS	
 L_DispByte_1_1_1:
;		%F_SetByteBit
 		STA	R_Temp0
		LDA	$2000,X
		ORA	R_Temp0
		STA	$2000,X	
		DEC		R_Temp2
		BNE		L_DispByte_1
 L_Not_show_0:
		RTS	
;=============================
;A:flag index
; ==============================================
; Function	name: F_DispFlag 
; Purpose	    : show DOT
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
F_DispFlag:
_F_DispFlag:
		LDA	T_Icon,x
		STA	R_Temp0
		inx
		LDA	T_Icon,x
		STA	R_Temp1
		LDX	R_Temp0
		LDA	$2000,X
		ORA	R_Temp1
		STA	$2000,X			
		RTS		

		
F_32DispFlag:
_F_32DispFlag:
    STA R_LCD32Temp         
    LDX #0                  
    LDY #0                  
?Loop_Check:
    CPY R_LCD32Temp         
    BCC ?L_TurnOn           
    BCS ?L_TurnOff          
?L_TurnOn:
    LDA T_60Icon,X
    STA R_Temp0
    LDA T_60Icon+1,X
    STA R_Temp1
    TXA                     
    PHA
    LDX R_Temp0             
    LDA $2000,X             
    ORA R_Temp1             
    STA $2000,X
    PLA                     
    TAX
    JMP ?L_Next
?L_TurnOff:
    LDA T_60Icon,X
    STA R_Temp0
    LDA T_60Icon+1,X
    EOR #0FFH               
    STA R_Temp1
    TXA                     
    PHA
    LDX R_Temp0
    LDA $2000,X
    AND R_Temp1             
    STA $2000,X
    PLA                     
    TAX
?L_Next:
    INX
    INX                     
    INY                     
    CPY #60                 
    BCC ?Loop_Check
    RTS

; ==============================================
; Function name : F_12DispFlag
; Purpose       : Display 12 icons based on _R_IconCount
; Parameter     : None (uses _R_IconCount)
; Return        : None
; Destroy       : A, X, Y, R_Temp0, R_Temp1
; Stack depth   : 2
; ==============================================
F_12DispFlag:
_F_12DispFlag:
    LDA R_IconCount        ; Load count from C variable
    STA R_LCD32Temp         ; Store in temp for comparison
    LDX #0                  ; Table index
    LDY #0                  ; Loop counter

?Loop_Check:
    CPY R_LCD32Temp
    BCC ?L_TurnOn
    BCS ?L_TurnOff

?L_TurnOn:
    LDA T_12Icon,X
    STA R_Temp0
    LDA T_12Icon+1,X
    STA R_Temp1
    TXA
    PHA
    LDX R_Temp0
    LDA $2000,X
    ORA R_Temp1
    STA $2000,X
    PLA
    TAX
    JMP ?L_Next

?L_TurnOff:
    LDA T_12Icon,X
    STA R_Temp0
    LDA T_12Icon+1,X
    EOR #0FFH
    STA R_Temp1
    TXA
    PHA
    LDX R_Temp0
    LDA $2000,X
    AND R_Temp1
    STA $2000,X
    PLA
    TAX

?L_Next:
    INX
    INX
    INY
    CPY #12                 ; Loop 12 times
    BCC ?Loop_Check
    RTS
    
; ==============================================
; Function	name F_DispFlag 
; Purpose	    : not show DOT
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
F_NotDispFlag:
_F_NotDispFlag:
		LDA	T_Icon,x
		STA	R_Temp0
		inx
		LDA	T_Icon,x
		EOR	#FFH
		STA	R_Temp1
		LDX	R_Temp0
		LDA	$2000,X
		and	R_Temp1
		STA	$2000,X			
		RTS		

F_Not32DispFlag:
_F_Not32DispFlag:
;    STX R_LCD32Temp         ; 保存起始索引到R_LCD32Temp（包括输入62的情况）
; 	BEQ ?Loop_Not	
;    INX                     ; 索引+2（对应下一个点，保留你的写法）
;    INX
;;    STX R_LCD32Temp         ; 保存新的清除索引
;    ; 步骤1：前置判断（先判断索引，再执行清除，解决起始索引62的问题）
;;    LDX R_LCD32Temp         ; 加载起始索引
;    CPX #0x40               ; 对比最后一个点的索引（62）
;    BEQ ?Loop_Not    
;    BCS ?L_ExitClear        ; 若起始索引超过62，直接退出，不执行清除
;
;?Loop_Not:
;    ; 步骤2：先恢复当前索引，再执行清除操作（流程顺序调整：判断→清除）
;    LDX R_LCD32Temp         ; 恢复当前清除索引（确保每次循环都先拿到正确索引）
;    
;    ; 你原有清除核心逻辑（完全保留，不修改）
;    LDA T_32Icon,x          ; 读取点的地址
;    STA R_Temp0
;    LDA T_32Icon+1,x        ; 读取点的显示数据
;    EOR #0FFH               ; 生成清除掩码（保留你的写法）
;    STA R_Temp1
;    LDX R_Temp0             ; 加载清除地址
;    LDA $2000,X
;    AND R_Temp1             ; 熄灭当前点（核心清除逻辑，保留）
;    STA $2000,X
;    
;    ; 步骤3：循环控制（索引递增2，再判断是否继续）
;    LDX R_LCD32Temp         ; 恢复当前清除索引
;    INX                     ; 索引+2（对应下一个点，保留你的写法）
;    INX
;    STX R_LCD32Temp         ; 保存新的清除索引
;    
;    ; 步骤4：后置判断（递增后，判断是否到达62，决定是否继续循环）
;    LDX R_LCD32Temp         ; 加载递增后的新索引
;    CPX #0x3E              ; 对比最后一个点的索引（62）
;    BEQ  ?Loop_Not      
;    BCS ?L_ExitClear        ; 若递增后超过62，直接退出
;    JMP ?Loop_Not           ; 未到达62，继续下一次循环

?L_ExitClear:
    RTS                     ; 清除完成，无错误，起始索引为62时直接退出;	; 新功能：根据A寄存器中的值清除对应数量的点

.ENDS
