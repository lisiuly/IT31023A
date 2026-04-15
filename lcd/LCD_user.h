#ifndef _LCD_USER_H
#define _LCD_USER_H
/* Resource Info C File GPL815PX*/
//; ==============================================
//; Function	name: F_Flash_Dot 
//; Purpose	    : Make a dot flash 
//; Parameter		: X
//; Return    	: 
//; Destroy	    : 
//; Stack depth	: 2
//; =============================================		

extern	void	F_Flash_Dot(unsigned char flash_index);
//; ==============================================
//; Function	name: F_DispFlag 
//; Purpose	    : show DOT
//; Parameter		: A,X
//; Return    	: 
//; Destroy	    : 
//; Stack depth	: 2
//; ==============================================
extern	void	F_DispFlag(unsigned char lcd_index);
//; ==============================================
//; Function	name: F_NotDispFlag 
//; Purpose	    : show DOT
//; Parameter		: A,X
//; Return    	: 
//; Destroy	    : 
//; Stack depth	: 2
//; ==============================================
extern	void	F_NotDispFlag(unsigned char lcd_index);
extern	void	F_Fill_ALL_LCDDPRAM(void);
extern	void	F_SeetupDisplay_Proc(void);

//; ==============================================
//; Function	name: F_Disp_NO_Digital 
//; Purpose	    : show digital 
//; Parameter		: A  display icon ,X  dispaly index
//; Return    	: 
//; Destroy	    : 
//; Stack depth	: 2
//; =============================================
extern	void	F_Disp_Digital(unsigned char A_disp,unsigned char Y_index);
	
//; ==============================================
//; Function	name: F_Flash_PandTime_Dot 
//; Purpose	    : Make a dot flash 
//; Parameter		: X
//; Return    	: 
//; Destroy	    : 
//; Stack depth	: 2
//; =============================================
extern	void	F_LCDDisplay(void);
extern	void	F_LCDDisplay_Proc(void);
extern	void	F_Fill_LCDDPRAM(void);
extern	void	F_Flash_COL_Dot(void);
extern	void	F_LCD_Initinal(void);
extern unsigned char	R_LcdBuff[30];

extern unsigned char	RB_Lcd_Updata_Flag;
	#define		D_LcdtimesetUpdate	0x80
	#define		D_LcdUpdate			0x40
	#define		D_LcdChangeUpdate	0x20
	 

extern unsigned char	RB_LCD_Display_change;
extern unsigned char	R_flash_Temp;
//extern unsigned char	RB_Temp_CF_Flag;
//#define		D_F_Flag		0x80

extern unsigned char	RB_Setup_LCD_Status;
#define		D_Time_Minute_setup_lcd		0x00
#define		D_Time_Hour_setup_lcd		0x01
#define		D_Date_Year_setup_lcd		0x02
#define		D_Date_Month_setup_lcd		0x03
#define		D_Date_Day_setup_lcd		0x04
#define		D_Alarm_Minute_setup_lcd	0x05
#define		D_Alarm_Hour_setup_lcd		0x06

extern unsigned char	RB_Setup_Status;
#define		D_Setting_flag		0x80
extern unsigned char	R_flash_Temp;

extern unsigned char   R_POINT;

extern unsigned char  R_Uart_UI	;
#define	D_UI_Time		60

extern unsigned char R_Electricity;
//
//extern unsigned char	R_SpecFlag;
//#define		D_HumHH				0x80
//#define		D_HumLL				0x40
//#define		D_TempHH			0x20
//#define		D_TempLL			0x10
//#define		D_Neg				0x08	
//#define		D_TF				0x04	
//#define		D_DelayReady		0x02	
//#define		C_TEMP_HH			5
//#define		C_TEMP_LL			9

#endif
