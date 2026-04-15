;============================================================================
;File Name:	lcd_user.inc
;Applied body:	GPL815PX
;Descriptions:	AT24C01D/02D I2C function for user Call
;Programmer:	yanxiaodu
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
.EXTERNAL			F_Flash_counter_set
; ==============================================
; Function	name: F_Flash_Dot 
; Purpose	    : Make a dot flash 
; Parameter		: X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; =============================================		

;.EXTERNAL			F_Flash_Dot
; ==============================================
; Function	name: F_DispFlag 
; Purpose	    : show DOT
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
.EXTERNAL			F_DispFlag
.EXTERNAL			F_SwatchDispFlag
; ==============================================
; Function	name: F_NotDispFlag 
; Purpose	    : show DOT
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
.EXTERNAL			F_NotDispFlag
.EXTERNAL			F_SwatchNotDispFlag

;.EXTERNAL			F_Fill_ALL_LCDDPRAM
.EXTERNAL			.PAGE0	R_LcdBuff
; ==============================================
; Function	name: F_Disp_NO_Digital 
; Purpose	    : show digital 
; Parameter		: A  display icon ,X  dispaly index
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; =============================================
.EXTERNAL			F_Disp_Digital
.EXTERNAL			F_Disp_Digital_1	
; ==============================================
; Function	name: F_Flash_PandTime_Dot 
; Purpose	    : Make a dot flash 
; Parameter		: X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; =============================================		
.EXTERNAL	F_LCDDisplay
.EXTERNAL	F_LCDDisplay_Proc
;.EXTERNAL	F_Fill_LCDDPRAM
.EXTERNAL	F_Flash_COL_Dot
.EXTERNAL	F_SeetupDisplay_Proc
.EXTERNAL	F_Settup_Hour_LCD_Disp
.EXTERNAL		F_Settup_Hour_LCD_Disp
.EXTERNAL		F_Settup_Minute_LCD_Disp
.EXTERNAL		F_Settup_alarmhour_LCD_Disp
.EXTERNAL		F_Settup_alarmminu_LCD_Disp
.EXTERNAL		F_Settup_day_LCD_Disp
.EXTERNAL		F_Settup_Year_LCD_Disp
.EXTERNAL		F_Settup_month_LCD_Disp


.EXTERNAL	.PAGE0		RB_Lcd_Updata_Flag
	 D_LcdtimesetUpdate:			.EQU		10000000B
	 D_LcdUpdate:					.EQU		40H
	 D_LcdChangeUpdate:				.EQU		20H	
	 

.EXTERNAL	RB_LCD_Display_change

;.EXTERNAL	RB_Temp_CF_Flag
;	D_F_Flag:			.equ	0x80
.EXTERNAL	RB_Setup_LCD_Status
	D_Time_Minute_setup_lcd:		.equ	0
	D_Time_Hour_setup_lcd:			.equ	1
	D_Date_Year_setup_lcd:			.equ	2
	D_Date_Month_setup_lcd:			.equ	3
	D_Date_Day_setup_lcd:			.equ	4
	D_Alarm_Minute_setup_lcd:		.equ	5
	D_Alarm_Hour_setup_lcd:			.equ	6
.EXTERNAL	RB_Setup_Status
	D_Setting_flag:			.equ	0x80

.EXTERNAL	R_flash_Temp

.EXTERNAL	R_POINT

.EXTERNAL		R_Uart_UI	
D_UI_Time		equ		60

;.EXTERNAL	R_DispTemper	
;.EXTERNAL	R_DispHum	
;.EXTERNAL	R_SpecFlag	
;;R_TempMin_Sign	ds	1
;;R_TempMax_Sign	ds	1
;;R_HumMin_Sign	ds	1
;;R_HumMax_Sign	ds	1
;D_HumHH				equ	0x80
;D_HumLL				equ	0x40
;D_TempHH			equ	0x20
;D_TempLL			equ	0x10
;D_Neg				equ 0x08	;负温度
;D_TF				equ 0x04	;华氏度
;D_DelayReady		equ 0x02	
;C_TEMP_HH		equ	5
;C_TEMP_LL		equ 9
.EXTERN	F_LCD_Initinal
