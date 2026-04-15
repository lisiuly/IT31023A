	.IFDEF		GPL815_SERIES

;---------------------------------
GPL815P02Ax		.EQU		1
;---------------------------------

.ifndef GPL815P_Body_inc
GPL815P_Body_inc:    .EQU    1
;==================================================================================
; The information contained herein is the exclusive property of
; Generalplus Technology Co. And shall not be distributed, reproduced,
; or disclosed in whole in part without prior written permission.
;       (C) COPYRIGHT 2014   Generalplus TECHNOLOGY CO.                            
;                   ALL RIGHTS RESERVED
; The entire notice above must be reproduced on all authorized copies.
;==================================================================================
;==================================================================================
; Program Name: GPL815P series register declare
; Applied body:  
; Programmer  : Frank Kung
; Description : 
;             : V0.1
; History version
; Rev #  Date         Who         Comments
; -----  -----------  --------    ---------------------------------------------------
; 0.1    2024/08/19   Frank Kung    release
; 0.2    2025/03/31   Frank Kung    Add Body :   GPL815P02Ax
;==================================================================================
;==================================================================================

P_System_Ctrl_Base:                     .EQU    $3000
P_IO_Ctrl_Base:                         .EQU    $3080
P_INT_Ctrl_Base:                        .EQU    $30C0
P_TIMER_Ctrl_Base:                      .EQU    $3110
P_UART_Ctrl_Base:						.EQU	$3150
P_SPI_Ctrl_Base:                        .EQU    $3180
P_SWT_Ctrl_Base:                        .EQU    $3200
P_ADC_Ctrl_Base:                        .EQU    $3340 
P_I2C_Ctrl_Base:                        .EQU    $3360 
P_Buzzer_Ctrl_Base:						.EQU    $3371
P_AUX_Ctrl_Base:                        .EQU    $33D0
P_LCD_Ctrl_Base:                        .EQU    $3450
P_PWMIO_Ctrl_Base:                      .EQU    $3490
P_RFC_Ctrl_Base:						.EQU	$34C0


    .IFNDEF GPL815P04Ax
    GPL815P04Ax: .EQU    0
    .ENDIF 
    
    .IFNDEF GPL815P04Ax_16KB
    GPL815P04Ax_16KB: .EQU    0
    .ENDIF     
    
    .IFNDEF GPL815P04Bx
    GPL815P04Bx: .EQU    0
    .ENDIF    
    
    .IFNDEF GPL815P04Bx_15KB
    GPL815P04Bx_15KB: .EQU    0
    .ENDIF         
    
    .IFNDEF GPL815P03Ax
    GPL815P03Ax: .EQU    0
    .ENDIF     
      
    .IFNDEF GPL815P03Bx
    GPL815P03Bx: .EQU    0
    .ENDIF   
    
    .IFNDEF GPL815P02Ax
    GPL815P02Ax: .EQU    0
    .ENDIF       

    
.IF (GPL815P04Ax+GPL815P04Ax_16KB+GPL815P04Bx+GPL815P04Bx_15KB+GPL815P03Ax+GPL815P03Bx+GPL815P02Ax)
GPL815P      .EQU    1
.ENDIF

	.IFDEF GPL815P
;===============================================================
;               System base Control Registers
;               Base Address Start from 0x3000 
;===============================================================
;==============  BANK Register  =============
P_BANK_Sel:                     .EQU    P_System_Ctrl_Base+0x00 ;$0x3000

;==========  CPU & Clock Register  ==========
P_CLK_IOSC_Ctrl:                 .EQU    P_System_Ctrl_Base+0x07 ;$0x3007
	D_CPUSysClkDiv1:				.EQU	00000000B
	D_CPUSysClkDiv2:				.EQU	00000001B
	D_CPUSysClkDiv4:				.EQU	00000010B
	D_CPUSysClkDiv8:				.EQU	00000011B
	D_SYS32K:						.EQU	00000000B
	D_SYS2M:						.EQU	00010000B
	D_SYS4M:						.EQU	00100000B
	D_SYS8M:						.EQU	00110000B	
	
P_SLP_Ctrl:						.EQU    P_System_Ctrl_Base+0x09 ;$0x3009
	D_SleepMode:					.EQU	01011010B
	D_GreenMode:					.EQU	10100101B
	
;================  LVD Ctrl  ================
P_LVD_Ctrl:                     .EQU    P_System_Ctrl_Base+0x0A ;$0x300A
	D_LVDEn:						.EQU	10000000B
	D_LVDStatus:					.EQU	00100000B
	D_LVD2P1V:						.EQU	00000000B	
	D_LVD2P4V:						.EQU	00000001B	
	D_LVD3P0V:						.EQU	00000010B	
	D_LVD3P3V:						.EQU	00000011B	
	D_LVDLevelMask:					.EQU	00000011B	
		
;===========  Watch Dog Register  ===========
P_WDT_Clear:					.EQU    P_System_Ctrl_Base+0x0B ;$0x300B

;=============  Reset Register  =============
P_RESET_Ctrl:					.EQU    P_System_Ctrl_Base+0x0C ;$0x300C
	D_LVRResetEn:					.EQU	00000001B
	D_IllegalAddrResetEn:			.EQU	00000010B
	D_SWResetEn:					.EQU	00000100B
	D_WDTResetEn:					.EQU	00001000B	
	
P_RESET_Status:					.EQU    P_System_Ctrl_Base+0x0D ;$0x300D
	D_LVRResetFlag:					.EQU	00000001B
	D_IllegalAddrResetFlag:			.EQU	00000010B
	D_SWResetFlag:					.EQU	00000100B
	D_WDTResetFlag:					.EQU	00001000B
	

;===============================================================
;               IO base Control Registers
;               Base Address Start from 0x3080 
;=============================================================== 
;===============  IO Register  ==============
P_IO_Ctrl1:                      .EQU    P_IO_Ctrl_Base+0x00     ;$0x3080
	D_IRDuty2:						.EQU	00000000B
	D_IRDuty3:						.EQU	00000010B
	D_IRDuty4:						.EQU	00000100B
	D_IRDuty5:						.EQU	00000110B	
	D_IREn:							.EQU	00001000B
	D_ExtI1Edge:					.EQU	00010000B
	D_ExtI1En:						.EQU	00100000B
	D_ExtI2Edge:					.EQU	01000000B
	D_ExtI2En:						.EQU	10000000B
	
P_IO_Ctrl2:                      .EQU    P_IO_Ctrl_Base+0x01     ;$0x3081
	D_RFC1En:						.EQU	00000001B
	D_RFC2En:						.EQU	00000010B	
	D_RFC1OutEn:					.EQU	00000100B
	D_RFC2OutEn:					.EQU	00001000B
	D_PA32KOutEn:					.EQU	01000000B
	D_PD32KOutEn:					.EQU	10000000B
	
P_IO_RFC_Ctrl:                   .EQU    P_IO_Ctrl_Base+0x02     ;$0x3082
	D_REF2En:						.EQU	00000001B
	D_SEN2AEn:						.EQU	00000010B
	D_SEN2BEn:						.EQU	00001000B	
	D_REF1En:						.EQU	00010000B
	D_SEN1AEn:						.EQU	00100000B
	D_SEN1BEn:						.EQU	10000000B
	
P_IO_LCDPORT_Ctrl:              .EQU    P_IO_Ctrl_Base+0x03     ;$0x3083
	D_PCEn:							.EQU	00000001B	
	D_PDEn:							.EQU	00000010B
	D_PEEn:							.EQU	00000100B
	D_ShiftSeg0:					.EQU	00000000B
	D_ShiftSeg8:					.EQU	00010000B
	D_ShiftSeg16:					.EQU	00100000B
	D_ShiftSeg24:					.EQU	00110000B	
		
P_IO_KeyChange_Ctrl1:           .EQU    P_IO_Ctrl_Base+0x04     ;$0x3084
P_IO_KeyChange_Ctrl2:           .EQU    P_IO_Ctrl_Base+0x05     ;$0x3085

P_IO_PB_LINEN_Ctrl:				.EQU    P_IO_Ctrl_Base+0x06     ;$0x3086

P_IO_PortA_Dir:                 .EQU    P_IO_Ctrl_Base+0x08     ;$0x3088
P_IO_PortA_Attrib:              .EQU    P_IO_Ctrl_Base+0x09     ;$0x3089
P_IO_PortA_Data:                .EQU    P_IO_Ctrl_Base+0x0A     ;$0x308A
P_IO_PortA_Buffer:              .EQU    P_IO_Ctrl_Base+0x0B     ;$0x308B
P_IO_PortA_SMT_En:				.EQU    P_IO_Ctrl_Base+0x0C     ;$0x308C

P_IO_PortB_Dir:                 .EQU    P_IO_Ctrl_Base+0x10     ;$0x3090
P_IO_PortB_Attrib:              .EQU    P_IO_Ctrl_Base+0x11     ;$0x3091
P_IO_PortB_Data:                .EQU    P_IO_Ctrl_Base+0x12     ;$0x3092
P_IO_PortB_Buffer:              .EQU    P_IO_Ctrl_Base+0x13     ;$0x3093
P_IO_PortB_SMT_En:				.EQU    P_IO_Ctrl_Base+0x14     ;$0x3094
	
P_IO_PortC_Dir:                 .EQU    P_IO_Ctrl_Base+0x18     ;$0x3098
P_IO_PortC_Attrib:              .EQU    P_IO_Ctrl_Base+0x19     ;$0x3099
P_IO_PortC_Data:                .EQU    P_IO_Ctrl_Base+0x1A     ;$0x309A
P_IO_PortC_Buffer:              .EQU    P_IO_Ctrl_Base+0x1B     ;$0x309B
P_IO_PortC_SMT_En:				.EQU    P_IO_Ctrl_Base+0x1C     ;$0x309C

P_IO_PortD_Dir:                 .EQU    P_IO_Ctrl_Base+0x20     ;$0x30A0
P_IO_PortD_Attrib:              .EQU    P_IO_Ctrl_Base+0x21     ;$0x30A1
P_IO_PortD_Data:                .EQU    P_IO_Ctrl_Base+0x22     ;$0x30A2
P_IO_PortD_Buffer:              .EQU    P_IO_Ctrl_Base+0x23     ;$0x30A3
P_IO_PortD_SMT_En:				.EQU    P_IO_Ctrl_Base+0x24     ;$0x30A4

P_IO_PortE_Dir:                 .EQU    P_IO_Ctrl_Base+0x28     ;$0x30A8
P_IO_PortE_Attrib:              .EQU    P_IO_Ctrl_Base+0x29     ;$0x30A9
P_IO_PortE_Data:                .EQU    P_IO_Ctrl_Base+0x2A     ;$0x30AA
P_IO_PortE_Buffer:              .EQU    P_IO_Ctrl_Base+0x2B     ;$0x30AB
P_IO_PortE_SMT_En:				.EQU    P_IO_Ctrl_Base+0x2C     ;$0x30AC
	

P_IO_Ctrl3:                     .EQU    P_IO_Ctrl_Base+0x30     ;$0x30B0
	D_PFEn:							.EQU	00000001B
	D_PGEn:							.EQU	00000010B

P_IO_PortF_Buffer:				.EQU    P_IO_Ctrl_Base+0x31     ;$0x30B1
P_IO_PortG_Buffer:				.EQU    P_IO_Ctrl_Base+0x32     ;$0x30B2	
;===============================================================
;               Interrupt base Control Registers
;               Base Address Start from 0x30C0 
;=============================================================== 
;============  INT/NMI Register  ============
P_NMI_Ctrl:                     .EQU    P_INT_Ctrl_Base+0x00    ;$0x30C0 
	D_LVDNMIEn:						.EQU	00000001B
	D_TM1NMIEn:						.EQU	00000010B
	D_TM0NMIEn:						.EQU	00000100B	
	D_ILLADRNMIEn:					.EQU	00010000B
	
P_NMI_Status:                   .EQU    P_INT_Ctrl_Base+0x01    ;$0x30C1
	D_LVDNMIFlag:						.EQU	00000001B
	D_TM1NMIFlag:						.EQU	00000010B
	D_TM0NMIFlag:						.EQU	00000100B	
	D_ILLADRNMIFlag:					.EQU	00010000B	
	
P_INT_Ctrl1:                    .EQU    P_INT_Ctrl_Base+0x02    ;$0x30C2
	D_FPIntEn:						.EQU	00000001B
	D_SPIInt_En:					.EQU	00000010B
	D_TM0IntEn:						.EQU	10000000B	
	
P_INT_Ctrl2:                    .EQU    P_INT_Ctrl_Base+0x03    ;$0x30C3   
	D_ExtI1IntEn:					.EQU	00000001B	
	D_ExtI2IntEn:					.EQU	00000010B
	D_TBLIntEn:						.EQU	00000100B
	D_TBHIntEn:						.EQU	00001000B	
	D_KeyIntEn:						.EQU	00010000B		
	D_TM1IntEn:						.EQU	00100000B
	D_RFCTM0IntEn:					.EQU	01000000B
	D_RFCTM1IntEn:					.EQU	10000000B
		
P_INT_Ctrl3:                    .EQU    P_INT_Ctrl_Base+0x04    ;$0x30C4 
	D_LVDIntEn:						.EQU	00000001B	
	D_ADCIntEn:						.EQU	00000010B
	D_UARTIntEn:					.EQU	00000100B
	D_SWTIntEn:						.EQU	00001000B
	D_I2CIntEn:						.EQU	00010000B
	D_PWMTMIntEn:					.EQU	00100000B
	D_CaptureIntEn:					.EQU	01000000B	
	
P_INT_Status1:            		.EQU    P_INT_Ctrl_Base+0x0A    ;$0x30CA 
	D_FP_Flag:						.EQU	00000001B
	D_SPI_Flag:						.EQU	00000010B
	D_TM0_Flag:						.EQU	10000000B	
	
P_INT_Status2:            		.EQU    P_INT_Ctrl_Base+0x0B    ;$0x30CB
	D_EXT1_Flag:					.EQU	00000001B
	D_EXT2_Flag:					.EQU	00000010B
	D_TBL_Flag:						.EQU	00000100B
	D_TBH_Flag:						.EQU	00001000B
	D_Key_Flag:						.EQU	00010000B
	D_TM1_Flag:						.EQU	00100000B
	D_RFCTM0_Flag:					.EQU	01000000B	
	D_RFCTM1_Flag:					.EQU	10000000B
	
P_INT_Status3:            		.EQU    P_INT_Ctrl_Base+0x0C    ;$0x30CC
	D_LVD_Flag:						.EQU	00000001B	
	D_ADC_Flag:						.EQU	00000010B
	D_UART_Flag:					.EQU	00000100B
	D_SWT_Flag:						.EQU	00001000B
	D_I2C_Flag:						.EQU	00010000B
	D_PWMTM_Flag:					.EQU	00100000B
	D_Capture_Flag:					.EQU	01000000B
	
P_INT_FP_Clear:					.EQU    P_INT_Ctrl_Base+0x10    ;$0x30D0 
P_INT_SPI_Clear:				.EQU    P_INT_Ctrl_Base+0x11    ;$0x30D1
P_INT_TM0_Clear:				.EQU    P_INT_Ctrl_Base+0x17    ;$0x30D7
P_INT_EXT1_Clear:				.EQU    P_INT_Ctrl_Base+0x18    ;$0x30D8
P_INT_EXT2_Clear:				.EQU    P_INT_Ctrl_Base+0x19    ;$0x30D9
P_INT_TBL_Clear:				.EQU    P_INT_Ctrl_Base+0x1A    ;$0x30DA 
P_INT_TBH_Clear:				.EQU    P_INT_Ctrl_Base+0x1B    ;$0x30DB 
P_INT_KEY_Clear:				.EQU    P_INT_Ctrl_Base+0x1C    ;$0x30DC
P_INT_TM1_Clear:				.EQU    P_INT_Ctrl_Base+0x1D    ;$0x30DD
P_INT_RFCTM0_Clear:				.EQU	P_INT_Ctrl_Base+0x1E    ;$0x30DE
P_INT_RFCTM1_Clear:				.EQU	P_INT_Ctrl_Base+0x1F    ;$0x30DF	
P_INT_LVD_Clear:				.EQU    P_INT_Ctrl_Base+0x20    ;$0x30E0
P_INT_ADC_Clear:				.EQU    P_INT_Ctrl_Base+0x21    ;$0x30E1
P_INT_UART_Clear:				.EQU    P_INT_Ctrl_Base+0x22    ;$0x30E2
P_INT_SWT_Clear:				.EQU    P_INT_Ctrl_Base+0x23    ;$0x30E3
P_INT_I2C_Clear:				.EQU    P_INT_Ctrl_Base+0x24    ;$0x30E4
P_INT_PWMTM_Clear:				.EQU    P_INT_Ctrl_Base+0x25    ;$0x30E5
P_INT_Capture_Clear:			.EQU    P_INT_Ctrl_Base+0x26    ;$0x30E6
P_NMI_LVD_Clear:				.EQU    P_INT_Ctrl_Base+0x30    ;$0x30F0
P_NMI_TM1_Clear:				.EQU    P_INT_Ctrl_Base+0x31    ;$0x30F1
P_NMI_TM0_Clear:				.EQU    P_INT_Ctrl_Base+0x32    ;$0x30F2
P_NMI_ILLADDR_Clear:			.EQU    P_INT_Ctrl_Base+0x34    ;$0x30F4


;===============================================================
;               TIME base Control Registers
;               Base Address Start from 0x3110 
;=============================================================== 
;=============  Timer Register  =============
P_TIMER_TimeBase_Ctrl1:         .EQU    P_TIMER_Ctrl_Base+0x00  ;$0x3110
	D_TBRUN:						.EQU	00000001B
	D_TBRST:						.EQU	00010000B
	
P_TIMER_TimeBase_CNT:           .EQU    P_TIMER_Ctrl_Base+0x01  ;$0x3111

P_TIMER_TimeBase_Ctrl2:		    .EQU    P_TIMER_Ctrl_Base+0x02  ;$0x3112
	D_1KHzEn:						.EQU	00000001B	
	D_512HzEn:						.EQU	00000010B	
	D_256HzEn:						.EQU	00000100B
	D_128HzEn:						.EQU	00001000B	
	D_32HzEn:						.EQU	00010000B	
	D_8HzEn:						.EQU	00100000B
	D_2HzEn:						.EQU	01000000B	
	D_1HzEn:						.EQU	10000000B	
	
P_TIMER_TimeBase_Status:            .EQU    P_TIMER_Ctrl_Base+0x03  ;$0x3113
	D_1KHz_Flag:					.EQU	00000001B	
	D_512Hz_Flag:					.EQU	00000010B	
	D_256Hz_Flag:					.EQU	00000100B
	D_128Hz_Flag:					.EQU	00001000B	
	D_32Hz_Flag:					.EQU	00010000B	
	D_8Hz_Flag:						.EQU	00100000B
	D_2Hz_Flag:						.EQU	01000000B	
	D_1Hz_Flag:						.EQU	10000000B
		
P_TIMER_EN:						.EQU	P_TIMER_Ctrl_Base+0x04  ;$0x3114
	D_TM0En:						.EQU	00000001B
	D_TM1En:						.EQU	00000010B
	
P_TIMER_Timer_Ctrl:         	.EQU    P_TIMER_Ctrl_Base+0x05  ;$0x3115	
	D_TM1stop:						.EQU	00000000B
	D_TM1ClkSysClk:					.EQU	00000001B
	D_TM1Clk32K:					.EQU	00000010B
	D_TM1ClkTM0:					.EQU	00000011B
	
	D_TM0Stop:						.EQU	00000000B
	D_TM0AClkSysClk:				.EQU	00100000B
	D_TM0AClk32K:					.EQU	01000000B
	D_TM0AClkEXT1:					.EQU	01100000B	
	D_TM0AClkEXT2:					.EQU	10000000B
	
	D_TM0BClkVDD:					.EQU	00000000B
	D_TM0BClkEXT1:					.EQU	00001000B
	D_TM0BClkEXT2:					.EQU	00001100B
	D_TM0BClk2Hz:					.EQU	00010000B	
	D_TM0BClk8Hz:					.EQU	00010100B
	D_TM0BClk32Hz:					.EQU	00011000B
	D_TM0BClk64Hz:					.EQU	00011100B	


P_TIMER_TM0Data_LB:             .EQU    P_TIMER_Ctrl_Base+0x08  ;$0x3118
P_TIMER_TM0Data_HB:             .EQU    P_TIMER_Ctrl_Base+0x09  ;$0x3119
P_TIMER_TM0CntData_LB:          .EQU    P_TIMER_Ctrl_Base+0x0A  ;$0x311A
P_TIMER_TM0CntData_HB:          .EQU    P_TIMER_Ctrl_Base+0x0B  ;$0x311B

P_TIMER_TM1Data_LB:             .EQU    P_TIMER_Ctrl_Base+0x0C  ;$0x311C
P_TIMER_TM1Data_HB:             .EQU    P_TIMER_Ctrl_Base+0x0D  ;$0x311D
P_TIMER_TM1CntData_LB:          .EQU    P_TIMER_Ctrl_Base+0x0E  ;$0x311E
P_TIMER_TM1CntData_HB:          .EQU    P_TIMER_Ctrl_Base+0x0F  ;$0x311F


;===============================================================
;               SWT base Control Registers
;               Base Address Start from 0x3200 
;=============================================================== 
P_SWT_CTRL1:					.EQU    P_SWT_Ctrl_Base+0x00	;$0x3200
	D_SWTRun:						.EQU	00000001B
	D_SWTRst:						.EQU	00010000B	

P_SWT_BCD_CNT:					.EQU    P_SWT_Ctrl_Base+0x01	;$0x3201

P_SWT_1K_BCD:					.EQU    P_SWT_Ctrl_Base+0x02	;$0x3202

P_SWT_Ctrl2:					.EQU    P_SWT_Ctrl_Base+0x03	;$0x3203
	D_T1HzEn:						.EQU	00000001B
	D_T10HzEn:						.EQU	00000010B
	D_T100HzEn:						.EQU	00000100B
	D_T1KHzEn:						.EQU	00001000B	
	
P_SWT_Status:					.EQU    P_SWT_Ctrl_Base+0x04	;$0x3204
	D_T1Hz_Flag:					.EQU	00000001B
	D_T10Hz_Flag:					.EQU	00000010B
	D_T100Hz_Flag:					.EQU	00000100B
	D_T1KHz_Flag:					.EQU	00001000B	
	

;===============================================================
;               UART base Control Registers
;               Base Address Start from 0x3150 
;===============================================================
P_UART_Data:           			.EQU    P_UART_Ctrl_Base+0x00  ;$0x3150

P_UART_RX_Status:           	.EQU    P_UART_Ctrl_Base+0x01  ;$0x3151
	D_FrameErrorFlag:				.EQU		00000001B
	D_ParityErrorFlag:				.EQU		00000010B
	D_BreakErrorFlag:				.EQU		00000100B
	D_OverrunErrorFlag:				.EQU		00001000B
	
	
P_UART_Ctrl1:           		.EQU    P_UART_Ctrl_Base+0x02  ;$0x3152	
	D_UARTReset:					.EQU		00001000B
	D_UARTEn:						.EQU		00010000B
	D_UARTRxTimeoutIntEn:			.EQU		00100000B
	D_UARTTxIntEn:					.EQU		01000000B
	D_UARTRxIntEn:					.EQU		10000000B
	
P_UART_Ctrl2:           		.EQU    P_UART_Ctrl_Base+0x03  ;$0x3153
	D_UARTSendBreak:				.EQU		00000001B
	D_UARTParityEn:					.EQU		00000010B
	D_UARTParityOdd:				.EQU		00000000B
	D_UARTParityEven:				.EQU		00000100B	
	D_UARTStopBit1:					.EQU		00000000B
	D_UARTStopBit2:					.EQU		00001000B	
	D_UARTFIFOEn:					.EQU		00010000B
	D_UARTDataBit5:					.EQU		00000000B
	D_UARTDataBit6:					.EQU		00100000B
	D_UARTDataBit7:					.EQU		01000000B
	D_UARTDataBit8:					.EQU		01100000B
	
P_UART_BaudRate_HB:           	.EQU    P_UART_Ctrl_Base+0x04  ;$0x3154
P_UART_BaudRate_LB:           	.EQU    P_UART_Ctrl_Base+0x05  ;$0x3155

P_UART_Status1:           		.EQU    P_UART_Ctrl_Base+0x06  ;$0x3156
	D_RxTimeOutFlag:				.EQU		00100000B
	D_TxIntFlag:					.EQU 		01000000B
	D_RxIntFlag:					.EQU		10000000B
	
P_UART_Status2:           		.EQU    P_UART_Ctrl_Base+0x07  ;$0x3157
	D_UARTBusy:						.EQU		00001000B
	D_UARTRxFIFOEmpty:				.EQU		00010000B
	D_UARTTxFIFOFull:				.EQU		00100000B
	D_UARTRxFIFOFull:				.EQU		01000000B
	D_UARTTxFIFOEmpty:				.EQU		10000000B	
	
P_UART_FMD:           			.EQU    P_UART_Ctrl_Base+0x0A  ;$0x315A

;===============================================================
;               SPI base Control Registers
;               Base Address Start from 0x3180 
;=============================================================== 
;==============  SPI Register  ==============
.IF (GPL815P04Ax+GPL815P04Ax_16KB+GPL815P04Bx+GPL815P04Bx_15KB+GPL815P03Ax+GPL815P03Bx)
P_SPI_Ctrl:                    .EQU    P_SPI_Ctrl_Base+0x00    ;$0x3180
	D_SPICpuClkDiv2:				.EQU		00000000B
	D_SPICpuClkDiv4:				.EQU		00000001B
	D_SPICpuClkDiv8:				.EQU		00000010B
	D_SPICpuClkDiv16:				.EQU		00000011B
	D_SPICpuClkDiv32:				.EQU		00000100B
	D_SPICpuClkDiv64:				.EQU		00000101B
	D_SPICpuClkDiv128:				.EQU		00000110B
	D_SPIPolarity:					.EQU		00001000B
	D_SPIPhase:						.EQU		00010000B
	D_SPIMaster:					.EQU		00000000B
	D_SPISlaver:					.EQU		00100000B
	D_SPISelfLoopEn:				.EQU		01000000B
	D_SPIEn:						.EQU		10000000B
	
P_SPI_TX_Status:               .EQU    P_SPI_Ctrl_Base+0x01    ;$0x3181
	D_SPITxEmptyFlag:				.EQU		00000010B	
	D_SPITxIntEn:					.EQU		01000000B
	D_SPITxIntFlag:					.EQU		10000000B
	
P_SPI_TX_Ctrl:                 .EQU    P_SPI_Ctrl_Base+0x02    ;$0x3182
	D_SPITxFIFODataLvMask:			.EQU		00000111B
	D_SPITxFIFOIntLvMask:			.EQU		01110000B

P_SPI_TX_Data:                 .EQU    P_SPI_Ctrl_Base+0x03    ;$0x3183

P_SPI_RX_Status:               .EQU    P_SPI_Ctrl_Base+0x04    ;$0x3184
	D_SPIRxFIFOOverRun:				.EQU		00000001B	
	D_SPIRxStatusFIFOFull:			.EQU		00000010B
	D_SPIRxIntEn:					.EQU		01000000B
	D_SPIRxIntFlag:					.EQU		10000000B
	
P_SPI_RX_Ctrl:                 .EQU    P_SPI_Ctrl_Base+0x05    ;$0x3185
	D_SPIRxFIFODataLvMask:			.EQU		00000111B
	D_SPIRxFIFOIntLvMask:			.EQU		01110000B

P_SPI_RX_Data:                 .EQU    P_SPI_Ctrl_Base+0x06    ;$0x3186

P_SPI_Misc_Ctrl:               .EQU    P_SPI_Ctrl_Base+0x07    ;$0x3187
	D_SPITxFIFOEmpty:				.EQU		00000001B	
	D_SPITxFIFONotFull:				.EQU		00000010B
	D_SPIRxFIFONotEmpty:			.EQU		00000100B
	D_SPIMiscRxFIFOFull:			.EQU		00001000B
	D_SPIBusy:						.EQU		00010000B
	D_SPISmartEn:					.EQU		00100000B
	D_SPIOverWriteEn:				.EQU		01000000B
	D_SPIFIFOReset:					.EQU		10000000B
	
P_SPI_Port_Ctrl:               .EQU    P_SPI_Ctrl_Base+0x08    ;$0x3188
	D_SPIAutoRead:					.EQU		00000001B
	D_SPIIO:						.EQU		00000000B
	D_SPIPB:						.EQU		00000000B
	D_SPIPD:						.EQU		00001000B	
	D_SPICSDisable:					.EQU		00010000B
.ENDIF	
	
;===============================================================
;               ADC base Control Registers
;               Base Address Start from 0x3340 
;===============================================================
P_ADC_Ctrl1:					.EQU    P_ADC_Ctrl_Base+0x00    ;$0x3340
	D_ADCClkDiv2:					.EQU		00000000B
	D_ADCClkDiv4:					.EQU		00000001B
	D_ADCClkDiv8:					.EQU		00000010B
	D_ADCClkDiv12:					.EQU		00000011B
	D_ADCClkDiv16:					.EQU		00000100B	
	D_ADCClkDiv20:					.EQU		00000101B	
	D_ADCClkDiv24:					.EQU		00000110B	
	D_ADCClkDiv28:					.EQU		00000111B	
	
	D_ADCSHCycle2:					.EQU		00000000B
	D_ADCSHCycle4:					.EQU		00001000B
	D_ADCSHCycle8:					.EQU		00010000B	
	D_ADCSHCycle16:					.EQU		00011000B
	
	D_ADCTrigManual:				.EQU		00000000B	
	D_ADCTrigTM0:					.EQU		00100000B	
	D_ADCTrigTM1:					.EQU		01000000B
	
	D_ADCStart:						.EQU		10000000B
	
P_ADC_Ctrl2:					.EQU    P_ADC_Ctrl_Base+0x01    ;$0x3341
	D_ADCPB0:						.EQU		00000000B
	D_ADCPB1:						.EQU		00000001B	
	D_ADCPB2:						.EQU		00000010B	
	D_ADCPB3:						.EQU		00000011B	
	D_ADCPB4:						.EQU		00000100B	
	D_ADCPB5:						.EQU		00000101B	
	D_ADCPB6:						.EQU		00000110B	
	D_ADCPB7:						.EQU		00000111B
	D_ADCVREG:						.EQU		00001000B
	D_ADCVBAT:						.EQU		00001001B	
	D_ADCDiv5VDD:					.EQU		00001010B	
	D_ADCVSS:						.EQU		00001011B	
	
	D_ADCEn:						.EQU		00010000B		
	D_BatteryDetectEn:				.EQU		00100000B	
	D_ADCIntEnable:					.EQU		01000000B
	D_ADCStatus:					.EQU		10000000B	
	
P_ADC_Data_LB:					.EQU    P_ADC_Ctrl_Base+0x02    ;$0x3342
P_ADC_Data_HB:					.EQU    P_ADC_Ctrl_Base+0x03    ;$0x3343
P_ADC_VREF_Ctrl:				.EQU    P_ADC_Ctrl_Base+0x04    ;$0x3344
	D_ADCVregEn:					.EQU		00000001B
	D_ADCVreg1P8V:					.EQU		00000000B	
	D_ADCVreg2V:					.EQU		00000010B	
	D_ADCVreg2P4V:					.EQU		00000100B	
	D_ADCVreg2P6V:					.EQU		00000110B	
	D_ADCVreg3V:					.EQU		00001000B	
	D_ADCVreg3P2V:					.EQU		00001010B
	D_ADCVreg3P4V:					.EQU		00001100B
	D_ADCVregVDD:					.EQU		00001110B	

	
;===============================================================
;               I2C base Control Registers
;               Base Address Start from 0x3360 
;===============================================================
.IF (GPL815P04Ax+GPL815P04Ax_16KB+GPL815P04Bx+GPL815P04Bx_15KB+GPL815P03Ax+GPL815P03Bx)
P_I2C_Ctrl:						.EQU    P_I2C_Ctrl_Base+0x00    ;$0x3360
	D_I2C_En:						.EQU		00000001B	
	D_I2C_TriggerEn:				.EQU		00000010B		
	D_I2C_ClockDiv128:				.EQU		00000000B	
	D_I2C_ClockDiv256:				.EQU		00000100B
	D_I2C_ClockDiv768:				.EQU		00001000B	
	D_I2C_ClockDiv1024:				.EQU		00001100B	
	D_I2C_Slaver:					.EQU		00010000B		
	D_I2C_Master:					.EQU		00000000B	
	D_Master_Nack:					.EQU		00100000B	
	D_Master_Ack:					.EQU		00000000B	
	D_Master_StopEn:				.EQU		01000000B	
	D_Master_StartEn:				.EQU		10000000B
	
P_I2C_Status:						.EQU    P_I2C_Ctrl_Base+0x01    ;$0x3361
	D_I2C_TrsDone:					.EQU		00000001B
	D_I2C_Ack:						.EQU		00000000B
	D_I2C_Nack:						.EQU		00000010B	
	D_I2C_IntEn:					.EQU		00000100B
	D_I2C_DIDErrIntEn:				.EQU		00010000B
	D_I2C_StopOK:					.EQU		00100000B	
	D_I2C_DataOK:					.EQU		01000000B	
	D_I2C_DIDOK:					.EQU		10000000B		
	
P_I2C_ID:						.EQU    P_I2C_Ctrl_Base+0x02    ;$0x3362
	D_I2C_Write:					.EQU		00000000B
	D_I2C_Read:						.EQU		00000001B	
P_I2C_Data:						.EQU    P_I2C_Ctrl_Base+0x03    ;$0x3363
P_I2C_Debounce:					.EQU    P_I2C_Ctrl_Base+0x04    ;$0x3364
.ENDIF

;===============================================================
;               Buzzer base Control Registers
;               Base Address Start from 0x3371 
;===============================================================	
P_AUDIO_BZ_Ctrl:						.EQU    P_Buzzer_Ctrl_Base+0x00    ;$0x3371
	D_BZSrc:						.EQU		00000001B
	D_BZOn:							.EQU		10000000B	


;===============================================================
;               AUX base Registers
;               Base Address Start from 0x33D0 
;=============================================================== 
;=========  Bit Operation Register  ========= 
P_AUX_DataX:                    .EQU    P_AUX_Ctrl_Base+0x00    ;$0x33D0
P_AUX_DataY:                    .EQU    P_AUX_Ctrl_Base+0x01    ;$0x33D1
P_AUX_BPPExtend_IN:             .EQU    P_AUX_Ctrl_Base+0X02    ;$0x33D2
P_AUX_DataX_0H:                 .EQU    P_AUX_Ctrl_Base+0x06    ;$0x33D6
P_AUX_DataX_0L:                 .EQU    P_AUX_Ctrl_Base+0x07    ;$0x33D7
P_AUX_DataY_0H:                 .EQU    P_AUX_Ctrl_Base+0x08    ;$0x33D8
P_AUX_DataY_0L:                 .EQU    P_AUX_Ctrl_Base+0x09    ;$0x33D9
P_AUX_DataX_H0:                 .EQU    P_AUX_Ctrl_Base+0x0A    ;$0x33DA
P_AUX_DataX_L0:                 .EQU    P_AUX_Ctrl_Base+0x0B    ;$0x33DB
P_AUX_DataY_H0:                 .EQU    P_AUX_Ctrl_Base+0x0C    ;$0x33DC
P_AUX_DataY_L0:                 .EQU    P_AUX_Ctrl_Base+0x0D    ;$0x33DD
P_AUX_DataX_LH:                 .EQU    P_AUX_Ctrl_Base+0x0E    ;$0x33DE
P_AUX_DataY_LH:                 .EQU    P_AUX_Ctrl_Base+0x0F    ;$0x33DF
P_AUX_DataXY_XLYH:              .EQU    P_AUX_Ctrl_Base+0x10    ;$0x33E0
P_AUX_DataXY_YLXH:              .EQU    P_AUX_Ctrl_Base+0x11    ;$0x33E1
P_AUX_DataX_Mirror:             .EQU    P_AUX_Ctrl_Base+0x12    ;$0x33E2
P_AUX_DataY_Mirror:             .EQU    P_AUX_Ctrl_Base+0x13    ;$0x33E3
P_AUX_BPPExtendOut_LB:          .EQU    P_AUX_Ctrl_Base+0x14    ;$0x33E4
P_AUX_BPPExtendOut_HB:          .EQU    P_AUX_Ctrl_Base+0x15    ;$0x33E5


;===============================================================
;               LCD base Registers
;               Base Address Start from 0x3450 
;=============================================================== 
;==============  LCD Register  ==============
P_LCD_Ctrl1:                    .EQU    P_LCD_Ctrl_Base+0x00    ;$0x3450
	D_DisplayOn:					.EQU	00001000B
	D_LCDEn:						.EQU	10000000B

P_LCD_Ctrl2:                    .EQU    P_LCD_Ctrl_Base+0x01    ;$0x3451
	D_LCDStrobeTimeMask:			.EQU	00001111B
	D_LCDStrobeEn:					.EQU	00010000B
	D_LCDAllOff:					.EQU	00100000B
	D_LCDAllOn:						.EQU	01000000B
	
P_LCD_Clock:                    .EQU    P_LCD_Ctrl_Base+0x02    ;$0x3452
	D_LCDclk32K:					.EQU	00000000B
	D_LCDclk16K:					.EQU	00010000B
	D_LCDclk8K:						.EQU	00100000B	
	D_LCDclk4K:						.EQU	00110000B	

P_LCD_SEG_Num:					.EQU    P_LCD_Ctrl_Base+0x03    ;$0x3453
	D_32SEG:						.EQU	00000011B	
	D_48SEG:						.EQU	00000101B
	
P_LCD_COM_Num:					.EQU    P_LCD_Ctrl_Base+0x04    ;$0x3454	
	D_5COM:							.EQU	00000100B	
	D_9COM:							.EQU	00001000B
	
P_LCD_FM_Ctrl:					.EQU    P_LCD_Ctrl_Base+0x05    ;$0x3455
	D_LCDBType:						.EQU	00000000B
	D_LCDCType:						.EQU	10000000B	
	
P_LCD_VLCD_Ctrl:                .EQU    P_LCD_Ctrl_Base+0x06    ;$0x3456

P_LCD_PUMP_Ctrl:                .EQU    P_LCD_Ctrl_Base+0x07    ;$0x3457
	D_PumpClk2K:					.EQU	00000000B
	D_PumpClk4K:					.EQU	00000001B
	D_PumpClk8K:					.EQU	00000010B
	D_PumpClk16K:					.EQU	00000011B	
	D_PumpEn:						.EQU	10000000B
	
P_LCD_BIAS_Ctrl:                .EQU    P_LCD_Ctrl_Base+0x08    ;$0x3458
	D_LCDBias4:						.EQU	00000001B
	D_LCDBias3:						.EQU	00000010B
	D_LCDBias2:						.EQU	00000011B
	
P_LCD_StartAddr_LB:             .EQU    P_LCD_Ctrl_Base+0x09    ;$0x3459	


;===============================================================
;               PWMIO base Registers
;               Base Address Start from 0x3490 
;===============================================================
P_PWMIO_Ctrl:                   .EQU    P_PWMIO_Ctrl_Base+0x00  ;$0x3490
	D_PWMIO0En:						.EQU	00000001B
	D_PWMIO1En:						.EQU	00000010B
	D_PWMIO2En:						.EQU	00000100B	
	D_PWMIO3En:						.EQU	00001000B	
	D_PWMClkSysClk:					.EQU	00000000B
	D_PWMClkSysClk8:				.EQU	00010000B	
	D_PWMClkSysClk64:				.EQU	00100000B	
	D_PWMClk32K:					.EQU	00110000B
	D_PWMClkTM0:					.EQU	01000000B
	D_PWMClkTM1:					.EQU	01010000B	
	D_PWMClkRFCTM0:					.EQU	01100000B		
	D_PWMClkRFCTM1:					.EQU	01110000B	

P_PWMIO_Sel:                    .EQU    P_PWMIO_Ctrl_Base+0x01  ;$0x3491
P_PWMIO_Timer_Data:				.EQU    P_PWMIO_Ctrl_Base+0x02  ;$0x3492
P_PWMIO_Timer_Cnt:				.EQU    P_PWMIO_Ctrl_Base+0x03  ;$0x3493
			
P_PWMIO_IO0_DUTY:               .EQU    P_PWMIO_Ctrl_Base+0x04  ;$0x3494
P_PWMIO_IO1_DUTY:               .EQU    P_PWMIO_Ctrl_Base+0x05  ;$0x3495
P_PWMIO_IO2_DUTY:               .EQU    P_PWMIO_Ctrl_Base+0x06  ;$0x3496
P_PWMIO_IO3_DUTY:               .EQU    P_PWMIO_Ctrl_Base+0x07  ;$0x3497


;===============================================================
;               RFC base Registers
;               Base Address Start from 0x34C0 
;===============================================================
P_RFC_Ctrl1:       				.EQU    P_RFC_Ctrl_Base+0x01  ;$0x34C1
	D_AutoStop:						.EQU	01000000B
	D_RFCEn:						.EQU	00010000B	
	D_RFCStart:						.EQU	00000001B	

P_RFC_Timer_Ctrl:       		.EQU    P_RFC_Ctrl_Base+0x03  ;$0x34C3
	D_RFCTM0En:						.EQU	00000001B
	D_RFCTM1En:						.EQU	00000010B
	D_RFCTM0ClkMask:				.EQU	00011100B
	D_RFCTM0ClkStop:				.EQU	00000000B
	D_RFCTM0ClkIO:					.EQU	00000100B
	D_RFCTM0ClkSysClk:				.EQU	00001100B
	D_RFCTM0ClkSysClk2:				.EQU	00010000B
	D_RFCTM0ClkRFC1:				.EQU	00010100B
	D_RFCTM0ClkRFC2:				.EQU	00011000B
	D_RFCTM0Clk32K:					.EQU	00011100B
	
	D_RFCTM1ClkMask:				.EQU	11100000B
	D_RFCTM1ClkStop:				.EQU	00000000B
	D_RFCTM1ClkSysClk:				.EQU	00100000B
	D_RFCTM1ClkSysClk2:				.EQU	01000000B
	D_RFCTM1ClkSysClk4:				.EQU	01100000B
	D_RFCTM1ClkSysClk8:				.EQU	10000000B
	D_RFCTM1ClkSysClk16:			.EQU	10100000B
	D_RFCTM1ClkSysClk32:			.EQU	11000000B
	D_RFCTM1Clk32K:					.EQU	11100000B
	
P_RFC_Ctrl2:       				.EQU    P_RFC_Ctrl_Base+0x04  ;$0x34C4
	D_RFCCaptureEdgeRising:			.EQU	00000000B
	D_RFCCaptureEdgeFalling:		.EQU	00000100B		
	D_RFCCaptureTrigDis:			.EQU	00000000B	
	D_RFCCaptureTrigTM0:			.EQU	00000001B	
	
P_RFC_TM0Data_LB:       		.EQU    P_RFC_Ctrl_Base+0x06  ;$0x34C6
P_RFC_TM0Data_HB:       		.EQU    P_RFC_Ctrl_Base+0x07  ;$0x34C7
P_RFC_TM0Cnt_LB:       			.EQU    P_RFC_Ctrl_Base+0x08  ;$0x34C8
P_RFC_TM0Cnt_HB:       			.EQU    P_RFC_Ctrl_Base+0x09  ;$0x34C9

P_RFC_TM1Data_LB:       		.EQU    P_RFC_Ctrl_Base+0x0A  ;$0x34CA
P_RFC_TM1Data_HB:       		.EQU    P_RFC_Ctrl_Base+0x0B  ;$0x34CB
P_RFC_TM1Cnt_LB:				.EQU    P_RFC_Ctrl_Base+0x0C  ;$0x34CC
P_RFC_TM1Cnt_HB:       			.EQU    P_RFC_Ctrl_Base+0x0D  ;$0x34CD

P_RFC_TM1CapData_LB:       		.EQU    P_RFC_Ctrl_Base+0x0E  ;$0x34CE
P_RFC_TM1CapData_HB:		  	.EQU    P_RFC_Ctrl_Base+0x0F  ;$0x34CF
	

;**********************************************************************
;ROM Checksum
;**********************************************************************
.IF (GPL815P04Ax)
;	ROM Checksum : Bank0 address :		  0x4000 ~ 0x7FE5, 0x8000 ~ 0xBFFF
;				   NMI and Reset Vector : 0xFFFA ~ 0xFFFD
;				   
	D_Bank0UserRomStartAddr:		.EQU	0x4000		;0x4000 ~ 0x7FE5:User ROM Code
	D_Bank0UserRomEndAddr:			.EQU	0x7FE5
	D_Bank0HUserRomStartAddr:		.EQU	0x8000		;0x8000 ~ 0xBFFF:User ROM Code
	D_Bank0HUserRomEndAddr:			.EQU	0xBFFF	
	D_NMIandResetVectorStartAddr:	.EQU	0x7FFA
	D_NMIandResetVectorEndAddr:		.EQU	0x7FFD	
.ENDIF

.IF (GPL815P04Ax_16KB)
;	ROM Checksum : Bank0 address :		  0x4000 ~ 0x7FE5
;				   NMI and Reset Vector : 0xFFFA ~ 0xFFFD
;				   
	D_Bank0UserRomStartAddr:		.EQU	0x4000		;0x4000 ~ 0x7FE5:User ROM Code
	D_Bank0UserRomEndAddr:			.EQU	0x7FE5
	D_NMIandResetVectorStartAddr:	.EQU	0x7FFA
	D_NMIandResetVectorEndAddr:		.EQU	0x7FFD	
.ENDIF	

.IF (GPL815P04Bx)
;	ROM Checksum : Bank0 address :		  0x4400 ~ 0x7FE5, 0x8000 ~ 0xBFFF (0x4000 ~ 0x43FF for GP Test Code : 1K Bytes)
;				   NMI and Reset Vector : 0xFFFA ~ 0xFFFD
;				   
	D_Bank0UserRomStartAddr:		.EQU	0x4400		;0x4400 ~ 0x7FE5:User ROM Code
	D_Bank0UserRomEndAddr:			.EQU	0x7FE5
	D_Bank0HUserRomStartAddr:		.EQU	0x8000		;0x8000 ~ 0xBFFF:User ROM Code
	D_Bank0HUserRomEndAddr:			.EQU	0xBFFF	
	D_NMIandResetVectorStartAddr:	.EQU	0x7FFA
	D_NMIandResetVectorEndAddr:		.EQU	0x7FFD	
.ENDIF	

.IF (GPL815P04Bx_15KB)
;	ROM Checksum : Bank0 address :		  0x4400 ~ 0x7FE5 (0x4000 ~ 0x43FF for GP Test Code : 1K Bytes)
;				   NMI and Reset Vector : 0xFFFA ~ 0xFFFD
;				   
	D_Bank0UserRomStartAddr:		.EQU	0x4400		;0x4400 ~ 0x7FE5:User ROM Code
	D_Bank0UserRomEndAddr:			.EQU	0x7FE5
	D_NMIandResetVectorStartAddr:	.EQU	0x7FFA
	D_NMIandResetVectorEndAddr:		.EQU	0x7FFD	
.ENDIF

.IF (GPL815P03Ax)
;	ROM Checksum : Bank0 address :		  0x4000 ~ 0x7FE5, 0x8000 ~ 0x9FFF
;				   NMI and Reset Vector : 0xFFFA ~ 0xFFFD
;				   
	D_Bank0UserRomStartAddr:		.EQU	0x4000		;0x4000 ~ 0x7FE5:User ROM Code
	D_Bank0UserRomEndAddr:			.EQU	0x7FE5
	D_Bank0HUserRomStartAddr:		.EQU	0x8000		;0x8000 ~ 0x9FFF:User ROM Code
	D_Bank0HUserRomEndAddr:			.EQU	0x9FFF	
	D_NMIandResetVectorStartAddr:	.EQU	0x7FFA
	D_NMIandResetVectorEndAddr:		.EQU	0x7FFD
.ENDIF

.IF (GPL815P03Bx)
;	ROM Checksum : Bank0 address :		  0x4400 ~ 0x7FE5, 0x8000 ~ 0x9FFF (0x4000 ~ 0x43FF for GP Test Code : 1K Bytes)
;				   NMI and Reset Vector : 0xFFFA ~ 0xFFFD
;				   
	D_Bank0UserRomStartAddr:		.EQU	0x4400		;0x4400 ~ 0x7FE5:User ROM Code
	D_Bank0UserRomEndAddr:			.EQU	0x7FE5
	D_Bank0HUserRomStartAddr:		.EQU	0x8000		;0x8000 ~ 0x9FFF:User ROM Code
	D_Bank0HUserRomEndAddr:			.EQU	0x9FFF	
	D_NMIandResetVectorStartAddr:	.EQU	0x7FFA
	D_NMIandResetVectorEndAddr:		.EQU	0x7FFD
.ENDIF	

.IF (GPL815P02Ax)
;	ROM Checksum : Bank0 address :		  0x4000 ~ 0x7FE5
;				   NMI and Reset Vector : 0xFFFA ~ 0xFFFD
;				   
	D_Bank0UserRomStartAddr:		.EQU	0x4000		;0x4000 ~ 0x7FE5:User ROM Code
	D_Bank0UserRomEndAddr:			.EQU	0x7FE5
	D_NMIandResetVectorStartAddr:	.EQU	0x7FFA
	D_NMIandResetVectorEndAddr:		.EQU	0x7FFD	
.ENDIF	
; ========================================================================================
; Macro Name	: M_UserRomChecksum
; Parameters	: None
; Return Value	: R_ChecksumResult: bit[7:0]
;				: R_ChecksumResult + 1: bit[15:8]
;				: R_ChecksumResult + 2: bit[23:16]
;				: R_ChecksumResult + 3: bit[31:24]
; Description	: Calculate user ROM area code checksum
; Destroy		: A, X
; Example		: %M_UserRomChecksum	R_ChecksumAddrPtr, R_ChecksumResult
; ========================================================================================	
%M_UserRomChecksum:	.MACRO	R_ChecksumAddrPtr, R_ChecksumResult
	LDA		#0
	STA		R_ChecksumResult					;Result Byte0
	STA		R_ChecksumResult + 1				;Result Byte1
	STA		R_ChecksumResult + 2				;Result Byte2
	STA		R_ChecksumResult + 3				;Result Byte3
;=================== Bank 0 ==================================================	
	LDA		#.HIGH.D_Bank0UserRomStartAddr
	STA		R_ChecksumAddrPtr + 1				;Start High Byte
	LDA		#.LOW.D_Bank0UserRomStartAddr
	STA		R_ChecksumAddrPtr					;Start Low Byte
		
	LDY		#0	

L_ChecksumLoop1?
	STA	   P_WDT_Clear	
	CLC
	LDA		(R_ChecksumAddrPtr),Y
	ADC		R_ChecksumResult					;Result Low Byte
	STA		R_ChecksumResult					;Result Low Byte
	BCC		L_CheckAddress1?
	INC		R_ChecksumResult + 1				;Result Byte1
	BNE		L_CheckAddress1?
	INC		R_ChecksumResult + 2				;Result Byte3
	BNE		L_CheckAddress1?
	INC		R_ChecksumResult + 3				;Result Byte4
		
L_CheckAddress1?:
	LDA		R_ChecksumAddrPtr + 1				;Address Pointer HB
	CMP		#.HIGH.D_Bank0UserRomEndAddr		;End High Byte
	BNE		L_IncreaseAdd1?
	
	LDA		R_ChecksumAddrPtr					;Address Pointer LB
	CMP		#.LOW.D_Bank0UserRomEndAddr			;End Low Byte
	BEQ		L_ExitRomSum1?
	
L_IncreaseAdd1?:
	INC		R_ChecksumAddrPtr					;Address Pointer LB
	BNE		L_ChecksumLoop1?
	INC		R_ChecksumAddrPtr + 1				;Address Pointer HB
	JMP		L_ChecksumLoop1?	
		
L_ExitRomSum1?:		
.IF (GPL815P04Ax+GPL815P04Bx+GPL815P03Ax+GPL815P03Bx)	
;===================================Bank0H==============================================
	LDA		#.HIGH.D_Bank0HUserRomStartAddr
	STA		R_ChecksumAddrPtr + 1				;Start High Byte
	LDA		#.LOW.D_Bank0HUserRomStartAddr
	STA		R_ChecksumAddrPtr
	
L_ChecksumLoop1H?
	STA	   P_WDT_Clear	
	CLC
	LDA		(R_ChecksumAddrPtr),Y
	ADC		R_ChecksumResult					;Result Low Byte
	STA		R_ChecksumResult					;Result Low Byte
	BCC		L_CheckAddress1H?
	INC		R_ChecksumResult + 1				;Result Byte1
	BNE		L_CheckAddress1H?
	INC		R_ChecksumResult + 2				;Result Byte3
	BNE		L_CheckAddress1H?
	INC		R_ChecksumResult + 3				;Result Byte4
		
L_CheckAddress1H?:
	LDA		R_ChecksumAddrPtr + 1				;Address Pointer HB
	CMP		#.HIGH.D_Bank0HUserRomEndAddr		;End High Byte
	BNE		L_IncreaseAdd1H?
	
	LDA		R_ChecksumAddrPtr					;Address Pointer LB
	CMP		#.LOW.D_Bank0HUserRomEndAddr			;End Low Byte
	BEQ		L_ExitRomSum1H?
	
L_IncreaseAdd1H?:
	INC		R_ChecksumAddrPtr					;Address Pointer LB
	BNE		L_ChecksumLoop1H?
	INC		R_ChecksumAddrPtr + 1				;Address Pointer HB
	JMP		L_ChecksumLoop1H?	
		
L_ExitRomSum1H?:	
.ENDIF	
;===================NMI & Reset Vector==================================================		
	LDA		#.HIGH.D_NMIandResetVectorStartAddr
	STA		R_ChecksumAddrPtr + 1				; Start High Byte
	LDA		#.LOW.D_NMIandResetVectorStartAddr
	STA		R_ChecksumAddrPtr					;Start Low Byte
		
L_ChecksumLoop2?
	STA	   P_WDT_Clear		
	CLC
	LDA		(R_ChecksumAddrPtr),Y
	ADC		R_ChecksumResult					;Result Low Byte
	STA		R_ChecksumResult					;Result Low Byte
	BCC		L_CheckAddress2?
	INC		R_ChecksumResult + 1				;Result Byte2
	BNE		L_CheckAddress2?
	INC		R_ChecksumResult + 2				;Result Byte3
	BNE		L_CheckAddress2?
	INC		R_ChecksumResult + 3				;Result Byte4
		
L_CheckAddress2?:
	LDA		R_ChecksumAddrPtr + 1				;Address Pointer HB
	CMP		#.HIGH.D_NMIandResetVectorEndAddr	;End High Byte
	BNE		L_IncreaseAdd2?
	
	LDA		R_ChecksumAddrPtr					;Address Pointer LB
	CMP		#.LOW.D_NMIandResetVectorEndAddr	;End Low Byte
	BEQ		L_ExitRomSum2?
	
L_IncreaseAdd2?:
	INC		R_ChecksumAddrPtr					;Address Pointer LB
	BNE		L_ChecksumLoop2?
	INC		R_ChecksumAddrPtr + 1				;Address Pointer HB
	JMP		L_ChecksumLoop2?	
		
L_ExitRomSum2?:	
	.ENDM

	.ENDIF
.endif
	.ENDIF	

