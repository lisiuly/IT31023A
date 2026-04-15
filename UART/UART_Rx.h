#ifndef	_Uart_Rx_H__
#define __Uart_Rx_H__

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

	Bai_SP,             // 百
    ErLing_SP,          // 二零
    Nian_SP,            // 年
    Yue_SP,             // 月
    Ri_SP,              // 日
    Dian_SP,            // 点
    Fen_SP,             // 分
    LingChen_SP,        // 凌晨
    ShangWu_SP,         // 上午
    XiaWu_SP,           // 下午
    WanShang_SP,        // 晚上
    XianZaiShiKe_SP,    // 现在时刻
    JinTianShi_SP,      // 今天是
    ShiJianSheZhiWei_SP,// 时间设置为
    RiQiSheZhiWei_SP,   // 日期设置为
    BaoShiGongNeng_SP,  // 报时功能
    ZhengDianBaoShi_SP, // 整点报时
    SheZhi_SP,          // 设置
    Wei_SP,             // 为
    SheZhiWei_SP,       // 设置为
    TingZhiXiangNao_SP, // 停止响闹
    JinRuTanShui_SP,    // 进入贪睡
    TanShuiGongNeng_SP, // 贪睡功能
    SuoYou_SP,          // 所有
    NaoZhong_SP,        // 闹钟
    DanCi_SP,AlarmCycle_SP=DanCi_SP,           // 单次
    WuTian_SP,          // 五天
    LiuTian_SP,         // 六天
    MeiTian_SP,         // 每天
    XiangNao_SP,        // 响闹
    YiGuanBi_SP,        // 已关闭
    YiKaiQi_SP,         // 已开启
    ZhengJiShi_SP,      // 正计时
    DaoJiShi_SP,        // 倒计时
    FenZhong_SP,        // 分钟
    FanQieJiShiFa_SP,   // 番茄计时法
    ZanTing_SP,         // 暂停
    KaiQi_SP,           // 开启
    GuanBi_SP,          // 关闭
    JieShu_SP,          // 结束
    JiXu_SP,            // 继续
    JiShi_SP,           // 计时
    DaKai_SP,           // 打开
    JinTian_SP,         // 今天
    MingTian_SP,        // 明天
    TiXing_SP,          // 提醒
    DangQianWenDu_SP,   // 当前温度
    LingXia_SP,         // 零下
    SheShiDu_SP,        // 摄氏度
    HuaShiDu_SP,        // 华氏度
    BaBa_SP,FamilyStart_SP=BaBa_SP,            // 爸爸
    MaMa_SP,            // 妈妈
    GeGe_SP,            // 哥哥
    DiDi_SP,            // 弟弟
    JieJie_SP,          // 姐姐
    MeiMei_SP,          // 妹妹
    LaoDa_SP,           // 老大
    LaoEr_SP,           // 老二
    LaoSan_SP,          // 老三
    LaoSi_SP,           // 老四
    LaoGong_SP,         // 老公
    LaoPo_SP,           // 老婆
    WaiGong_SP,         // 外公
    WaiPo_SP,           // 外婆
    YeYe_SP,            // 爷爷
    NaiNai_SP,          // 奶奶
    De_SP,              // 的
    ShengRi_SP,         // 生日
    Shi_SP,             // 是
    QingChu_SP,         // 清除
    ShangYiQu_SP,       // 上一曲
    XiaYiQu_SP,         // 下一曲
    XianShi_SP,         // 显示
    LiangYiDian_SP,     // 亮一点
    AnYiDian_SP,        // 暗一点
    YinLiang_SP,        // 音量
    ZengDa_SP,          // 增大
    JianXiao_SP,        // 减小
    NaoZhongSheng_SP,   // 闹铃声
    Di_SP,              // 第
    Ji_SP,              // 级
    Shou_SP,            // 首
    YingDa1_SP,RespondStart_SP=YingDa1_SP,         // 应答1
    YingDa2_SP,         // 应答2
    YingDa3_SP,         // 应答3
    YingDa4_SP,         // 应答4
    YingDa5_SP,         // 应答5
    Zai_SP,             // 再
    ChiYao_SP,          // 吃药
    DangQianShiDu_SP,   // 当前湿度
    BaiFenZhi_SP,       // 百分之
    Zheng_SP,           // 整
    ZhongWu_SP,         // 中午
    SheZhiChengGong_SP, // 设置成功
    SheZhiShiBai_SP,    // 设置失败

    naoling1_SP,naolingStart_SP=naoling1_SP,     // 闹铃1
    naoling2_SP,     // 闹铃2
    naoling3_SP,     // 闹铃3
    naoling4_SP,     // 闹铃4
    naoling5_SP,     // 闹铃5
    naoling6_SP,     // 闹铃6
    naoling7_SP,     // 闹铃7
    didianbaojing_SP, // 低电报警
    chakan_SP,        // 查看
    riqi_SP,          // 日期
    shezhi1_SP,       // 设置
    shijian_SP,       // 时间
} action_sp;

#define Set_Time                0x81    //设置时间
#define Set_Date                0x82    //设置日期
#define Set_Alarm               0x83    //设置闹钟
#define CountDown_Start         0x84    //倒计时
#define CountDown_Pause         0x85    //暂停计时
#define CountDown_Continue      0x86    //继续计时
#define CountDown_End           0x87    //结束计时
#define FQ_CountDown_Start      0x88    //番茄计时
#define FQ_CountDown_End        0x89    //结束番茄计时
#define Alarm_On_Off            0x8A    //打开/关闭闹钟
#define Alarm_Loop              0x8B    //闹钟循环模式
#define Alarm_Music             0x8C    //闹铃选择
#define Alarm_Snooze            0x8D    //贪睡
#define Alarm_Stop              0x8E    //闹钟停止
#define Display_On_Off          0x8F    //打开/关闭显示
#define Report_Time             0x70    //报时
#define Report_ZD_On_Off        0x71    //打开/关闭整点报时
#define Report_On_Off           0x72    //打开/关闭报时
#define Check_Alarm             0x73    //查看闹钟
#define Check_Date              0x74    //查看日期
#define Check_Temp              0x75    //查看温度
#define CountUp_Start           0x76    //正计时
#define Set_Snooze              0x77    //贪睡开关
#define Birthday_Save           0x78    //生日存储
#define Birthday_Report         0x79    //生日播报
#define Alarm_Remind_Today      0x7A    //今天闹钟提醒
#define Alarm_Remind_Tomorrow   0x7B    //明天闹钟提醒
#define Alarm_Off_Today         0x7C    //今天所有闹钟关闭
#define Alarm_Off_Tomorrow      0x7D    //明天所有闹钟关闭
#define WakeUp_Word             0x7E    //唤醒词
#define Volume_Level            0x7F    //音量



/* 语音指令定义 */
/* 指定曲目播放 (打断播放) */
#define VOICE_CMD_PLAY        0x10    /* 指令代码: 指定曲目播放 */
/* 格式: A5 5A 10 AA 55
   AA: 要播放的曲目编号 */

/* 接着播 (不打断，单个发表示下个播放曲目) */
#define VOICE_CMD_CONTINUE    0x11    /* 指令代码: 连续播放 */
/* 格式: A5 5A 11 AA C0 C1 C2..55
   AA: 要播放的曲目数
   C0 C1 C2..: 连续播放的曲目序号 */

/* 指定音量值 */
#define VOICE_CMD_VOLUME      0x12    /* 指令代码: 指定音量 */
/* 格式: A5 5A 12 AA 55
   AA: 音量等级 0~31 (0为静音) */

/* 单曲循环/播一次 */
#define VOICE_CMD_MODE        0x13    /* 指令代码: 播放模式设置 */
/* 格式: A5 5A 13 AA 55
   AA: 0x01为播放一次, 0x02为单曲循环 */

/* 停止/暂停/继续播放 */
#define VOICE_CMD_CONTROL     0x20    /* 指令代码: 播放控制 */
/* 格式: A5 5A 20 AA 55
   AA: 0x01为停止, 0x02为暂停, 0x03为播放 */

/* IO扩展口控制 */
#define VOICE_CMD_IO          0x21    /* 指令代码: IO扩展口控制(起始) */
/* 格式: A5 5A 2x AA 55
   0x2x: 0x21:PA4, 0x22:PA6
   AA: 0输出低, 1输出高 */

/* 播放状态查询 */
#define VOICE_CMD_STATUS      0xA0    /* 指令代码: 播放状态查询 */
/* 格式: A5 5A A0 00 55
   主机回复: 5A A5 00 A0 BB 00 00 00 AA
   BB: 00停止, 01正在播放, 02暂停 */

/* ========================================================================
   参数定义
   ======================================================================== */

/* 播放模式参数 */
#define PLAY_MODE_ONCE        0x01    /* 播放一次 */
#define PLAY_MODE_LOOP        0x02    /* 单曲循环 */

/* 播放控制参数 */
#define PLAY_CTRL_STOP        0x01    /* 停止播放 */
#define PLAY_CTRL_PAUSE       0x02    /* 暂停播放 */
#define PLAY_CTRL_RESUME      0x03    /* 继续播放 */

/* IO控制端口定义 */
#define IO_PORT_PA4           0x21    /* PA4控制端口 */
#define IO_PORT_PA6           0x22    /* PA6控制端口 */

/* IO输出电平定义 */
#define IO_LEVEL_LOW          0x00    /* 输出低电平 */
#define IO_LEVEL_HIGH         0x01    /* 输出高电平 */

/* 音量范围定义 */
#define VOLUME_MIN            0x00    /* 最小音量 (静音) */

#define VOLUME_MAX            0x1F    /* 最大音量 (31) */
// 三档音量宏定义
#define VOLUME_LOW   0x00   // 最小音量
#define VOLUME_MID   0x14  // 中档音量
#define VOLUME_HIGH  0x1E  // 最大音量
/* ========================================================================
   响应定义
   ======================================================================== */

/* 响应帧头帧尾 */
#define FRAME_HEADER_LO        0x5A    /* 响应帧头高字节 */
#define FRAME_HEADER_HI        0xA5    /* 响应帧头低字节 */
#define RESP_FIXED_BYTE        0x00    /* 响应固定字节 */
#define	FRAME_TRAILER		   0x55    /* 响应帧尾字节 */	
/* 播放状态定义 (响应中的BB字节) */
#define PLAY_STATUS_STOPPED   0x00    /* 停止状态 */
#define PLAY_STATUS_PLAYING   0x01    /* 正在播放状态 */
#define PLAY_STATUS_PAUSED    0x02    /* 暂停状态 */
#define FRAME_TAIL           0xAA
/* 响应长度 */
#define STATUS_RESP_LEN       8       /* 状态查询响应长度 */



#define Power_On                0xFF    //上电完成后，语音模组发出协议 

#define Function_Total      12// 扩展：加入暂停/继续/结束三条指令 (移除播放状态回调)
        
#define Tx_Len              4

#define asrTime				0x0A


extern unsigned char CLOCK_FLAG_ASR;     //语音识别工作标志

extern unsigned char UART_RxBuffer[];
extern unsigned char PlayList;
extern unsigned seed;
extern unsigned char g_voice_play_status;

//extern unsigned char g_alarm_music_id; // 当前要播放的闹铃声编号


extern void Uart_Disable(void);
extern void Check_UartData(void);
extern void SetVolumeAndPlayAlarm1(unsigned char volume);
//extern void PlayGroup(void);
//extern unsigned CheckAudioStatus(void);
extern void Play_AlarmMusic_Stop(void); // 铃声函数
extern void CheckAndStartTimer(void);//

/* 函数声明 */
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


#endif    