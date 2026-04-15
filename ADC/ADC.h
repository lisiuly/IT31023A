//==============================================================================
// 文件名: battery_monitor.h
// 描述: 电池电压检测模块头文件
//       使用 ADC 通过 PB7 采集分压后的电池电压（分压比 2:1），
//       直接根据校准后的 ADC 原始值判断 3.4V / 3.6V / 3.8V 档位。
// 依赖: 芯片头文件（如 815.h）需定义 ADC 相关寄存器及宏
//==============================================================================

#ifndef BATTERY_MONITOR_H
#define BATTERY_MONITOR_H
//
//// 电池档位值（根据原汇编定义，请根据实际修改）
//#define D_BatLevel1   0x01   // 高电量（≥3.8V）
//#define D_BatLevel2   0x02   // 中电量（≥3.6V）
//#define D_BatLevel3   0x04   // 低电量（≥3.4V）
//
//// 先按理论值给出默认阈值，后续可直接替换成 3.4V/3.6V/3.8V 的实测 ADC 值
//#define ADC_BAT_LEVEL1_THRESHOLD  3983
//#define ADC_BAT_LEVEL2_THRESHOLD  3766
//#define ADC_BAT_LEVEL3_THRESHOLD  3555
//
//// 调试观测值：便于在调试器里直接看原始采样结果并回填阈值
//extern unsigned int G_ADC_LastVssValue;
//extern unsigned int G_ADC_LastPb7Value;
//extern unsigned int G_ADC_LastStablePb7Value;
//
//------------------------------------------------------------------------------
// 函数原型
//------------------------------------------------------------------------------

/**
 * @brief 初始化 ADC 模块（参考电压 2.0V，PB7 为模拟输入，手动触发）
 * @note  应在系统上电后、主循环前调用一次
 */
extern void ADC_Init(void);

/**
 * @brief 电池电压检测主函数（替换原汇编的 F_DC_Det）
 * @note  周期性调用，采集 PB7 校准后的 ADC 原始值，
 *        判断档位并更新 R_LVDStatus、R_Charge、R_KeyFlag
 */
extern void F_DC_Det(void);


#endif // BATTERY_MONITOR_H