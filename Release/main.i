# 1 ".\\main.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 ".\\main.c"
# 11 ".\\main.c"
# 1 ".\\/GPL815P.h" 1
# 57 ".\\/GPL815P.h"
# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 1





# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h" 1
# 34 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h"
unsigned char __bgetc(unsigned char* src, unsigned char bID);
# 7 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 2
# 58 ".\\/GPL815P.h" 2
# 12 ".\\main.c" 2
# 1 ".\\/System.h" 1
# 11 ".\\/System.h"
extern void F_InitPort(void);
# 20 ".\\/System.h"
extern void F_SYS_ClearDPRAM(void);
extern void F_SYS_FillDPRAM();







extern void F_SYS_ClearPage0(void);







extern void F_SYS_ClearNPage(void);







extern void F_SYS_PowerOnCPUInitinal(void);







extern void F_InitIRQ(void);







extern void F_GreenMode(void);







extern void F_StandbyMode(void);







extern void F_Afterwakeup_Proc(void);
extern void F_LVD_Init(void);
# 13 ".\\main.c" 2
# 1 ".\\/calendar\\calendar.h" 1
# 11 ".\\/calendar\\calendar.h"
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
# 14 ".\\main.c" 2
# 1 ".\\/lcd\\lcd_user.h" 1
# 13 ".\\/lcd\\lcd_user.h"
extern void F_Flash_Dot(unsigned char flash_index);
# 22 ".\\/lcd\\lcd_user.h"
extern void F_DispFlag(unsigned char lcd_index);
# 31 ".\\/lcd\\lcd_user.h"
extern void F_NotDispFlag(unsigned char lcd_index);
extern void F_Fill_ALL_LCDDPRAM(void);
extern void F_SeetupDisplay_Proc(void);
# 43 ".\\/lcd\\lcd_user.h"
extern void F_Disp_Digital(unsigned char A_disp,unsigned char Y_index);
# 53 ".\\/lcd\\lcd_user.h"
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
# 80 ".\\/lcd\\lcd_user.h"
extern unsigned char RB_Setup_Status;

extern unsigned char R_flash_Temp;

extern unsigned char R_POINT;

extern unsigned char R_Uart_UI ;


extern unsigned char R_Electricity;
# 15 ".\\main.c" 2
# 1 ".\\/UART\\UART_Code.h" 1
# 21 ".\\/UART\\UART_Code.h"
extern void F_UART_Initial(void);
extern void Countdown(void);
# 45 ".\\/UART\\UART_Code.h"
extern void F_UART_Baudrate(void);
# 55 ".\\/UART\\UART_Code.h"
extern void F_UART_Disable(void);
# 69 ".\\/UART\\UART_Code.h"
extern void F_UART_GetStatus(void);
# 79 ".\\/UART\\UART_Code.h"
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
# 16 ".\\main.c" 2
# 1 ".\\/KEYSCAN\\key_user.h" 1
# 13 ".\\/KEYSCAN\\key_user.h"
extern void F_InitialKeyBorad(void);
# 24 ".\\/KEYSCAN\\key_user.h"
extern void F_KeyScan(void);
extern void F_CodeSwitchScan(void);
# 35 ".\\/KEYSCAN\\key_user.h"
extern void F_DC_Det(void);
extern void F_Charge(void);
# 45 ".\\/KEYSCAN\\key_user.h"
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
# 104 ".\\/KEYSCAN\\key_user.h"
extern unsigned char R_KeepAwakeTimer;

extern unsigned char R_Uart_OpenTime;
extern unsigned char R_LVDStatus;





extern unsigned char R_VoiceFlag;


extern unsigned char R_DelayOpen;
extern void Voice_PowerOn(void);
extern void F_SystemPowerOff(void);
extern unsigned char R_VoiceReq;
extern void Voice_PowerOn_Noxiaonao(void);
# 17 ".\\main.c" 2
# 1 ".\\/Timer\\Timer.h" 1




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
# 18 ".\\main.c" 2
# 1 ".\\/UART\\UART_Rx.h" 1



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
# 279 ".\\/UART\\UART_Rx.h"
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
# 19 ".\\main.c" 2
# 1 ".\\/ADC\\ADC.h" 1
# 35 ".\\/ADC\\ADC.h"
extern void ADC_Init(void);






extern void F_DC_Det(void);
# 20 ".\\main.c" 2
# 28 ".\\main.c"
unsigned char R_KeepAwakeTimer = 0;

unsigned char RB_128hz_counter = 0x00;
unsigned char R_DateMiniSecond = 0;

unsigned char NsLi_Year[2] = {0,0};
unsigned char NsLi_Month = 0;
unsigned char NsLi_Day = 0;

unsigned char RB_128HzTo32Hz_count = 0;
unsigned char RB_RFC_30S_count = 0;
unsigned char RB_ADC_50S_count = 0;

static unsigned char g_low_power_flow = 0x00;

static unsigned int g_low_power_query_ticks = 0;
static unsigned char g_low_power_last_tick = 0;
static unsigned char g_recheck_battery_after_power_on = 0;

extern unsigned char R_Second_Temp;

static unsigned char F_IsSystemPowerOff(void)
{
 return (R_KeyFlag & 0x02) != 0;
}

static void F_ResetLowPowerFlow(void)
{

 g_low_power_flow = 0x00;
 g_low_power_query_ticks = 0;
 g_low_power_last_tick = RB_128hz_counter;
}

static void F_ProcessLowPowerShutdown(void)
{
 unsigned char elapsed_ticks;
 unsigned char is_low_power;

 if (F_IsSystemPowerOff())
 {
  F_ResetLowPowerFlow();
  g_voice_play_status = 0x00;
  return;
 }


 if (R_Charge & 0x02)
 {
  F_ResetLowPowerFlow();
  return;
 }

 is_low_power = (R_Charge & 0x01) != 0;







 if (!is_low_power && (g_low_power_flow == 0x00))
 {
  return;
 }


 if (g_low_power_flow == 0x00)
 {
  g_low_power_flow = 0x01;
  g_low_power_query_ticks = 0;
  g_low_power_last_tick = RB_128hz_counter;
  R_VoiceReq = 0;
  R_VoiceFlag &= ~0x02;
  g_voice_play_status = 0x00;
 }

 switch (g_low_power_flow)
 {
 case 0x01:

  if ((R_VoiceFlag & 0x01) == 0)
  {
   if (R_DelayOpen == 0)
   {
    Voice_PowerOn_Noxiaonao();
   }
   return;
  }

  PlaySingle(didianbaojing_SP);
  g_voice_play_status = 0x01;
  g_low_power_flow = 0x02;
  g_low_power_query_ticks = 0;
  g_low_power_last_tick = RB_128hz_counter;
  return;

 case 0x02:

  elapsed_ticks = RB_128hz_counter - g_low_power_last_tick;
  if (elapsed_ticks != 0)
  {
   g_low_power_last_tick = RB_128hz_counter;
   g_low_power_query_ticks += elapsed_ticks;
  }

  if (g_low_power_query_ticks >= 640)
  {
   g_low_power_flow = 0x03;
   F_SystemPowerOff();
  }
  return;

 case 0x03:
  return;

 default:
  F_ResetLowPowerFlow();
  return;
 }
}

void F_InitDateTime(void)
{
   R_Year[0] = 0x18;
   R_Year_temp[0] = 0x18;
   R_Year[1] = 0x14;
   R_Year_temp[1] = 0x14;
   R_Month = 0x0a;
   R_Day = 0x14;
   R_DateSecond = 0;
   R_Second_Temp = 0;
   R_DateHour = 0x00;
   R_DateMinute = 0x00;
   R_AlarmHour[0] = 0x00;
   R_AlarmHour[1] = 0x00;
   R_AlarmHour[2] = 0x00;
   R_AlarmMinute[0] = 0x00;
   R_AlarmMinute[1] = 0x00;
   R_AlarmMinute[2] = 0x00;

   SetVolumeAndPlayAlarm1_flag = 0x01;
   R_CurrentVolume = 0x01;
   R_BacklightLevel = 0x03;



   R_LVDStatus = 0x01;
   RB_Lcd_Updata_Flag = 0x40;
   F_JudegLeapYear();
   F_JudgeWeek();
}

void F_Cheak_VDC(void)
{

    if (*(volatile unsigned char *) (0x3080 +0x0A) & 0x20)
    {
        return;
    }

    if ((R_OtherFlag & (0x40 | 0x02 | 0x20)) == 0&& (R_DelayOpen == 0))
    {
        *(volatile unsigned char *) (0x3080 +0x0A) |= 0x20;
        R_VoiceFlag = 0;
        CLOCK_FLAG_ASR = 0;
    }
}

void F_SecondRTC(void)
{
 if (R_Second_Temp>1)
 {
  F_DC_Det();

  R_Second_Temp = 0;
  R_DateSecond++;
        F_24HourClock();
        F_TimerUpdate();

  CheckAndStartTimer();
  Disable_Alarm();
  if(R_Uart_UI != 0)
  {
  R_Uart_UI--;
  }
   if (R_Uart_UI == 0)
   {
   RB_Lcd_Updata_Flag |= 0x40;
    }

  if(R_Uart_OpenTime != 0)
  {
  R_Uart_OpenTime--;
   if (R_Uart_OpenTime == 0)
   {
  R_OtherFlag&= ~0x02;
    }
  }
  if(R_SetBack != 0)
  {
  R_SetBack--;
     if (R_SetBack == 0)
   {
    R_TimeFlashSet = 0;
    R_AlmTimeFlashSet = 0;
    R_TimerFlashSet = 0;
    RB_Lcd_Updata_Flag |= 0x40;






   }
  }
 }
}
int main(void)
{
 F_SYS_ClearPage0();
 F_SYS_ClearNPage();

 F_InitDateTime();
 F_SYS_PowerOnCPUInitinal();
 F_LVD_Init();
 F_LCD_Initinal();
 F_InitPort();

    ADC_Init();
    PWM_Backlight_Init();

 *(volatile unsigned char *) (0x3080 +0x0A) &= ~0x20;
 R_BacklightLevel = 3;
 PWM_SetBrightness(255);
 R_CurrentBrightness = 255;



 F_InitIRQ();


 F_SYS_FillDPRAM();
 *(volatile unsigned char *) (0x3000 +0x0B) = 0;

 __asm SEI ‡ __endasm;


 F_UART_Initial();
 *(volatile unsigned char *) (0x3150 +0x02) = 0b00001000|0b00010000|0b10000000;

 temp = *(volatile unsigned char *) (0x3150 +0x00);

 *(volatile unsigned char *) (0x3150 +0x03) = 0b00000000|0b01100000;


 __asm CLI ‡ __endasm;

  while(R_Second_Temp < 4)
    {
       *(volatile unsigned char *) (0x3000 +0x0B) = 0;
        __asm NOP ‡ __endasm;
    }
 F_SYS_ClearDPRAM();

 while(1)
 {
  *(volatile unsigned char *) (0x3000 +0x0B) = 0;

     F_KeyScan();
  if (F_IsSystemPowerOff())
  {

   g_recheck_battery_after_power_on = 1;
   F_ResetLowPowerFlow();
   g_voice_play_status = 0x00;

   F_SecondRTC();
   F_GreenMode();
   F_Afterwakeup_Proc();
   __asm NOP ‡ __endasm;
   continue;
  }

  if (g_recheck_battery_after_power_on)
  {

   g_recheck_battery_after_power_on = 0;
   R_Charge &= ~0x01;
   F_ResetLowPowerFlow();
   F_DC_Det();
  }

     SetVolumeAndPlayAlarm1(R_CurrentVolume);
  F_CheckKeyTone();
        F_Backlight_Process();
        F_SecondRTC();
  Play_AlarmMusic_Stop();
    F_Calc12Icon();

    F_Charge();

       F_LCDDisplay();
       Check_UartData();
  F_ProcessLowPowerShutdown();
  F_Cheak_VDC();


  if ((g_low_power_flow == 0x00) && (R_VoiceFlag & 0x02) && (R_VoiceFlag & 0x01))
  {

   R_VoiceFlag &= ~0x02;
   Play_Wake_Response();
  }


  if ((g_low_power_flow == 0x00) && (R_VoiceReq != 0) && (R_VoiceFlag & 0x01))
  {
   unsigned char req = R_VoiceReq;
   R_VoiceReq = 0;

   if (req & 0x10) PlaySingle(Di000_1_SP);
   if (req & 0x01) {
    unsigned char seq1[2] = {NaoZhong_SP, chakan_SP};
   PlaySequence(2, seq1);}
   if (req & 0x02) {
    unsigned char seq1[2] = {NaoZhong_SP, shezhi1_SP};
    PlaySequence(2, seq1);
   }
   if (req & 0x04) {
    unsigned char seq2[2] = {riqi_SP,shezhi1_SP};
    PlaySequence(2, seq2);
   }
   if (req & 0x08) {

    if (R_TimeFlashSet != 0) {
     unsigned char seq3[2] = {shijian_SP, shezhi1_SP};
     PlaySequence(2, seq3);
    } else {
     Play_SetTimeVoice_FromKey();
    }
   }
   if (req & 0x20) {
    unsigned char seq1[2] = {KaiQi_SP, JiShi_SP};
    PlaySequence(2, seq1); }
   if (req & 0x40) {
    unsigned char seq1[2] = {ZanTing_SP, JiShi_SP};
    PlaySequence(2, seq1); }
   if (req & 0x80) {
    unsigned char seq1[2] = {JiXu_SP, JiShi_SP};
    PlaySequence(2, seq1); }
  }
# 392 ".\\main.c"
  __asm NOP ‡ __endasm;
 }
 return 0;
}
