#ifndef _TIMER_H
#define _TIMER_H

// 背光控制变量声明
extern unsigned char R_BacklightLevel; // 背光档位
//extern unsigned char R_BacklightFlag;  // 背光开关标志
extern unsigned char R_CurrentBrightness; // 当前实际PWM值

// PWM背光函数声明
void PWM_Backlight_Init(void);
void PWM_SetBrightness(unsigned char brightness);
void F_Backlight_Process(void); // 背光处理函数
//void F_Backlight_Sleep(void); // 睡眠前背光处理

// 函数声明
extern	void allocate_segments(unsigned char minutes);
//extern	void update_progress_ring(void);
extern	void F_TimerUpdate(void);
extern	void F_ForwardTimer(void);
extern	void F_CountdownTimer(void);
//extern	void CheckAndStartCountdown(void);
extern	void F_Calc12Icon(void); 



#endif