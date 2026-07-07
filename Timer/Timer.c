#include "GPL815P.h"
#include "calendar\calendar.h"
#include "KEYSCAN\key_user.h"
#include "lcd\lcd_user.h"
#include "timer.h"  // 包含我们自己的头文件


// 全局变量定义（如果尚未在别处定义，需要添加）
//unsigned char R_TotalMinutes = 0;  // 倒计时总分钟数
//unsigned char R_TimerMinuteSet = 0;  // 设置的分钟
extern	unsigned char	R_IconCount;
// 标志位定义
#define D_Timerstatus_just 0x01  // 正计时运行标志位
#define D_Timerstatus      0x02  // 倒计时运行标志位


// 正向计时函数（每次调用增加1秒）
void F_ForwardTimer(void) {
    // 检查是否正在正计时
    if (!(R_TimerFlag & D_Timerstatus_just)) {
        return;
    }
    // 检查时间是否为0
    if (R_TimerMinute == 60 && R_TimerSecond ==00) {
        // 正计时结束
	   	Voice_PowerOn_Noxiaonao();//电源	
//    	P_IO_PortA_Data &= ~0x20;	//bit5 拉DI	

        R_TimerFlag &= ~D_Timerstatus_just;  // 清除正计时标志
        R_SnoozeTime = C_SnoozeTime1min;  // 设置响闹时间为1分钟
        R_OtherFlag &= ~(D_ToneDIS+D_EnableSnooze+D_Alarming);
        R_OtherFlag &= ~D_ToneDIS;
        R_OtherFlag |= (D_Alarming+D_TimeringStatus+D_Timering);      
        
        return;
    }    
    // 秒数加1
    R_TimerSecond++;
 	RB_Lcd_Updata_Flag |= D_LcdUpdate;   
    // 处理进位
    if (R_TimerSecond >= 60) {
        R_TimerSecond = 0;
        R_TimerMinute++;
        
    }
}

// 倒计时函数（每次调用减少1秒）
void F_CountdownTimer(void) {
    // 检查是否正在倒计时
    if (!(R_TimerFlag & D_Timerstatus)) {
        return;
    }
    
    // 检查时间是否为0
    if (R_TimerMinute == 0 && R_TimerSecond == 0) {
        // 倒计时结束
    	Voice_PowerOn_Noxiaonao();
//    	P_IO_PortA_Data &= ~0x20;	//bit5 拉DI	
        R_TimerFlag &= ~D_Timerstatus;  // 清除倒计时标志
        R_SnoozeTime = C_SnoozeTime1min;  // 设置响闹时间为1分钟
        R_OtherFlag &= ~(D_ToneDIS+D_EnableSnooze+D_Alarming);
        R_OtherFlag |= (D_Alarming+D_TimeringStatus+D_Timering);        
        return;
    }
    	RB_Lcd_Updata_Flag |= D_LcdUpdate;
    // 秒数减1
    if (R_TimerSecond > 0) {
        R_TimerSecond--;
    } else {
        // 借位
        R_TimerSecond = 59;
        if (R_TimerMinute > 0) {
            R_TimerMinute--;
        }
    }
}

// 计时器控制函数（在F_SecondRTC中调用）
void F_TimerUpdate(void) {
    // 检查是否在正计时
//    if (R_TimerFlag & D_Timerstatus_just) {
        F_ForwardTimer();
//    }
//    // 检查是否在倒计时
//    else if (R_TimerFlag & D_Timerstatus) {
        F_CountdownTimer();
//    }
}

// PWM背光控制相关代码

// 背光控制变量
unsigned char R_BacklightLevel = 1; // 背光档位: 0=灭, 1=弱, 2=中, 3=强
unsigned char R_CurrentBrightness = 255; // 当前实际PWM值，初始化为255以强制同步关闭

// 常量映射（避免硬编码与反向计算错误）
static const unsigned char kBacklightBrightness[4] = {0, 76, 153, 255};   // 1->30%,2->60%,3->100%
static const unsigned char kBacklightSleepBrightness[4] = {0, 13, 28, 43}; // 1->5%,2->11%,3->17%

static unsigned char Get_Backlight_Target(void)
{
   const unsigned char level = (R_BacklightLevel >= 1 && R_BacklightLevel <= 3) 
                                ? R_BacklightLevel : 3;
    
    // PA5为低电平时保持亮度，变高后恢复休眠
    return ((P_IO_PortA_Data & 0x20) == 0) 
           ? kBacklightBrightness[level] 
           : kBacklightSleepBrightness[level];
}

/**
 * @brief 初始化 PA1 为 PWM 背光输出 (优化方案)
 * 
 * 硬件配置:
 * - 时钟源: System Clock / 8 (2.048MHz / 8 = 256kHz)
 * - 周期: 256 (256kHz / 256 = 1kHz PWM频率)
 * - 引脚: PA1 (PWMIO1)
 */
void PWM_Backlight_Init(void)
{
    // 1. 配置 PA1 为输出模式
    P_IO_PortA_Dir |= 0x02;      // PA1 方向输出
    P_IO_PortA_Data &= ~0x02;    // 确保 PA1 数据位为0，防止PWM极性反转
	F_KeepPA3InputPulldown();

    // 2. 选择 PWMIO1 映射到 IOA1 (PA1)
    // P_PWMIO_Sel [3:2] = 01
    P_PWMIO_Sel &= ~(0x03 << 2); // 清除旧值
    P_PWMIO_Sel |= (0x01 << 2);  // 设置为 01 (IOA1)

    // 3. 设置 PWM 周期 (分辨率)
    // 目标 1kHz，源时钟 256kHz -> 256kHz / 256 = 1kHz
    P_PWMIO_Timer_Data = 255; 

    // // 4. 初始化亮度为 100% (满占空比)
    // P_PWMIO_IO1_DUTY = 255;

    // 5. 先只配置 PWM 时钟，不立即使能输出
    // 避免沿用旧 duty 导致首次输出出现反相/毛刺
    // CLKSEL [6:4] = 001 (System Clock / 8)
    P_PWMIO_Ctrl &= 0x80; // 清除低7位 (保留Bit7 Reserved)
    P_PWMIO_Ctrl |= (0x01 << 4);
}

/**
 * @brief 设置背光亮度
 * @param brightness 0~255 (0=灭, 255=最亮)
 */
void PWM_SetBrightness(unsigned char brightness)
{
    P_PWMIO_IO1_DUTY = brightness;
}

/**
 * @brief 背光处理函数 (主循环调用)
 * 
 * 逻辑:
 * 1. 检查 R_BacklightFlag 标志位
 * 2. 如果为1(开)，根据 R_BacklightLevel 设置亮度（强/中/弱）
 * 3. 如果为0(关)，设置休眠最低亮度（避免熄灭）
 * 
 * 档位定义 (R_BacklightLevel):
 * 1: 弱光 (30% -> ~76)
 * 2: 中光 (60% -> ~153)
 * 3: 强光 (100% -> 255)
 */
void F_Backlight_Process(void)
{
    if((R_KeyFlag & D_LCDOFF) == 0)
	{
    unsigned char target_brightness = Get_Backlight_Target();

    // 只有当背光亮度实际变化时才写硬件，避免 PWM 频繁切换
    if (R_CurrentBrightness != target_brightness)
    {
        // 目标亮度>0且PWM模块未使能时，初始化PWM
        // 避免每次计时/按键触发时反复重设硬件
        if (target_brightness > 0 && (P_PWMIO_Ctrl & D_PWMIO1En) == 0)
        {
            PWM_Backlight_Init();
        }

        // 如果要点亮（含睡眠暗光），确保 PA1输出低起始，避免反相、漏光
        if (target_brightness > 0)
        {
            P_IO_PortA_Data &= ~(0x01 << 1);
			F_KeepPA3InputPulldown();
        }
        PWM_SetBrightness(target_brightness);
        if (target_brightness > 0)
        {
            P_PWMIO_Ctrl |= D_PWMIO1En;  // duty 就位后再启用 PWM1，避免首次反相
        }
        R_CurrentBrightness = target_brightness;
//
//        // 如果目标是关闭，则禁用PWM并拉低IO
//        if (target_brightness == 0)
//        {
//            P_PWMIO_Ctrl &= ~D_PWMIO1En; // 禁用PWM模块
//            P_IO_PortA_Data &= ~0x02;    // 手动拉低 PA1
//        }
    }
	}


}

//void F_Backlight_Sleep(void)
//{
//    R_BacklightFlag = 0;
//    R_CurrentBrightness = 0; // 标记为关闭状态，以便唤醒时若Flag=1能重新初始化
//}
//
// /**
//  * @brief 按下开始按钮时的分配函数
//  * 
//  * 这个函数在用户按下开始倒计时按钮时调用，它会：
//  * 1. 保存总时间
//  * 2. 设置计时器时间为用户指定的分钟数
//  * 3. 设置R_POINT为全显（32格）
//  * 4. 设置倒计时标志位
//  * 
//  * @param minutes 设置的倒计时分钟数（1-99）
//  */
// void allocate_segments(unsigned char R_TimerMinute)
// {
//     if (R_TimerMinute < 1 || R_TimerMinute > 99) {
//         // 输入参数检查
//         return;
//     }
    
//     // 1. 保存总时间
//     R_TotalMinutes = R_TimerMinute;  // 保存当前设置的时间作为总时间
    
//     // 2. 保存设置值
//     R_TimerMinuteSet = R_TimerMinute;
//     R_TimerSecondSet = 0;
    
//     // 3. 设置进度环为全显状态（32/32格）
//     R_POINT = 31;  // 初始全满
    
//     // 4. 清除正计时标志，设置倒计时标志
//     R_TimerFlag &= ~D_Timerstatus_just;  // 清除正计时标志
//     R_TimerFlag |= D_Timerstatus;        // 设置倒计时标志
// }
// /**
//  * @brief 检测并处理开始倒计时标志位
//  * 
//  * 这个函数在主循环中轮询调用，检测到TIMER_START_FLAG标志位时
//  * 调用分配函数，并清除标志位
//  */
// void CheckAndStartCountdown(void)
// {
//     // 检查是否设置了开始倒计时标志位
//     if (R_TimerFlag & TIMER_START_FLAG) 
//     {
//         // 调用分配函数
//         allocate_segments(R_TimerMinute);
        
//         // 清除开始倒计时标志位
//         R_TimerFlag &= ~TIMER_START_FLAG;
//     }
// }
// /**
//  * @brief 更新进度环函数
//  * 
//  * 这个函数每半秒调用一次，它会：
//  * 1. 检查倒计时是否正在运行，如果不是则直接退出
//  * 2. 根据剩余时间比例计算应显示的格子数
//  * 3. 更新R_POINT（从32逐渐减少到0）
//  * 4. 倒计时结束时设置R_POINT为0
//  */
// void update_progress_ring(void)
// {
//    unsigned int remaining_seconds = 0;
//     unsigned int total_seconds = 0;
//     unsigned long scaled_value = 0;
//     unsigned char target = 0;
//     // 1. 检查倒计时是否正在运行，如果不是则直接退出
//     if (!(R_TimerFlag & D_Timerstatus)) {
//         return;  // 倒计时不在运行，直接退出
//     }
    
//     // 2. 计算剩余总秒数
//    remaining_seconds = R_TimerMinute * 60 + R_TimerSecond;
    
//     // 3. 计算进度环应该显示的格子数
//     if (remaining_seconds > 0) {
//         // 计算剩余时间比例对应的格子数
//         unsigned int total_seconds = R_TotalMinutes * 60;
        
//         if (total_seconds > 0) {
//             // 使用整数计算
//             unsigned long scaled_value = (unsigned long)remaining_seconds * 32;
//             unsigned char target = (unsigned char)(scaled_value / total_seconds);
            
//             // 四舍五入
//             if ((scaled_value % total_seconds) * 2 >= total_seconds) {
//                 target++;
//             }
            
//             // 边界检查
//             if (target > 31) {
//                 target = 31;
//             }
            
//             // 确保剩余时间大于0时，至少显示1格
//             if (remaining_seconds > 0 && target == 0) {
//                 target = 1;
//             }
            
//             // 更新R_POINT
//             R_POINT = target;
// 		RB_Lcd_Updata_Flag |= D_LcdUpdate;     
//         }
//     } 
//     // 4. 剩余时间为0，倒计时结束
//     else if (remaining_seconds == 0) {
//         // 倒计时结束
//         R_POINT = 0;  // 进度环为0
// 		RB_Lcd_Updata_Flag |= D_LcdUpdate;             	
        
//         // 清除倒计时标志
// //        R_TimerFlag &= ~D_Timerstatus;
//     }
// }

// 计算显示图标数量的函数
// 根据分钟数除以5计算
void F_Calc12Icon(void) {
    R_IconCount = R_TimerMinute / 5;

}	

