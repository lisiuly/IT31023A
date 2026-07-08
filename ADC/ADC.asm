;==========================================================================
; 文件名: ADC.asm
; 描述  : 电池电压检测模块（6502 汇编）
;         使用 ADC 通过 PB7 采集分压后的电池电压（分压比 2:1），
;         VREF = 3.2V，VSS 零偏校准。
;         公式: voltage = ((LineIn - VSS) * 3.2V) / (0xFFF - VSS)
; 历史:
;   1.0  2026/04/01  初始版本（替换原 ADC.c）
;==========================================================================
;==========================================
; 编译器参数
;==========================================
.SYNTAX		6502
.LINKLIST
.SYMBOLS

;==========================================
; Include
;==========================================
.INCLUDE	GPL815P.inc
.INCLUDE	KEYSCAN\keyscan_user.inc
.INCLUDE	SYS\Macro.inc
;==========================================
; 常量定义
;==========================================
;--- 档位阈值（已减去 VSS 偏移后的 12-bit 值，VREF=3.2V，2:1 分压）---
; 3.8V -> PIN=1.9V -> (1900*4095/3200) = 2431 = 0x09_7F
; 3.6V -> PIN=1.8V -> (1800*4095/3200) = 2303 = 0x08_FF
; 3.4V -> PIN=1.7V -> (1700*4095/3200) = 2175 = 0x08_7F	;整体调高20H
C_ADC_Bat38V_HB		.EQU	09H		; >=3.8V 高字节
C_ADC_Bat38V_MB		.EQU	9FH;	7FH		; >=3.8V 低字节
C_ADC_Bat36V_HB		.EQU	09H	;	08H		; >=3.6V 高字节
C_ADC_Bat36V_MB		.EQU	1FH;	0FFH	; >=3.6V 低字节
C_ADC_Bat34V_HB		.EQU	08H		; >=3.4V 高字节
C_ADC_Bat34V_MB		.EQU	9FH;	7FH		; >=3.4V 低字节

;==========================================
; 导出声明
;==========================================
.PUBLIC		ADC_Init
.PUBLIC		_ADC_Init
.PUBLIC		F_DC_Det
.PUBLIC		_F_DC_Det

.PUBLIC		R_ADC_VSS_MB
.PUBLIC		_R_ADC_VSS_MB
.PUBLIC		R_ADC_VSS_HB
.PUBLIC		_R_ADC_VSS_HB
.PUBLIC		R_ADC_LineIn_MB
.PUBLIC		_R_ADC_LineIn_MB
.PUBLIC		R_ADC_LineIn_HB
.PUBLIC		_R_ADC_LineIn_HB
.PUBLIC		R_ADC_VREF_MB
.PUBLIC		_R_ADC_VREF_MB
.PUBLIC		R_ADC_VREF_HB
.PUBLIC		_R_ADC_VREF_HB

;==========================================
; 变量声明（PAGE0）
;==========================================
.PAGE0;ADC_RAM:	.section
R_ADC_VSS_MB:		.DS		1		; VSS 低 8bit（右移4位后）
_R_ADC_VSS_MB:		.EQU	R_ADC_VSS_MB
R_ADC_VSS_HB:		.DS		1		; VSS 高 4bit（右移4位后）
_R_ADC_VSS_HB:		.EQU	R_ADC_VSS_HB
R_ADC_LineIn_MB:	.DS		1		; PB7 低 8bit（右移4位后）
_R_ADC_LineIn_MB:	.EQU	R_ADC_LineIn_MB
R_ADC_LineIn_HB:	.DS		1		; PB7 高 4bit（右移4位后）
_R_ADC_LineIn_HB:	.EQU	R_ADC_LineIn_HB
R_ADC_VREF_MB:		.DS		1		; (0xFFF - VSS) 低 8bit
_R_ADC_VREF_MB:		.EQU	R_ADC_VREF_MB
R_ADC_VREF_HB:		.DS		1		; (0xFFF - VSS) 高 4bit
_R_ADC_VREF_HB:		.EQU	R_ADC_VREF_HB
R_ADC_DelayOuter:	.DS		1		; 延时外层计数
R_ADC_DelayInner:	.DS		1		; 延时内层计数

.ENDS
;==========================================
; 代码段（合并到默认CODE段，避免尾部空间不足）
;==========================================
.CODE	

;==========================================================================
; 子程序: F_ADC_Delay4ms
; 描述  : 软件延时约 4ms（基于 2MHz 系统时钟）
;         外8次 × 内200次 × 约5cycle = 8000 cycle ≈ 4ms
; 破坏  : R_ADC_DelayOuter, R_ADC_DelayInner
;==========================================================================
F_ADC_Delay4ms:
		LDA		#08H
		STA		R_ADC_DelayOuter
?L_DelayOuter:
		LDA		#0C8H			; 200次内层
		STA		R_ADC_DelayInner
?L_DelayInner:
		DEC		R_ADC_DelayInner
		BNE		?L_DelayInner
		DEC		R_ADC_DelayOuter
		BNE		?L_DelayOuter
		RTS

;==========================================================================
; 函数: ADC_Init / _ADC_Init
; 描述: 初始化 ADC 参考电压为 3.2V 并使能内部稳压器
; 调用: 系统上电后，主循环前调用一次
;==========================================================================
ADC_Init:
_ADC_Init:
		LDA		#D_ADCVregEn + D_ADCVreg3P2V
		STA		P_ADC_VREF_Ctrl
L_DCDet_Exit:
		RTS		
	

;==========================================================================
; 函数: F_DC_Det / _F_DC_Det
; 描述: 电池电压检测主函数
;       1. 采集 VSS（零偏校准）
;       2. 采集 PB7（经 2:1 分压的电池电压）
;       3. 公式换算后判断 3.8V / 3.6V / 3.4V 档位
;       4. 更新 R_LVDStatus, R_Charge, R_KeyFlag
; 调用: 主循环或定时器中周期性调用
;==========================================================================
F_DC_Det:
_F_DC_Det:
		;--- Guard: 关机态不检测 ---
		LDA		R_KeyFlag
		AND		#D_LCDOFF
		BNE		L_DCDet_Exit

		;--- Guard: 充电中不检测 ---
		LDA		R_Charge
		AND		#D_Charge
		BNE		L_DCDet_Exit

		;==================================================
		; 步骤1: 设置 VREF + VSS 预热转换 + Delay 4ms
		;==================================================
		LDA		#D_ADCVregEn + D_ADCVreg3P2V
		STA		P_ADC_VREF_Ctrl

		LDA		#D_ADCVSS + D_ADCEn + D_ADCStatus
		STA		P_ADC_Ctrl2

		LDA		#D_ADCClkDiv8 + D_ADCSHCycle16 + D_ADCTrigManual + D_ADCStart
		STA		P_ADC_Ctrl1

		JSR		F_ADC_Delay4ms

		;==================================================
		; 步骤2: 正式采样 VSS，存储数据
		;==================================================
		LDA		#80H
		STA		P_INT_ADC_Clear

		LDA		#D_ADCVSS + D_ADCEn + D_ADCStatus
		STA		P_ADC_Ctrl2

		LDA		#D_ADCClkDiv8 + D_ADCSHCycle16 + D_ADCTrigManual + D_ADCStart
		STA		P_ADC_Ctrl1

?L_ADC_VSSNorReady:
		STA		P_WDT_Clear
		LDA		P_ADC_Ctrl2
		AND		#D_ADCStatus
		BEQ		?L_ADC_VSSNorReady
?L_ADC_VSSNorEnd:
		LDA		#00H
		STA		P_ADC_Ctrl1
		LDA		#D_ADCStatus
		STA		P_ADC_Ctrl2

		LDA		#D_ADC_Flag
		STA		P_INT_Status3		; 清除 ADC 中断标志

		LDA		P_ADC_Data_LB
		STA		R_ADC_VSS_MB
		LDA		P_ADC_Data_HB
		STA		R_ADC_VSS_HB		; 保存 VSS 原始数据

		;==================================================
		; 步骤3: 切换 PB7 为 LineIn + Delay 4ms
		;==================================================
		LDA		#80H				; PB7 为 Line-in（ADC 输入）
		STA		P_IO_PB_LINEN_Ctrl

		LDA		#D_ADCStatus
		STA		P_ADC_Ctrl2
		LDA		#D_ADCPB7 + D_ADCEn
		STA		P_ADC_Ctrl2

		JSR		F_ADC_Delay4ms

		;==================================================
		; 步骤4: 正式采样 PB7，存储数据
		;==================================================
		LDA		#D_ADCPB7 + D_ADCEn
		STA		P_ADC_Ctrl2

		LDA		#D_ADCClkDiv4 + D_ADCSHCycle16 + D_ADCTrigManual + D_ADCStart
		STA		P_ADC_Ctrl1

?L_ADC_VSSNorReadypb:
		STA		P_WDT_Clear
		LDA		P_ADC_Ctrl2
		AND		#D_ADCStatus
		BEQ		?L_ADC_VSSNorReadypb

		LDA		#00H
		STA		P_ADC_Ctrl1
		LDA		#D_ADCStatus
		STA		P_ADC_Ctrl2

		LDA		#D_ADC_Flag
		STA		P_INT_Status3		; 清除 ADC 中断标志

		LDA		P_ADC_Data_LB
		STA		R_ADC_LineIn_MB
		LDA		P_ADC_Data_HB
		STA		R_ADC_LineIn_HB		; 保存 PB7 原始数据

		;==================================================
		; 步骤5: 数据为 bit15~bit4，统一右移 4bit
		;==================================================
		LSR		R_ADC_VSS_HB
		ROR		R_ADC_VSS_MB
		LSR		R_ADC_VSS_HB
		ROR		R_ADC_VSS_MB
		LSR		R_ADC_VSS_HB
		ROR		R_ADC_VSS_MB
		LSR		R_ADC_VSS_HB
		ROR		R_ADC_VSS_MB

		LSR		R_ADC_LineIn_HB
		ROR		R_ADC_LineIn_MB
		LSR		R_ADC_LineIn_HB
		ROR		R_ADC_LineIn_MB
		LSR		R_ADC_LineIn_HB
		ROR		R_ADC_LineIn_MB
		LSR		R_ADC_LineIn_HB
		ROR		R_ADC_LineIn_MB

		;==================================================
		; 步骤6: 按公式计算
		;   R_ADC_VREF  = 0x0FFF - R_ADC_VSS   (分母)
		;   R_ADC_LineIn = R_ADC_LineIn - R_ADC_VSS  (分子，零偏校正)
		; 注: 此处只做减法，档位判断直接对校正后 LineIn 做阈值比较
		;     (相当于在同一 VREF 坐标系下比较，无需完整乘除)
		;==================================================
		SEC
		LDA		#0FFH
		SBC		R_ADC_VSS_MB
		STA		R_ADC_VREF_MB
		LDA		#0FH
		SBC		R_ADC_VSS_HB
		STA		R_ADC_VREF_HB

		SEC
		LDA		R_ADC_LineIn_MB
		SBC		R_ADC_VSS_MB
		STA		R_ADC_LineIn_MB
		LDA		R_ADC_LineIn_HB
		SBC		R_ADC_VSS_HB
		STA		R_ADC_LineIn_HB

		;==================================================
		; 步骤7: 16位档位判断（先比高字节，再比低字节）
		; 阈值基于: VREF=3.2V, 2:1分压
		;   3.8V -> 0x097F, 3.6V -> 0x08FF, 3.4V -> 0x087F
		;==================================================

		;--- 判断是否 >= 3.8V ---
		LDA		R_ADC_LineIn_HB
		CMP		#C_ADC_Bat38V_HB
		BCC		?L_Check36V			; HB < 阈值，检查下一档
		BNE		?L_Bat_Level1		; HB > 阈值，确定 Level1
		LDA		R_ADC_LineIn_MB		; HB 相等，比较 MB
		CMP		#C_ADC_Bat38V_MB
		BCC		?L_Check36V
?L_Bat_Level1:
		LDA		#D_BatLevel1
		STA		R_LVDStatus
		%bitr	R_Charge, D_LowPower
		%bits	R_KeyFlag, D_UpdateBAT
		JMP		?L_DCDet_Exit

		;--- 判断是否 >= 3.6V ---
?L_Check36V:
		LDA		R_ADC_LineIn_HB
		CMP		#C_ADC_Bat36V_HB
		BCC		?L_Check34V
		BNE		?L_Bat_Level2
		LDA		R_ADC_LineIn_MB
		CMP		#C_ADC_Bat36V_MB
		BCC		?L_Check34V
?L_Bat_Level2:
		LDA		#D_BatLevel2
		STA		R_LVDStatus
		%bitr	R_Charge, D_LowPower
		%bits	R_KeyFlag, D_UpdateBAT
		JMP		?L_DCDet_Exit

		;--- 判断是否 >= 3.4V ---
?L_Check34V:
		LDA		R_ADC_LineIn_HB
		CMP		#C_ADC_Bat34V_HB
		BCC		?L_Bat_LowPower
		BNE		?L_Bat_Level3
		LDA		R_ADC_LineIn_MB
		CMP		#C_ADC_Bat34V_MB
		BCC		?L_Bat_LowPower
?L_Bat_Level3:
		LDA		#D_BatLevel3
		STA		R_LVDStatus
		%bitr	R_Charge, D_LowPower
		%bits	R_KeyFlag, D_UpdateBAT
		JMP		?L_DCDet_Exit

		;--- 低于 3.4V，低电标志 ---
?L_Bat_LowPower:
		LDA		#00H
		STA		R_LVDStatus
		%bits	R_Charge, D_LowPower
		%bits	R_KeyFlag, D_UpdateBAT

?L_DCDet_Exit:
		RTS

.ENDS

