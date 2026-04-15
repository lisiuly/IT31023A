;==========================================================================
; 文件名: ADC_user.inc
; 描述  : ADC 模块外部声明头文件，供其他汇编模块 .INCLUDE 使用
;==========================================================================
.EXTERN		ADC_Init
.EXTERN		_ADC_Init
.EXTERN		F_DC_Det
.EXTERN		_F_DC_Det

.EXTERN		R_ADC_VSS_MB
.EXTERN		_R_ADC_VSS_MB
.EXTERN		R_ADC_VSS_HB
.EXTERN		_R_ADC_VSS_HB
.EXTERN		R_ADC_LineIn_MB
.EXTERN		_R_ADC_LineIn_MB
.EXTERN		R_ADC_LineIn_HB
.EXTERN		_R_ADC_LineIn_HB
.EXTERN		R_ADC_VREF_MB
.EXTERN		_R_ADC_VREF_MB
.EXTERN		R_ADC_VREF_HB
.EXTERN		_R_ADC_VREF_HB
