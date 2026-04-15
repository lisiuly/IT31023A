# 1 ".\\system.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 ".\\system.c"
# 11 ".\\system.c"
# 1 ".\\/GPL815P.h" 1
# 57 ".\\/GPL815P.h"
# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 1





# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h" 1
# 34 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h"
unsigned char __bgetc(unsigned char* src, unsigned char bID);
# 7 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 2
# 58 ".\\/GPL815P.h" 2
# 12 ".\\system.c" 2
# 1 ".\\/Variable.h" 1


extern unsigned char RB_128hz_counter;


extern unsigned char R_Second_Temp;

extern unsigned char RB_128HzTo32Hz_count;
# 13 ".\\system.c" 2
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
# 14 ".\\system.c" 2
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
# 15 ".\\system.c" 2
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
# 16 ".\\system.c" 2
unsigned char R_Temp = 0;
unsigned char R_Wakeup_Flag2 = 0;

void F_SYS_PowerOnCPUInitinal(void)
{
 *(volatile unsigned char *) (0x3110 +0x02) = 0b00001000|0b01000000;
 *(volatile unsigned char *) (0x3110 +0x03) = 0b00001000|0b01000000;
 *(volatile unsigned char *) (0x3110 +0x00) = 0b00010000;
 *(volatile unsigned char *) (0x3110 +0x00) = 0b00000001;
 RB_128hz_counter = 0;
 *(volatile unsigned char *) (0x30C0 +0x03) = 0b00000100|0b00001000;
 __asm CLI ‡ __endasm;
 while (RB_128hz_counter<5)
 {
  __asm NOP ‡ __endasm;
 }
 *(volatile unsigned char *) (0x3000 +0x07) = 0b00010000|0b00000000;

 *(volatile unsigned char *) (0x3080 +0x03) = 0b00000001;
}


void F_SYS_ClearPage0()
{
 __asm
 LDX #00H
 LDA #00H

L_STA_LOOP:
 STA $00,X
 INX
 BNE L_STA_LOOP

 __endasm;

}


void F_SYS_ClearNPage()
{
 __asm
 LDX #00H
 LDA #00H

L_STA_LOOP2:
 STA $200,X
 STA $300,X
 STA $400,X
 STA $500,X
 STA $600,X
 STA $700,X
 STA $800,X
 STA $900,X
 STA $A00,X
 STA $B00,X
 INX
 BNE L_STA_LOOP2

 __endasm;
}

void F_SYS_FillDPRAM()
{
 __asm
 LDX #35H
 LDA #FFH

L_STA_LOOPd:
 STA $2000,X
 DEX
 BNE L_STA_LOOPd
 STA $2000
 __endasm;
}

void F_SYS_ClearDPRAM()
{
 __asm
 LDX #35H
 LDA #00H

L_STA_LOOPd1:
 STA $2000,X
 DEX
 BNE L_STA_LOOPd1
 STA $2000
 __endasm;
}




void F_InitIRQ(void)
{
 __asm SEI ‡ __endasm;
 *(volatile unsigned char *) (0x30C0 +0x03) = 0;
 *(volatile unsigned char *) (0x30C0 +0x1A) = 0;
 *(volatile unsigned char *) (0x30C0 +0x1B) = 0;
 *(volatile unsigned char *) (0x30C0 +0x17) = 0;
 *(volatile unsigned char *) (0x30C0 +0x1C) = 0;

 *(volatile unsigned char *) (0x3110 +0x02) = 0b01000000 | 0b00001000;

 *(volatile unsigned char *) (0x3110 +0x00) = 0b00010000;
 *(volatile unsigned char *) (0x3110 +0x00) = 0b00000001;

 *(volatile unsigned char *) (0x3110 +0x08) = 0xC0;
    *(volatile unsigned char *) (0x3110 +0x09) = 0xF7;

 *(volatile unsigned char *) (0x30C0 +0x03) = 0b00000100 +0b00001000;
 *(volatile unsigned char *) (0x30C0 +0x02) = 0b10000000;
 *(volatile unsigned char *) (0x3110 +0x04) = 0b00000001;

 __asm CLI ‡ __endasm;

}






void F_GreenMode(void)
{
 __asm SEI ‡ __endasm;




  *(volatile unsigned char *) (0x30C0 +0x02) = 0;
  *(volatile unsigned char *) (0x30C0 +0x03) = 0;
  *(volatile unsigned char *) (0x30C0 +0x04) = 0;

  *(volatile unsigned char *) (0x30C0 +0x0B) = 0b00010000 | 0b00000100;
  *(volatile unsigned char *) (0x30C0 +0x1C) = 0b00010000 | 0b00000100;
# 161 ".\\system.c"
  *(volatile unsigned char *) (0x3080 +0x11) = 0x00;
  *(volatile unsigned char *) (0x3080 +0x10) = 0x00;
  *(volatile unsigned char *) (0x3080 +0x12) = 0x00;

  *(volatile unsigned char *) (0x3080 +0x05) = 0x40;
  R_Temp = *(volatile unsigned char *) (0x3080 +0x12);
# 175 ".\\system.c"
  *(volatile unsigned char *) (0x3110 +0x02) = 0b01000000;

  *(volatile unsigned char *) (0x30C0 +0x03) = 0b00000100 | 0b00010000;





  *(volatile unsigned char *) (0x3000 +0x07) = 0b00000000 | 0b00000000;
  *(volatile unsigned char *) (0x3000 +0x09) = 0b10100101;
  __asm NOP ‡ __endasm;
  __asm NOP ‡ __endasm;
  __asm NOP ‡ __endasm;
  *(volatile unsigned char *) (0x3000 +0x0B) = 0;

  *(volatile unsigned char *) (0x3000 +0x07) = 0b00010000 | 0b00000000;

  *(volatile unsigned char *) (0x3000 +0x0B) = 0;

}
# 238 ".\\system.c"
#pragma nooverlay
void F_StandbyMode(void)
{
 __asm SEI ‡ __endasm;

  *(volatile unsigned char *) (0x3450 +0x00) = 0;


  *(volatile unsigned char *) (0x30C0 +0x02) = 0;
  *(volatile unsigned char *) (0x30C0 +0x03) = 0;
  *(volatile unsigned char *) (0x30C0 +0x04) = 0;

  *(volatile unsigned char *) (0x30C0 +0x0B) = 0b00010000;
  *(volatile unsigned char *) (0x30C0 +0x1C) = 0b00010000;



  *(volatile unsigned char *) (0x3080 +0x08) = 0x22;
  *(volatile unsigned char *) (0x3080 +0x09) = 0;
  *(volatile unsigned char *) (0x3080 +0x0A) = 0x00;





  *(volatile unsigned char *) (0x3080 +0x04) = 0xff;
  R_Temp = *(volatile unsigned char *) (0x3080 +0x0A);



  *(volatile unsigned char *) (0x30C0 +0x03) = 0b00010000;





  *(volatile unsigned char *) (0x3000 +0x07) = 0b00000000 | 0b00000000;
  *(volatile unsigned char *) (0x3000 +0x09) = 0b01011010;
  __asm NOP ‡ __endasm;
  __asm NOP ‡ __endasm;
  __asm NOP ‡ __endasm;
  *(volatile unsigned char *) (0x3000 +0x0B) = 0;

  *(volatile unsigned char *) (0x3000 +0x07) = 0b00010000 | 0b00000000;
  *(volatile unsigned char *) (0x3000 +0x0B) = 0;

}




void F_Afterwakeup_Proc(void)
{

  R_Wakeup_Flag2 = *(volatile unsigned char *) (0x30C0 +0x0B);
  if (R_Wakeup_Flag2&0b00000100)
  {



  }

  if(R_Wakeup_Flag2&0b00010000)
  {



  }

  __asm SEI ‡ __endasm;

  *(volatile unsigned char *) (0x30C0 +0x0B) = 0b00010000 | 0b00000100;
  *(volatile unsigned char *) (0x30C0 +0x1C) = 0b00010000 | 0b00000100;
  *(volatile unsigned char *) (0x30C0 +0x1A) = 0b00010000 | 0b00000100;


  *(volatile unsigned char *) (0x3110 +0x02) = 0b00001000 | 0b01000000;


  *(volatile unsigned char *) (0x3490 +0x00) &= ~0b00000010;
  R_CurrentBrightness = 0;

  *(volatile unsigned char *) (0x30C0 +0x03) = 0b00000100 +0b00001000;

  __asm CLI ‡ __endasm;
}




void F_InitPort(void)
{
  *(volatile unsigned char *) (0x3080 +0x11) = 0x00;
  *(volatile unsigned char *) (0x3080 +0x10) = 0x00;
  *(volatile unsigned char *) (0x3080 +0x12) = 0x00;


  *(volatile unsigned char *) (0x3080 +0x08) = 0x22;
  *(volatile unsigned char *) (0x3080 +0x09) = 0;
  *(volatile unsigned char *) (0x3080 +0x0A) = 0x20;

  *(volatile unsigned char *) (0x3080 +0x19) = 0x00;
  *(volatile unsigned char *) (0x3080 +0x18) = 0x00;
  *(volatile unsigned char *) (0x3080 +0x1A) = 0x01;
}




void F_LVD_Init(void)
{

    *(volatile unsigned char *) (0x3000 +0x0A) = 0b10000000 | 0b00000010;
}
