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



;==========================================
; Include file area
;==========================================
.INCLUDE		GPL815P.inc
.INCLUDE		KEYSCAN\keyscan_user.inc
.INCLUDE		SYS\Macro.inc
.INCLUDE		lcd\lcd_user.inc
;==========================================
; External declare area
;==========================================

;==========================================
; Public declare area
;==========================================
.PUBLIC			F_24HourClock
.PUBLIC			_F_24HourClock
;.PUBLIC			F_GetNsLiCalendar
;.PUBLIC			_F_GetNsLiCalendar
.PUBLIC			F_JudegLeapYear
.PUBLIC			_F_JudegLeapYear
.PUBLIC			F_24TO12Change
.PUBLIC			_F_24TO12Change
; .PUBLIC			F_Check_Alarming
; .PUBLIC			_F_Check_Alarming
.PUBLIC			F_JudgeWeek
.PUBLIC			_F_JudgeWeek


.PUBLIC			R_Week
.PUBLIC			_R_Week
.PUBLIC			R_Month
.PUBLIC			_R_Month
.PUBLIC			R_Month_temp
.PUBLIC			_R_Month_temp
.PUBLIC			R_Day
.PUBLIC			_R_Day
.PUBLIC			R_Day_temp
.PUBLIC			_R_Day_temp
.PUBLIC			R_Year
.PUBLIC			_R_Year
.PUBLIC			R_Year_temp
.PUBLIC			_R_Year_temp
.PUBLIC			R_Hejira_LeapYear_CalendarFlag
.PUBLIC			_R_Hejira_LeapYear_CalendarFlag
.PUBLIC			R_LCDHourBuff
.PUBLIC			_R_LCDHourBuff
.PUBLIC			R_LCDMinuBuff
.PUBLIC			_R_LCDMinuBuff
.PUBLIC			R_LCDSecBuff
.PUBLIC			_R_LCDSecBuff

.PUBLIC			R_DateSecond
.PUBLIC			_R_DateSecond
.PUBLIC			R_DateMinute
.PUBLIC			_R_DateMinute
.PUBLIC			R_DateHour
.PUBLIC			_R_DateHour
.PUBLIC			RB_12_24_Status
.PUBLIC			_RB_12_24_Status
.PUBLIC			R_AlarmMinute
.PUBLIC			_R_AlarmMinute
.PUBLIC			R_AlarmHour
.PUBLIC			_R_AlarmHour

.PUBLIC			R_CurrentGroup
.PUBLIC			_R_CurrentGroup
.PUBLIC			R_DispAlmDay
.PUBLIC			_R_DispAlmDay
.PUBLIC			R_AlarmOnOff
.PUBLIC			_R_AlarmOnOff

.PUBLIC			R_Alarm_ENDIS_Flag
.PUBLIC			_R_Alarm_ENDIS_Flag
.PUBLIC			R_TimerMinute
.PUBLIC			_R_TimerMinute
.PUBLIC			R_TimerSecond
.PUBLIC			_R_TimerSecond

.PUBLIC		R_Second_Temp
.PUBLIC		_R_Second_Temp
.PUBLIC		R_IconCount
.PUBLIC		_R_IconCount
.PUBLIC		R_SnoozeCount
.PUBLIC		_R_SnoozeCount
.PUBLIC		R_SnoozeGroup
.PUBLIC		_R_SnoozeGroup
;==========================================
;Variable RAM declare area
;==========================================
.PAGE0
R_Week:			.DS		1
_R_Week:		.EQU	R_Week
R_Month:		.DS		1
_R_Month:		.EQU	R_Month
R_Month_temp:	.ds		1
_R_Month_temp:		.equ	R_Month_temp
R_Day:			.DS		1
_R_Day:			.EQU	R_Day
R_Day_temp:				.ds		1
_R_Day_temp:	.equ	R_Day_temp
R_Year:			.DS		2
_R_Year:		.EQU	R_Year
R_Year_temp:	.ds		2
_R_Year_temp:	.EQU	R_Year_temp
R_JMP_Temp		.ds		2
R_Calendar_Temp0:		.DS		1
R_Calendar_Temp1:		.DS		1
R_Calendar_Temp2:		.DS		1		;春节所在月份
R_Calendar_Temp3:		.DS		1		;春节所在日
R_Calendar_Temp4:		.DS		1		;春节离元旦的天数
R_Calendar_Temp5:		.DS		2		;计算公历日离当年元旦的天数
R_Calendar_ADDR:		.DS		1

R_YEAR_ADDR:		.DS		2
R_DayRange:			.DS		1
D_LeapYear:			.EQU	%10000000B
R_Index_temp:		.DS		1
R_Flag_y:			.DS		1
R_Index_Month:		.ds		1
R_Hejira_LeapYear_CalendarFlag:		.DS		1
_R_Hejira_LeapYear_CalendarFlag:		.EQU		R_Hejira_LeapYear_CalendarFlag


R_LCDHourBuff:		.ds		1
_R_LCDHourBuff:		.equ	R_LCDHourBuff
R_LCDMinuBuff:		.ds		1
_R_LCDMinuBuff:		.equ	R_LCDMinuBuff
R_LCDSecBuff:		.ds		1
_R_LCDSecBuff:		.equ	R_LCDSecBuff

R_DateSecond:		.ds		1
_R_DateSecond:		.equ	R_DateSecond
R_DateMinute:		.ds		1
_R_DateMinute:		.equ	R_DateMinute
R_DateHour:			.ds		1
_R_DateHour:		.equ	R_DateHour

R_AlarmMinute:		.ds		3
_R_AlarmMinute:		.equ	R_AlarmMinute
R_AlarmHour:			.ds		3
_R_AlarmHour:		.equ	R_AlarmHour

R_CurrentGroup: 	ds	1		;响闹组别(0-2)
_R_CurrentGroup:	.equ	R_CurrentGroup
R_SnoozeGroup:	ds	1		;贪睡中的闹钟组(0-2),响铃时记录
_R_SnoozeGroup:	.equ	R_SnoozeGroup
R_DispAlmDay	ds	3		;3组门闹钟的类型，0为每天，1为单休，2为双休
_R_DispAlmDay		.equ	R_DispAlmDay
R_AlarmOnOff	ds  1		;bit0-2对应组开关状态
_R_AlarmOnOff		.equ	R_AlarmOnOff

RB_12_24_Status:		.ds		1
_RB_12_24_Status:		.equ	RB_12_24_Status
	D_24H:		.EQU	00H
	D_12H:		.EQU	80H
R_Alarm_ENDIS_Flag:		.DS		1
_R_Alarm_ENDIS_Flag:		.equ	R_Alarm_ENDIS_Flag
	D_Alarm_EN:		.EQU	0X80

	
RB_Alarming_cnt:		.ds		1		
R_KEYMathTemp:		.DS		1

R_TimerMinute:		.ds		1
_R_TimerMinute:		.equ	R_TimerMinute
R_TimerSecond:		.ds		1
_R_TimerSecond:		.equ	R_TimerSecond
C_SnoozeInterval	EQU		5
C_SnoozeMaxCount	EQU		3
R_SnoozeCount		ds		1
_R_SnoozeCount		equ		R_SnoozeCount

R_IconCount			ds	1
_R_IconCount		equ		R_IconCount
R_Second_Temp		ds	1
_R_Second_Temp		equ		R_Second_Temp

.ENDS
;;===========================================================
;N_User_calendar:			.section
N_User_calendar:			.section
R_TEST_Temp:		.DS		1
.ENDS
;==========================================
; code starting 
;==========================================

.CODE
;ROM_calendar:			.SECTION

;;======================================
;Function Name:  F_24HourClock
;Applied Body:   GPL10B
;purpose:        set clock & clock change
;programmer:     yanxiaodu
;data:           2011-11-03
;modification:   2011-11-03 
;;======================================
F_24HourClock:
_F_24HourClock:
	lda	R_DateSecond				;R_Scend
	STA	R_LCDSecBuff
	cmp	#60d
	BCS	?L_Minute
	jmp	L_24HourClockEnd
?L_Minute:
	lda		#00h						;clear scend temp
	sta		R_DateSecond				;R_Scend
	STA		R_LCDSecBuff	
	
	INC		R_DateMinute
;	JSR		F_OpenData					;打开温湿度检测
	LDA		R_DateMinute
	STA		R_LCDMinuBuff
	
	cmp		#60d
	BCS		?L_Hour	
	jmp		L_minute_end
?L_Hour:
	lda		#00h						;clear minute time
	sta		R_DateMinute				;R_Minute
	STA		R_LCDMinuBuff

	INC		R_DateHour					;R_Hour
	LDA		R_DateHour
	STA		R_LCDHourBuff
	CMP		#24d
	BCS		?L_Day	
	jmp		L_minute_end			;hour is 24?
?L_Day:
	lda		#00h						;
	sta		R_DateHour					;R_Hour
	STA		R_LCDHourBuff
	
	inc	R_Week
	lda	R_Week
	cmp	#08d
	bcc	?L_Month					;if week over sunday,it must be change
	lda	#01d
	sta	R_Week
?L_Month:
	lda	R_Month
	EOR	#02h
	beq	?L_JudgeLeapYear
	jmp	?L_NormalYear
?L_JudgeLeapYear:
	lda	R_Hejira_LeapYear_CalendarFlag				;R_LeapYearFlag=0,not leap year
	and	#10000000B									;D_LeapYear
	bne	?L_LeapYear						;R_LeapYearFlag=0 --→ leap year
?L_NormalYear:
	ldx	R_Month
	lda	T_Month_Table,x
	sta	R_DayRange						;one month max day
	lda	R_Day
	cmp	R_DayRange
	beq	?L_MonthAdjust
	jmp	?L_DayIncrease
?L_LeapYear:
	lda	R_Day
	cmp	#1dh
	beq	?L_MonthAdjust
?L_DayIncrease:
	inc	R_Day						;day+1
	jmp	L_minute_end	
?L_MonthAdjust:
	lda	#01h
	sta	R_Day
	lda	R_Month
	cmp	#12d
	beq	?L_Year
	inc	R_Month						;month+1
	jmp	L_minute_end
?L_Year:
	lda	#01h
	sta	R_Month						;month loop:1,2,3,4````,12,1,2,```12,1,2,```
	
	lda	R_Year
	cmp	#99D
	BEQ	?l_AdjustYear
	inc	R_Year
	jmp	L_minute_end
?l_AdjustYear:
	lda	#00h
	sta	R_Year						;
	lda	R_Year+1
	cmp	#20d						;the maximal year is 3999
	beq	?L_AdjustYear_1
	inc	R_Year+1
	jmp	L_minute_end
?L_AdjustYear_1:
	lda	#19d
	sta	R_Year+1					;the min year is 1000
	
L_minute_end:
	JSR		F_CheckAlarm				;check alarm after minute/hour carry
;	JSR		F_JudegAlarm
	%bits RB_Lcd_Updata_Flag,D_LcdUpdate;	
L_24HourClockEnd:

	jsr		F_JudegLeapYear
	NOP
	JSR		F_JudgeWeek
	rts
;; ==============================================
;; Function	name: F_JudegAlarm 
;; Purpose	    : Judeg leap year 
;; Parameter		: 
;; Return    	: 
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;
;F_JudegAlarm:
;_F_JudegAlarm:
;	
;		LDA		R_Alarm_ENDIS_Flag
;		AND		#D_Alarm_EN
;		BNE		?L_Alarm_enable
;		RTS
;		
;?L_Alarm_enable:
;		LDA		R_AlarmHour
;		CMP		R_DateHour
;		BEQ		?L_Check_Minute
;		RTS
;?L_Check_Minute:
;		LDA		R_AlarmMinute
;		CMP		R_DateMinute
;		BEQ		?L_Alarm_checked
;		RTS
;?L_Alarm_checked:
;		LDA		#00010000B			;output pull low
;		STA		P_IO_PortC_Dir
;		
;		LDA		#00000000B
;		STA		P_IO_PortC_Data
;		
;		LDA		#02h			;pC4
;		STA		P_PWMIO_Sel
;		
;		LDA		#10H
;		STA		P_PWMIO_Timer_Data
;		LDA		#08D
;		STA		P_PWMIO_IO0_DUTY
;		
;		LDA		#D_PWMClk32K+D_PWMIO0En
;		STA		P_PWMIO_Ctrl
;		
;		LDA		R_Alarm_ENDIS_Flag
;		ORA		#D_Alarming
;		STA		R_Alarm_ENDIS_Flag
;		
;		LDA		#30d
;		STA		RB_Alarming_cnt
;		RTS
; ; ==============================================
; ; Function	name: F_Check_Alarming 
; ; Purpose	    : alarm 30s
; ; Parameter		: 
; ; Return    	: 
; ; Destroy	    : X
; ; Stack depth	: 1
; ; ==============================================
; F_Check_Alarming:
; _F_Check_Alarming:
; 		LDA		R_Alarm_ENDIS_Flag
; 		EOR		#D_Alarming+D_Alarm_EN
; 		BEQ		?L_Alarming
; 		RTS
; ?L_Alarming:
; 		LDA		RB_Alarming_cnt
; 		BEQ		?L_Stop_alarm
; 		DEC		RB_Alarming_cnt
; 		RTS
; ?L_Stop_alarm:
; 		LDA		#00h
; 		STA		P_PWMIO_Sel
; 		LDA		#D_PWMClk32K
; 		STA		P_PWMIO_Ctrl
		
; 		LDA		R_Alarm_ENDIS_Flag
; 		AND		#~D_Alarming
; 		STA		R_Alarm_ENDIS_Flag
		
; 		LDA		P_IO_PortC_Data
; 		AND		#E0H
; 		STA		P_IO_PortC_Data
; 		RTS
	
; ==============================================
; Function	name: F_JudegLeapYear 
; Purpose	    : Judeg leap year 
; Parameter		: 
; Return    	: 
; Destroy	    : X
; Stack depth	: 1
; ==============================================

F_JudegLeapYear:
_F_JudegLeapYear:
	lda		R_Year
	sta		R_Calendar_Temp0
	lda		R_Year+1
	sta		R_Calendar_Temp1
	
	lda		R_Calendar_Temp0
	bne		?L_NextL#
	lda		R_Calendar_Temp1
	clc
	ror		a
	bcs		?L_LeapYear_Not#
	ror		a
	bcs		?L_LeapYear_Not#		;不是400的整数倍
	jmp		?L_LeapYear_Yes#
?L_NextL#:
	lda		R_Calendar_Temp0
	clc
	ror		a
	bcs		?L_LeapYear_Not#
	ror		a
	bcs		?L_LeapYear_Not#		;不是4的整数倍
?L_LeapYear_Yes#:					;400的整数倍
	lda		R_Hejira_LeapYear_CalendarFlag
	ora		#D_LeapYear
	sta		R_Hejira_LeapYear_CalendarFlag
	jmp		?L_JudegLeapYearEnd#
?L_LeapYear_Not#:
	lda		R_Hejira_LeapYear_CalendarFlag
	and		#.not.D_LeapYear
	sta		R_Hejira_LeapYear_CalendarFlag
?L_JudegLeapYearEnd#:
	rts

;; ==============================================
;; Function	name: F_GetNsLiCalendar 
;; Purpose	    : 公历转换为农历
;; Parameter		: 
;; Return    	: 
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetNsLiCalendar:
;_F_GetNsLiCalendar:
;	LDA		R_Year+1
;	CMP		#14h
;	BCC		L_19XX_YEARADDR
;	
;;=================================================
;L_20XX_YEARADDR:						;20XX YEAR TAB
;	LDA		R_Year
;	STA		R_Calendar_ADDR
;	LDA		#01h
;	STA		R_YEAR_ADDR+1
;	JMP		L_YEARADDR_3
;L_19XX_YEARADDR:						;19XX YEAR TAB
;	LDA		R_Year
;	SEC		
;	SBC		#15d
;	STA		R_Calendar_ADDR
;	LDA		#00H
;	STA		R_YEAR_ADDR+1				;gaowei
;L_YEARADDR_3:
;	LDA		R_Calendar_ADDR
;	CLC
;	ROL		A
;	CLC
;	ADC		R_Calendar_ADDR
;	STA		R_YEAR_ADDR
;
;;================================================
;L_NongLi_Chunjie_YueFen:
;	TAX	
;	INX
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_NongLi_Chunjie_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_NongLi_Chunjie_20#
;?L_NongLi_Chunjie_19#:
;	LDA		T_year_code_TAB,X
;?L_NongLi_Chunjie_20#:
;	AND		#01100000b
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	AND		#03H
;	STA		R_Calendar_Temp2					;nongli chunjie suozai yuefen
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_Gongli_Chunjie_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_Gongli_Chunjie_20#
;?L_Gongli_Chunjie_19#:
;	LDA		T_year_code_TAB,X
;?L_Gongli_Chunjie_20#:
;	AND		#1fh
;	STA		R_Calendar_Temp3					;nongli chunjie suozai ri
;;====================================================================	
;	LDA		#01h
;	BIT		R_Calendar_Temp2					
;	BNE		L_YuanYue_ChunJie					;1yuefen shi nongli chunjie
;	JMP		L_ErYue_ChunJie
;L_YuanYue_ChunJie:
;	CLC
;	DEC		R_Calendar_Temp3
;	LDA		R_Calendar_Temp3
;	JMP		L_ChunJie
;	;STA		R_Calendar_Temp4					;chunjie juli yuandan  tianshu 
;L_ErYue_ChunJie:
;	LDA		R_Calendar_Temp3
;	CLC
;	ADC		#30d								;+31-1
;L_ChunJie:
;	STA		R_Calendar_Temp4
;;=======================================================================
;	LDA		R_Month
;	TAX
;	CMP		#10d
;	BCC		L_Gongli_Days1
;	JMP		L_Gongli_Days2
;L_Gongli_Days1:
;	DEX
;	LDA		T_day_code_TAB1,X
;	CLC
;	ADC		R_Day
;	STA		R_Calendar_Temp5
;	BCS		?L_C_Carry
;	LDA		#00h
;	BEQ		?L_Sta_c5
;
;?L_C_Carry:
;	LDA		#01h
;?L_Sta_c5:
;	STA		R_Calendar_Temp5+1
;	DEC		R_Calendar_Temp5
;	LDA		R_Calendar_Temp5
;	CMP		#ffh
;	BNE		L_eapYear_Day_Modify
;	LDA		#00h
;	STA		R_Calendar_Temp5+1
;	JMP		L_eapYear_Day_Modify
;L_Gongli_Days2:
;	DEX
;	LDA		T_day_code_TAB1,X
;	CLC
;	ADC		R_Day
;	ROL		R_Calendar_Temp5+1
;	STA		R_Calendar_Temp5			;diwei
;	INC			R_Calendar_Temp5+1			;gaowei
;L_eapYear_Day_Modify:
;	LDA		R_Hejira_LeapYear_CalendarFlag
;	BMI		L_LEAP_YEAR
;	JMP		L_ChunJie_QianHou
;L_LEAP_YEAR:							;RUN NIAN +1
;	LDA		R_Month
;	CMP		#03H
;	BCS		L_LEAR_YEAR_Day_adc_1
;	JMP		L_ChunJie_QianHou
;L_LEAR_YEAR_Day_adc_1:
;	INC		R_Calendar_Temp5
;L_ChunJie_QianHou:							;fi start
;	LDA		R_Calendar_Temp5+1
;	BNE		L_ChunJie_Qian
;	LDA		R_Calendar_Temp4
;	CMP		R_Calendar_Temp5
;	BEQ		L_ChunJie_Qian				;add 20150630
;	BCC		L_ChunJie_Qian
;	JMP		L_ChunJie_Hou1
;L_ChunJie_Qian:
;	LDA		R_Calendar_Temp5
;	SEC
;	SBC		R_Calendar_Temp4
;	STA		R_Calendar_Temp5
;	BCC		L_Clear_gaowei1#
;	JMP		L_Nop_Clear1#
;L_Clear_gaowei1#:
;	LDA		#00h
;	STA		R_Calendar_Temp5+1
;L_Nop_Clear1#:
;	LDA		#00H
;	STA		R_Flag_y
;	LDA		#01h
;	STA		R_Month_temp				;R_Month
;	STA		R_Index_Month
;	LDX		R_YEAR_ADDR
;	STX		R_Index_temp
;	JSR		F_JudgeMoonDay
;	STA		R_Calendar_Temp2
;;======================================
;	LDX		R_YEAR_ADDR
;	
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_Runnian_yue_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_Runnian_yue_20#
;?L_Runnian_yue_19#:
;	LDA		T_year_code_TAB,X
;?L_Runnian_yue_20#:
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	STA		R_Calendar_Temp3
;L_Calculate_Day_loop:
;	LDA		R_Calendar_Temp5+1
;	BNE		L_Calculate_Day_loop1
;	LDA		R_Calendar_Temp5
;	CMP		R_Calendar_Temp2
;	BCS		L_Calculate_Day_loop1			;R_Calendar_Temp5>=R_Calendar_Temp2
;	JMP		L_Day_Value
;L_Calculate_Day_loop1:
;	LDA		R_Calendar_Temp5
;	SEC
;	SBC		R_Calendar_Temp2
;	STA		R_Calendar_Temp5
;	BCC		L_Clear_gaowei2#
;	JMP		L_Nop_Clear2#
;L_Clear_gaowei2#:
;	LDA		#00h
;	STA		R_Calendar_Temp5+1
;L_Nop_Clear2#:
;	INC		R_Index_Month					;R_Index_temp
;	
;	LDA		R_Month_temp					;R_Month
;	EOR		R_Calendar_Temp3
;	BEQ		L_YUE_DENGYU_LeapYear_yue
;	JMP		L_Month_add
;L_YUE_DENGYU_LeapYear_yue:
;	LDA		R_Flag_y
;	EOR		#01H	
;	STA		R_Flag_y
;	BEQ		L_Month_add
;	JMP		L_GetMoonDay
;L_ChunJie_Hou1:
;	JMP		L_ChunJie_Hou
;L_Month_add:
;	INC		R_Month_temp				;R_Index_Month
;L_GetMoonDay:
;	LDX		R_YEAR_ADDR
;	STX		R_Index_temp
;	JSR		F_JudgeMoonDay
;	STA		R_Calendar_Temp2
;	JMP		L_Calculate_Day_loop	
;L_Day_Value:
;	INC		R_Calendar_Temp5
;	LDA		R_Calendar_Temp5
;	STA		R_Day_temp						;R_Day
;	JMP		L_Data_Evaluate;	RTS										;if stop										;ADBHAOUDHAOUIDHAIOWDNIOAWNDIOAWNDIO
;L_ChunJie_Hou:													;else start
;	LDA		R_Calendar_Temp4
;	SEC
;	SBC		R_Calendar_Temp5
;	STA		R_Calendar_Temp4	
;	LDA		R_Year_temp										;R_Year		IF(YEAR_L ==0)		
;	BEQ		L_YearH_jian1
;	JMP		L_YearL_jian1
;L_YearH_jian1:
;	LDA		#99D														;100-1
;	STA		R_Year_temp												;R_Year	
;	LDA		#19D
;	STA		R_Year_temp+1											;R_Year+1
;	JMP		L_TAB_ADDR_3
;L_YearL_jian1:
;	DEC		R_Year_temp											;R_Year
;L_TAB_ADDR_3:
;	DEC		R_YEAR_ADDR											;ADDR -3
;	DEC		R_YEAR_ADDR
;	DEC		R_YEAR_ADDR
;	LDA		#12D
;	STA		R_Month_temp										;R_Month
;	LDX		R_YEAR_ADDR
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_else_Runnian_yue_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_else_Runnian_yue_20#
;?L_else_Runnian_yue_19#:
;	LDA		T_year_code_TAB,X
;?L_else_Runnian_yue_20#:
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	CLC
;	ROR		A
;	STA		R_Calendar_Temp3	
;	BEQ		L_Index_Month_Change
;	LDA		#13D
;	STA		R_Index_Month	
;	JMP		L_GetMoonDay_ELSE	
;L_Index_Month_Change:
;	LDA		#12D
;	STA		R_Index_Month	
;L_GetMoonDay_ELSE:
;	LDA		#00H
;	STA		R_Flag_y
;	LDX		R_YEAR_ADDR
;	STX		R_Index_temp
;	JSR		F_JudgeMoonDay
;	STA		R_Calendar_Temp2
;L_Calculate_Day_loop2_ELSE:
;	LDA		R_Calendar_Temp2
;	CMP		R_Calendar_Temp4
;	BCC		L_Calculate_Day_While
;	jmp		L_Calculate_Day_While_end
;L_Calculate_Day_While:
;	lda		R_Calendar_Temp4
;	sec
;	sbc		R_Calendar_Temp2
;	sta		R_Calendar_Temp4
;	dec		R_Index_Month
;	lda		R_Flag_y
;	beq		L_Month_jian1
;	jmp		L_Month_VS_Temp3
;L_Month_jian1:
;	dec		R_Month_temp									;R_Month
;L_Month_VS_Temp3:
;	lda		R_Month_temp									;R_Month
;	EOR		R_Calendar_Temp3
;	beq		L_Month_dengyu_Temp3
;	jmp		L_GetMoonDay_ELSE_WHILE
;L_Month_dengyu_Temp3:
;	lda		R_Flag_y
;	eor		#01h
;	sta		R_Flag_y
;L_GetMoonDay_ELSE_WHILE:
;	LDX		R_YEAR_ADDR
;	STX		R_Index_temp
;	JSR		F_JudgeMoonDay
;	STA		R_Calendar_Temp2
;L_Calculate_Day_While_end:
;	LDA		R_Calendar_Temp2
;	SEC
;	SBC		R_Calendar_Temp4
;	CLC
;	ADC		#01H
;	STA		R_Day_temp							;R_Day
;L_Data_Evaluate:
;	;LDX		R_Year_temp
;	;%Hex_To_BCD
;	;STA		R_LCDHourBuff
;
;	;LDX		R_Month_temp
;	;%Hex_To_BCD
;	;STA		R_LCDMinuBuff	
;	;LDX		R_Day_temp
;	;%Hex_To_BCD
;	;STA		R_LCDSecBuff
;	RTS
;	
;=================================================================
; ==============================================
; Macro		name: F_JudgeWeek
; Purpose	    : 依据阳历日期计算星期
; Parameter		: 
; Return    	: R_Week
; Destroy	    : X
; Stack depth	: 1
; ==============================================
F_JudgeWeek:
_F_JudgeWeek:
	lda		R_Year+1
	and		#00000011b				;(R_Year+1)%4
	beq		?L_WeekNext1#
	sta		R_Calendar_Temp0
;---------------------	
	lda		R_Calendar_Temp0
	clc
	rol		a
	clc
	rol		a
	clc
	adc		R_Calendar_Temp0
	sta		R_Calendar_Temp0				;(R_Year+1)%4*5
	jmp		?L_WeekNext2#
	
 ?L_WeekNext1#:
	lda		#00h
	sta		R_Calendar_Temp0
;---------------------
 ?L_WeekNext2#:
	lda		R_Year
	clc
	adc		R_Calendar_Temp0
	sta		R_Calendar_Temp0				;(R_Year+1)%4*5+R_Year
;---------------------
	lda		R_Year
	clc
	ror		a
	clc
	ror		a
	clc
	adc		R_Calendar_Temp0
	sta		R_Calendar_Temp0				;(R_Year+1)%4*5+R_Year+R_Year/4
;---------------------
	lda		R_Hejira_LeapYear_CalendarFlag
	and		#D_LeapYear
	bne		?L_LeapYear#
?L_NormalYear#:
	ldx		R_Month
	lda		T_WeekAdjust_Normal,x
	clc
	adc		R_Calendar_Temp0				;(R_Year+1)%4*5+R_Year+R_Year/4+mothAdjust
	sta		R_Calendar_Temp0
	jmp		?L_WeekNext#
 ?L_LeapYear#:
	ldx		R_Month
	lda		T_WeekAdjust_Leap,x
	clc
	adc		R_Calendar_Temp0				;(R_Year+1)%4*5+R_Year+R_Year/4+mothAdjust
	sta		R_Calendar_Temp0
;---------------------
 ?L_WeekNext#:
	lda		R_Day
	clc
	adc		R_Calendar_Temp0				;(R_Year+1)%4*5+R_Year+R_Year/4+mothAdjust+R_Day
	sta		R_Calendar_Temp0
	inc		R_Calendar_Temp0
	inc		R_Calendar_Temp0				;(R_Year+1)%4*5+R_Year+R_Year/4+mothAdjust+R_Day+2
;---------------------
	lda		R_Calendar_Temp0
	cmp		#07h
	bcs		?L_WeekValue#
	jmp		?L_JudgeWeekEnd#
 ?L_WeekValue#:
	sec
	sbc		#07h
	cmp		#07h
	bcs		?L_WeekValue#
 ?L_JudgeWeekEnd#:
	sta		R_Week				;week value
	RTS
;;=================================================
;; ==============================================
;; Function	name: F_JudgeMoonDay 
;; Purpose	    : 决定该取那个农历月来判断大月还是小月 
;; Parameter		: R_Index_Month
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_JudgeMoonDay:		
;			LDX		R_Index_Month			;P
;			LDA		T_MonthIndexTab,X
;			TAX
;			LDA		T_GetMoonDay_TAB,X
;			STA		R_JMP_Temp
;			LDA		T_GetMoonDay_TAB+1,X
;			STA		R_JMP_Temp+1
;			JMP		(R_JMP_Temp)
;			RTS
;;ci tab 表格是为了匹配选取那个月份来判断
;T_MonthIndexTab:
;		DB	00H, 00H, 02H, 04H, 06H, 08H, 0AH, 0CH, 0EH, 10H, 12H, 14H, 16H, 18H
;T_MonthIndexTabEnd:
;
;T_GetMoonDay_TAB:
;	DW	F_GetMoonDay1, F_GetMoonDay2, F_GetMoonDay3, F_GetMoonDay4, F_GetMoonDay5, F_GetMoonDay6
;	DW	F_GetMoonDay7, F_GetMoonDay8, F_GetMoonDay9, F_GetMoonDay10, F_GetMoonDay11, F_GetMoonDay12, F_GetMoonDay13
;T_GetMoonDay_TAB_END:
;; ==============================================
;; Function	name: F_GetMoonDay1 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay1:
;	LDX		R_Index_temp
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay1_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay1_20#
;?L_GetMoonDay1_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay1_20#:
;	AND		#08H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay2 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay2:
;	LDX		R_Index_temp
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay2_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay2_20#
;?L_GetMoonDay2_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay2_20#:
;	AND		#04H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay3 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay3:
;	LDX		R_Index_temp
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay3_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay3_20#
;?L_GetMoonDay3_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay3_20#:
;	AND		#02H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay4 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay4:
;	LDX		R_Index_temp
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay4_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay4_20#
;?L_GetMoonDay4_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay4_20#:
;	AND		#01H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay5 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay5:
;	LDX		R_Index_temp
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay5_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay5_20#
;?L_GetMoonDay5_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay5_20#:
;	AND		#80H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay6 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay6:
;	LDX		R_Index_temp
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay6_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay6_20#
;?L_GetMoonDay6_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay6_20#:
;	AND		#40H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay7 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay7:
;	LDX		R_Index_temp
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay7_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay7_20#
;?L_GetMoonDay7_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay7_20#:
;	AND		#20H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay8 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay8:
;	LDX		R_Index_temp
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay8_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay8_20#
;?L_GetMoonDay8_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay8_20#:
;	AND		#10H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay9 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay9:
;	LDX		R_Index_temp
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay9_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay9_20#
;?L_GetMoonDay9_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay9_20#:
;	AND		#08H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay10 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay10:
;	LDX		R_Index_temp
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay10_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay10_20#
;?L_GetMoonDay10_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay10_20#:
;	AND		#04H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay11 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay11:
;	LDX		R_Index_temp
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay11_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay11_20#
;?L_GetMoonDay11_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay11_20#:
;	AND		#02H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay12 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay12:
;	LDX		R_Index_temp
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay12_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay12_20#
;?L_GetMoonDay12_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay12_20#:
;	AND		#01H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;?L_XiaoYue#:
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;; ==============================================
;; Function	name: F_GetMoonDay13 
;; Purpose	    : 判断月份大小月
;; Parameter		: R_Index_temp	year_code_TAB 表格的地址
;; Return    	: nong li yue tian shu
;; Destroy	    : X
;; Stack depth	: 1
;; ==============================================
;F_GetMoonDay13:
;	LDX		R_Index_temp
;	INX
;	INX
;	LDA		R_YEAR_ADDR+1
;	BEQ		?L_GetMoonDay13_19#
;	LDA		T_year_code_TAB1,X
;	JMP		?L_GetMoonDay13_20#
;?L_GetMoonDay13_19#:
;	LDA		T_year_code_TAB,X
;?L_GetMoonDay13_20#:
;	AND		#80H
;	BEQ		?L_XiaoYue#
;	LDA		#30d
;	JMP		?L_DaYue#
;	LDA		#29d
;?L_DaYue#:	
;	RTS
;===========END=============================

;;=====================================
;此处可以进行年月日赋值
;----------------------------------
T_Month_Table:
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
T_Month_Table_END:
;----------------------------------
T_WeekAdjust_Normal:
	DB	0xFF
	DB 	4		;一月
	DB	0		;二月
	DB	0		;三月
	DB	3		;四月
	DB	5		;五月
	DB	1		;六月
	DB	3		;七月
	DB	6		;八月
	DB	2		;九月
	DB	4		;十月
	DB	0		;十一月
	DB	2		;十二月
T_WeekAdjust_Normal_END:
;----------------------------------
T_WeekAdjust_Leap:
	DB	0xFF
	DB 	3		;一月
	DB	6		;二月
	DB	0		;三月
	DB	3		;四月
	DB	5		;五月
	DB	1		;六月
	DB	3		;七月
	DB	6		;八月
	DB	2		;九月
	DB	4		;十月
	DB	0		;十一月
	DB	2		;十二月
T_WeekAdjust_Leap_END:
;表格中：第一个8bit高4位表示农历年闰月的月数，低4bit表示1－4月大小月的标志0为小月1为大月
;		 第二个8bit全部8bit表示农历月的大小5－12月，doushi 对应阳历年的阴历月份
;		 第三个8bit bit7 表示13农历月大小。剩下bit6/bit5表示农历年所在的月bit4春节所在日的高位，低4bit表示春节的日低位
;T_year_code_TAB:
;DB 04H,AeH,53H ;;1901 0
;DB 0AH,57H,48H ;;1902 3
;DB 55H,26H,BdH ;;1903 6
;DB 0dH,26H,50H ;;1904 9
;DB 0dH,95H,44H ;;1905 12
;DB 46H,AAH,B9H ;;1906 15
;DB 05H,6AH,4dH ;;1907 18
;DB 09H,AdH,42H ;;1908 21
;DB 24H,AeH,B6H ;;1909
;DB 04H,AeH,4AH ;;1910
;DB 6AH,4dH,BeH ;;1911
;DB 0AH,4dH,52H ;;1912
;DB 0dH,25H,46H ;;1913
;DB 5dH,52H,BAH ;;1914

;DB 0BH,54H,4eH ;;1915
;DB 0dH,6AH,43H ;;1916
;DB 29H,6dH,37H ;;1917
;DB 09H,5BH,4BH ;;1918
;DB 74H,9BH,C1H ;;1919
;DB 04H,97H,54H ;;1920
;DB 0AH,4BH,48H ;;1921
;DB 5BH,25H,BCH ;;1922
;DB 06H,A5H,50H ;;1923
;DB 06H,d4H,45H ;;1924
;DB 4AH,dAH,B8H ;;1925
;DB 02H,B6H,4dH ;;1926
;DB 09H,57H,42H ;;1927
;DB 24H,97H,B7H ;;1928
;DB 04H,97H,4AH ;;1929
;DB 66H,4BH,3eH ;;1930
;DB 0dH,4AH,51H ;;1931
;DB 0eH,A5H,46H ;;1932
;DB 56H,d4H,BAH ;;1933
;DB 05H,AdH,4eH ;;1934
;DB 02H,B6H,44H ;;1935
;DB 39H,37H,38H ;;1936
;DB 09H,2eH,4BH ;;1937
;DB 7CH,96H,BfH ;;1938
;DB 0CH,95H,53H ;;1939
;DB 0dH,4AH,48H ;;1940
;DB 6dH,A5H,3BH ;;1941
;DB 0BH,55H,4fH ;;1942
;DB 05H,6AH,45H ;;1943
;DB 4AH,AdH,B9H ;;1944
;DB 02H,5dH,4dH ;;1945
;DB 09H,2dH,42H ;;1946
;DB 2CH,95H,B6H ;;1947
;DB 0AH,95H,4AH ;;1948
;	
;DB 7BH,4AH,BdH ;;1949
;DB 06H,CAH,51H ;;1950
;DB 0BH,55H,46H ;;1951
;DB 55H,5AH,BBH ;;1952
;DB 04H,dAH,4eH ;;1953
;DB 0AH,5BH,43H ;;1954
;DB 35H,2BH,B8H ;;1955
;DB 05H,2BH,4CH ;;1956
;DB 8AH,95H,3fH ;;1957
;DB 0eH,95H,52H ;;1958
;DB 06H,AAH,48H ;;1959
;DB 7AH,d5H,3CH ;;1960
;DB 0AH,B5H,4fH ;;1961
;DB 04H,B6H,45H ;;1962
;DB 4AH,57H,39H ;;1963
;DB 0AH,57H,4dH ;;1964
;DB 05H,26H,42H ;;1965
;DB 3eH,93H,35H ;;1966
;DB 0dH,95H,49H ;;1967
;DB 75H,AAH,BeH ;;1968
;DB 05H,6AH,51H ;;1969
;DB 09H,6dH,46H ;;1970
;DB 54H,AeH,BBH ;;1971
;DB 04H,AdH,4fH ;;1972
;DB 0AH,4dH,43H ;;1973
;DB 4dH,26H,B7H ;;1974
;DB 0dH,25H,4BH ;;1975
;DB 8dH,52H,BfH ;;1976
;DB 0BH,54H,52H ;;1977
;DB 0BH,6AH,47H ;;1978
;DB 69H,6dH,3CH ;;1979
;DB 09H,5BH,50H ;;1980
;DB 04H,9BH,45H ;;1981
;DB 4AH,4BH,B9H ;;1982
;DB 0AH,4BH,4dH ;;1983
;DB ABH,25H,C2H ;;1984
;DB 06H,A5H,54H ;;1985 252
;DB 06H,d4H,49H ;;1986 0
;DB 6AH,dAH,3dH ;;1987 3
;DB 0AH,B6H,51H ;;1988 6
;DB 09H,37H,46H ;;1989 9
;DB 54H,97H,BBH ;;1990 12
;DB 04H,97H,4fH ;;1991 15
;DB 06H,4BH,44H ;;1992 18
;DB 36H,A5H,37H ;;1993 21
;DB 0eH,A5H,4AH ;;1994 24
;DB 86H,B2H,BfH ;;1995 27
;DB 05H,ACH,53H ;;1996 30
;DB 0AH,B6H,47H ;;1997 33
;DB 59H,36H,BCH ;;1998 36
;DB 09H,2eH,50H ;;1999 39
;T_year_code_TAB_END:
;T_year_code_TAB1:
;DB 0CH,96H,45H ;;2000 42
;DB 4dH,4AH,B8H ;;2001 45
;DB 0dH,4AH,4CH ;;2002 48
;DB 0dH,A5H,41H ;;2003 51
;DB 25H,AAH,B6H ;;2004 54
;DB 05H,6AH,49H ;;2005 57
;DB 7AH,AdH,BdH ;;2006 60
;DB 02H,5dH,52H ;;2007 63
;DB 09H,2dH,47H ;;2008 66
;DB 5CH,95H,BAH ;;2009 69
;DB 0AH,95H,4eH ;;2010 72
;DB 0BH,4AH,43H ;;2011 75
;DB 4BH,55H,37H ;;2012 78
;DB 0AH,d5H,4AH ;;2013 81
;DB 95H,5AH,BfH ;;2014 84
;DB 04H,BAH,53H ;;2015 87
;DB 0AH,5BH,48H ;;2016 90
;DB 65H,2BH,BCH ;;2017 93
;DB 05H,2BH,50H ;;2018 96
;DB 0AH,93H,45H ;;2019 99
;DB 47H,4AH,B9H ;;2020 101
;DB 06H,AAH,4CH ;;2021 104
;DB 0AH,d5H,41H ;;2022 107
;DB 24H,dAH,B6H ;;2023 110
;DB 04H,B6H,4AH ;;2024 103
;DB 69H,57H,3dH ;;2025 106
;DB 0AH,4eH,51H ;;2026 109
;DB 0dH,26H,46H ;;2027 111
;DB 5eH,93H,3AH ;;2028 114
;DB 0dH,53H,4dH ;;2029 117
;DB 05H,AAH,43H ;;2030 120
;DB 36H,B5H,37H ;;2031 123
;DB 09H,6dH,4BH ;;2032 126
;DB B4H,AeH,BfH ;;2033 129
;DB 04H,AdH,53H ;;2034 132
;DB 0AH,4dH,48H ;;2035 135
;DB 6dH,25H,BCH ;;2036 138
;DB 0dH,25H,4fH ;;2037 141
;DB 0dH,52H,44H ;;2038 144
;DB 5dH,AAH,38H ;;2039 147
;DB 0BH,5AH,4CH ;;2040 150
;DB 05H,6dH,41H ;;2041 153
;DB 24H,AdH,B6H ;;2042 156
;DB 04H,9BH,4AH ;;2043 159
;DB 7AH,4BH,BeH ;;2044 162
;DB 0AH,4BH,51H ;;2045 165
;DB 0AH,A5H,46H ;;2046 168
;DB 5BH,52H,BAH ;;2047 171
;DB 06H,d2H,4eH ;;2048 174
;DB 0AH,dAH,42H ;;2049 177
;DB 35H,5BH,37H ;;2050 180
;DB 09H,37H,4BH ;;2051 183 
;DB 84H,97H,C1H ;;2052 186
;DB 04H,97H,53H ;;2053 189
;DB 06H,4BH,48H ;;2054 192
;DB 66H,A5H,3CH ;;2055 195
;DB 0eH,A5H,4fH ;;2056 198
;DB 06H,B2H,44H ;;2057 201
;DB 4AH,B6H,38H ;;2058 204
;DB 0AH,AeH,4CH ;;2059 207
;DB 09H,2eH,42H ;;2060 210
;DB 3CH,97H,35H ;;2061 213
;DB 0CH,96H,49H ;;2062 216
;DB 7dH,4AH,BdH ;;2063 219
;DB 0dH,4AH,51H ;;2064 222
;DB 0dH,A5H,45H ;;2065 225
;DB 55H,AAH,BAH ;;2066 228
;DB 05H,6AH,4eH ;;2067 231
;DB 0AH,6dH,43H ;;2068 234
;DB 45H,2eH,B7H ;;2069 237
;DB 05H,2dH,4BH ;;2070 240
;DB 8AH,95H,BfH ;;2071 243
;DB 0AH,95H,53H ;;2072 246
;DB 0BH,4AH,47H ;;2073 249
;DB 6BH,55H,3BH ;;2074 252
;DB 0AH,d5H,4fH ;;2075 255
;DB 05H,5AH,45H ;;2076
;DB 4AH,5dH,38H ;;2077
;DB 0AH,5BH,4CH ;;2078
;DB 05H,2BH,42H ;;2079
;DB 3AH,93H,B6H ;;2080
;DB 06H,93H,49H ;;2081
;DB 77H,29H,BdH ;;2082
;DB 06H,AAH,51H ;;2083
;DB 0AH,d5H,46H ;;2084
;DB 54H,dAH,BAH ;;2085
;DB 04H,B6H,4eH ;;2086
;DB 0AH,57H,43H ;;2087
;DB 45H,27H,38H ;;2088
;DB 0dH,26H,4AH ;;2089
;DB 8eH,93H,3eH ;;2090
;DB 0dH,52H,52H ;;2091
;DB 0dH,AAH,47H ;;2092
;DB 66H,B5H,3BH ;;2093
;DB 05H,6dH,4fH ;;2094
;DB 04H,AeH,45H ;;2095
;DB 4AH,4eH,B9H ;;2096
;DB 0AH,4dH,4CH ;;2097
;DB 0dH,15H,41H ;;2098
;DB 2dH,92H,B5H ;;2099
;T_year_code_TAB1_END:
;月份数据表
T_day_code_TAB1:
DB 00H,1FH,3BH,5AH,78H,97H,b5H,d4H,f3H,10H,2fH,4DH	;11h-1, 30h-1 ,4EH-1
T_day_code_TAB1_END:
	
	
;=====================================================
; ==============================================
; Function	name: %F_ADC_BCDADC 
; Purpose	    : 10进制和60进制操作  
; Parameter		: none
; Return    	: A
; Destroy	    : none
; Stack depth	: None 
; =============================================
F_ADC_BCDADC:
			TAX
			CLC
			ADC		#C_Bit_0
			AND		#C_HideHigh
			CMP		#0AH
			BCC		?L_HighNebble_Change
			LDA		#00h
?L_HighNebble_Change:
			STA		R_KEYMathTemp
			TXA
			BCC		?L_No_Caryy
			ADC		#C_Bit_4
?L_No_Caryy:		
			AND		#C_HideLow
			CMP		#70H		;#60h
			BCC		?L_ChangeOk
			LDA		#00h
?L_ChangeOk:
			EOR		R_KEYMathTemp			; when >=a0h,c=1 
			RTS
;; ==============================================
;; Function	name: %F_DEC_BCDADC 
;; Purpose	    : 10进制和60进制操作  
;; Parameter		: none
;; Return    	: A
;; Destroy	    : none
;; Stack depth	: None 
;; =============================================
;F_DEC_BCDADC:
;			TAX
;			SEC
;			SBC		#C_Bit_0
;			AND		#C_HideHigh
;			CMP		#C_HideHigh
;			BCC		?L_HighNebble_Change
;			LDA		#09h
;?L_HighNebble_Change:
;			STA		R_KEYMathTemp
;			TXA
;			BCC		?L_No_Caryy
;			SBC		#C_Bit_4
;?L_No_Caryy:		
;			AND		#C_HideLow
;			CMP		#C_HideLow
;			BCC		?L_ChangeOk
;			LDA		#50h
;?L_ChangeOk:
;			EOR		R_KEYMathTemp			; when >=a0h,c=1 
;			RTS
;			
;; ==============================================
;; Function	name: F_Hour_BCDADC 
;; Purpose	    : one byte data inc and change to BCD 
;; Parameter		: A
;; Return    	: A,C
;; Destroy	    : X
;; Stack depth	: 1
;; =============================================
;F_Hour_BCDADC:
;			TAX
;			AND		#C_HideLow
;			CMP		#C_Bit_5		;>=2 C=1 ELSE C=0
;			BCC		?L_Nomal#	;20H以下操作
;			JMP		?L_NotNomal#
;?L_Nomal#:
;			JSR		F_HourADC_Nomal
;			RTS
;?L_NotNomal#:
;			JSR		F_HourADC_NOTNomal
;			RTS
;; ==============================================
;; Function	name: F_HourADC_Nomal 
;; Purpose	    : one byte data ADC and change to BCD 
;; Parameter		: A
;; Return    	: A,C
;; Destroy	    : X
;; Stack depth	: 1
;; =============================================
;F_HourADC_Nomal:
;			TXA
;			CLC
;			ADC		#C_Bit_0
;			AND		#C_HideHigh
;			CMP		#0AH
;			BCC		?L_HighNebble_Change
;			LDA		#00h
;?L_HighNebble_Change:
;			STA		R_KEYMathTemp
;			TXA
;			BCC		?L_No_Caryy
;			ADC		#C_Bit_4
;?L_No_Caryy:		
;			AND		#C_HideLow
;			CMP		#30H
;			BCC		?L_ChangeOk
;			LDA		#00h
;?L_ChangeOk:
;			EOR		R_KEYMathTemp			; when >=a0h,c=1  
;			RTS
;
;			
;; ==============================================
;; Function	name: F_HourADC_NOTNomal 
;; Purpose	    : one byte data ADC and change to BCD 
;; Parameter		: A
;; Return    	: A,C
;; Destroy	    : X
;; Stack depth	: 1
;; =============================================
;F_HourADC_NOTNomal:
;			TXA
;			CLC
;			ADC		#C_Bit_0
;			AND		#C_HideHigh
;			CMP		#05H		;#04h			;c=0	A<=4 else c=1 a>=4
;			BCC		?L_HighNebble_Change24
;			LDA		#00h
;?L_HighNebble_Change24:
;			STA		R_KEYMathTemp
;			TXA
;			BCC		?L_No_Caryy24
;			LDA		#00H
;			JMP		?L_ChangeOk24
;?L_No_Caryy24:		
;			AND		#C_HideLow
;			CMP		#30H
;			BCC		?L_ChangeOk24
;			LDA		#00h
;?L_ChangeOk24:
;			EOR		R_KEYMathTemp			; when >=a0h,c=1  
;			RTS
;; ==============================================
;; Function	name: F_Hour_BCDDEC 
;; Purpose	    : one byte data DEC and change to BCD 
;; Parameter		: A
;; Return    	: A,C
;; Destroy	    : X
;; Stack depth	: 1
;; =============================================
;F_Hour_BCDDEC:
;			TAX
;			AND		#C_HideLow
;			CMP		#C_Bit_5		;>=2 C=1 ELSE C=0
;			BCC		?L_Nomal#	;20H以下操作
;			JMP		?L_NotNomal#
;?L_Nomal#:
;			JSR		F_HourDEC_Nomal
;			RTS
;?L_NotNomal#:
;			JSR		F_HourDEC_NotNomal
;			RTS
;; ==============================================
;; Function	name: F_HourDEC_Nomal 
;; Purpose	    : one byte data DEC and change to BCD 
;; Parameter		: A
;; Return    	: A,C
;; Destroy	    : X
;; Stack depth	: 1
;; =============================================
;F_HourDEC_Nomal:
;			TXA
;			SEC
;			SBC		#C_Bit_0
;			AND		#C_HideHigh
;			CMP		#C_HideHigh
;			BCC		?L_HighNebble_Change
;			TXA
;			BEQ		?L_24_Caryy
;			LDA		#09h
;			JMP		?L_HighNebble_Change
;?L_24_Caryy:
;			LDA		#03H
;?L_HighNebble_Change:
;			STA		R_KEYMathTemp
;			TXA
;			BCC		?L_No_Caryy
;			SBC		#C_Bit_4
;?L_No_Caryy:		
;			AND		#C_HideLow
;			CMP		#C_HideLow
;			BCC		?L_ChangeOk
;			LDA		#C_Bit_5
;?L_ChangeOk:
;			EOR		R_KEYMathTemp			; when >=a0h,c=1  
;			RTS
;
;; ==============================================
;; Function	name: F_HourDEC_NotNomal 
;; Purpose	    : one byte data DEC and change to BCD 
;; Parameter		: A
;; Return    	: A,C
;; Destroy	    : X
;; Stack depth	: 1
;; =============================================
;F_HourDEC_NotNomal:
;			TXA
;			SEC
;			SBC		#C_Bit_0
;			AND		#C_HideHigh
;			CMP		#C_HideHigh			;c=0	A<=4 else c=1 a>=4
;			BCC		?L_HighNebble_Change24
;			LDA		#09h
;?L_HighNebble_Change24:
;			STA		R_KEYMathTemp
;			TXA
;			BCC		?L_No_Caryy24
;			LDA		#C_Bit_4
;			JMP		?L_ChangeOk24
;?L_No_Caryy24:		
;			AND		#C_HideLow
;			CMP		#30H
;			BCC		?L_ChangeOk24
;			LDA		#00h
;?L_ChangeOk24:
;			EOR		R_KEYMathTemp			; when >=a0h,c=1  
;			RTS
; ==============================================
; Function	name: F_24TO12Change 
; Purpose	    : change Hour 24 to 12 
; Parameter		: A
; Return    	: A
; Destroy	    : none
; Stack depth	: None
; =============================================
F_24TO12Change:
_F_24TO12Change:
			BEQ		?L_NeedChange2
			CMP		#13H
			BCS		?L_NeedChange
			JMP		?L_ChangeOK
?L_NeedChange:
			SEC
			SBC		#12H
			TAX
			AND		#C_HideHigh
			CMP		#0EH
			BCS		?L_NeedChange1
			TXA
			JMP		?L_ChangeOK
?L_NeedChange2:
			LDA		#12H
			JMP		?L_ChangeOK
?L_NeedChange1:
			SBC		#06H
?L_ChangeOK:
			RTS
			

F_CheckAlarm:					;检查闹钟是否打开
;	jsr		Disable_Alarm
	LDA		R_TimeFlashSet
	ORA		R_AlmTimeFlashSet
	ORA		R_TimerFlashSet
	BNE		?Exit				;有设置界面打开则不检查闹钟	
	LDA		R_AlarmOnOff
	BNE		$+3				;有闹钟打开，则去比较闹钟时间与当前时间
	?Exit:
		RTS
		LDX		#0		
;;------------------------------------------------	
F_EnCheckAlarm:
		LDA     R_AlarmOnOff         ; 加载闹钟启用状态
		JSR     CheckAlarmEnabled             ; 测试第X位是否设置
		BEQ     ?L_NextAlarm           ; 未启用则跳过	
		
		LDA		R_AlarmHour	,x
		EOR		R_DateHour		
		BNE		?L_NextAlarm		;判断小时
		LDA		R_AlarmMinute	,x
		EOR		R_DateMinute
		BNE		?L_NextAlarm		;判断分
	    STX     R_CurrentGroup      ; 保存当前组号
       JSR     F_CheckAlarmDayType ; 调用天数类型检查（C=1触发）	
       BCC     ?L_NextAlarm         ; 天数类型不匹配则跳过
		JSR		L_LoadAlarming		;闹钟响
		LDA		#0
		STA		R_SleepTime
		JMP     ?L_SleepSnooze
	?L_NextAlarm:					;闹钟时间没到
		INX
	    CPX #3
   	BCC F_EnCheckAlarm
   ?L_SleepSnooze: 	; 贪睡状态检查
	 	LDA R_OtherFlag
		AND	#D_EnableSnooze
		BEQ	$+5		
		JSR	F_CheckSnoozeAlarm
		RTS
		
; 输入：X = 闹钟组号 (0-2)
; 输出：Z=1 表示未启用，Z=0 表示启用
CheckAlarmEnabled:
   LDA BitMaskTable,X   ; 获取对应位掩码
   AND R_AlarmOnOff     ; 与启用状态寄存器相与
   RTS                  ; 结果在 A 中，Z 标志位表示是否启用	
.PUBLIC		F_CheckAlarmDayType		
F_CheckAlarmDayType:
	   LDA    R_Week
	   TAY                         ; Y = 当前星期（0=日,1=一...6=六）
       LDX     R_CurrentGroup   ; 获取当前组的天数类型
       LDA     R_DispAlmDay,X      ; A=天数类型(0=双休,1=单休,2=每天)        
    
       BEQ     ?Check_5Day         ; 根据类型判断
       CMP     #1
       BEQ     ?Check_6Day       
       
	?Check_7Day:                      
       SEC                         ; 直接允许触发
       RTS
       
	?Check_5Day:                        ; 检查是否工作日（周一至周五）
       CPY     #1                  ; 周一
       BCC     ?Not_Workday        ; Y<1（周日）
       CPY     #6                  ; 周六
       BCS     ?Not_Workday        ; Y>=6（周六）
       SEC                         ; 允许触发
       RTS       
	?Check_6Day:                        ; 检查周一至周六
       CPY     #0                  ; 周日
       BEQ     ?Not_Workday
       SEC                         ; 允许触发
       RTS
       
?Not_Workday:
       CLC                         ; 不触发
       RTS		
	   
.PUBLIC		Disable_Alarm
.PUBLIC		_Disable_Alarm
 Disable_Alarm:	
_Disable_Alarm:
	%btsf	R_OtherFlag,(D_Alarming+D_Timering),Exit_ALMCheck
	DEC		R_SnoozeTime
	BNE		Exit_ALMCheck
	; 保存D_Timering状态用于区分闹钟/计时
	%btst	R_OtherFlag,D_Timering,?L_Exit
	; 自动贪睡:仅闹钟(非计时器)且剩余次数>0
	LDA		R_SnoozeCount
	BEQ		?L_Exit
	LDA		#6
	STA		R_SleepTime
	%bits	R_OtherFlag,D_EnableSnooze
	LDA		#D_UI_Time
	STA		R_Uart_OpenTime	
?L_Exit:	
	%bitr	R_OtherFlag,(D_Alarming+D_Timering)
	%bits	R_OtherFlag,D_ToneDIS

Exit_ALMCheck:	
	
	rts      

L_LoadAlarming:		
		 ; 新闹钟/计时响铃时取消之前的贪睡
		 LDA		#0
		 STA		R_SnoozeCount
		 STA		R_SleepTime
		 %bitr	R_OtherFlag,D_EnableSnooze
		 ; 记录本次响铃的闹钟组,贪睡闪烁用
		 LDA		R_CurrentGroup
		 STA		R_SnoozeGroup
	     LDA		#C_SnoozeTime1min
		 STA		R_SnoozeTime
		 JSR		Voice_PowerOn_Noxiaonao	 
		 %bitr	R_OtherFlag,D_ToneDIS	
		%bits	R_OtherFlag,(D_Alarming+D_AlarmingStatus)	
		; 首次响铃:初始化贪睡次数=3
		LDA		#C_SnoozeMaxCount
		STA		R_SnoozeCount
		CLI
		RTS
		

F_CheckSnoozeAlarm:			;贪睡时间检查
		; 响铃期间不递减贪睡计时,保证静音间隔准确
		LDA		R_OtherFlag
		AND		#D_Alarming
		BNE		?L_Exit
		LDA		R_SleepTime
		BEQ		?Check_SnoozeTrigger  ;时间到，触发贪睡
		DEC		R_SleepTime
		BNE		?L_Exit
	?Check_SnoozeTrigger:
		; 贪睡时间到:次数>0则重新响铃
		LDA		R_SnoozeCount
		BEQ		?L_ClearSnooze		; 次数用完,清除贪睡标志防止图标残留闪烁
		DEC		R_SnoozeCount	
		LDA		#6
		STA		R_SleepTime	
		LDA		R_SnoozeCount
		BNE		?L_LoadAlarming
		%bitr	R_OtherFlag,D_EnableSnooze		
?L_LoadAlarming:			
		 ; 将当前组设为贪睡组，确保响铃闪烁显示正确的闹钟组
		 LDA		R_SnoozeGroup
		 STA		R_CurrentGroup
	     LDA	#C_SnoozeTime1min
		 STA	R_SnoozeTime
		 JSR	Voice_PowerOn_Noxiaonao	 
		 %bitr	R_OtherFlag,D_ToneDIS	
		%bits	R_OtherFlag,(D_Alarming+D_AlarmingStatus)		
		CLI
		JMP		?L_Exit			; 响铃已启动,跳过清除贪睡标志
?L_ClearSnooze:
		%bitr	R_OtherFlag,D_EnableSnooze	; 次数用完,清除贪睡标志
	?L_Exit:	
		RTS	
		
.ENDS
