/* =======================================================================  */
/*    File Name   : GPL815P.h                                               */
/*    Description : GPL815P #define () unsigned char definition             */
/*    Body        : GPL815P series 6502 CPU                                 */
/*    Toolchain   : gp65cc Compiler V0.9x                                   */
/*    Date        : 2024/04/22                                              */
/*    Version     : 0.0.1                                                   */
/* =======================================================================  */
// History version
// Rev #       Date			 Who		Comments
// -----	-----------		--------	--------------------------------------------
// 0.1		 2024/08/19		Frank Kung	Oringinal Version
//==================================================================================
#ifndef __GPL815P__
#define __GPL815P__

//---------------------------------
#define	GPL815P04Ax		1
//---------------------------------

#ifndef GPL815P04Ax                
#define		GPL815P04Ax			0
#endif   

#ifndef GPL815P04Ax_16KB                
#define		GPL815P04Ax_16KB			0
#endif 

#ifndef GPL815P04Bx                
#define		GPL815P04Bx			0
#endif

#ifndef GPL815P04Bx_15KB                
#define		GPL815P04Bx_15KB	0
#endif       

#ifndef GPL815P03Ax                
#define		GPL815P03Ax			0
#endif  

#ifndef GPL815P03Bx                
#define		GPL815P03Bx			0
#endif   


#if defined(GPL815P04Ax) || defined(GPL815P04Ax_16KB) || defined(GPL815P04Bx) || defined(GPL815P04Bx_15KB) || defined(GPL815P03Ax) || defined(GPL815P03Bx)
#define GPL815P
#endif

#ifdef GPL815P
/* For intrinsic functions */
#include <intr6502.h>

#define		P_System_Ctrl_Base          0x3000
#define		P_IO_Ctrl_Base              0x3080
#define		P_INT_Ctrl_Base             0x30C0
#define		P_TIMER_Ctrl_Base			0x3110
#define		P_UART_Ctrl_Base			0x3150
#define		P_SPI_Ctrl_Base             0x3180
#define		P_SWT_Ctrl_Base             0x3200 
#define		P_ADC_Ctrl_Base             0x3340 
#define		P_I2C_Ctrl_Base             0x3360 
#define		P_Buzzer_Ctrl_Base			0x3371
#define		P_AUX_Ctrl_Base             0x33D0
#define		P_LCD_Ctrl_Base             0x3450
#define		P_PWMIO_Ctrl_Base           0x3490
#define		P_RFC_Ctrl_Base				0x34C0

//===============================================================
//		System base Control Registers
//		Base Address Start from 0x3000 
//===============================================================
//==============  BANK Register  =============
#define P_BANK_Sel				*(volatile unsigned char *)	(P_System_Ctrl_Base+0x00)	//0x3000

	
//==========  CPU & Clock Register  ==========
#define P_CLK_IOSC_Ctrl          *(volatile unsigned char *)	(P_System_Ctrl_Base+0x07)	//0x3007
	#define		D_CPUSysClkDiv1				0b00000000
	#define		D_CPUSysClkDiv2				0b00000001
	#define		D_CPUSysClkDiv4				0b00000010
	#define		D_CPUSysClkDiv8				0b00000011
	#define		D_SYS32K					0b00000000
	#define		D_SYS2M						0b00010000
	#define		D_SYS4M						0b00100000
	#define		D_SYS8M						0b00110000	
	
#define P_SLP_Ctrl				*(volatile unsigned char *)	(P_System_Ctrl_Base+0x09)	//0x3009
	#define		D_SleepMode					0b01011010
	#define		D_GreenMode					0b10100101
	
	
//================  LVD Ctrl  ================
#define P_LVD_Ctrl				*(volatile unsigned char *) (P_System_Ctrl_Base+0x0A)	//0x300A
	#define		D_LVDEn						0b10000000
	#define		D_LVDStatus					0b00100000
	#define		D_LVD2P1V					0b00000000	
	#define		D_LVD2P4V						0b00000001
	#define		D_LVD3P0V					0b00000010	
	#define		D_LVD3P3V					0b00000011	
	#define		D_LVDLevelMask				0b00000011	
		
//===========  Watch Dog Register  ===========
#define P_WDT_Clear				*(volatile unsigned char *) (P_System_Ctrl_Base+0x0B)	//0x300B

//=============  Reset Register  =============
#define P_RESET_Ctrl			*(volatile unsigned char *) (P_System_Ctrl_Base+0x0C)	//0x300C
	#define		D_LVRResetEn				0b00000001
	#define		D_IllegalAddrResetEn		0b00000010
	#define		D_SWResetEn					0b00000100
	#define		D_WDTResetEn				0b00001000
	
#define P_RESET_Status			*(volatile unsigned char *) (P_System_Ctrl_Base+0x0D)	//0x300D
	#define		D_LVRResetFlag				0b00000001
	#define		D_IllegalAddrResetFlag		0b00000010
	#define		D_SWResetFlag				0b00000100
	#define		D_WDTResetFlag				0b00001000	

//===============================================================
//		IO base Control Registers
//		Base Address Start from 0x3080 
//=============================================================== 
//===============  IO Register  ==============
#define P_IO_Ctrl1				*(volatile unsigned char *) (P_IO_Ctrl_Base+0x00)		//0x3080
	#define		D_IRDuty2					0b00000000
	#define		D_IRDuty3					0b00000010
	#define		D_IRDuty4					0b00000100
	#define		D_IRDuty5					0b00000110	
	#define		D_IREn						0b00001000
	#define		D_ExtI1Edge					0b00010000
	#define		D_ExtI1En					0b00100000
	#define		D_ExtI2Edge					0b01000000
	#define		D_ExtI2En					0b10000000
	
#define P_IO_Ctrl2             *(volatile unsigned char *) (P_IO_Ctrl_Base+0x01)		//0x3081
	#define		D_RFC1En					0b00000001
	#define		D_RFC2En					0b00000010	
	#define		D_RFC1OutEn					0b00000100
	#define		D_RFC2OutEn					0b00001000
	#define		D_PA32KOutEn				0b01000000
	#define		D_PD32KOutEn				0b10000000
	
#define P_IO_RFC_Ctrl          *(volatile unsigned char *) (P_IO_Ctrl_Base+0x02)		//0x3082
	#define		D_REF2En					0b00000001
	#define		D_SEN2AEn					0b00000010
	#define		D_SEN2BEn					0b00001000	
	#define		D_REF1En					0b00010000
	#define		D_SEN1AEn					0b00100000
	#define		D_SEN1BEn					0b10000000
	
#define P_IO_LCDPORT_Ctrl      *(volatile unsigned char *) (P_IO_Ctrl_Base+0x03)		//0x3083
	#define		D_PCEn						0b00000001	
	#define		D_PDEn						0b00000010
	#define		D_PEEn						0b00000100
	#define		D_ShiftSeg0					0b00000000
	#define		D_ShiftSeg8					0b00010000
	#define		D_ShiftSeg16				0b00100000
	#define		D_ShiftSeg24				0b00110000	
		
#define P_IO_KeyChange_Ctrl1	*(volatile unsigned char *) (P_IO_Ctrl_Base+0x04)		//0x3084
#define P_IO_KeyChange_Ctrl2    *(volatile unsigned char *) (P_IO_Ctrl_Base+0x05)		//0x3085

#define P_IO_PB_LINEN_Ctrl		*(volatile unsigned char *) (P_IO_Ctrl_Base+0x06)		//0x3086

#define P_IO_PortA_Dir          *(volatile unsigned char *) (P_IO_Ctrl_Base+0x08)		//0x3088
#define P_IO_PortA_Attrib       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x09)		//0x3089
#define P_IO_PortA_Data         *(volatile unsigned char *) (P_IO_Ctrl_Base+0x0A)		//0x308A
#define P_IO_PortA_Buffer       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x0B)		//0x308B
#define P_IO_PortA_SMT_En		*(volatile unsigned char *)	(P_IO_Ctrl_Base+0x0C)		//0x308C

#define P_IO_PortB_Dir          *(volatile unsigned char *) (P_IO_Ctrl_Base+0x10)		//0x3090
#define P_IO_PortB_Attrib       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x11)		//0x3091
#define P_IO_PortB_Data         *(volatile unsigned char *) (P_IO_Ctrl_Base+0x12)		//0x3092
#define P_IO_PortB_Buffer       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x13)		//0x3093
#define P_IO_PortB_SMT_En		*(volatile unsigned char *)	(P_IO_Ctrl_Base+0x14)		//0x3094

#define P_IO_PortC_Dir          *(volatile unsigned char *) (P_IO_Ctrl_Base+0x18)		//0x3098
#define P_IO_PortC_Attrib       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x19)		//0x3099
#define P_IO_PortC_Data         *(volatile unsigned char *) (P_IO_Ctrl_Base+0x1A)		//0x309A
#define P_IO_PortC_Buffer       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x1B)		//0x309B
#define P_IO_PortC_SMT_En		*(volatile unsigned char *)	(P_IO_Ctrl_Base+0x1C)		//0x309C
	
#define P_IO_PortD_Dir          *(volatile unsigned char *) (P_IO_Ctrl_Base+0x20)		//0x30A0
#define P_IO_PortD_Attrib       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x21)		//0x30A1
#define P_IO_PortD_Data         *(volatile unsigned char *) (P_IO_Ctrl_Base+0x22)		//0x30A2
#define P_IO_PortD_Buffer       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x23)		//0x30A3
#define P_IO_PortD_SMT_En		*(volatile unsigned char *) (P_IO_Ctrl_Base+0x24)		//0x30A4

#define P_IO_PortE_Dir          *(volatile unsigned char *) (P_IO_Ctrl_Base+0x28)		//0x30A8
#define P_IO_PortE_Attrib       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x29)		//0x30A9
#define P_IO_PortE_Data         *(volatile unsigned char *) (P_IO_Ctrl_Base+0x2A)		//0x30AA
#define P_IO_PortE_Buffer       *(volatile unsigned char *) (P_IO_Ctrl_Base+0x2B)		//0x30AB
#define P_IO_PortE_SMT_En		*(volatile unsigned char *)	(P_IO_Ctrl_Base+0x2C)		//0x30AC	

#define	P_IO_Ctrl3              *(volatile unsigned char *) (P_IO_Ctrl_Base+0x30)   //0x30B0
		#define	D_PFEn							0b00000001
		#define	D_PGEn							0b00000010

#define	P_IO_PortF_Buffer				*(volatile unsigned char *) (P_IO_Ctrl_Base+0x31)    //0x30B1
#define	P_IO_PortG_Buffer				*(volatile unsigned char *) (P_IO_Ctrl_Base+0x32)    //0x30B2
	
//===============================================================
//		Interrupt base Control Registers
//		Base Address Start from 0x30C0 
//===============================================================
//============  INT/NMI Register  ============
#define P_NMI_Ctrl              *(volatile unsigned char *) (P_INT_Ctrl_Base+0x00)		//0x30C0 
	#define		D_LVDNMIEn					0b00000001
	#define		D_TM1NMIEn					0b00000010
	#define		D_TM0NMIEn					0b00000100	
	#define		D_ILLADRNMIEn				0b00010000
	
#define P_NMI_Status            *(volatile unsigned char *) (P_INT_Ctrl_Base+0x01)		//0x30C1
	#define		D_LVDNMIFlag				0b00000001
	#define		D_TM1NMIFlag				0b00000010
	#define		D_TM0NMIFlag				0b00000100	
	#define		D_ILLADRNMIFlag				0b00010000	
	
#define P_INT_Ctrl1             *(volatile unsigned char *) (P_INT_Ctrl_Base+0x02)		//0x30C2
	#define		D_FPIntEn					0b00000001
	#define		D_SPIInt_En					0b00000010
	#define		D_TM0IntEn					0b10000000	
	
#define P_INT_Ctrl2             *(volatile unsigned char *) (P_INT_Ctrl_Base+0x03)		//0x30C3   
	#define		D_ExtI1IntEn				0b00000001
	#define		D_ExtI2IntEn				0b00000010
	#define		D_TBLIntEn					0b00000100
	#define		D_TBHIntEn					0b00001000	
	#define		D_KeyIntEn					0b00010000		
	#define		D_TM1IntEn					0b00100000
	#define		D_RFCTM0IntEn				0b01000000
	#define		D_RFCTM1IntEn				0b10000000
		
#define P_INT_Ctrl3				*(volatile unsigned char *) (P_INT_Ctrl_Base+0x04)		//0x30C4 
	#define		D_LVDIntEn					0b00000001	
	#define		D_ADCIntEn					0b00000010
	#define		D_UARTIntEn					0b00000100
	#define		D_SWTIntEn					0b00001000
	#define		D_I2CIntEn					0b00010000
	#define		D_PWMTMIntEn				0b00100000
	#define		D_CaptureIntEn				0b01000000
	
#define P_INT_Status1			*(volatile unsigned char *) (P_INT_Ctrl_Base+0x0A)		//0x30CA 
	#define		D_FP_Flag					0b00000001
	#define		D_SPI_Flag					0b00000010
	#define		D_TM0_Flag					0b10000000	
	
#define P_INT_Status2			*(volatile unsigned char *) (P_INT_Ctrl_Base+0x0B)		//0x30CB
	#define		D_EXT1_Flag					0b00000001
	#define		D_EXT2_Flag					0b00000010
	#define		D_TBL_Flag					0b00000100
	#define		D_TBH_Flag					0b00001000
	#define		D_Key_Flag					0b00010000
	#define		D_TM1_Flag					0b00100000
	#define		D_RFCTM0_Flag				0b01000000	
	#define		D_RFCTM1_Flag				0b10000000
	
#define P_INT_Status3			*(volatile unsigned char *) (P_INT_Ctrl_Base+0x0C)		//0x30CC
	#define		D_LVD_Flag					0b00000001
	#define		D_ADC_Flag					0b00000010
	#define		D_UART_Flag					0b00000100
	#define		D_SWT_Flag					0b00001000
	#define		D_I2C_Flag					0b00010000
	#define		D_PWMTM_Flag				0b00100000
	#define		D_Capture_Flag				0b01000000
	
#define P_INT_FP_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x10)		//0x30D0 
#define P_INT_SPI_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x11)		//0x30D1
#define P_INT_TM0_Clear			*(volatile unsigned char *) (P_INT_Ctrl_Base+0x17)		//0x30D7
#define P_INT_EXT1_Clear		*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x18)		//0x30D8
#define P_INT_EXT2_Clear		*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x19)		//0x30D9
#define P_INT_TBL_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x1A)		//0x30DA 
#define P_INT_TBH_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x1B)		//0x30DB 
#define P_INT_KEY_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x1C)		//0x30DC
#define P_INT_TM1_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x1D)		//0x30DD
#define P_INT_RFCTM0_Clear		*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x1E)		//0x30DE
#define P_INT_RFCTM1_Clear		*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x1F)		//0x30DF	
#define P_INT_LVD_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x20)		//0x30E0
#define P_INT_ADC_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x21)		//0x30E1
#define P_INT_UART_Clear		*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x22)		//0x30E2
#define P_INT_SWT_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x23)		//0x30E3
#define P_INT_I2C_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x24)		//0x30E4
#define P_INT_PWMTM_Clear		*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x25)		//0x30E5
#define P_INT_Capture_Clear		*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x26)		//0x30E6
#define P_NMI_LVD_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x30)		//0x30F0
#define P_NMI_TM1_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x31)		//0x30F1
#define P_NMI_TM0_Clear			*(volatile unsigned char *)	(P_INT_Ctrl_Base+0x32)		//0x30F2
#define P_NMI_ILLADDR_Clear		*(volatile unsigned char *) (P_INT_Ctrl_Base+0x34)		//0x30F4	
	
//===============================================================
//		TIME base Control Registers
//		Base Address Start from 0x3110 
//=============================================================== 
//=============  Timer Register  =============
#define P_TIMER_TimeBase_Ctrl1  *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x00)	//0x3110
	#define		D_TBRUN						0b00000001
	#define		D_TBRST						0b00010000
	
#define P_TIMER_TimeBase_CNT    *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x01)	//0x3111

#define P_TIMER_TimeBase_Ctrl2	*(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x02)	//0x3112
	#define		D_1KHzEn					0b00000001	
	#define		D_512HzEn					0b00000010	
	#define		D_256HzEn					0b00000100
	#define		D_128HzEn					0b00001000	
	#define		D_32HzEn					0b00010000	
	#define		D_8HzEn						0b00100000
	#define		D_2HzEn						0b01000000	
	#define		D_1HzEn						0b10000000	
	
#define P_TIMER_TimeBase_Status *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x03)	//0x3113
	#define		D_1KHz_Flag					0b00000001	
	#define		D_512Hz_Flag				0b00000010	
	#define		D_256Hz_Flag				0b00000100
	#define		D_128Hz_Flag				0b00001000	
	#define		D_32Hz_Flag					0b00010000	
	#define		D_8Hz_Flag					0b00100000
	#define		D_2Hz_Flag					0b01000000	
	#define		D_1Hz_Flag					0b10000000
		
#define P_TIMER_EN				*(volatile unsigned char *)	(P_TIMER_Ctrl_Base+0x04)	//0x3114
	#define		D_TM0En						0b00000001
	#define		D_TM1En						0b00000010
	
#define P_TIMER_Timer_Ctrl      *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x05)	//0x3115	
	#define		D_TM1stop					0b00000000
	#define		D_TM1ClkSysClk				0b00000001
	#define		D_TM1Clk32K					0b00000010
	#define		D_TM1ClkTM0					0b00000011
	
	#define		D_TM0Stop					0b00000000
	#define		D_TM0AClkSysClk				0b00100000
	#define		D_TM0AClk32K				0b01000000
	#define		D_TM0AClkEXT1				0b01100000	
	#define		D_TM0AClkEXT2				0b10000000
	
	#define		D_TM0BClkVDD				0b00000000
	#define		D_TM0BClkEXT1				0b00001000
	#define		D_TM0BClkEXT2				0b00001100
	#define		D_TM0BClk2Hz				0b00010000	
	#define		D_TM0BClk8Hz				0b00010100
	#define		D_TM0BClk32Hz				0b00011000
	#define		D_TM0BClk64Hz				0b00011100


#define P_TIMER_TM0Data_LB		*(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x08)	//0x3118
#define P_TIMER_TM0Data_HB      *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x09)	//0x3119
#define P_TIMER_TM0CntData_LB   *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x0A)	//0x311A
#define P_TIMER_TM0CntData_HB   *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x0B)	//0x311B

#define P_TIMER_TM1Data_LB      *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x0C)	//0x311C
#define P_TIMER_TM1Data_HB      *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x0D)	//0x311D
#define P_TIMER_TM1CntData_LB   *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x0E)	//0x311E
#define P_TIMER_TM1CntData_HB   *(volatile unsigned char *) (P_TIMER_Ctrl_Base+0x0F)	//0x311F	

//===============================================================
//               SWT base Control Registers
//               Base Address Start from 0x3200 
//=============================================================== 
#define P_SWT_CTRL1				*(volatile unsigned char *) (P_SWT_Ctrl_Base+0x00)		//0x3200
	#define		D_SWTRun					0b00000001
	#define		D_SWTRst					0b00010000	

#define P_SWT_BCD_CNT			*(volatile unsigned char *)	(P_SWT_Ctrl_Base+0x01)		//0x3201

#define P_SWT_1K_BCD			*(volatile unsigned char *)	(P_SWT_Ctrl_Base+0x02)		//0x3202

#define P_SWT_Ctrl2				*(volatile unsigned char *)	(P_SWT_Ctrl_Base+0x03)		//0x3203
	#define		D_T1HzEn					0b00000001
	#define		D_T10HzEn					0b00000010
	#define		D_T100HzEn					0b00000100
	#define		D_T1KHzEn					0b00001000	
	
#define P_SWT_Status			*(volatile unsigned char *)	(P_SWT_Ctrl_Base+0x04)		//0x3204
	#define		D_T1Hz_Flag					0b00000001
	#define		D_T10Hz_Flag				0b00000010
	#define		D_T100Hz_Flag				0b00000100
	#define		D_T1KHz_Flag				0b00001000
	

//===============================================================
//               UART base Control Registers
//               Base Address Start from 0x3150 
//=============================================================== 
#define P_UART_Data				*(volatile unsigned char *) (P_UART_Ctrl_Base+0x00)		//0x3150

#define P_UART_RX_Status        *(volatile unsigned char *) (P_UART_Ctrl_Base+0x01)		//0x3151
	#define		D_FrameErrorFlag			0b00000001
	#define		D_ParityErrorFlag			0b00000010
	#define		D_BreakErrorFlag			0b00000100
	#define		D_OverrunErrorFlag			0b00001000
	
	
#define P_UART_Ctrl1           	*(volatile unsigned char *)	(P_UART_Ctrl_Base+0x02)		//0x3152	
	#define		D_UARTReset					0b00001000
	#define		D_UARTEn					0b00010000
	#define		D_UARTRxTimeoutIntEn		0b00100000
	#define		D_UARTTxIntEn				0b01000000
	#define		D_UARTRxIntEn				0b10000000
	
#define P_UART_Ctrl2			*(volatile unsigned char *) (P_UART_Ctrl_Base+0x03)		//0x3153
	#define		D_UARTSendBreak				0b00000001
	#define		D_UARTParityEn				0b00000010
	#define		D_UARTParityOdd				0b00000000
	#define		D_UARTParityEven			0b00000100	
	#define		D_UARTStopBit1				0b00000000
	#define		D_UARTStopBit2				0b00001000	
	#define		D_UARTFIFOEn				0b00010000
	#define		D_UARTDataBit5				0b00000000
	#define		D_UARTDataBit6				0b00100000
	#define		D_UARTDataBit7				0b01000000
	#define		D_UARTDataBit8				0b01100000
	
#define P_UART_BaudRate_HB		*(volatile unsigned char *) (P_UART_Ctrl_Base+0x04)		//0x3154
#define P_UART_BaudRate_LB      *(volatile unsigned char *) (P_UART_Ctrl_Base+0x05)		//0x3155

#define P_UART_Status1          *(volatile unsigned char *) (P_UART_Ctrl_Base+0x06)		//0x3156
	#define		D_RxTimeOutFlag				0b00100000
	#define		D_TxIntFlag					0b01000000
	#define		D_RxIntFlag					0b10000000
	
#define P_UART_Status2			*(volatile unsigned char *) (P_UART_Ctrl_Base+0x07)		//0x3157
	#define		D_UARTBusy					0b00001000
	#define		D_UARTRxFIFOEmpty			0b00010000
	#define		D_UARTTxFIFOFull			0b00100000
	#define		D_UARTRxFIFOFull			0b01000000
	#define		D_UARTTxFIFOEmpty			0b10000000	
	
#define P_UART_FMD           	*(volatile unsigned char *)	(P_UART_Ctrl_Base+0x0A)		//0x315A	
	
//===============================================================
//		SPI base Control Registers
//		Base Address Start from 0x3180 
//=============================================================== 
//==============  SPI Register  ==============
#define P_SPI_Ctrl				*(volatile unsigned char *) (P_SPI_Ctrl_Base+0x00)		//0x3180
	#define		D_SPICpuClkDiv2				0b00000000
	#define		D_SPICpuClkDiv4				0b00000001
	#define		D_SPICpuClkDiv8				0b00000010
	#define		D_SPICpuClkDiv16			0b00000011
	#define		D_SPICpuClkDiv32			0b00000100
	#define		D_SPICpuClkDiv64			0b00000101
	#define		D_SPICpuClkDiv128			0b00000110
	#define		D_SPIPolarity				0b00001000
	#define		D_SPIPhase					0b00010000
	#define		D_SPIMaster					0b00000000
	#define		D_SPISlaver					0b00100000
	#define		D_SPISelfLoopEn				0b01000000
	#define		D_SPIEn						0b10000000
	
#define P_SPI_TX_Status			*(volatile unsigned char *) (P_SPI_Ctrl_Base+0x01)		//0x3181
	#define		D_SPITxEmptyFlag			0b00000010	
	#define		D_SPITxIntEn				0b01000000
	#define		D_SPITxIntFlag				0b10000000
	
#define P_SPI_TX_Ctrl			*(volatile unsigned char *) (P_SPI_Ctrl_Base+0x02)		//0x3182
	#define		D_SPITxFIFODataLvMask		0b00000111
	#define		D_SPITxFIFOIntLvMask		0b01110000

#define P_SPI_TX_Data           *(volatile unsigned char *) (P_SPI_Ctrl_Base+0x03)		//0x3183

#define P_SPI_RX_Status			*(volatile unsigned char *) (P_SPI_Ctrl_Base+0x04)		//0x3184
	#define		D_SPIRxFIFOOverRun			0b00000001	
	#define		D_SPIRxStatusFIFOFull		0b00000010
	#define		D_SPIRxIntEn				0b01000000
	#define		D_SPIRxIntFlag				0b10000000
	
#define P_SPI_RX_Ctrl			*(volatile unsigned char *) (P_SPI_Ctrl_Base+0x05)		//0x3185
	#define		D_SPIRxFIFODataLvMask		0b00000111
	#define		D_SPIRxFIFOIntLvMask		0b01110000

#define P_SPI_RX_Data           *(volatile unsigned char *) (P_SPI_Ctrl_Base+0x06)		//0x3186

#define P_SPI_Misc_Ctrl         *(volatile unsigned char *) (P_SPI_Ctrl_Base+0x07)		//0x3187
	#define		D_SPITxFIFOEmpty			0b00000001	
	#define		D_SPITxFIFONotFull			0b00000010
	#define		D_SPIRxFIFONotEmpty			0b00000100
	#define		D_SPIMiscRxFIFOFull			0b00001000
	#define		D_SPIBusy					0b00010000
	#define		D_SPISmartEn				0b00100000
	#define		D_SPIOverWriteEn			0b01000000
	#define		D_SPIFIFOReset				0b10000000
	
#define P_SPI_Port_Ctrl         *(volatile unsigned char *) (P_SPI_Ctrl_Base+0x08)		//0x3188
	#define		D_SPIAutoRead				0b00000001
	#define		D_SPIIO						0b00000000
	#define		D_SPIPB						0b00000000
	#define		D_SPIPD						0b00001000
	#define		D_SPICSDisable				0b00010000
	
//===============================================================
//               ADC base Control Registers
//               Base Address Start from 0x3340 
//===============================================================
#define P_ADC_Ctrl1				*(volatile unsigned char *) (P_ADC_Ctrl_Base+0x00)		//0x3340
	#define		D_ADCClkDiv2				0b00000000
	#define		D_ADCClkDiv4				0b00000001
	#define		D_ADCClkDiv8				0b00000010
	#define		D_ADCClkDiv12				0b00000011
	#define		D_ADCClkDiv16				0b00000100	
	#define		D_ADCClkDiv20				0b00000101	
	#define		D_ADCClkDiv24				0b00000110	
	#define		D_ADCClkDiv28				0b00000111	
	
	#define		D_ADCSHCycle2				0b00000000
	#define		D_ADCSHCycle4				0b00001000
	#define		D_ADCSHCycle8				0b00010000	
	#define		D_ADCSHCycle16				0b00011000
	
	#define		D_ADCTrigManual				0b00000000	
	#define		D_ADCTrigTM0				0b00100000	
	#define		D_ADCTrigTM1				0b01000000
	
	#define		D_ADCStart					0b10000000
	
#define P_ADC_Ctrl2				*(volatile unsigned char *) (P_ADC_Ctrl_Base+0x01)		//0x3341
	#define		D_ADCPB0					0b00000000
	#define		D_ADCPB1					0b00000001
	#define		D_ADCPB2					0b00000010	
	#define		D_ADCPB3					0b00000011
	#define		D_ADCPB4					0b00000100	
	#define		D_ADCPB5					0b00000101
	#define		D_ADCPB6					0b00000110	
	#define		D_ADCPB7					0b00000111
	#define		D_ADCVREG					0b00001000
	#define		D_ADCVBAT					0b00001001	
	#define		D_ADCDiv5VDD				0b00001010	
	#define		D_ADCVSS					0b00001011
	
	#define		D_ADCEn						0b00010000		
	#define		D_BatteryDetectEn			0b00100000
	#define		D_ADCIntEnable				0b01000000
	#define		D_ADCStatus					0b10000000	
	
#define P_ADC_Data_LB			*(volatile unsigned char *) (P_ADC_Ctrl_Base+0x02)		//0x3342
#define P_ADC_Data_HB			*(volatile unsigned char *)	(P_ADC_Ctrl_Base+0x03)		//0x3343
#define P_ADC_VREF_Ctrl			*(volatile unsigned char *)	(P_ADC_Ctrl_Base+0x04)		//0x3344
	#define		D_ADCVregEn					0b00000001
	#define		D_ADCVreg1P8V				0b00000000	
	#define		D_ADCVreg2V					0b00000010	
	#define		D_ADCVreg2P4V				0b00000100	
	#define		D_ADCVreg2P6V				0b00000110	
	#define		D_ADCVreg3V					0b00001000	
	#define		D_ADCVreg3P2V				0b00001010
	#define		D_ADCVreg3P4V				0b00001100
	#define		D_ADCVregVDD				0b00001110		
	
//===============================================================
//               I2C base Control Registers
//               Base Address Start from 0x3360 
//===============================================================
#define P_I2C_Ctrl				*(volatile unsigned char *)	(P_I2C_Ctrl_Base+0x00)		//0x3360
	#define		D_I2C_En					0b00000001	
	#define		D_I2C_TriggerEn				0b00000010		
	#define		D_I2C_ClockDiv128			0b00000000	
	#define		D_I2C_ClockDiv256			0b00000100
	#define		D_I2C_ClockDiv768			0b00001000	
	#define		D_I2C_ClockDiv1024			0b00001100	
	#define		D_I2C_Slaver				0b00010000		
	#define		D_I2C_Master				0b00000000	
	#define		D_Master_Nack				0b00100000
	#define		D_Master_Ack				0b00000000	
	#define		D_Master_StopEn				0b01000000	
	#define		D_Master_StartEn			0b10000000
	
#define P_I2C_Status			*(volatile unsigned char *)	(P_I2C_Ctrl_Base+0x01)		//0x3361
	#define		D_I2C_TrsDone				0b00000001
	#define		D_I2C_Ack					0b00000000
	#define		D_I2C_Nack					0b00000010	
	#define		D_I2C_IntEn					0b00000100
	#define		D_I2C_DIDErrIntEn			0b00010000
	#define		D_I2C_StopOK				0b00100000	
	#define		D_I2C_DataOK				0b01000000
	#define		D_I2C_DIDOK					0b10000000		
	
#define P_I2C_ID				*(volatile unsigned char *)	(P_I2C_Ctrl_Base+0x02)		//0x3362
	#define		D_I2C_Write					0b00000000
	#define		D_I2C_Read					0b00000001	
#define P_I2C_Data				*(volatile unsigned char *)	(P_I2C_Ctrl_Base+0x03)		//0x3363
#define P_I2C_Debounce			*(volatile unsigned char *)	(P_I2C_Ctrl_Base+0x04)		//0x3364

//===============================================================
//               Buzzer base Control Registers
//               Base Address Start from 0x3371 
//===============================================================	
#define P_AUDIO_BZ_Ctrl			*(volatile unsigned char *) (P_Buzzer_Ctrl_Base+0x00)    //0x3371
	#define		D_BZSrc						0b00000001
	#define		D_BZOn						0b10000000	
	
//===============================================================
//               AUX base Registers
//               Base Address Start from 0x33D0 
//=============================================================== 
//=========  Bit Operation Register  ========= 
#define P_AUX_DataX             *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x00)		//0x33D0
#define P_AUX_DataY             *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x01)		//0x33D1
#define P_AUX_BPPExtend_IN      *(volatile unsigned char *) (P_AUX_Ctrl_Base+0X02)		//0x33D2
#define P_AUX_DataX_0H          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x06)		//0x33D6
#define P_AUX_DataX_0L          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x07)		//0x33D7
#define P_AUX_DataY_0H          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x08)		//0x33D8
#define P_AUX_DataY_0L          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x09)		//0x33D9
#define P_AUX_DataX_H0          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x0A)		//0x33DA
#define P_AUX_DataX_L0          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x0B)		//0x33DB
#define P_AUX_DataY_H0          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x0C)		//0x33DC
#define P_AUX_DataY_L0          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x0D)		//0x33DD
#define P_AUX_DataX_LH          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x0E)		//0x33DE
#define P_AUX_DataY_LH          *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x0F)		//0x33DF
#define P_AUX_DataXY_XLYH       *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x10)		//0x33E0
#define P_AUX_DataXY_YLXH       *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x11)		//0x33E1
#define P_AUX_DataX_Mirror      *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x12)		//0x33E2
#define P_AUX_DataY_Mirror      *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x13)		//0x33E3
#define P_AUX_BPPExtendOut_LB   *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x14)		//0x33E4
#define P_AUX_BPPExtendOut_HB   *(volatile unsigned char *) (P_AUX_Ctrl_Base+0x15)		//0x33E5

	
//===============================================================
//               LCD base Registers
//               Base Address Start from 0x3450 
//=============================================================== 
//==============  LCD Register  ==============
#define P_LCD_Ctrl1				*(volatile unsigned char *) (P_LCD_Ctrl_Base+0x00)		//0x3450
	#define		D_DisplayOn					0b00001000
	#define		D_LCDEn						0b10000000

#define P_LCD_Ctrl2				*(volatile unsigned char *) (P_LCD_Ctrl_Base+0x01)		//0x3451
	#define		D_LCDStrobeTimeMask			0b00001111
	#define		D_LCDStrobeEn				0b00010000
	#define		D_LCDAllOff					0b00100000
	#define		D_LCDAllOn					0b01000000
	
#define P_LCD_Clock				*(volatile unsigned char *) (P_LCD_Ctrl_Base+0x02)		//0x3452
	#define		D_LCDclk32K					0b00000000
	#define		D_LCDclk16K					0b00010000
	#define		D_LCDclk8K					0b00100000	
	#define		D_LCDclk4K					0b00110000	

#define P_LCD_SEG_Num			*(volatile unsigned char *)	(P_LCD_Ctrl_Base+0x03)		//0x3453
	#define		D_32SEG						0b00000011		
	#define		D_48SEG						0b00000101	
	
#define P_LCD_COM_Num			*(volatile unsigned char *)	(P_LCD_Ctrl_Base+0x04)		//0x3454		
	#define		D_5COM						0b00000100
	#define		D_9COM						0b00001000
	
#define P_LCD_FM_Ctrl			*(volatile unsigned char *)	(P_LCD_Ctrl_Base+0x05)		//0x3455
	#define		D_LCDBType					0b00000000
	#define		D_LCDCType					0b10000000	
	
#define P_LCD_VLCD_Ctrl			*(volatile unsigned char *)	(P_LCD_Ctrl_Base+0x06)		//0x3456

#define P_LCD_PUMP_Ctrl			*(volatile unsigned char *)	(P_LCD_Ctrl_Base+0x07)		//0x3457
	#define		D_PumpClk2K					0b00000000
	#define		D_PumpClk4K					0b00000001
	#define		D_PumpClk8K					0b00000010
	#define		D_PumpClk16K				0b00000011	
	#define		D_PumpEn					0b10000000
	
#define P_LCD_BIAS_Ctrl			*(volatile unsigned char *)	(P_LCD_Ctrl_Base+0x08)		//0x3458
	#define		D_LCDBias4					0b00000001
	#define		D_LCDBias3					0b00000010
	#define		D_LCDBias2					0b00000011
	
#define P_LCD_StartAddr_LB		*(volatile unsigned char *)	(P_LCD_Ctrl_Base+0x09)		//0x3459		

	
//===============================================================
//               PWMIO base Registers
//               Base Address Start from 0x3490 
//===============================================================
#define P_PWMIO_Ctrl			*(volatile unsigned char *)	(P_PWMIO_Ctrl_Base+0x00)	//0x3490
	#define		D_PWMIO0En					0b00000001
	#define		D_PWMIO1En					0b00000010
	#define		D_PWMIO2En					0b00000100	
	#define		D_PWMIO3En					0b00001000	
	#define		D_PWMClkSysClk				0b00000000
	#define		D_PWMClkSysClk8				0b00010000	
	#define		D_PWMClkSysClk64			0b00100000	
	#define		D_PWMClk32K					0b00110000
	#define		D_PWMClkTM0					0b01000000
	#define		D_PWMClkTM1					0b01010000	
	#define		D_PWMClkRFCTM0				0b01100000		
	#define		D_PWMClkRFCTM1				0b01110000	

#define P_PWMIO_Sel				*(volatile unsigned char *)	(P_PWMIO_Ctrl_Base+0x01)	//0x3491
#define P_PWMIO_Timer_Data		*(volatile unsigned char *)	(P_PWMIO_Ctrl_Base+0x02)	//0x3492
#define P_PWMIO_Timer_Cnt		*(volatile unsigned char *)	(P_PWMIO_Ctrl_Base+0x03)	//0x3493
			
#define P_PWMIO_IO0_DUTY		*(volatile unsigned char *)	(P_PWMIO_Ctrl_Base+0x04)	//0x3494
#define P_PWMIO_IO1_DUTY		*(volatile unsigned char *)	(P_PWMIO_Ctrl_Base+0x05)	//0x3495
#define P_PWMIO_IO2_DUTY		*(volatile unsigned char *)	(P_PWMIO_Ctrl_Base+0x06)	//0x3496
#define P_PWMIO_IO3_DUTY        *(volatile unsigned char *)	(P_PWMIO_Ctrl_Base+0x07)	//0x3497	
	
	
//===============================================================
//               RFC base Registers
//               Base Address Start from 0x34C0 
//===============================================================
#define P_RFC_Ctrl1				*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x01)		//0x34C1
	#define		D_AutoStop					0b01000000
	#define		D_RFCEn						0b00010000	
	#define		D_RFCStart					0b00000001	

#define P_RFC_Timer_Ctrl       	*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x03)		//0x34C3
	#define		D_RFCTM0En					0b00000001
	#define		D_RFCTM1En					0b00000010
	#define		D_RFCTM0ClkMask				0b00011100
	#define		D_RFCTM0ClkStop				0b00000000
	#define		D_RFCTM0ClkIO				0b00000100
	#define		D_RFCTM0ClkSysClk			0b00001100
	#define		D_RFCTM0ClkSysClk2			0b00010000
	#define		D_RFCTM0ClkRFC1				0b00010100
	#define		D_RFCTM0ClkRFC2				0b00011000
	#define		D_RFCTM0Clk32K				0b00011100
	
	#define		D_RFCTM1ClkMask				0b11100000
	#define		D_RFCTM1ClkStop				0b00000000
	#define		D_RFCTM1ClkSysClk			0b00100000
	#define		D_RFCTM1ClkSysClk2			0b01000000
	#define		D_RFCTM1ClkSysClk4			0b01100000
	#define		D_RFCTM1ClkSysClk8			0b10000000
	#define		D_RFCTM1ClkSysClk16			0b10100000
	#define		D_RFCTM1ClkSysClk32			0b11000000
	#define		D_RFCTM1Clk32K				0b11100000
	
#define P_RFC_Ctrl2				*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x04)		//0x34C4
	#define		D_RFCCaptureEdgeRising		0b00000000
	#define		D_RFCCaptureEdgeFalling		0b00000100		
	#define		D_RFCCaptureTrigDis			0b00000000	
	#define		D_RFCCaptureTrigTM0			0b00000001			
	
#define P_RFC_TM0Data_LB		*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x06)		//0x34C6
#define P_RFC_TM0Data_HB		*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x07)		//0x34C7
#define P_RFC_TM0Cnt_LB			*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x08)		//0x34C8
#define P_RFC_TM0Cnt_HB			*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x09)		//0x34C9

#define P_RFC_TM1Data_LB		*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x0A)		//0x34CA
#define P_RFC_TM1Data_HB		*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x0B)		//0x34CB
#define P_RFC_TM1Cnt_LB			*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x0C)		//0x34CC
#define P_RFC_TM1Cnt_HB			*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x0D)		//0x34CD

#define P_RFC_TM1CapData_LB		*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x0E)		//0x34CE
#define P_RFC_TM1CapData_HB		*(volatile unsigned char *)	(P_RFC_Ctrl_Base+0x0F)		//0x34CF	
 

//===============================================================
//		Interrupt Vector Index Define
//===============================================================
#define 	IRQ_EXT1		0
#define 	IRQ_EXT2		1
#define 	IRQ_ADC			2	
#define 	IRQ_TM0			3
#define 	IRQ_TM1			4
#define 	IRQ_SWT			5	
#define 	IRQ_TBH			6	
#define 	IRQ_TBL			7	
#define 	IRQ_FP			8 	
#define 	IRQ_KEY			9
#define 	IRQ_SPI			10 
#define 	IRQ_RFC_TM0		11
#define 	IRQ_RFC_TM1		12 
#define 	IRQ_UART		13
#define 	IRQ_PWMTM		14 
#define 	IRQ_I2C			15
#define 	IRQ_LVD			16
#define 	IRQ_Capture		17 	

#endif
#endif


