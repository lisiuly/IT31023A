# 1 ".\\Int_Vec.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 ".\\Int_Vec.c"
# 11 ".\\Int_Vec.c"
# 1 ".\\/GPL815P.h" 1
# 57 ".\\/GPL815P.h"
# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 1





# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h" 1
# 34 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h"
unsigned char __bgetc(unsigned char* src, unsigned char bID);
# 7 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 2
# 58 ".\\/GPL815P.h" 2
# 12 ".\\Int_Vec.c" 2
# 1 ".\\/Variable.h" 1


extern unsigned char RB_128hz_counter;


extern unsigned char R_Second_Temp;

extern unsigned char RB_128HzTo32Hz_count;
# 13 ".\\Int_Vec.c" 2
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
# 14 ".\\Int_Vec.c" 2
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
# 15 ".\\Int_Vec.c" 2
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
# 16 ".\\Int_Vec.c" 2
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
# 17 ".\\Int_Vec.c" 2
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
# 18 ".\\Int_Vec.c" 2






static unsigned char g_uart_rx_timeout_ticks = 0;

void V_IRQ_EXT1(void) __interrupt (0);
void V_IRQ_EXT2(void) __interrupt (1);
void V_IRQ_ADC(void) __interrupt (2);
void V_IRQ_TM0(void) __interrupt (3);
void V_IRQ_TM1(void) __interrupt (4);
void V_IRQ_SWT(void) __interrupt (5);
void V_IRQ_TBH(void) __interrupt (6);
void V_IRQ_TBL(void) __interrupt (7);
void V_IRQ_FP(void) __interrupt (8);
void V_IRQ_KEY(void) __interrupt (9);
void V_IRQ_SPI(void) __interrupt (10);
void V_IRQ_RFC_TM0(void) __interrupt (11);
void V_IRQ_RFC_TM1(void) __interrupt (12);
void V_IRQ_UART(void) __interrupt (13);
void V_IRQ_PWMTM(void) __interrupt (14);
void V_IRQ_I2C(void) __interrupt (15);
void V_IRQ_LVD(void) __interrupt (16);
void V_IRQ_Capture(void) __interrupt (17);


#pragma save
#pragma nooverlay
void V_NMI(void) __interrupt;

void V_IRQ_EXT1(void) __interrupt
{

}
void V_IRQ_EXT2(void) __interrupt
{

}
void V_IRQ_ADC(void) __interrupt
{

}
void V_IRQ_TM0(void) __interrupt
{


}
void V_IRQ_TM1(void) __interrupt
{

}
void V_IRQ_SWT(void) __interrupt
{

}
void V_IRQ_TBH(void) __interrupt
{
 *(volatile unsigned char *) (0x3110 +0x03) = 0b00001000;
 *(volatile unsigned char *) (0x30C0 +0x1B) = 0;
 RB_128hz_counter++;
    R_DebounceCnt = (R_DebounceCnt > 0) ? (R_DebounceCnt - 1) : 0;
    R_LongKeyTime = (R_LongKeyTime > 0) ? (R_LongKeyTime - 1) : 0;
    R_CodeDebounce = (R_CodeDebounce > 0) ? (R_CodeDebounce - 1) : 0;
 if(R_DelayOpen > 0)
 {
 R_DelayOpen--;
    if (R_DelayOpen == 0)
  {
   R_Uart_OpenTime = 60;
   R_OtherFlag |= 0x02;
   R_VoiceFlag |= 0x01;
       CLOCK_FLAG_ASR = 1;
   }
  }
# 103 ".\\Int_Vec.c"
 if (R_KeepAwakeTimer > 0)
 {
  R_KeepAwakeTimer--;
 }

 if ((R_UART_CNT > 0) && (R_UART_CNT < 9))
 {

  if (g_uart_rx_timeout_ticks > 0)
  {
   g_uart_rx_timeout_ticks--;
   if (g_uart_rx_timeout_ticks == 0)
   {
    R_UART_CNT = 0;
   }
  }
 }
 else
 {
  g_uart_rx_timeout_ticks = 0;
 }

 RB_128HzTo32Hz_count++;
 if (RB_128HzTo32Hz_count>3)
 {
  RB_128HzTo32Hz_count = 0;
  *(volatile unsigned char *) (0x30C0 +0x0B) = 0b01000000;
  *(volatile unsigned char *) (0x30C0 +0x03) |= 0b01000000;

 }
}
void V_IRQ_TBL(void) __interrupt
{
 *(volatile unsigned char *) (0x3110 +0x03) = 0b01000000;

 *(volatile unsigned char *) (0x30C0 +0x1A) = 0;
 R_Second_Temp++;
 R_flash_Temp++;
 if (R_flash_Temp>1)
 {
  R_flash_Temp = 0;
 }
}
void V_IRQ_FP(void) __interrupt
{

}
void V_IRQ_KEY(void) __interrupt
{

}
void V_IRQ_SPI(void) __interrupt
{

}
void V_IRQ_RFC_TM0(void) __interrupt
{
# 172 ".\\Int_Vec.c"
}
void V_IRQ_RFC_TM1(void) __interrupt
{

}
void V_IRQ_UART(void) __interrupt
{
 *(volatile unsigned char *) (0x30C0 +0x0C) = 0b00000100;
  while(!(*(volatile unsigned char *) (0x3150 +0x07) & 0b00010000))
  {
   *(volatile unsigned char *) (0x3000 +0x0B) = 0x00;

   if (R_UART_CNT < 9)
   {

    UART_RxBuffer[R_UART_CNT] = *(volatile unsigned char *) (0x3150 +0x00);
    R_UART_CNT++;
    g_uart_rx_timeout_ticks = 4;
   }
   else
   {

    (void)*(volatile unsigned char *) (0x3150 +0x00);
   }
  }

  F_UART_GetStatus();

  *(volatile unsigned char *) (0x3150 +0x01) = 0b00001000 | 0b00000100 | 0b00000010 | 0b00000001;
  *(volatile unsigned char *) (0x30C0 +0x0C) = 0b00000100;
}


void V_IRQ_PWMTM(void) __interrupt
{

}
void V_IRQ_I2C(void) __interrupt
{

}
void V_IRQ_LVD(void) __interrupt
{

}
void V_IRQ_Capture(void) __interrupt
{

}
void V_NMI(void) __interrupt
{

}
#pragma restore

extern void V_RESET(void);
#pragma xconstsec INT_VEC
const int Int_Vec[2] = {(int)&V_NMI, (int)&V_RESET};
