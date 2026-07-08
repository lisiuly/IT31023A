;============================================================================
;File Name:	lcd_user.inc
;Applied body:	GPL811p0x
;Descriptions:	AT24C01D/02D I2C function for user Call
;Programmer:	GPL815PX
;Created Date:	2014-03-19
;Version:		1.0
;============================================================================
;==========================================
; external define area
;==========================================

; ==============================================
; Macro name	: F_CountDataAndTime 
; Purpose	    : count time with one second 
; Parameter		: 
; Return    	: 
; Destroy	    : 
; Stack depth	: 
; =============================================
.EXTERNAL			F_24HourClock

; ==============================================
; Function	name: F_Flash_Dot 
; Purpose	    : Make a dot flash 
; Parameter		: X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; =============================================		
C_SnoozeInterval	EQU		5
C_SnoozeMaxCount	EQU		3
.EXTERNAL	R_SnoozeCount	
.EXTERNAL	_R_SnoozeCount	
;.EXTERNAL			F_GetNsLiCalendar
; ==============================================
; Function	name: F_DispFlag 
; Purpose	    : show DOT
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
.EXTERNAL			F_JudegLeapYear
.EXTERNAL			F_24TO12Change
.EXTERNAL			F_Check_Alarming
.EXTERNAL			F_JudgeWeek
; ==============================================
; Function	name: F_NotDispFlag 
; Purpose	    : show DOT
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
.EXTERNAL		F_CheckAlarmDayType	

.EXTERNAL	.PAGE0		R_Week
.EXTERNAL	.PAGE0		R_Month
.EXTERNAL	.PAGE0		R_Month_temp
.EXTERNAL	.PAGE0		R_Day
.EXTERNAL	.PAGE0		R_Day_temp
.EXTERNAL	.PAGE0		R_Year
.EXTERNAL	.PAGE0		R_Year_temp
.EXTERNAL	.PAGE0		R_Hejira_LeapYear_CalendarFlag
.EXTERNAL	.PAGE0		R_LCDHourBuff
.EXTERNAL	.PAGE0		R_LCDMinuBuff
.EXTERNAL	.PAGE0		R_LCDSecBuff
.EXTERNAL	.PAGE0		R_DateHour
.EXTERNAL	.PAGE0		R_DateMinute
.EXTERNAL	.PAGE0		R_DateSecond
.EXTERNAL	.PAGE0		R_AlarmMinute
.EXTERNAL	.PAGE0		R_AlarmHour
.EXTERNAL	.PAGE0		R_CurrentGroup
.EXTERNAL	.PAGE0		R_SnoozeGroup
.EXTERNAL	.PAGE0		R_DispAlmDay
.EXTERNAL	.PAGE0		R_AlarmOnOff
.EXTERNAL	.PAGE0		R_Alarm_ENDIS_Flag
.EXTERNAL	.PAGE0		R_TimerMinute
.EXTERNAL	.PAGE0		R_TimerSecond	

	D_Alarm_EN:		.EQU	0X80
.EXTERNAL	.PAGE0		RB_12_24_Status
	D_24H:		.EQU	00H
	D_12H:		.EQU	80H
	
D_LeapYear:			.EQU	%10000000B
