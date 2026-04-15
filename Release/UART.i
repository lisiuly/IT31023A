# 1 ".\\UART\\UART.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 ".\\UART\\UART.c"
# 1 "./GPL815P.h" 1
# 57 "./GPL815P.h"
# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 1





# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h" 1
# 34 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h"
unsigned char __bgetc(unsigned char* src, unsigned char bID);
# 7 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 2
# 58 "./GPL815P.h" 2
# 2 ".\\UART\\UART.c" 2
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
# 3 ".\\UART\\UART.c" 2
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
# 4 ".\\UART\\UART.c" 2
# 1 "./UART\\UART_Code.h" 1
# 21 "./UART\\UART_Code.h"
extern void F_UART_Initial(void);
extern void Countdown(void);
# 45 "./UART\\UART_Code.h"
extern void F_UART_Baudrate(void);
# 55 "./UART\\UART_Code.h"
extern void F_UART_Disable(void);
# 69 "./UART\\UART_Code.h"
extern void F_UART_GetStatus(void);
# 79 "./UART\\UART_Code.h"
extern void IsUARTBusy(void);


extern void Play_SetTimeVoice_FromKey(void);





extern unsigned char R_UART_Baudrate;
extern unsigned char R_UARTRX_Status;
extern unsigned char R_UART_CNT;


extern unsigned char StatusBuff[];


extern unsigned char temp;
extern unsigned char Rx_data_test[];
extern unsigned char t;

extern void F_CheckKeyTone(void);
# 5 ".\\UART\\UART.c" 2
# 1 "./UART\\UART_Rx.h" 1



typedef enum {
 shangdianbbao_SP,
 Di000_1_SP,
 Di001_2_SP,
 Di002_4_SP,
 Di003_8_SP,
 Di004_1_SP,
 Di005_1_SP,
 Di006_1_SP,
 Di007_1_SP,
 Di008_1_SP,
 Di009_1_SP,
 Di010_1_SP,
 Di011_1_SP,
 Di012_1_SP,
 Di013_1_SP,
 Di014_1_SP,
 Di015_1_SP,
 Di016_1_SP,
 Di017_1_SP,
 Di018_1_SP,
 Di019_1_SP,

 Num000_SP,NumStart_Sp=Num000_SP,
 Num001_SP,
 Num002_SP,
 Num003_SP,
 Num004_SP,
 Num005_SP,
 Num006_SP,
 Num007_SP,
 Num008_SP,
 Num009_SP,
 Num010_SP,

 Bai_SP,
    ErLing_SP,
    Nian_SP,
    Yue_SP,
    Ri_SP,
    Dian_SP,
    Fen_SP,
    LingChen_SP,
    ShangWu_SP,
    XiaWu_SP,
    WanShang_SP,
    XianZaiShiKe_SP,
    JinTianShi_SP,
    ShiJianSheZhiWei_SP,
    RiQiSheZhiWei_SP,
    BaoShiGongNeng_SP,
    ZhengDianBaoShi_SP,
    SheZhi_SP,
    Wei_SP,
    SheZhiWei_SP,
    TingZhiXiangNao_SP,
    JinRuTanShui_SP,
    TanShuiGongNeng_SP,
    SuoYou_SP,
    NaoZhong_SP,
    DanCi_SP,AlarmCycle_SP=DanCi_SP,
    WuTian_SP,
    LiuTian_SP,
    MeiTian_SP,
    XiangNao_SP,
    YiGuanBi_SP,
    YiKaiQi_SP,
    ZhengJiShi_SP,
    DaoJiShi_SP,
    FenZhong_SP,
    FanQieJiShiFa_SP,
    ZanTing_SP,
    KaiQi_SP,
    GuanBi_SP,
    JieShu_SP,
    JiXu_SP,
    JiShi_SP,
    DaKai_SP,
    JinTian_SP,
    MingTian_SP,
    TiXing_SP,
    DangQianWenDu_SP,
    LingXia_SP,
    SheShiDu_SP,
    HuaShiDu_SP,
    BaBa_SP,FamilyStart_SP=BaBa_SP,
    MaMa_SP,
    GeGe_SP,
    DiDi_SP,
    JieJie_SP,
    MeiMei_SP,
    LaoDa_SP,
    LaoEr_SP,
    LaoSan_SP,
    LaoSi_SP,
    LaoGong_SP,
    LaoPo_SP,
    WaiGong_SP,
    WaiPo_SP,
    YeYe_SP,
    NaiNai_SP,
    De_SP,
    ShengRi_SP,
    Shi_SP,
    QingChu_SP,
    ShangYiQu_SP,
    XiaYiQu_SP,
    XianShi_SP,
    LiangYiDian_SP,
    AnYiDian_SP,
    YinLiang_SP,
    ZengDa_SP,
    JianXiao_SP,
    NaoZhongSheng_SP,
    Di_SP,
    Ji_SP,
    Shou_SP,
    YingDa1_SP,RespondStart_SP=YingDa1_SP,
    YingDa2_SP,
    YingDa3_SP,
    YingDa4_SP,
    YingDa5_SP,
    Zai_SP,
    ChiYao_SP,
    DangQianShiDu_SP,
    BaiFenZhi_SP,
    Zheng_SP,
    ZhongWu_SP,
    SheZhiChengGong_SP,
    SheZhiShiBai_SP,

    naoling1_SP,naolingStart_SP=naoling1_SP,
    naoling2_SP,
    naoling3_SP,
    naoling4_SP,
    naoling5_SP,
    naoling6_SP,
    naoling7_SP,
    didianbaojing_SP,
    chakan_SP,
    riqi_SP,
    shezhi1_SP,
    shijian_SP,
} action_sp;
# 279 "./UART\\UART_Rx.h"
extern unsigned char CLOCK_FLAG_ASR;

extern unsigned char UART_RxBuffer[];
extern unsigned char PlayList;
extern unsigned seed;
extern unsigned char g_voice_play_status;




extern void Uart_Disable(void);
extern void Check_UartData(void);
extern void SetVolumeAndPlayAlarm1(unsigned char volume);


extern void Play_AlarmMusic_Stop(void);
extern void CheckAndStartTimer(void);


void Voice_SendPlayCmd(unsigned char track);
void Voice_SendVolumeCmd(unsigned char volume);
void Voice_SendModeCmd(unsigned char mode);
void Voice_SendStopControlCmd(void);
void Voice_SendStatusQuery(void);
void Set_UartUI_And_LcdUpdateFlag(void);
void Voice_SendContinueCmd(unsigned char count, const unsigned char* tracks);
void Play_Wake_Response(void);
void PlaySingle(unsigned char track);
void PlaySequence(unsigned char count, const unsigned char* tracks);
void AnnounceDateTime(void);
# 6 ".\\UART\\UART.c" 2
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
# 7 ".\\UART\\UART.c" 2
# 1 "./Timer\\Timer.h" 1




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
# 8 ".\\UART\\UART.c" 2





unsigned char StatusBuff[9] ;
unsigned char temp;
unsigned char Rx_data_test[20];
unsigned char t;




extern unsigned char CLOCK_FLAG_ASR;

unsigned char UART_RxBuffer[16];






action_sp Function_SP;





unsigned char Spindex[32];
unsigned char SpCnt;
unsigned char PlayList;


unsigned CI_Mode;
unsigned PlayEnd;
unsigned Birthday[20][2];
unsigned seed;
unsigned char index;
unsigned char User_AsrTime;

unsigned Timer_Start;

static void F_OnVoicePlayStatus(void);
# 82 ".\\UART\\UART.c"
static void Sorting_Number(unsigned read0,unsigned number)
{
# 97 ".\\UART\\UART.c"
 if((number / 100)%10){
  Spindex[index++] = ((NumStart_Sp + ((number / 100)%10)));
  Spindex[index++] = Bai_SP;

  if((number / 10)%10){
   if(((number / 10)%10) > 1){
    Spindex[index++] = ((NumStart_Sp + ((number / 10)%10)));
   }

   Spindex[index++] = Num010_SP;

   if(number % 10){
    Spindex[index++] = NumStart_Sp + (number % 10);
   }
  }
  else{
   Spindex[index++] = Num000_SP;

   if(number % 10){
    Spindex[index++] = NumStart_Sp + (number % 10);
   }
  }
 }
 else if((number / 10)%10){
  if(((number / 10)%10) > 1){
   Spindex[index++] = ((NumStart_Sp + ((number / 10)%10)));
  }

  Spindex[index++] = Num010_SP;

  if(number % 10){
   Spindex[index++] = NumStart_Sp + (number % 10);
  }
 }
 else{
  if(number % 10){
   if(read0){
    Spindex[index++] = Num000_SP;
   }
   Spindex[index++] = NumStart_Sp + (number % 10);
  }
  if(number == 0)
   Spindex[index++] = NumStart_Sp + (number % 10);
 }
# 178 ".\\UART\\UART.c"
}

static void Sorting_Hour(unsigned * _buf,unsigned hour)
{
 if(hour > 23) return;

        if(RB_12_24_Status == 0X00){
         Sorting_Number(0,hour);
        }
        else{
  if ((hour >= 0) && (hour <= 5)) {
   Spindex[index++] = LingChen_SP;
  }
  else if ((hour >= 6) && (hour <= 11)) {
   Spindex[index++] = ShangWu_SP;
  }
  else if (hour == 12) {
   Spindex[index++] = ZhongWu_SP;
  }
  else if ((hour >= 13) && (hour <= 17)) {
   Spindex[index++] = XiaWu_SP;
  }
  else if ((hour >= 18) && (hour <= 23)) {
   Spindex[index++] = WanShang_SP;
  }
  if(hour>12){
   hour = hour - 12;
  }
  if(hour == 0)hour = 12;
  Sorting_Number(0,hour);
 }

}
void F_Setzhishibai(void){
  Spindex[index++] = SheZhiShiBai_SP;
  SpCnt = index;
  PlayList = 1;
  Voice_SendPlayCmd(Spindex[SpCnt-1]);
}
static int Check_Time_ZD(unsigned spindex,unsigned timevalue)
{
 if(timevalue == 0)
 {
  Spindex[spindex-3] = Dian_SP;
  Spindex[spindex-2] = Zheng_SP;

   (index)--;
 }
 return 0;
}



static void F_Set_Time(void)
{
 int isPm,hour;

 if((UART_RxBuffer[4] < 24) && (UART_RxBuffer[5] < 60))
 {


  Sorting_Hour(&Spindex[index],UART_RxBuffer[4]);
  Spindex[index++] = Dian_SP;
  Sorting_Number(1,UART_RxBuffer[5]);
  Spindex[index++] = Fen_SP;
  Check_Time_ZD(index,UART_RxBuffer[5]);
  Spindex[index++] = SheZhiChengGong_SP;
  SpCnt = index;
  PlayList = 1;
  Voice_SendContinueCmd(SpCnt,Spindex);
  hour = UART_RxBuffer[4];
# 268 ".\\UART\\UART.c"
  R_DateHour = UART_RxBuffer[4];
  R_LCDHourBuff = UART_RxBuffer[4];
  R_DateMinute = UART_RxBuffer[5];
  R_LCDMinuBuff = UART_RxBuffer[5];
  R_DateSecond = 0;
  R_LCDSecBuff = 0;


     Set_UartUI_And_LcdUpdateFlag();
# 288 ".\\UART\\UART.c"
 }
 else
 {
  F_Setzhishibai();




 }
}





static void F_Set_Date(void)
{
 int year,month,day;

 year = UART_RxBuffer[5];
 month = UART_RxBuffer[6];
 day = UART_RxBuffer[7];

 if(day<=31){

  Spindex[index++] = Num002_SP;
  Spindex[index++] = Num000_SP;
  Spindex[index++] = NumStart_Sp + (UART_RxBuffer[5] / 10);
  Spindex[index++] = NumStart_Sp + (UART_RxBuffer[5] % 10);
  Spindex[index++] = Nian_SP;
  Sorting_Number(0,UART_RxBuffer[6]);
  Spindex[index++] = Yue_SP;
  Sorting_Number(0,UART_RxBuffer[7]);
  Spindex[index++] = Ri_SP;
  Spindex[index++] = SheZhiChengGong_SP;
  SpCnt = index;
  PlayList = 1;
  Voice_SendContinueCmd(SpCnt,Spindex);
  R_Year[0] = UART_RxBuffer[5];
  R_Year_temp[0]=R_Year[0];
  R_Month = UART_RxBuffer[6];
  R_Month_temp = R_Month;
  R_Day = UART_RxBuffer[7];
  R_Day_temp = R_Day;
  F_JudegLeapYear();
  F_JudgeWeek();


  Set_UartUI_And_LcdUpdateFlag();


 }
 else{
  F_Setzhishibai();




 }

}


void Play_SetTimeVoice_FromKey(void)
{
 index = 0;

 Spindex[index++] = Num002_SP;
 Spindex[index++] = Num000_SP;

 Spindex[index++] = NumStart_Sp + (R_Year[0] / 10);
 Spindex[index++] = NumStart_Sp + (R_Year[0] % 10);
 Spindex[index++] = Nian_SP;


 Sorting_Number(0, R_Month);
 Spindex[index++] = Yue_SP;
 Sorting_Number(0, R_Day);
 Spindex[index++] = Ri_SP;


 Sorting_Hour(&Spindex[index], R_DateHour);
 Spindex[index++] = Dian_SP;
 Sorting_Number(1, R_DateMinute);
 Check_Time_ZD(index, R_DateMinute);

 Spindex[index++] = SheZhiChengGong_SP;

 SpCnt = index;
 PlayList = 1;
 Voice_SendContinueCmd(SpCnt, Spindex);
}





static void F_Set_Alarm(void)
{
 unsigned char alarm_num = UART_RxBuffer[4];

    if (alarm_num < 1 || alarm_num > 3) {
        Spindex[index++] = SheZhiShiBai_SP;
        SpCnt = index;
        PlayList = 1;
        Voice_SendPlayCmd(Spindex[SpCnt-1]);
        return;
     }
 if((UART_RxBuffer[5] < 24) && (UART_RxBuffer[6] < 60))
 {
  unsigned char alarm_index = alarm_num - 1;

        R_AlarmHour[alarm_index] = UART_RxBuffer[5];
        R_AlarmMinute[alarm_index] = UART_RxBuffer[6];

        R_CurrentGroup = alarm_index;
        R_Uart_UI = 10;

    Set_UartUI_And_LcdUpdateFlag();

     Spindex[index++] = SheZhi_SP;
  Spindex[index++] = NaoZhong_SP;
  Spindex[index++] = NumStart_Sp + UART_RxBuffer[4];
  Spindex[index++] = Wei_SP;
  Sorting_Hour(&Spindex[index],UART_RxBuffer[5]);
  Spindex[index++] = Dian_SP;
  Sorting_Number(1,UART_RxBuffer[6]);
  Spindex[index++] = Fen_SP;
  Check_Time_ZD(index,UART_RxBuffer[6]);


  Spindex[index++] = SheZhiChengGong_SP;
  SpCnt = index;
  PlayList = 1;
  Voice_SendContinueCmd(SpCnt,Spindex);
# 431 ".\\UART\\UART.c"
 }
 else{
  F_Setzhishibai();




 }

}
# 450 ".\\UART\\UART.c"
static void F_CountDown_Start(void)
{
 unsigned num;

 num = UART_RxBuffer[4];
 if(num > 60)
 {
  F_Setzhishibai();
  return;
 }
 Spindex[index++] = KaiQi_SP;
 Spindex[index++] = JiShi_SP;




 SpCnt = index;
 PlayList = 1;

 R_TimerFlag &= ~(0x01);
 R_TimerFlag &= ~(0x10 | 0x20);
 R_TimerFlag |= 0x02;
 Voice_SendContinueCmd(SpCnt,Spindex);

 if(num){


  R_TimerMinute = num ;
  R_TimerSecond = 0;





 }
   Set_UartUI_And_LcdUpdateFlag();




}




static void F_CountDown_Pause(void)
{


 if (R_TimerFlag & (0x01 | 0x02)) {
  if (R_TimerFlag & 0x01) {

   R_TimerFlag &= ~0x01;
   R_TimerFlag |= 0x10;
  } else {
   R_TimerFlag &= ~0x02;
   R_TimerFlag |= 0x20;
  }
   Spindex[index++] = ZanTing_SP;
   Spindex[index++] = JiShi_SP;
  SpCnt = index;
  PlayList = 1;
  Voice_SendContinueCmd(SpCnt, Spindex);
  Set_UartUI_And_LcdUpdateFlag();
  return;
 }
}


static void F_CountDown_Continue(void)
{


 if (R_TimerFlag & 0x10) {
  R_TimerFlag &= ~0x10;
  R_TimerFlag |= 0x01;
  Spindex[index++] = JiXu_SP;
  Spindex[index++] = JiShi_SP;
  SpCnt = index;
  PlayList = 1;
  Voice_SendContinueCmd(SpCnt, Spindex);
  Set_UartUI_And_LcdUpdateFlag();
  return;
 }


 if (R_TimerFlag & 0x20) {
  R_TimerFlag &= ~0x20;
  R_TimerFlag |= 0x02;
  Spindex[index++] = JiXu_SP;
  Spindex[index++] = JiShi_SP;
  SpCnt = index;
  PlayList = 1;
  Voice_SendContinueCmd(SpCnt, Spindex);
  Set_UartUI_And_LcdUpdateFlag();
 }
}


static void F_CountDown_End(void)
{

 R_TimerFlag &= ~(0x02 | 0x01 | 0x10 |0x20 | 0x04);
 Timer_Start = 0;
 R_TimerMinute = 0;
 R_TimerSecond = 0;
 R_POINT = 0;

 Spindex[index++] = JieShu_SP;
 Spindex[index++] = JiShi_SP;
 SpCnt = index;
 PlayList = 1;
 Voice_SendContinueCmd(SpCnt, Spindex);
 Set_UartUI_And_LcdUpdateFlag();
}
# 633 ".\\UART\\UART.c"
static void F_Alarm_On_Off(void)
{
    unsigned char selector = (UART_RxBuffer[4] >> 4) & 0x0F;
    unsigned char state = UART_RxBuffer[4] & 0x0F;


    if (selector == 0x0F) {
        Spindex[index++] = SuoYou_SP;
        Spindex[index++] = NaoZhong_SP;

        if (state & 0x01) {
            Spindex[index++] = DaKai_SP;
            R_AlarmOnOff = 0x07;
        } else {
            Spindex[index++] = GuanBi_SP;
            R_AlarmOnOff = 0x00;
        }
    }

    else if (selector >= 1 && selector <= 3) {
        Spindex[index++] = NaoZhong_SP;
        Spindex[index++] = NumStart_Sp + selector;
        R_CurrentGroup = selector - 1;
        if (state & 0x01) {
            Spindex[index++] = DaKai_SP;
            R_AlarmOnOff |= (1 << (selector - 1));
        } else {
            Spindex[index++] = GuanBi_SP;
            R_AlarmOnOff &= ~(1 << (selector - 1));
        }
    }

    else {
   F_Setzhishibai();




        return;
    }
        SpCnt = index;
        PlayList = 1;
     Voice_SendContinueCmd(SpCnt, Spindex);



   Set_UartUI_And_LcdUpdateFlag();
}




static void F_Alarm_Loop(void)
{
 unsigned char alarm_idx;
 unsigned char mode_idx;
 unsigned char set_val;
 unsigned char i;




 alarm_idx = (UART_RxBuffer[4] & 0xF0) >> 4;
 mode_idx = UART_RxBuffer[4] & 0x0F;



 if (mode_idx >= 1 && mode_idx <= 3) {
  set_val = mode_idx - 1;
 } else {

  set_val = 2;
 }

 if((UART_RxBuffer[4] & 0xF0) == 0xF0)
 {
  Spindex[index++] = SuoYou_SP;
  Spindex[index++] = NaoZhong_SP;
  Spindex[index++] = AlarmCycle_SP + mode_idx;
   Spindex[index++] = XiangNao_SP;

  for(i=0; i<3; i++) {
   R_DispAlmDay[i] = set_val;
  }
  R_CurrentGroup = 0;
 }
 else
 {
  if(alarm_idx >= 1 && alarm_idx <= 3) {
   Spindex[index++] = NaoZhong_SP;
   Spindex[index++] = NumStart_Sp + alarm_idx;
   Spindex[index++] = AlarmCycle_SP + mode_idx;
   Spindex[index++] = XiangNao_SP;

   R_DispAlmDay[alarm_idx - 1] = set_val;
   R_CurrentGroup = alarm_idx - 1;
  } else {

   F_Setzhishibai();
   return;
  }
 }

 SpCnt = index;
 PlayList = 1;
 Voice_SendContinueCmd(SpCnt,Spindex);


 Set_UartUI_And_LcdUpdateFlag();
}
# 803 ".\\UART\\UART.c"
static void F_Display_On_Off(void)
{

 if(UART_RxBuffer[4] == 1){
  Spindex[index++] = YiKaiQi_SP;



        if(R_BacklightLevel == 0) R_BacklightLevel = 3;
 }

 else if(UART_RxBuffer[4] == 2){
  Spindex[index++] = LiangYiDian_SP;
  if(R_BacklightLevel < 3)
            R_BacklightLevel++;

 }

 else if(UART_RxBuffer[4] == 3){
  Spindex[index++] = AnYiDian_SP;
  if(R_BacklightLevel > 1)
            R_BacklightLevel--;

 }







 SpCnt = index;
 PlayList = 1;
     Voice_SendContinueCmd(SpCnt, Spindex);
   Set_UartUI_And_LcdUpdateFlag();
}
# 973 ".\\UART\\UART.c"
static void F_CountUp_Start(void)
{

 if(UART_RxBuffer[4]){


  Spindex[index++] = ZhengJiShi_SP;
  if (R_TimerFlag & 0x01) {
   Spindex[index++] = YiKaiQi_SP;

   }
  else {

  Spindex[index++] = KaiQi_SP;
  R_TimerFlag &= ~(0x02);
  R_TimerFlag &= ~0x10;
  R_TimerFlag |= 0x01;
  R_TimerMinute = 0;
  R_TimerSecond = 0;
  R_POINT = 32;
  }
 }
# 1006 ".\\UART\\UART.c"
 SpCnt = index;
 PlayList = 1;
 Voice_SendContinueCmd(SpCnt,Spindex);
    Set_UartUI_And_LcdUpdateFlag();
}
# 1159 ".\\UART\\UART.c"
static void F_WakeUp_Word(void)
{

 Spindex[index++] = YingDa1_SP;
 SpCnt = index;
 PlayList = 1;

 CLOCK_FLAG_ASR = 1;
 Voice_SendPlayCmd(Spindex[SpCnt-1]);

}
# 1229 ".\\UART\\UART.c"
void (* const FunP[12])() = {



 F_Alarm_On_Off,
 F_Set_Time,
 F_Set_Date,
 F_Set_Alarm,
 F_Display_On_Off,
 F_CountDown_Start,
    F_CountDown_Pause,
    F_CountDown_Continue,
    F_CountDown_End,


 F_CountUp_Start,
 F_WakeUp_Word,
 F_Alarm_Loop,
};
const unsigned FunArray[12] = {



 0x8A,
 0x81,
 0x82,
 0x83,
 0x8F,
 0x84,
    0x85,
    0x86,
    0x87,


 0x76,
 0x7E,
 0x8B,
};


void Check_UartData(void)
{
 unsigned i,j=0;
 if(R_UART_CNT >= 9)
 {

  if ((UART_RxBuffer[0] == 0x5A)
   && (UART_RxBuffer[1] == 0xA5)
   && (UART_RxBuffer[2] == 0x00)
   && (UART_RxBuffer[3] == 0xA0)
   && (UART_RxBuffer[8] == 0xAA))
  {
   g_voice_play_status = UART_RxBuffer[4];
   F_OnVoicePlayStatus();
   R_UART_CNT = 0;
   return;
  }


  if(UART_RxBuffer[0]==0x5A
  && UART_RxBuffer[1]==0xA5
  && UART_RxBuffer[8]==0xAA||(R_OtherFlag & 0x02) )
  {
   if(CLOCK_FLAG_ASR == 1){
    if(UART_RxBuffer[2] == 0)
    {
     for(i=0;i<12;i++)
     {
      if(UART_RxBuffer[3] == FunArray[i])
      {
       j = 1;
       index = 0;
       FunP[i]();
       User_AsrTime = 0x0A;

       break;
      }
     }
     if(j){

     }
     else{

     }
    }
    else{

    }
   }
   else{
    if((UART_RxBuffer[2] == 0))
    {

     {
      if(UART_RxBuffer[3] == 0x7E)
      {
       index = 0;
       F_WakeUp_Word();
       User_AsrTime = 0x0A;
      }
      else
      {

      }
     }
    }
    else{

    }
   }
  }
  else{
  }
     R_UART_CNT = 0;
   }
 }





void UART_SendByte(unsigned char data)
{
if (data != 0xFF) {
    IsUARTBusy();
    *(volatile unsigned char *) (0x3000 +0x0B) = 0x00;
    *(volatile unsigned char *) (0x3150 +0x00) = data;
    }
}



unsigned char g_current_volume = 0x14;
unsigned char g_play_mode = 0x01;

unsigned char g_voice_play_status = 0x00;


static void Send_Voice_Cmd(unsigned char cmd, unsigned char param)
{
    UART_SendByte(0xA5);
    UART_SendByte(0x5A);
    UART_SendByte(cmd);
    UART_SendByte(param);
    UART_SendByte(0x55);
}

void Voice_SendPlayCmd(unsigned char track)
{
    Send_Voice_Cmd(0x10, track);
 g_voice_play_status = 0x01;
   PlayList = 0;
}


void Voice_SendVolumeCmd(unsigned char volume)
{

    if (volume > 0x1F) {
        volume = 0x14;
    }

    Send_Voice_Cmd(0x12, volume);
    g_current_volume = volume;
}


void Voice_SendModeCmd(unsigned char mode)
{
   if (mode != 0x01 && mode != 0x02) {
       mode = 0x01;
   }

   Send_Voice_Cmd(0x13, mode);
   g_play_mode = mode;
}


void Voice_SendStopControlCmd(void)
{
 Voice_SendModeCmd(0x01);
    Send_Voice_Cmd(0x20, 0x01);
 g_voice_play_status = 0x00;

}
# 1431 ".\\UART\\UART.c"
void Voice_SendStatusQuery(void)
{

 Send_Voice_Cmd(0xA0, 0x00);
}


void Voice_SendContinueCmd(unsigned char count, const unsigned char* tracks)
{
    unsigned char i;

    if (count == 0 || tracks == 0) {
        return;
    }


    UART_SendByte(0xA5);
    UART_SendByte(0x5A);
    UART_SendByte(0x11);
    UART_SendByte(count);


    for ( i = 0; i < count; i++) {
        UART_SendByte(tracks[i]);
    }


    UART_SendByte(0x55);
 g_voice_play_status = 0x01;
     PlayList = 0;

}



void CheckAndStartTimer(void)
{



}


static void F_OnVoicePlayStatus(void)
{

    if (UART_RxBuffer[4] == 0)
    {


    }
}
# 1491 ".\\UART\\UART.c"
void Set_UartUI_And_LcdUpdateFlag(void)
{


      R_Uart_OpenTime = 60;

    RB_Lcd_Updata_Flag |= 0x40;
}






void Play_Wake_Response(void)
{
 Voice_SendPlayCmd(YingDa1_SP);
}


void PlaySingle(unsigned char track)
{
 Voice_SendPlayCmd(track);
}


void PlaySequence(unsigned char count, const unsigned char* tracks)
{
 if (count == 0 || tracks == 0) return;
 Voice_SendContinueCmd(count, tracks);
}


void AnnounceDateTime(void)
{
 unsigned char seq[8];
 unsigned char idx = 0;


 seq[idx++] = XianZaiShiKe_SP;


 if (R_LCDHourBuff < 100) {
  if (R_LCDHourBuff >= 10) {
   seq[idx++] = NumStart_Sp + (R_LCDHourBuff / 10);
  }
  seq[idx++] = NumStart_Sp + (R_LCDHourBuff % 10);
 }

 seq[idx++] = Dian_SP;

 if (R_LCDMinuBuff < 100) {
  if (R_LCDMinuBuff >= 10) {
   seq[idx++] = NumStart_Sp + (R_LCDMinuBuff / 10);
  }
  seq[idx++] = NumStart_Sp + (R_LCDMinuBuff % 10);
 }

 seq[idx++] = Fen_SP;

 PlaySequence(idx, seq);
}







void SetVolumeAndPlayAlarm1(unsigned char level)
{
 if (SetVolumeAndPlayAlarm1_flag)
 {
 unsigned char volume = 0x14;
 SetVolumeAndPlayAlarm1_flag = 0;
 if(level == 0) volume = 0x00;
 else if(level == 2) volume = 0x1E;

 Voice_SendVolumeCmd(volume);
  Voice_SendModeCmd(0x01);

 }
}




void F_CheckKeyTone(void)
{
 if(R_KeyFlag & 0x04)
 {
  R_KeyFlag &= ~0x04;
  if(!(R_OtherFlag & 0x08))
  {
   Voice_SendPlayCmd(Di000_1_SP);
  }
 }
}




void Play_AlarmMusic_Stop(void)
 {
  int currentAlarmSong = Di001_2_SP;
    if ((R_OtherFlag & 0x10) && (R_OtherFlag & 0x40))
 {
  if ((R_VoiceFlag & 0x01) == 0)
  {
   return;
  }

  Voice_SendModeCmd(0x02);
  Voice_SendContinueCmd(1, &currentAlarmSong);
  R_OtherFlag &= ~(0x80 +0x10);
 }

 else if ((R_OtherFlag & 0x80) && (R_OtherFlag & 0x40))
 {
  int currentTimerSong = Di001_2_SP;
  if ((R_VoiceFlag & 0x01) == 0)
  {
   return;
  }

  Voice_SendModeCmd(0x02);
  Voice_SendContinueCmd(1, &currentTimerSong);
  R_OtherFlag &= ~(0x80 +0x10);
 }
# 1628 ".\\UART\\UART.c"
 else if (R_OtherFlag & 0x08)
 {
  R_OtherFlag &= ~(0x08 +0x40);

  Voice_SendStopControlCmd();
 }
 }
