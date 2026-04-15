#include "GPL815P.h"
#include "calendar\calendar.h"
#include "lcd\lcd_user.h"
#include	"UART\UART_Code.h"
#include "UART\UART_Rx.h"
#include "KEYSCAN\key_user.h"
#include "Timer\Timer.h"


//const unsigned char Tx_data[14] = {0,1,2,3,4,5,6,7,8,9,0xA,0xb,0xc,0xd};
//#pragma npage UART_Buffer  // 告诉编译器将后续缓冲区变量分配到非分页RAM（避免分页切换问题）
//unsigned char Databuff[32] ;  // UART接收数据缓冲区（存储外部设备发来的数据）
unsigned char StatusBuff[9] ;// UART接收状态缓冲区（存储每个接收数据的错误状态）
unsigned char temp;            // 临时变量（用于循环计数、数据暂存）
unsigned char Rx_data_test[20];// 接收数据测试备份数组（备份Databuff的前20个有效数据）
unsigned char t;               // 备份循环计数变量

//extern void PlayA1800_User_index(unsigned index);
//extern unsigned CheckA1800Status(void);

extern unsigned char CLOCK_FLAG_ASR;	
//extern unsigned UART_RxBuffer[9];
unsigned char UART_RxBuffer[16];
//extern unsigned UART_RxWritePtr;
//unsigned UART_RxWritePtr;
//unsigned UART_RX_TH;
//unsigned UART_RX_Timeout;


action_sp Function_SP;
//unsigned Uart_EndFlag;
//unsigned Uart_EndCnt;
//unsigned Rx_Length;
//unsigned CRCNum;
/* 扩容语音索引缓冲，避免构造较长语音序列时溢出（例如完整的时间/日期播报） */
unsigned char Spindex[32];
unsigned char SpCnt;
unsigned char PlayList;
//unsigned TimeOut;
//unsigned LastIndex;
unsigned CI_Mode;	//语音识别到的功能
unsigned PlayEnd;
unsigned Birthday[20][2];
unsigned seed;
unsigned char index;
unsigned char User_AsrTime;
//unsigned CLOCK_FLAG_ASR;	 //语音识别工作标志
unsigned Timer_Start;	 //语音识别倒计时开启工作

static void F_OnVoicePlayStatus(void);

//const unsigned TX_DATA[Tx_Len] = {0xA5,0x5A,0xFF,0x00};

//void Uart_Disable(void)
//{
//	*P_UART_Ctrl = C_UART_Disable;
//}
//void Uart_Recive_Data(void)//接收UART数据，并设置接收完成标志。
//{
//	if(Uart_EndFlag == 0)
//		Uart_EndCnt++;
//	if(Uart_EndCnt >= 16)
//	{
//		Uart_EndCnt = 0;
//		if(UART_RxWritePtr > 0)
//			Uart_EndFlag = 1;	
//	}
//}
//5A A5 XX XX XX XX XX XX AA

//void Receive_Timeout(void)//处理接收超时，当超时发生时设置接收完成标志。
//{
////	unsigned char i;
//	if(UART_RX_Timeout)
//	{
//		UART_RX_Timeout--;
//		if(UART_RX_Timeout == 0)
//			Uart_EndFlag = 1;
//	}
//}

static void Sorting_Number(unsigned read0,unsigned number)	//整理数字，分出百位十位和个位
{
	// if(number < 70)
	// 	*_buf = Num10_Start + (number / 10); //设置十位;
	// else
	// 	*_buf = ((Num70_Start + (number / 10))-7); //设置十位;
	// *(_buf + 1)  = Num_Start + (number % 10); //设置个位
	// if((number % 10) == 0)
	// 		*(_buf + 1) = 0xFFFF; //个位=0则不播
	// if(number < 10)
	// {
	// 	*_buf = 0xFFFF; //不播
	// 	*(_buf + 1) = Num_Start + (number % 10); //0时要播个位=0
	// }
//	#if 1
	if((number / 100)%10){
		Spindex[index++] = ((NumStart_Sp + ((number / 100)%10))); //设置百位;
		Spindex[index++] = Bai_SP;//设置百;

		if((number / 10)%10){
			if(((number / 10)%10) > 1){
				Spindex[index++] = ((NumStart_Sp + ((number / 10)%10))); //设置十位;
			}

			Spindex[index++] = Num010_SP;//设置十;

			if(number % 10){//取个位
				Spindex[index++] = NumStart_Sp + (number % 10);
			}
		}
		else{
			Spindex[index++] = Num000_SP; //设置十位;

			if(number % 10){//取个位
				Spindex[index++] = NumStart_Sp + (number % 10);
			}
		}
	}
	else if((number / 10)%10){
		if(((number / 10)%10) > 1){
			Spindex[index++] = ((NumStart_Sp + ((number / 10)%10))); //设置十位;
		}

		Spindex[index++] = Num010_SP;//设置十;

		if(number % 10){//取个位
			Spindex[index++] = NumStart_Sp + (number % 10);
		}
	}
	else{
		if(number % 10){	//取个位
			if(read0){
				Spindex[index++] = Num000_SP;
			}
			Spindex[index++] = NumStart_Sp + (number % 10);
		}
		if(number == 0)
			Spindex[index++] = NumStart_Sp + (number % 10); //0时要播个位=0
	}
//	#else
//	    /* ---------- 所有变量定义在最前面 ---------- */
//    unsigned bai, rest, shi, ge;
//
//    /* 合法性截断 */
//    if (number > 999) number = 999;
//
//    bai  = number / 100;
//    rest = number % 100;
//
//    /* -------- 百位 -------- */
//    if (bai) {
//        _buf[index++] = Num000_SP + bai; /* 1_SP ... 9_SP */
//        _buf[index++] = Bai_SP;          /* “百” */
//    }
//
//    /* -------- 剩余 0–99 -------- */
//    if (rest == 0) return;    /* 整百 */
//
//    if (rest < 10) {            /* 101–109：补“零” */
//        _buf[index++] = Num000_SP;       /* 0_SP */
//        _buf[index++] = Num000_SP + rest;
//        return;
//    }
//
//    shi = rest / 10;
//    ge  = rest % 10;
//
//    if (shi == 1) {             /* 10–19：直接用“十” */
//        _buf[index++] = Num010_SP;       /* “十” */
//        if (ge) _buf[index++] = Num000_SP + ge;
//    } else {                    /* 20–99：x 十 y */
//        _buf[index++] = Num000_SP + shi;
//        _buf[index++] = Num010_SP;       /* “十” */
//        if (ge) _buf[index++] = Num000_SP + ge;
//    }
//	#endif
}

static void Sorting_Hour(unsigned * _buf,unsigned hour)	 //整理24-12
{
	if(hour > 23) return;

	       if(RB_12_24_Status == D_24H){ // 24小时制
		       Sorting_Number(0,hour);
	       }
	       else{//12
		if ((hour >= 0) && (hour <= 5)) {     //凌晨（00:00-04:59）
			Spindex[index++] = LingChen_SP;
		}
		else if ((hour >= 6) && (hour <= 11)) {    //上午（05:00-11:59）
			Spindex[index++] = ShangWu_SP;
		}
		else if (hour == 12) {   //中午（12:00-12:59）
			Spindex[index++] = ZhongWu_SP;
		}
		else if ((hour >= 13) && (hour <= 17)) {    //下午（13:00-17:59）
			Spindex[index++] = XiaWu_SP;
		}
		else if ((hour >= 18) && (hour <= 23)) {    //晚上（18:00-23:59）
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
		Spindex[index++] = SheZhiShiBai_SP;  //设置失败
		SpCnt = index;
		PlayList = 1;
		Voice_SendPlayCmd(Spindex[SpCnt-1]);
}
static int Check_Time_ZD(unsigned spindex,unsigned timevalue)
{
	if(timevalue == 0)
	{
		Spindex[spindex-3] = Dian_SP;	//整点
		Spindex[spindex-2] = Zheng_SP;
//		Spindex[spindex-1] = 0xFF;
		 (index)--;
	}
	return 0;
}
/*
[0]:设置时间为  [1]:十位  [2]:个位  [3]:点  [4]:十位  [5]:个位  [6]:分
*/
static void F_Set_Time(void)
{
	int isPm,hour;

	if((UART_RxBuffer[4] < 24) && (UART_RxBuffer[5] < 60)) //时间正常
	{
		
		//Spindex[index++] = ShiJianSheZhiWei_SP;  //设置时间为
		Sorting_Hour(&Spindex[index],UART_RxBuffer[4]);
		Spindex[index++] = Dian_SP;	 //点
		Sorting_Number(1,UART_RxBuffer[5]);
		Spindex[index++] = Fen_SP; //分
		Check_Time_ZD(index,UART_RxBuffer[5]);
		Spindex[index++] = SheZhiChengGong_SP;  //设置成功
		SpCnt = index;
		PlayList = 1;
		Voice_SendContinueCmd(SpCnt,Spindex);
		hour = UART_RxBuffer[4];

//		#if 0
//		if(ClockFnMap[CLOCK_FLAG_24].get() == 0){
//			hour24to12(&hour,&isPm);
//			UART_RxBuffer[4] = hour;
//			ClockFnMap[CLOCK_FLAG_PM].set(isPm,0);
//		}
////		ClockFnMap[CLOCK_TIME_HOUR].set(UART_RxBuffer[4],0);
////		ClockFnMap[CLOCK_TIME_MINUTE].set(UART_RxBuffer[5],0);
////		ClockFnMap[CLOCK_TIME_SEC].set(0,0);
//		R_DateHour = UART_RxBuffer[4];
//		R_LCDHourBuff = UART_RxBuffer[4];
//		R_DateMinute = UART_RxBuffer[5];
//		R_LCDMinuBuff = UART_RxBuffer[5];	
//		R_DateSecond = 0;
//		R_LCDSecBuff = 0;
////		Display_UIOption(UI_HOUR_MINUTE);
////		UIProcDisplayTimer = 3000/10;
//		#else
		R_DateHour = UART_RxBuffer[4];
		R_LCDHourBuff = UART_RxBuffer[4];
		R_DateMinute = UART_RxBuffer[5];
		R_LCDMinuBuff = UART_RxBuffer[5];	
		R_DateSecond = 0;
		R_LCDSecBuff = 0;	
//		R_Uart_UI = D_UI_Time;
//		RB_Lcd_Updata_Flag |= D_LcdUpdate;   
		   Set_UartUI_And_LcdUpdateFlag();  
//		ClockFnMap[CLOCK_TIME_HOUR].set(UART_RxBuffer[4],0);
//		ClockFnMap[CLOCK_TIME_MINUTE].set(UART_RxBuffer[5],0);
//		ClockFnMap[CLOCK_TIME_SEC].set(0,0);
//		ClockFnMap[CLOCK_TIME_SEC].set(0,0);
//		Clock.timeSecCnt = 0;

//		ClockFnMap[CLOCK_FLAG_SNOOZE].set(0,0);
//		autoLight_back();
//		Display_UIOption(UI_HOUR_MINUTE);
//		UIProcDisplayTimer = 3000/10;
//		#endif
	}
	else
	{
		F_Setzhishibai();
		// Spindex[index++] = SheZhiShiBai_SP;  //设置失败
		// SpCnt = index;
		// PlayList = 1;
		// Voice_SendPlayCmd(Spindex[SpCnt-1]);
	}
}

/*
[0]:设置日期为  [1]:2	[1]:0	[3]:年份十位  [4]:年份个位	[5]:年
[6]:月份十位    [7]:月份个位	 [8]:月		  [9]:日十位	[10]:日个位		[11]:日
*/
static void  F_Set_Date(void)
{
	int year,month,day;

	year = UART_RxBuffer[5];
	month = UART_RxBuffer[6];
	day = UART_RxBuffer[7];
	
	if(day<=31){
		//Spindex[index++] = RiQiSheZhiWei_SP;  //设置日期为
		Spindex[index++] = Num002_SP;  //2
		Spindex[index++] = Num000_SP;  //0
		Spindex[index++] = NumStart_Sp + (UART_RxBuffer[5] / 10); //设置年十位
		Spindex[index++] = NumStart_Sp + (UART_RxBuffer[5] % 10); //设置年个位
		Spindex[index++] = Nian_SP; //年
		Sorting_Number(0,UART_RxBuffer[6]);
		Spindex[index++] = Yue_SP; //月
		Sorting_Number(0,UART_RxBuffer[7]);
		Spindex[index++] = Ri_SP;
		Spindex[index++] = SheZhiChengGong_SP;  //设置成功
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
//		R_Uart_UI = D_UI_Time;
//		RB_Lcd_Updata_Flag |= D_LcdUpdate; 
		Set_UartUI_And_LcdUpdateFlag();  
//		Display_UIOption(UI_YEAR_MONTH_DAY);
		//UIProcDisplayTimer = 3000/10;
	}
	else{
		F_Setzhishibai();
		// Spindex[index++] = SheZhiShiBai_SP;  //设置失败
		// SpCnt = index;
		// PlayList = 1;
		// Voice_SendPlayCmd(Spindex[SpCnt-1]);
	}

}

// 为按键设置完成播放时间（供主循环调用）
void Play_SetTimeVoice_FromKey(void)
{
	index = 0;
	/* 年份：前两位固定为 20 */
	Spindex[index++] = Num002_SP;  /* 2 */
	Spindex[index++] = Num000_SP;  /* 0 */
	/* 年的后两位（如 26 表示 2026 年中的 26） */
	Spindex[index++] = NumStart_Sp + (R_Year[0] / 10);
	Spindex[index++] = NumStart_Sp + (R_Year[0] % 10);
	Spindex[index++] = Nian_SP; /* 年 */

	/* 月、日 */
	Sorting_Number(0, R_Month);
	Spindex[index++] = Yue_SP; /* 月 */
	Sorting_Number(0, R_Day);
	Spindex[index++] = Ri_SP; /* 日 */

	/* 时、分 */
	Sorting_Hour(&Spindex[index], R_DateHour);
	Spindex[index++] = Dian_SP; /* 点 */
	Sorting_Number(1, R_DateMinute);
	Check_Time_ZD(index, R_DateMinute);

	Spindex[index++] = SheZhiChengGong_SP; /* 设置成功 */

	SpCnt = index;
	PlayList = 1;
	Voice_SendContinueCmd(SpCnt, Spindex);
}

/*
[0]:设置闹钟x为		[1]:小时十位	[2]:小时个位	[3]:点
[4]:分钟十位		[5]:分钟个位	[6]:分
*/
static void F_Set_Alarm(void)
{
	unsigned char alarm_num = UART_RxBuffer[4];  // 1,2,3
    
    if (alarm_num < 1 || alarm_num > 3) {
        Spindex[index++] = SheZhiShiBai_SP;
        SpCnt = index;
        PlayList = 1;
       	Voice_SendPlayCmd(Spindex[SpCnt-1]);
        return;
  	  }
	if((UART_RxBuffer[5] < 24) && (UART_RxBuffer[6] < 60)) //时间正常
	{
		unsigned char alarm_index = alarm_num - 1;
      // 存储时间
        R_AlarmHour[alarm_index] = UART_RxBuffer[5];
        R_AlarmMinute[alarm_index] = UART_RxBuffer[6];      
        // 设置当前组别
        R_CurrentGroup = alarm_index;
        R_Uart_UI = 10;
//  		RB_Lcd_Updata_Flag |= D_LcdUpdate;   
  		Set_UartUI_And_LcdUpdateFlag();  
  		
	    Spindex[index++] = SheZhi_SP;  //设置
		Spindex[index++] = NaoZhong_SP;  //闹钟
		Spindex[index++] = NumStart_Sp + UART_RxBuffer[4];  //设置闹钟x
		Spindex[index++] = Wei_SP;  //为
		Sorting_Hour(&Spindex[index],UART_RxBuffer[5]);
		Spindex[index++] = Dian_SP;	 //点
		Sorting_Number(1,UART_RxBuffer[6]);
		Spindex[index++] = Fen_SP; //分
		Check_Time_ZD(index,UART_RxBuffer[6]);
//		Spindex[index++] = NaoZhong_SP;  //闹钟
		//Spindex[index++] = Num001_SP;  //1
		Spindex[index++] = SheZhiChengGong_SP;  //设置成功
		SpCnt = index;
		PlayList = 1;
		Voice_SendContinueCmd(SpCnt,Spindex);
		
//		ClockFnMap[CLOCK_ALARM_HOUR].set(UART_RxBuffer[5],0);
//		ClockFnMap[CLOCK_ALARM_MINUTE].set(UART_RxBuffer[6],0);
//		ClockFnMap[CLOCK_FLAG_ALARM].set(1,0);
//		ClockFnMap[CLOCK_FLAG_SNOOZE].set(0,0);
//		Display_UIOption(UI_ALARM);
//		UIProcDisplayTimer = 3000/10;
		
	}
	else{
		F_Setzhishibai();
		// Spindex[index++] = SheZhiShiBai_SP;  //设置失败
		// SpCnt = index;
		// PlayList = 1;
		// Voice_SendPlayCmd(Spindex[SpCnt-1]);
	}
	
}
//void F_Count_Start(void)	
//  	Spindex[index++] = JiShi_SP;  //计时
//	Spindex[index++] = KaiQi_SP; 
//	SpCnt = index;
//	PlayList = 1;
//	Voice_SendContinueCmd(SpCnt,Spindex); 
//}
//
/*[0]:倒计时	[1]:分钟十位	[2]:分钟个位	[3]:分钟*/
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
	Spindex[index++] = JiShi_SP;  //倒计时
//	Sorting_Number(0,num);
//	Spindex[index++] = FenZhong_SP; //分钟
//  	Spindex[index++] = JiShi_SP;  //计时
	
	SpCnt = index;
	PlayList = 1;
	// 立即开始倒计时：不要依赖 Timer_Start 或等待语音播放完毕
	R_TimerFlag &= ~(D_Timerstatus_just);   // 清除正计时标志
	R_TimerFlag &= ~(D_Timerstatus_justpause | D_TimerPausedCountDown); // 清除暂停位
	R_TimerFlag |= D_Timerstatus;           // 置倒计时走时位
	Voice_SendContinueCmd(SpCnt,Spindex);
	
	if(num){
//		R_TimerFlag &= ~(D_Timerstatus+D_Timerstatus_just);
//		R_TimerFlag &= ~TIMER_START_FLAG;
		R_TimerMinute = num ;
		R_TimerSecond = 0;
// 		R_POINT	= 32;
// //		ClockFnMap[CLOCK_COUNT_DOWN_S].set((num*60),0);
// //
// //		Display_UIOption(UI_COUNT_DOWN);
// //		UIProcDisplayTimer = 3000/10;
	}
   Set_UartUI_And_LcdUpdateFlag();  	
//	R_Uart_UI = D_UI_Time;
//	RB_Lcd_Updata_Flag |= D_LcdUpdate;   
//	F_Count_Start(); 

}

// static void F_CountDown_Pause(void)
// {
// 暂停计时
static void F_CountDown_Pause(void)
{
	// 完全复刻按键 Enable_TimerKey 的判断与位操作，不依赖 Timer_Start
	// 如果处于走时 (D_Timerstatus_just 或 D_Timerstatus) -> 进入停止分支
	if (R_TimerFlag & (D_Timerstatus_just | D_Timerstatus)) {
		if (R_TimerFlag & D_Timerstatus_just) {
			// 正计时走时 -> 切换到暂停
			R_TimerFlag &= ~D_Timerstatus_just;
			R_TimerFlag |= D_Timerstatus_justpause;
		} else {
			R_TimerFlag &= ~D_Timerstatus;
			R_TimerFlag |= D_TimerPausedCountDown;
		}
			Spindex[index++] = ZanTing_SP;     // 暂停
			Spindex[index++] = JiShi_SP;    // 计时		
		SpCnt = index;
		PlayList = 1;
		Voice_SendContinueCmd(SpCnt, Spindex);
		Set_UartUI_And_LcdUpdateFlag();
		return;
	}
}

// 继续计时
static void F_CountDown_Continue(void)
{
	// 复刻按键的“开始”分支逻辑：
	// 优先处理暂停恢复：若处于 D_Timerstatus_justpause -> 清暂停，置 D_Timerstatus_just（正计时恢复）
	if (R_TimerFlag & D_Timerstatus_justpause) {
		R_TimerFlag &= ~D_Timerstatus_justpause;
		R_TimerFlag |= D_Timerstatus_just;
		Spindex[index++] = JiXu_SP;    //  继续
		Spindex[index++] = JiShi_SP;     // 计时
		SpCnt = index;
		PlayList = 1;
		Voice_SendContinueCmd(SpCnt, Spindex);
		Set_UartUI_And_LcdUpdateFlag();
		return;
	}

	// 若定时器不为 00:00 且未在走时 -> 启动倒计时走时
	if (R_TimerFlag & D_TimerPausedCountDown) {
		R_TimerFlag &= ~D_TimerPausedCountDown;
		R_TimerFlag |= D_Timerstatus;
		Spindex[index++] = JiXu_SP;    //  继续
		Spindex[index++] = JiShi_SP;     // 计时
		SpCnt = index;
		PlayList = 1;
		Voice_SendContinueCmd(SpCnt, Spindex);
		Set_UartUI_And_LcdUpdateFlag();
	}
}

// 结束计时
static void F_CountDown_End(void)
{
	// 结束计时：清除正/倒计时所有相关标志并清零计时寄存器
	R_TimerFlag &= ~(D_Timerstatus | D_Timerstatus_just | D_Timerstatus_justpause |D_TimerPausedCountDown | TIMER_START_FLAG);
	Timer_Start = 0;
	R_TimerMinute = 0;
	R_TimerSecond = 0;
	R_POINT = 0;

	Spindex[index++] = JieShu_SP;  // 结束
	Spindex[index++] = JiShi_SP;   // 计时
	SpCnt = index;
	PlayList = 1;
	Voice_SendContinueCmd(SpCnt, Spindex);
	Set_UartUI_And_LcdUpdateFlag();
}

// static void F_CountDown_End(void)
// {
// 	Spindex[index++] = JieShu_SP;  //结束计时
// 	Spindex[index++] = DaoJiShi_SP;  //计时
// 	SpCnt = index;
// 	PlayList = 1;
// 		Voice_SendContinueCmd(SpCnt,Spindex);
// }

//static void F_FQ_CountDown_Start(void)
//{
//	Spindex[index++] = FanQieJiShiFa_SP;  //番茄计时
//	SpCnt = index;
//	PlayList = 1;
//}
//static void F_FQ_CountDown_End(void)
//{
//	Spindex[index++] = GuanBi_SP;  //关闭番茄计时
//	Spindex[index++] = FanQieJiShiFa_SP;  //番茄计时
//	SpCnt = index;
//	PlayList = 1;
//}
//
//
/*
[0]:闹钟1/2/3	所有闹钟打开/关闭	[1]:打开/关闭
*/
//static void F_Alarm_On_Off(void)
//{
//	#if 0
//	if(UART_RxBuffer[4] == 0xF0){
//		Spindex[index++] = SuoYou_SP;
//		Spindex[index++] = NaoZhong_SP;
//		Spindex[index++] = GuanBi_SP;
//	}
//	else if(UART_RxBuffer[4] == 0xF1){
//		Spindex[index++] = SuoYou_SP;
//		Spindex[index++] = NaoZhong_SP;
//		Spindex[index++] = GuanBi_SP;
//	}
//	else
//	#else
//	if(UART_RxBuffer[4]&0xF0)
//	#endif
//	{
//		Spindex[index++] = NaoZhong_SP;
//		//Spindex[index++] = NumStart_Sp + ((UART_RxBuffer[4] & 0xF0) >> 4);
//		if(UART_RxBuffer[4] & 0x0F){
//			Spindex[index++] = DaKai_SP;
//		}
//		else{
//			Spindex[index++] = GuanBi_SP;
//			ClockFnMap[CLOCK_FLAG_SNOOZE].set(0,0);
//			ClockFnMap[CLOCK_FLAG_ALAMFIRED].set(0,0);
//		}
//	}
//	SpCnt = index;
//	PlayList = 1;
//
//	ClockFnMap[CLOCK_FLAG_ALARM].set((UART_RxBuffer[4] & 0x0F),0);
//
//	Display_UIOption(UI_ALARM);
//	UIProcDisplayTimer = 3000/10;
//}
/*
[0]:闹钟1/2/3/所有闹钟	[1]:打开/关闭
*/
static void F_Alarm_On_Off(void)
{
    unsigned char selector = (UART_RxBuffer[4] >> 4) & 0x0F;  // 高4位
    unsigned char state = UART_RxBuffer[4] & 0x0F;            // 低4位
    
    // 处理所有闹钟
    if (selector == 0x0F) {
        Spindex[index++] = SuoYou_SP;
        Spindex[index++] = NaoZhong_SP;
        
        if (state & 0x01) {  // 打开
            Spindex[index++] = DaKai_SP;
            R_AlarmOnOff = 0x07;  // 0000 0111
        } else {  // 关闭
            Spindex[index++] = GuanBi_SP;
            R_AlarmOnOff = 0x00;  // 0000 0000
        }
    }
    // 处理单个闹钟
    else if (selector >= 1 && selector <= 3) {
        Spindex[index++] = NaoZhong_SP;
        Spindex[index++] = NumStart_Sp + selector;
        R_CurrentGroup = selector - 1;  // 将selector
        if (state & 0x01) {  // 打开
            Spindex[index++] = DaKai_SP;
            R_AlarmOnOff |= (1 << (selector - 1));
        } else {  // 关闭
            Spindex[index++] = GuanBi_SP;
            R_AlarmOnOff &= ~(1 << (selector - 1));
        }
    }
    // 错误处理
    else {
			F_Setzhishibai();
        // Spindex[index++] = SheZhiShiBai_SP;
        // SpCnt = index;
        // PlayList = 1;
        // if (SpCnt > 0) Voice_SendPlayCmd(Spindex[SpCnt-1]);
        return;
    }
        SpCnt = index;
        PlayList = 1;    
     Voice_SendContinueCmd(SpCnt, Spindex);
    // 更新UI
//    R_Uart_UI = D_UI_Time;
//    RB_Lcd_Updata_Flag |= D_LcdUpdate;
   Set_UartUI_And_LcdUpdateFlag();  
}

/*
[0]:闹钟1  所有闹钟		[1]:单次/五天/六天/七天循环
*/
static void F_Alarm_Loop(void)
{
	unsigned char alarm_idx;
	unsigned char mode_idx;
	unsigned char set_val;
	unsigned char i;

	// 解析参数
	// 高4位: 闹钟索引 (0xF=所有, 1-3=指定闹钟)
	// 低4位: 模式索引 (0=单次?, 1=5天, 2=6天, 3=7天)
	alarm_idx = (UART_RxBuffer[4] & 0xF0) >> 4;
	mode_idx = UART_RxBuffer[4] & 0x0F;

	// 映射 mode_idx 到 R_DispAlmDay 的值 (0=5天, 1=6天, 2=7天)
	// 假设协议: 1=5天, 2=6天, 3=7天 (对应 WuTian_SP, LiuTian_SP, MeiTian_SP 的相对顺序)
	if (mode_idx >= 1 && mode_idx <= 3) {
		set_val = mode_idx - 1;
	} else {
		// 默认或错误处理，设为7天(2)
		set_val = 2; 
	}

	if((UART_RxBuffer[4] & 0xF0) == 0xF0) // 所有闹钟
	{
		Spindex[index++] = SuoYou_SP;
		Spindex[index++] = NaoZhong_SP;
		Spindex[index++] = AlarmCycle_SP + mode_idx; // 播报模式语音
			Spindex[index++] = XiangNao_SP;		
		// 设置所有闹钟循环
		for(i=0; i<3; i++) {
			R_DispAlmDay[i] = set_val;
		}
		R_CurrentGroup = 0; // 显示第1组
	}
	else // 单个闹钟
	{
		if(alarm_idx >= 1 && alarm_idx <= 3) {
			Spindex[index++] = NaoZhong_SP;
			Spindex[index++] = NumStart_Sp + alarm_idx;
			Spindex[index++] = AlarmCycle_SP + mode_idx; // 播报模式语音
			Spindex[index++] = XiangNao_SP;
			// 设置指定闹钟循环
			R_DispAlmDay[alarm_idx - 1] = set_val;
			R_CurrentGroup = alarm_idx - 1; // 显示当前设置组
		} else {
			// 错误索引处理
			F_Setzhishibai();
			return;
		}
	}
	
	SpCnt = index;
	PlayList = 1;
	Voice_SendContinueCmd(SpCnt,Spindex);

	// 更新UI
	Set_UartUI_And_LcdUpdateFlag();
}

///*
//[0]:设置闹钟铃声为	[1]:十位	[2]:个位
//*/
//static void F_Alarm_Music(void)
//{
//	if(UART_RxBuffer[4] < 62)
//	{
//		Spindex[index++] = SheZhi_SP;//设置闹钟铃声
//		Spindex[index++] = NaoZhongSheng_SP;
//		Spindex[index++] = Di_SP;
//		Sorting_Number(0,UART_RxBuffer[4]);
//		Spindex[index++] = Shou_SP;
//
//		SpCnt = index;
//		PlayList = 1;
//	}
//	else if(UART_RxBuffer[4] == 70)
//	{
//		Spindex[index++] = ShangYiQu_SP; //上一首
//		SpCnt = index;
//		PlayList = 1;
//	}
//	else if(UART_RxBuffer[4] == 71)
//	{
//		Spindex[index++] = XiaYiQu_SP; //下一首
//		SpCnt = index;
//		PlayList = 1;
//	}
//}
//
//static void F_Alarm_Snooze(void)
//{
//	Spindex[index++] = TanShuiGongNeng_SP;  //贪睡模式
//
//	if(ClockFnMap[CLOCK_FLAG_ALAMFIRED].get()){
//		ClockFnMap[CLOCK_FLAG_ALAMFIRED].set(0,0);
//		if(ClockFnMap[CLOCK_FLAG_SNOOZE].get() == 0){
//			ClockFnMap[CLOCK_FLAG_SNOOZE].set(1,0);
//			ClockFnMap[CLOCK_SNOOZE_HOUR].set(ClockFnMap[CLOCK_TIME_HOUR].get(),0);
//			ClockFnMap[CLOCK_SNOOZE_MINUTE].set(ClockFnMap[CLOCK_TIME_MINUTE].get()+ClockFnMap[CLOCK_SNOOZE].get(),0);
//		}
//		else{
//			//ClockFnMap[CLOCK_FLAG_SNOOZE].set(1,0);
//			ClockFnMap[CLOCK_SNOOZE_HOUR].set(ClockFnMap[CLOCK_SNOOZE_HOUR].get(),0);
//			ClockFnMap[CLOCK_SNOOZE_MINUTE].set(ClockFnMap[CLOCK_SNOOZE_MINUTE].get()+ClockFnMap[CLOCK_SNOOZE].get(),0);
//		}
//	}
//	
//	SpCnt = index;
//	PlayList = 1;
//}
//
//static void F_Alarm_Stop(void)
//{
//	Spindex[index++] = TingZhiXiangNao_SP;  //停止响闹
//	SpCnt = index;
//	PlayList = 1;
//}
//
static void F_Display_On_Off(void)
{
	// 0x01: 打开背光
	if(UART_RxBuffer[4] == 1){
		Spindex[index++] = YiKaiQi_SP;  //已开启
		//Spindex[index++] = XianShi_SP;  //显示 (暂用显示代替背光)
//		F_OpenBacklight(); // 确保背光开启并重置计时
        // 如果当前亮度为0，默认设置为最大亮度
        if(R_BacklightLevel == 0) R_BacklightLevel = 3; 
	}
	// 0x02: 亮一点
	else if(UART_RxBuffer[4] == 2){
		Spindex[index++] = LiangYiDian_SP;  //亮度增加
		if(R_BacklightLevel < 3)
            R_BacklightLevel++;
//        F_OpenBacklight(); // 调整亮度时确保背光开启并重置计时
	}
	// 0x03: 暗一点
	else if(UART_RxBuffer[4] == 3){
		Spindex[index++] = AnYiDian_SP;  //亮度降低
		if(R_BacklightLevel > 1)
            R_BacklightLevel--;
//        F_OpenBacklight(); // 调整亮度时确保背光开启并重置计时
	}
	// 其他: 关闭背光
//	else{
//		Spindex[index++] = YiGuanBi_SP;  //已关闭
		//Spindex[index++] = XianShi_SP;  //显示
//		R_BacklightFlag = 0;
//	}
		
	SpCnt = index;
	PlayList = 1;
     Voice_SendContinueCmd(SpCnt, Spindex);
   Set_UartUI_And_LcdUpdateFlag();  
}

//static void F_Report_Time(void)
//{
//	// if((UART_RxBuffer[4] < 24) && (UART_RxBuffer[5]<  60)) //时间正常
//	// {
//		Spindex[index++] = XianZaiShiKe_SP;//现在时刻
//		Spindex[index++] = 0xFFFF;  //
//		Sorting_Hour(&Spindex[index],ClockFnMap[CLOCK_TIME_HOUR].get());
//		Spindex[index++] = Dian_SP;	 //点
//		Sorting_Number(1,ClockFnMap[CLOCK_TIME_MINUTE].get());
//		Spindex[index++] = Fen_SP; //分
//		Check_Time_ZD(index,ClockFnMap[CLOCK_TIME_MINUTE].get());
//		SpCnt = index;
//		PlayList = 1;
//	// }
//	// Spindex[0] = 1;  //现在几点
//	// SpCnt = 1;
//	// PlayList = 1;
//
//	Display_UIOption(UI_HOUR_MINUTE);
//	UIProcDisplayTimer = 3000/10;
//}

//static void F_Report_ZD_On_Off(void)
//{
//	if(UART_RxBuffer[4]){
//		Spindex[index++] = DaKai_SP; //打开整点报时
//		Spindex[index++] = ZhengDianBaoShi_SP; //打开整点报时
//	}
//	else{
//		Spindex[index++] = GuanBi_SP; //关闭整点报时
//		Spindex[index++] = ZhengDianBaoShi_SP; //关闭整点报时
//	}
//		
//	SpCnt = index;
//	PlayList = 1;
//}
//
//static void F_Report_On_Off(void)
//{
//	if(UART_RxBuffer[4]){
//		Spindex[index++] = DaKai_SP; //打开语音报时
//		Spindex[index++] = BaoShiGongNeng_SP; //打开语音报时
//	}
//	else{
//		Spindex[index++] = GuanBi_SP; //关闭语音报时
//		Spindex[index++] = BaoShiGongNeng_SP; //关闭语音报时
//	}
//		
//	SpCnt = index;
//	PlayList = 1;
//}
//
//
//static void F_Check_Alarm(void)
//{
//	#if 0
//	Spindex[index++] = XianShi_SP; //查看闹钟
//	Spindex[index++] = NaoZhong_SP; //查看闹钟
//	Spindex[index++] = NumStart_Sp + UART_RxBuffer[4];
//	SpCnt = index;
//	PlayList = 1;
//	#else
//	Spindex[index++] = NaoZhong_SP;  //闹钟
//	//Spindex[index++] = NumStart_Sp + UART_RxBuffer[4];  //设置闹钟x
//	Spindex[index++] = Wei_SP;  //为
//	Sorting_Hour(&Spindex[index],ClockFnMap[CLOCK_ALARM_HOUR].get());
//	Spindex[index++] = Dian_SP;	 //点
//	Sorting_Number(1,ClockFnMap[CLOCK_ALARM_MINUTE].get());
//	Spindex[index++] = Fen_SP; //分
//	Check_Time_ZD(index,ClockFnMap[CLOCK_ALARM_MINUTE].get());
//
//	SpCnt = index;
//	PlayList = 1;
//	#endif
//
//	Display_UIOption(UI_ALARM);
//	UIProcDisplayTimer = 3000/10;
//}
//
/* 查看日期*/
//static void F_Check_Date(void)
//{
//	// Spindex[0] = 64;  //今天是几月几日
//	// SpCnt = 1;
//	// PlayList = 1;
//	Spindex[index++] = JinTianShi_SP;
//
//	{
//		int year = ((R_Year[1] << 8) | R_Year[0]);
//		Spindex[index++] = NumStart_Sp + ((year / 1000) % 10);
//		Spindex[index++] = NumStart_Sp + ((year / 100) % 10);
//		Spindex[index++] = NumStart_Sp + ((year / 10) % 10);
//		Spindex[index++] = NumStart_Sp + ((year / 1) % 10);
//	}
//	Spindex[index++] = Nian_SP; //年
//
//	Sorting_Number(0,R_Month);
//	Spindex[index++] = Yue_SP; //月
//	Sorting_Number(0,R_Day);
//	Spindex[index++] = Ri_SP; //日
//	SpCnt = index;
//	PlayList = 1;
//	Voice_SendContinueCmd(SpCnt,Spindex);	
//	Set_UartUI_And_LcdUpdateFlag();
//}
//
//static void F_Check_Temp(void)
//{
//	unsigned temp;
//	Spindex[index++] = DangQianWenDu_SP;//当前温度
//	//Spindex[index++] = 0xFFFF;
//	//Sorting_Number(&Spindex[index],ClockFnMap[CLOCK_TEMP].get());
//	if(ClockFnMap[CLOCK_FLAG_TEMP_CF].get()){
//		temp = ClockFnMap[CLOCK_TEMP].get();
//
//		Spindex[index++] = 0xFFFF;
//		Sorting_Number(0,temp);
//		Spindex[index++] = SheShiDu_SP;
//	}
//	else{
//		temp = ClockFnMap[CLOCK_TEMP].get();
//		temp = temp * 9.0 / 5.0 + 32.0;
//
//		Spindex[index++] = 0xFFFF;
//		Sorting_Number(0,temp);
//		Spindex[index++] = HuaShiDu_SP;
//	}
//	SpCnt = index;
//	PlayList = 1;
//
//	//Menu_goUI(Menu_UI_TEMP);
//}
//
static void F_CountUp_Start(void)
{

	if(UART_RxBuffer[4]){
		//Spindex[index++] = DaKai_SP;  //打开正计时
		//Spindex[index++] = ZhengJiShi_SP;  //打开正计时
		Spindex[index++] = ZhengJiShi_SP;  //正计时
		if (R_TimerFlag & D_Timerstatus_just) {
			Spindex[index++] = YiKaiQi_SP;     // 已开启
		//	return;
			}
		else {	
			
		Spindex[index++] = KaiQi_SP;  //打开正计时	
		R_TimerFlag &= ~(D_Timerstatus);            
		R_TimerFlag &= ~D_Timerstatus_justpause;
		R_TimerFlag |= D_Timerstatus_just; // 立即开始正计时
		R_TimerMinute = 0;
		R_TimerSecond = 0;
		R_POINT	= 32;
		}
	}
	// else{
	// 	Spindex[index++] = ZhengJiShi_SP;  //正计时
	// 	if (!(R_TimerFlag & D_Timerstatus_just)) {
  	// 		Spindex[index++] = YiGuanBi_SP;    // 已关闭
   	// 	}		
	// 	else {	
	// 	Spindex[index++] = GuanBi_SP;  //关闭
	// 	R_TimerFlag &= ~D_Timerstatus_just;
	// 	R_POINT	= 0;
	// 	}
	//}
	SpCnt = index;
	PlayList = 1;
	Voice_SendContinueCmd(SpCnt,Spindex);
    Set_UartUI_And_LcdUpdateFlag();  
}

//static void F_Set_Snooze(void)
//{
//	if(UART_RxBuffer[4]){
//		Spindex[index++] = DaKai_SP;  //打开贪睡模式
//		Spindex[index++] = TanShuiGongNeng_SP;  //打开贪睡模式
//	}
//	else{
//		Spindex[index++] = GuanBi_SP;  //关闭贪睡模式
//		Spindex[index++] = TanShuiGongNeng_SP;  //关闭贪睡模式
//	}
//	SpCnt = index;
//	PlayList = 1;	
//}
//
///*
//[0]:家庭成员	[1]:的生日		[2]:月份十位    [3]:月份个位	 [4]:月		  
//[5]:日十位		[6]:日个位		[7]:日
//*/
//static void F_Birthday_Save(void)
//{
//	unsigned i;
//	if(UART_RxBuffer[5]==0)
//	{
//		Spindex[index++] = (FamilyStart_SP + UART_RxBuffer[4]);
//		Spindex[index++] = De_SP;	//的生日
//		Spindex[index++] = ShengRi_SP;	//的生日
//		Sorting_Number(0,UART_RxBuffer[6]);
//		Spindex[index++] = Yue_SP; //月
//		Sorting_Number(0,UART_RxBuffer[7]);
//		Spindex[index++] = Ri_SP;
//		SpCnt = index;
//		PlayList = 1;
//		Birthday[UART_RxBuffer[UART_RxBuffer[4]]][0] = UART_RxBuffer[6];
//		Birthday[UART_RxBuffer[UART_RxBuffer[4]]][1] = UART_RxBuffer[7];
//	}
//	else if(UART_RxBuffer[5]==1)
//	{
//		Spindex[index++] = (FamilyStart_SP + UART_RxBuffer[4]);
//		Spindex[index++] = De_SP;	//的生日
//		Spindex[index++] = ShengRi_SP;	//的生日
//		Sorting_Number(0,Birthday[UART_RxBuffer[4]][0]);
//		Spindex[index++] = Yue_SP; //月
//		Sorting_Number(0,Birthday[UART_RxBuffer[4]][1]);
//		Spindex[index++] = Ri_SP;
//		SpCnt = index;
//		PlayList = 1;
//	}
//	else if(UART_RxBuffer[5]==2)
//	{
//		if(UART_RxBuffer[4] != 0xFF)
//		{
//			Birthday[UART_RxBuffer[4]][0] = 0;
//			Birthday[UART_RxBuffer[4]][1] = 0;
//			Spindex[index++] = QingChu_SP;
//			Spindex[index++] = (FamilyStart_SP + UART_RxBuffer[4]);
//			Spindex[index++] = De_SP;	//的生日
//			Spindex[index++] = ShengRi_SP;	//的生日
//			SpCnt = index;
//			PlayList = 1;
//		}
//		else
//		{
//			for(i=0;i<14;i++)
//			{
//				Birthday[i][0]=0;
//				Birthday[i][1]=0;
//			}
//			Spindex[index++] = QingChu_SP;
//			Spindex[index++] = SuoYou_SP;
//			Spindex[index++] = ShengRi_SP;	//生日
//			SpCnt = index;
//			PlayList = 1;
//		}
//	}
//}
//
///*
//[0]:家庭成员	[1]:的生日是什么时候
//*/
//static void F_Birthday_Report(void)
//{
//	Spindex[index++] = (FamilyStart_SP + UART_RxBuffer[4]);
//	Spindex[index++] = De_SP;	//的生日
//	Spindex[index++] = ShengRi_SP;	//的生日
//	Spindex[index++] = Shi_SP;	//是
//	Sorting_Number(0,Birthday[UART_RxBuffer[UART_RxBuffer[4]]][0]);
//	Spindex[index++] = Yue_SP; //月
//	Sorting_Number(0,Birthday[UART_RxBuffer[UART_RxBuffer[4]]][1]);
//	Spindex[index++] = Ri_SP;
//	SpCnt = index;
//	PlayList = 1;
//}
//
///*
//[0]:今天		[1]:小时十位	[2]:小时个位	[3]:点
//[4]:分钟十位	[5]:分钟个位	[6]:分			[7]:提醒我
//*/
//static void F_Alarm_Remind_Today(void)
//{
//	Spindex[index++] = JinTian_SP; //今天
//	Sorting_Hour(&Spindex[index],UART_RxBuffer[4]);
//	Spindex[index++] = Dian_SP;	 //点
//	Sorting_Number(1,UART_RxBuffer[5]);
//	Spindex[index++] = Fen_SP; //分
//	Check_Time_ZD(index,UART_RxBuffer[5]);
//	Spindex[index++] = TiXing_SP;	//提醒我
//	SpCnt = index;
//	PlayList = 1;
//}
//
///*
//[0]:明天		[1]:小时十位	[2]:小时个位	[3]:点
//[4]:分钟十位	[5]:分钟个位	[6]:分			[7]:提醒我
//*/
//static void F_Alarm_Remind_Tomorrow(void)
//{
//	Spindex[index++] = MingTian_SP; //明天
//	Sorting_Hour(&Spindex[index],UART_RxBuffer[4]);
//	Spindex[index++] = Dian_SP;	 //点
//	Sorting_Number(1,UART_RxBuffer[5]);
//	Spindex[index++] = Fen_SP; //分
//	Check_Time_ZD(index,UART_RxBuffer[5]);
//	Spindex[index++] = TiXing_SP;	//提醒我
//	SpCnt = index;
//	PlayList = 1;
//}
//
//static void F_Alarm_Off_Today(void)
//{
//	Spindex[index++] = JinTian_SP;	//今天
//	Spindex[index++] = NaoZhong_SP;	//闹钟
//	Spindex[index++] = YiGuanBi_SP;	//已关闭
//	//Spindex[index++] = DontDistur_SP;	//闹钟勿打扰
//	SpCnt = index;
//	PlayList = 1;
//}
//
//static void F_Alarm_Off_Tomorrow(void)
//{
//	Spindex[index++] = MingTian_SP;	//明天
//	Spindex[index++] = NaoZhong_SP;	//闹钟
//	Spindex[index++] = YiGuanBi_SP;	//已关闭
//	//Spindex[index++] = DontDistur_SP;	//闹钟勿打扰
//	SpCnt = index;
//	PlayList = 1;
//}
//
static void F_WakeUp_Word(void)
{
	//Spindex[index++] = RespondStart_SP+ClockFnMap[CLOCK_TIME_SEC].get()%5;//YingDa1_SP + (seed % 3);	//
	Spindex[index++] = YingDa1_SP;
	SpCnt = index;
	PlayList = 1;
//唤醒的标志位
	CLOCK_FLAG_ASR = 1;	
	Voice_SendPlayCmd(Spindex[SpCnt-1]);
//	ClockFnMap[CLOCK_FLAG_ASR].set(1,0);
}
//
///*
//[0]:音量设置为/音量增加/音量减小	[1]:十位	[2]:个位	
//*/
//static void F_Volume_Level(void)
//{
//	if(UART_RxBuffer[4] < 32)
//	{
//		Spindex[index++] = SheZhi_SP;	//设置音量为
//		Spindex[index++] = YinLiang_SP;	//设置音量为
//		Spindex[index++] = Wei_SP;	//设置音量为
//		Sorting_Number(0,UART_RxBuffer[4]);
//		SpCnt = index;
//		PlayList = 1;
//	}
//	else if(UART_RxBuffer[4] == 40)
//	{
//		Spindex[index++] = YinLiang_SP;	//音量增加
//		Spindex[index++] = ZengDa_SP;	//音量增加
//		SpCnt = index;
//		PlayList = 1;
//	}
//	else if(UART_RxBuffer[4] == 41)
//	{
//		Spindex[index++] = YinLiang_SP;	//音量减小
//		Spindex[index++] = JianXiao_SP;	//音量减小
//		SpCnt = index;
//		PlayList = 1;
//	}
//}
//
//static void F_Power_On(void)
//{
//	if(UART_RxBuffer[4])
//		return;
//	Spindex[index++] = 0xFFFF;	//
//	SpCnt = index;
//	PlayList = 1;
//}
//#if 0
//void  (* const FunP[Function_Total])() = {
//	F_Set_Time,F_Set_Date,F_Set_Alarm,F_CountDown_Start,F_CountDown_Pause,
//	F_CountDown_Continue,F_CountDown_End,F_FQ_CountDown_Start,F_FQ_CountDown_End,F_Alarm_On_Off,
//	F_Alarm_Loop,F_Alarm_Music,F_Alarm_Snooze,F_Alarm_Stop,F_Display_On_Off,
//	F_Report_Time,F_Report_ZD_On_Off,F_Report_On_Off,F_Check_Alarm,F_Check_Date,
//	F_Check_Temp,F_CountUp_Start,F_Set_Snooze,F_Birthday_Save,F_Birthday_Report,
//	F_Alarm_Remind_Today,F_Alarm_Remind_Tomorrow,F_Alarm_Off_Today,F_Alarm_Off_Tomorrow,F_WakeUp_Word,
//	F_Volume_Level,F_Power_On,
//};			
//const unsigned FunArray[Function_Total] = {
//	Set_Time,Set_Date,Set_Alarm,CountDown_Start,CountDown_Pause,
//	CountDown_Continue,CountDown_End,FQ_CountDown_Start,FQ_CountDown_End,Alarm_On_Off,
//	Alarm_Loop,Alarm_Music,Alarm_Snooze,Alarm_Stop,Display_On_Off,
//	Report_Time,Report_ZD_On_Off,Report_On_Off,Check_Alarm,Check_Date,
//	Check_Temp,CountUp_Start,Set_Snooze,Birthday_Save,Birthday_Report,
//	Alarm_Remind_Today,Alarm_Remind_Tomorrow,Alarm_Off_Today,Alarm_Off_Tomorrow,WakeUp_Word,
//	Volume_Level,Power_On
//};
//#else
void  (* const FunP[Function_Total])() = {
//	F_Check_Date,
//	F_Report_Time,
//	F_Check_Alarm,
	F_Alarm_On_Off,
	F_Set_Time,
	F_Set_Date,
	F_Set_Alarm,
	F_Display_On_Off,
	F_CountDown_Start,
    F_CountDown_Pause,
    F_CountDown_Continue,
    F_CountDown_End,
//	F_Alarm_Snooze,
//	//F_Alarm_Stop,
	F_CountUp_Start,
	F_WakeUp_Word,
	F_Alarm_Loop,
};			
const unsigned FunArray[Function_Total] = {
//	Check_Date,
//	Report_Time,
//	Check_Alarm,
	Alarm_On_Off,
	Set_Time,
	Set_Date,
	Set_Alarm,
	Display_On_Off,
	CountDown_Start,
    CountDown_Pause,
    CountDown_Continue,
    CountDown_End,
//	Alarm_Snooze,
	//Alarm_Stop,
	CountUp_Start,
	WakeUp_Word,
	Alarm_Loop,
};

//#endif
void Check_UartData(void)
{
	unsigned i,j=0;
	if(R_UART_CNT >= 9)   //R_UARTRX_Status == 0 表示接收到数据 	if(Uart_EndFlag)
	{
		/* 播放状态回包和 ASR 命令共用 UART，这里先把状态帧单独摘出来。 */
		if ((UART_RxBuffer[0] == FRAME_HEADER_LO)
			&& (UART_RxBuffer[1] == FRAME_HEADER_HI)
			&& (UART_RxBuffer[2] == RESP_FIXED_BYTE)
			&& (UART_RxBuffer[3] == VOICE_CMD_STATUS)
			&& (UART_RxBuffer[8] == FRAME_TAIL))
		{
			g_voice_play_status = UART_RxBuffer[4];
			F_OnVoicePlayStatus();
			R_UART_CNT = 0;
			return;
		}
//		Rx_Length = UART_RxWritePtr;
		//帧头 帧尾检查通过
		if(UART_RxBuffer[0]==FRAME_HEADER_LO
		&& UART_RxBuffer[1]==FRAME_HEADER_HI 
		&& UART_RxBuffer[8]==FRAME_TAIL||(R_OtherFlag & D_Urat_Open) )//&& CheckAudioStatus() == 0)
		{
		 if(CLOCK_FLAG_ASR == 1){		
				if(UART_RxBuffer[2] == 0) //固定为零则通过
				{
					for(i=0;i<Function_Total;i++)
					{
						if(UART_RxBuffer[3] == FunArray[i])
						{
							j = 1;
							index = 0;
							FunP[i]();
							User_AsrTime = asrTime;
							//if(ClockFnMap[CLOCK_FLAG_SNOOZE].get())ClockFnMap[CLOCK_FLAG_SNOOZE].set(0,0);
							break;
						}
					}
					if(j){

					}
					else{
	//					GPCE3_HW_Uart_SendNByte(TX_DATA,Tx_Len);// 发送错误信息或默认响应
					}
				}
				else{
	//				GPCE3_HW_Uart_SendNByte(TX_DATA,Tx_Len);// 发送错误信息或默认响应
				}
			}
			else{
				if((UART_RxBuffer[2] == 0))//&&(ClockFnMap[CLOCK_FLAG_DC].get() == 1)) //固定为零且dc打开则通过
				{
					//for(i=0;i<Function_Total;i++)
					{
						if(UART_RxBuffer[3] == WakeUp_Word)
						{
							index = 0;
							F_WakeUp_Word();
							User_AsrTime = asrTime;	// 更新用户语音识别时间	
						}
						else
						{
	//						GPCE3_HW_Uart_SendNByte(TX_DATA,Tx_Len);
						}
					}
				}
				else{
	//				GPCE3_HW_Uart_SendNByte(TX_DATA,Tx_Len);
				}
			}
		}
		else{
		}
					R_UART_CNT = 0;
			}
	}	

/**
 * @brief 发送一个字节
 * @param data 要发送的字节
 */
void UART_SendByte(unsigned char data)
{
if (data != 0xFF) {	
    IsUARTBusy();
    P_WDT_Clear = 0x00;  // 喂狗
    P_UART_Data = data;
    }
}

///* 全局变量定义 */
//unsigned char g_current_status = PLAY_STATUS_STOPPED;
unsigned char g_current_volume = VOLUME_MID;
unsigned char g_play_mode = PLAY_MODE_ONCE;
/* 最近一次从语音模块得到的播放状态，供低电关机流程轮询。 */
unsigned char g_voice_play_status = PLAY_STATUS_STOPPED;

/* 发送语音指令帧的基础函数 */
static void Send_Voice_Cmd(unsigned char cmd, unsigned char param)
{
    UART_SendByte(FRAME_HEADER_HI);  // 0xA5
    UART_SendByte(FRAME_HEADER_LO);  // 0x5A
    UART_SendByte(cmd);
    UART_SendByte(param);
    UART_SendByte(FRAME_TRAILER);    // 0x55
}
/* 1. 指定曲目播放 */
void Voice_SendPlayCmd(unsigned char track)
{
    Send_Voice_Cmd(VOICE_CMD_PLAY, track);
	g_voice_play_status = PLAY_STATUS_PLAYING;
  	PlayList = 0;
}

/* 2. 指定音量值 */
void Voice_SendVolumeCmd(unsigned char volume)
{
    /* 音量范围限制 */
    if (volume > VOLUME_MAX) {
        volume = VOLUME_MID;
    }
    
    Send_Voice_Cmd(VOICE_CMD_VOLUME, volume);
    g_current_volume = volume;
}

/* 3. 播放模式设置 */
void Voice_SendModeCmd(unsigned char mode)
{
   if (mode != PLAY_MODE_ONCE && mode != PLAY_MODE_LOOP) {
       mode = PLAY_MODE_ONCE;  // 默认播放一次
   }
   
   Send_Voice_Cmd(VOICE_CMD_MODE, mode);
   g_play_mode = mode;
}
//
/* 4. 打断循环且停止播放 */
void Voice_SendStopControlCmd(void)
{
	Voice_SendModeCmd(PLAY_MODE_ONCE);
    Send_Voice_Cmd(VOICE_CMD_CONTROL, PLAY_CTRL_STOP);
	g_voice_play_status = PLAY_STATUS_STOPPED;
    
}
//}
//
///* 5. IO扩展口控制 */
//void Voice_SendIOCmd(unsigned char port, unsigned char level)
//{
//    if (port != IO_PORT_PA4 && port != IO_PORT_PA6) {
//        port = IO_PORT_PA4;  // 默认PA4
//    }
//    
//    if (level != IO_LEVEL_LOW && level != IO_LEVEL_HIGH) {
//        level = IO_LEVEL_LOW;  // 默认低电平
//    }
//    
//    Send_Voice_Cmd(port, level);
//}

/* 6. 播放状态查询 */
void Voice_SendStatusQuery(void)
{
	/* 低电报警场景会周期查询，直到语音模块返回停止状态。 */
	Send_Voice_Cmd(VOICE_CMD_STATUS, 0x00);
}

/* 7. 接着播 (连续播放多个曲目) */
void Voice_SendContinueCmd(unsigned char count, const unsigned char* tracks)
{
    unsigned char i;
    
    if (count == 0 || tracks == 0) {
        return;
    }
    
    // 发送帧头
    UART_SendByte(FRAME_HEADER_HI);  // 0xA5
    UART_SendByte(FRAME_HEADER_LO);  // 0x5A
    UART_SendByte(VOICE_CMD_CONTINUE); // 0x11
    UART_SendByte(count);             // 曲目数量
    
    // 发送曲目列表
    for ( i = 0; i < count; i++) {
        UART_SendByte(tracks[i]);
    }
    
    // 发送帧尾
    UART_SendByte(FRAME_TRAILER);  // 0x55
	g_voice_play_status = PLAY_STATUS_PLAYING;
    	PlayList = 0;

}


// 检查Timer_Start并发送播放状态查询
void CheckAndStartTimer(void)
{
	// 已移除基于 Timer_Start 的等待/查询逻辑，改为启动时直接设置计时标志
	// 原逻辑会向语音模块查询播放状态以等待播报结束后再真正启动计时，
	// 现在我们不再等待，因此此处保留为空。
}

// 播放状态检测回调（播放完毕时调用）
static void F_OnVoicePlayStatus(void)
{
    // status == 0 表示停止，1表示正在播放
    if (UART_RxBuffer[4] == 0)
    {
		// Timer_Start 机制已废弃：不再在语音播放结束回调中触发计时开始
		// 保留函数以便其它播放状态处理（若需扩展可在此处添加）
    }
}
/**
 * @brief  设置串口UI值并置位LCD更新标志位
 * @note   核心操作：
 *         1. 将D_UI_Time赋值给R_Uart_UI
 *         2. 置位RB_Lcd_Updata_Flag中的D_LcdUpdate位
 * @param  无（若需动态传值可扩展参数，见下方说明）
 * @retval 无
 */
void Set_UartUI_And_LcdUpdateFlag(void)
{
    // 1. 设置串口UI值
	 //   R_Uart_UI = 10;	//改为 65，比默认的 D_UI_Time (60) 大 5
      R_Uart_OpenTime = D_UI_Time;
    // 2. 置位LCD更新标志位（不影响其他位）
    RB_Lcd_Updata_Flag |= D_LcdUpdate;
}

/*
 * Play wake response phrase ("我在").
 * This wrapper calls the existing Voice_SendPlayCmd with the
 * predefined YingDa1_SP track index used for the wake response.
 */
void Play_Wake_Response(void)
{
	Voice_SendPlayCmd(YingDa1_SP);
}

/* Play a single voice ID (wrapper) */
void PlaySingle(unsigned char track)
{
	Voice_SendPlayCmd(track);
}

/* Play a sequence of voice IDs */
void PlaySequence(unsigned char count, const unsigned char* tracks)
{
	if (count == 0 || tracks == 0) return;
	Voice_SendContinueCmd(count, tracks);
}

/* Announce current date/time via voice sequence (简易实现) */
void AnnounceDateTime(void)
{
	unsigned char seq[8];
	unsigned char idx = 0;

	/* 简单示例："现在时刻" + hour + "点" + minute + "分" */
	seq[idx++] = XianZaiShiKe_SP;

	/* hours: use NumStart_Sp + hour (0-23) handling crude split */
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



/**
设置音量并播放闹铃1
参数 level: 0=小音量 1=中音量 2=大音量
 */
void SetVolumeAndPlayAlarm1(unsigned char level)
{
	if (SetVolumeAndPlayAlarm1_flag)
	{
	unsigned char volume = VOLUME_MID; // 默认中音量
	SetVolumeAndPlayAlarm1_flag = 0;
	if(level == 0) volume = VOLUME_LOW;      // 小音量
	else if(level == 2) volume = VOLUME_HIGH; // 大音量
	// 1为中音量
	Voice_SendVolumeCmd(volume); // 发送指定音量
	 Voice_SendModeCmd(PLAY_MODE_ONCE); // 播放一次
	// Voice_SendPlayCmd(Di001_2_SP); // 播放dd
	}
}

/**
检测按键音
*/
void F_CheckKeyTone(void)
{
	if(R_KeyFlag & D_KeyTone)
	{
		R_KeyFlag &= ~D_KeyTone;
		if(!(R_OtherFlag & D_ToneDIS))
		{
			Voice_SendPlayCmd(Di000_1_SP);
		}
	}
}

/**
如果是打开提示音就开，停止则停止闹铃
*/
void Play_AlarmMusic_Stop(void)
	{
		int currentAlarmSong = Di001_2_SP;//naolingStart_SP + R_CurrentSong; 		
    if ((R_OtherFlag & D_AlarmingStatus) && (R_OtherFlag & D_Alarming)) 
	{
		if ((R_VoiceFlag & D_OpenReady) == 0)
		{
			return;
		}

		Voice_SendModeCmd(PLAY_MODE_LOOP); // 先设置为单曲循环
		Voice_SendContinueCmd(1, &currentAlarmSong); // 传递临时变量的地址
		R_OtherFlag &= ~(D_TimeringStatus+D_AlarmingStatus);//+D_SetVolumeFlag); // 取消闹铃状态标志位
	}

	else if ((R_OtherFlag & D_TimeringStatus) && (R_OtherFlag & D_Alarming)) 
	{
		int currentTimerSong = Di001_2_SP;//naoling2_SP; 			
		if ((R_VoiceFlag & D_OpenReady) == 0)
		{
			return;
		}

		Voice_SendModeCmd(PLAY_MODE_LOOP); // 先设置为单曲循环
		Voice_SendContinueCmd(1, &currentTimerSong); // 传递临时变量的地址
		R_OtherFlag &= ~(D_TimeringStatus+D_AlarmingStatus);//+D_SetVolumeFlag); // 取消闹铃状态标志位
	}

//	else if (R_OtherFlag & D_SetVolumeFlag)
//	{
//		R_OtherFlag &= ~D_SetVolumeFlag; //  取消设置音量标志位
//		 Send_Voice_Cmd(VOICE_CMD_CONTROL, PLAY_CTRL_STOP);//  停止闹铃
//		Voice_SendModeCmd(PLAY_MODE_LOOP); // 先设置为单曲循环
//		Voice_SendContinueCmd(1, &currentAlarmSong); // 传递临时变量的地址
//	}
	else if (R_OtherFlag & D_ToneDIS) //  如果是提示音停止则停止闹铃
	{
		R_OtherFlag &= ~(D_ToneDIS+D_Alarming); //  取消提示音停止标志位
//		 R_OtherFlag &= ~D_Alarming; 
		Voice_SendStopControlCmd(); //  停止播放闹铃
	}
	}