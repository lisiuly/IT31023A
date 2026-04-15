# 1 ".\\Timer\\Timer.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 ".\\Timer\\Timer.c"
# 1 "./GPL815P.h" 1
# 57 "./GPL815P.h"
# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 1





# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h" 1
# 34 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h"
unsigned char __bgetc(unsigned char* src, unsigned char bID);
# 7 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 2
# 58 "./GPL815P.h" 2
# 2 ".\\Timer\\Timer.c" 2
# 1 "./calendar\\calendar.h" 1
# 11 "./calendar\\calendar.h"
void F_24HourClock(void) ;

void F_JudegLeapYear(void);
void F_Check_Alarming(void);
void F_JudgeWeek(void);

void Disable_Alarm(void);

extern unsigned char R_Week;
extern unsigned char R_Month;
extern unsigned char R_Month_temp;
extern unsigned char R_Day_temp;
extern unsigned char R_Day;
extern unsigned char R_Year[2];
extern unsigned char R_Year_temp[2];
extern unsigned char R_Hejira_LeapYear_CalendarFlag;
extern unsigned char R_LCDHourBuff;
extern unsigned char R_LCDMinuBuff;
extern unsigned char R_LCDSecBuff;
extern unsigned char R_DateMinute;
extern unsigned char R_DateHour;
extern unsigned char R_DateSecond;
extern unsigned char R_AlarmHour[3];
extern unsigned char R_AlarmMinute[3];
extern unsigned char R_CurrentGroup;
extern unsigned char R_DispAlmDay[3];
extern unsigned char R_AlarmOnOff;
extern unsigned char R_Alarm_ENDIS_Flag;
extern unsigned char R_TimerMinute;
extern unsigned char R_TimerSecond;






extern unsigned char RB_12_24_Status;
# 3 ".\\Timer\\Timer.c" 2
# 1 "./KEYSCAN\\key_user.h" 1
# 13 "./KEYSCAN\\key_user.h"
extern void F_InitialKeyBorad(void);
# 24 "./KEYSCAN\\key_user.h"
extern void F_KeyScan(void);
extern void F_CodeSwitchScan(void);
# 35 "./KEYSCAN\\key_user.h"
extern void F_DC_Det(void);
extern void F_Charge(void);
# 45 "./KEYSCAN\\key_user.h"
extern unsigned char R_KeyTemp;
extern unsigned char R_CodeIOValue;
extern unsigned char R_KeyValue;

extern unsigned char R_DebounceCnt;
extern unsigned char R_LongKeyTime;
extern unsigned char R_CodeDebounce;

extern unsigned char R_SleepTime;

extern unsigned char R_KeyFlag;





extern unsigned char R_SnoozeTime;





extern unsigned char R_Charge;




extern unsigned char R_CurrentSong;

extern unsigned char R_TimerFlag;






extern unsigned char R_SetBack;
extern unsigned char R_TimeFlashSet;
extern unsigned char R_AlmTimeFlashSet;

extern unsigned char R_TimerFlashSet;




extern unsigned char R_CurrentVolume;
extern unsigned char SetVolumeAndPlayAlarm1_flag;

extern unsigned char R_DelayTemp;

extern unsigned char R_OtherFlag;
# 104 "./KEYSCAN\\key_user.h"
extern unsigned char R_KeepAwakeTimer;

extern unsigned char R_Uart_OpenTime;
extern unsigned char R_LVDStatus;





extern unsigned char R_VoiceFlag;


extern unsigned char R_DelayOpen;
extern void Voice_PowerOn(void);
extern void F_SystemPowerOff(void);
extern unsigned char R_VoiceReq;
extern void Voice_PowerOn_Noxiaonao(void);
# 4 ".\\Timer\\Timer.c" 2
# 1 "./lcd\\lcd_user.h" 1
# 13 "./lcd\\lcd_user.h"
extern void F_Flash_Dot(unsigned char flash_index);
# 22 "./lcd\\lcd_user.h"
extern void F_DispFlag(unsigned char lcd_index);
# 31 "./lcd\\lcd_user.h"
extern void F_NotDispFlag(unsigned char lcd_index);
extern void F_Fill_ALL_LCDDPRAM(void);
extern void F_SeetupDisplay_Proc(void);
# 43 "./lcd\\lcd_user.h"
extern void F_Disp_Digital(unsigned char A_disp,unsigned char Y_index);
# 53 "./lcd\\lcd_user.h"
extern void F_LCDDisplay(void);
extern void F_LCDDisplay_Proc(void);
extern void F_Fill_LCDDPRAM(void);
extern void F_Flash_COL_Dot(void);
extern void F_LCD_Initinal(void);
extern unsigned char R_LcdBuff[30];

extern unsigned char RB_Lcd_Updata_Flag;





extern unsigned char RB_LCD_Display_change;
extern unsigned char R_flash_Temp;



extern unsigned char RB_Setup_LCD_Status;
# 80 "./lcd\\lcd_user.h"
extern unsigned char RB_Setup_Status;

extern unsigned char R_flash_Temp;

extern unsigned char R_POINT;

extern unsigned char R_Uart_UI ;


extern unsigned char R_Electricity;
# 5 ".\\Timer\\Timer.c" 2
# 1 ".\\Timer\\/timer.h" 1




extern unsigned char R_BacklightLevel;

extern unsigned char R_CurrentBrightness;


void PWM_Backlight_Init(void);
void PWM_SetBrightness(unsigned char brightness);
void F_Backlight_Process(void);



extern void allocate_segments(unsigned char minutes);

extern void F_TimerUpdate(void);
extern void F_ForwardTimer(void);
extern void F_CountdownTimer(void);

extern void F_Calc12Icon(void);
# 6 ".\\Timer\\Timer.c" 2





extern unsigned char R_IconCount;






void F_ForwardTimer(void) {

    if (!(R_TimerFlag & 0x01)) {
        return;
    }

    if (R_TimerMinute == 60 && R_TimerSecond ==00) {

     Voice_PowerOn_Noxiaonao();

        R_TimerFlag &= ~0x01;
        R_SnoozeTime = 60;
        R_OtherFlag &= ~0x08;
        R_OtherFlag |= (0x40 +0x80 +0x20);

        return;
    }

    R_TimerSecond++;
  RB_Lcd_Updata_Flag |= 0x40;

    if (R_TimerSecond >= 60) {
        R_TimerSecond = 0;
        R_TimerMinute++;

    }
}


void F_CountdownTimer(void) {

    if (!(R_TimerFlag & 0x02)) {
        return;
    }


    if (R_TimerMinute == 0 && R_TimerSecond == 0) {

     Voice_PowerOn_Noxiaonao();

        R_TimerFlag &= ~0x02;
        R_SnoozeTime = 60;
        R_OtherFlag &= ~0x08;
        R_OtherFlag |= (0x40 +0x80);
        return;
    }
     RB_Lcd_Updata_Flag |= 0x40;

    if (R_TimerSecond > 0) {
        R_TimerSecond--;
    } else {

        R_TimerSecond = 59;
        if (R_TimerMinute > 0) {
            R_TimerMinute--;
        }
    }
}


void F_TimerUpdate(void) {


        F_ForwardTimer();



        F_CountdownTimer();

}




unsigned char R_BacklightLevel = 1;
unsigned char R_CurrentBrightness = 255;


static const unsigned char kBacklightBrightness[4] = {0, 76, 153, 255};
static const unsigned char kBacklightSleepBrightness[4] = {0, 13, 28, 43};

static unsigned char Get_Backlight_Target(void)
{
   const unsigned char level = (R_BacklightLevel >= 1 && R_BacklightLevel <= 3)
                                ? R_BacklightLevel : 3;


    return ((*(volatile unsigned char *) (0x3080 +0x0A) & 0x20) == 0)
           ? kBacklightBrightness[level]
           : kBacklightSleepBrightness[level];
}
# 118 ".\\Timer\\Timer.c"
void PWM_Backlight_Init(void)
{

    *(volatile unsigned char *) (0x3080 +0x08) |= 0x02;
    *(volatile unsigned char *) (0x3080 +0x0A) &= ~0x02;



    *(volatile unsigned char *) (0x3490 +0x01) &= ~(0x03 << 2);
    *(volatile unsigned char *) (0x3490 +0x01) |= (0x01 << 2);



    *(volatile unsigned char *) (0x3490 +0x02) = 255;







    *(volatile unsigned char *) (0x3490 +0x00) &= 0x80;
    *(volatile unsigned char *) (0x3490 +0x00) |= (0x01 << 4) | (0x01 << 1);
}





void PWM_SetBrightness(unsigned char brightness)
{
    *(volatile unsigned char *) (0x3490 +0x05) = brightness;
}
# 165 ".\\Timer\\Timer.c"
void F_Backlight_Process(void)
{
    if((R_KeyFlag & 0x02) == 0)
 {
    unsigned char target_brightness = Get_Backlight_Target();


    if (R_CurrentBrightness != target_brightness)
    {


        if (target_brightness > 0 && (*(volatile unsigned char *) (0x3490 +0x00) & 0b00000010) == 0)
        {
            PWM_Backlight_Init();
        }


        if (target_brightness > 0)
        {
            *(volatile unsigned char *) (0x3080 +0x0A) &= ~(0x01 << 1);
            *(volatile unsigned char *) (0x3490 +0x00) |= 0b00000010;


        }
        R_CurrentBrightness = target_brightness;
        PWM_SetBrightness(target_brightness);







    }
 }


}
# 326 ".\\Timer\\Timer.c"
void F_Calc12Icon(void) {
    R_IconCount = R_TimerMinute / 5;

}
