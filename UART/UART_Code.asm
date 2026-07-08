				.SYNTAX 6502
                .LINKLIST
                .SYMBOLS
                
;==================================================================================
; The information contained herein is the exclusive property of
; Generalplus Technology Co. And shall !be distributed, reproduced,
; or disclosed in whole in part without prior written permission.
;       (C) COPYRIGHT 2010   Generalplus TECHNOLOGY CO.                            
;                   ALL RIGHTS RESERVED
; The entire notice above must be reproduced on all authorized copies.
;==================================================================================
;==========================================================================
; Program Name: UART_Code.asm
; Applied body: GPL815P Series Body
; Programmer  : Frank Kung
; Description : UART Driver Code
; History version
; Rev #     Date       Who          Comments
; -----  -----------  -----------  --------------------------------------------
; 1.0     2014/10/22  Frank Kung    Oringinal Version
;==========================================================================


;==================================================================================
; Include file area
;==================================================================================
.INCLUDE	GPL815P.inc
;==================================================================================
;UART Hardware Configuration Define Area
;==================================================================================
.comment @
; System Clock = 8.192MHz
D_Baudrate_460800:			.EQU		0x0000
D_Baudrate_230400:			.EQU		0x0001
D_Baudrate_115200:			.EQU		0x0003
D_Baudrate_76800:			.EQU		0x0005
D_Baudrate_57600:			.EQU		0x0007
D_Baudrate_38400:			.EQU		0x000C
D_Baudrate_28800:			.EQU		0x0010
D_Baudrate_19200:			.EQU		0x0019
D_Baudrate_14400:			.EQU		0x0022
D_Baudrate_9600:			.EQU		0x0034
D_Baudrate_4800:			.EQU		0x0069
D_Baudrate_2400:			.EQU		0x00D4
D_Baudrate_1200:			.EQU		0x01A9

D_FMD_460800:				.EQU		0x0002
D_FMD_230400:				.EQU		0x0004
D_FMD_115200:				.EQU		0x0007
D_FMD_76800:				.EQU		0x000B
D_FMD_57600:				.EQU		0x000E
D_FMD_38400:				.EQU		0x0005
D_FMD_28800:				.EQU		0x000C
D_FMD_19200:				.EQU		0x000B
D_FMD_14400:				.EQU		0x0009
D_FMD_9600:					.EQU		0x0005
D_FMD_4800:					.EQU		0x000B
D_FMD_2400:					.EQU		0x0005
D_FMD_1200:					.EQU		0x000B
;@
;====================================================
.comment @
; System Clock = 4.096MHz
D_Baudrate_460800:			.EQU		0x0000		;can't used
D_Baudrate_230400:			.EQU		0x0000
D_Baudrate_115200:			.EQU		0x0001
D_Baudrate_76800:			.EQU		0x0002
D_Baudrate_57600:			.EQU		0x0003
D_Baudrate_38400:			.EQU		0x0005
D_Baudrate_28800:			.EQU		0x0007
D_Baudrate_19200:			.EQU		0x000C
D_Baudrate_14400:			.EQU		0x0010
D_Baudrate_9600:			.EQU		0x0019
D_Baudrate_4800:			.EQU		0x0034
D_Baudrate_2400:			.EQU		0x0069
D_Baudrate_1200:			.EQU		0x00D4

D_FMD_460800:				.EQU		0x0000		;can't used
D_FMD_230400:				.EQU		0x0002
D_FMD_115200:				.EQU		0x0004
D_FMD_76800:				.EQU		0x0005
D_FMD_57600:				.EQU		0x0007
D_FMD_38400:				.EQU		0x000B
D_FMD_28800:				.EQU		0x000E
D_FMD_19200:				.EQU		0x0005
D_FMD_14400:				.EQU		0x000C
D_FMD_9600:					.EQU		0x000B
D_FMD_4800:					.EQU		0x0005
D_FMD_2400:					.EQU		0x000B
D_FMD_1200:					.EQU		0x0005
;@
;====================================================
;.comment @
; System Clock = 2.048MHz
D_Baudrate_460800:			.EQU		0x0000		;can't used
D_Baudrate_230400:			.EQU		0x0000		;can't used
D_Baudrate_115200:			.EQU		0x0000
D_Baudrate_76800:			.EQU		0x0000
D_Baudrate_57600:			.EQU		0x0001
D_Baudrate_38400:			.EQU		0x0002
D_Baudrate_28800:			.EQU		0x0003
D_Baudrate_19200:			.EQU		0x0005
D_Baudrate_14400:			.EQU		0x0007
D_Baudrate_9600:			.EQU		0x000C
D_Baudrate_4800:			.EQU		0x0019
D_Baudrate_2400:			.EQU		0x0034
D_Baudrate_1200:			.EQU		0x0069

D_FMD_460800:				.EQU		0x0000		;can't used
D_FMD_230400:				.EQU		0x0002		;can't used
D_FMD_115200:				.EQU		0x0002
D_FMD_76800:				.EQU		0x000B
D_FMD_57600:				.EQU		0x0004
D_FMD_38400:				.EQU		0x0005
D_FMD_28800:				.EQU		0x0007
D_FMD_19200:				.EQU		0x000B
D_FMD_14400:				.EQU		0x000E
D_FMD_9600:					.EQU		0x0005
D_FMD_4800:					.EQU		0x000B
D_FMD_2400:					.EQU		0x0005
D_FMD_1200:					.EQU		0x000B
;@
;==================================================================================
;UART Driver Constant Define Area
;==================================================================================

;==================================================================================
; Function External declare area
;==================================================================================

;==================================================================================
; Function Public area
;==================================================================================
.PUBLIC	F_UART_Initial
.PUBLIC	F_UART_Baudrate
.PUBLIC	F_UART_Disable
.PUBLIC F_UART_GetStatus
.PUBLIC IsUARTBusy

.PUBLIC	_F_UART_Initial
.PUBLIC	_F_UART_Baudrate
.PUBLIC	_F_UART_Disable
.PUBLIC _F_UART_GetStatus
.PUBLIC _IsUARTBusy

;==================================================================================
; Variable Public area
;==================================================================================
.PUBLIC	R_UART_Baudrate
.PUBLIC	R_UARTRX_Status
.PUBLIC	R_UART_CNT

.PUBLIC	_R_UART_Baudrate
.PUBLIC	_R_UARTRX_Status
.PUBLIC	_R_UART_CNT

.PUBLIC	CLOCK_FLAG_ASR
.PUBLIC	_CLOCK_FLAG_ASR
;==================================================================================
; Variable RAM declare area
;==================================================================================
;UART_Page0RAM:    .SECTION      .PAGE0
;
;.ENDS      
 .PAGE0
;UART_PageNRAM:    .SECTION		
R_UART_Baudrate		DS	1
_R_UART_Baudrate		.EQU	R_UART_Baudrate

R_UARTRX_Status		DS	1
_R_UARTRX_Status		.EQU	R_UARTRX_Status

R_UART_CNT			DS	1
_R_UART_CNT				.EQU	R_UART_CNT

CLOCK_FLAG_ASR		ds	1
_CLOCK_FLAG_ASR		equ		CLOCK_FLAG_ASR
.ENDS
;=============================================
; Code area
;=============================================                                  
;UART_Code:    .SECTION
.CODE
; =======================================================================================
; Function name : F_UART_Initial
; Purpose       : Initial UART H/W
; Parameter     : R_UART_Baudrate
; Return        : None
; Destroy       : A
; ======================================================================================
F_UART_Initial:
_F_UART_Initial:
	

;	R_UART_CNT = 0x00;
;	R_UARTRX_Status = 0xFF;
;	F_Clear_buffs();
;	/* Add your code here */
;	R_UART_Baudrate = 0x02; //115200hz		
	LDA		#00
	STA		R_UART_CNT
	LDA		#0xff
	STA		R_UARTRX_Status
	LDA		#0x09
	STA		R_UART_Baudrate
;
	
	LDA		#D_UARTReset+D_UARTEn+D_UARTTxIntEn;+D_UARTRxTimeoutIntEn
	STA		P_UART_Ctrl1

	LDA		#D_UARTStopBit1+D_UARTFIFOEn+D_UARTDataBit8	;	D_UARTParityEn+D_UARTParityOdd+
	STA		P_UART_Ctrl2
	
	LDA		R_UART_Baudrate
	JSR		F_UART_Baudrate


	RTS

; =======================================================================================
; Function name : F_UART_Baudrate
; Purpose       : change UART baudrate 
; Parameter     : Acc=Level
;   Acc = 0 : Baudrate = 460800
;   Acc = 1 : Baudrate = 230400
;   Acc = 2 : Baudrate = 115200
;   Acc = 3 : Baudrate = 76800
;   Acc = 4 : Baudrate = 57600
;   Acc = 5 : Baudrate = 38400
;   Acc = 6 : Baudrate = 28800
;   Acc = 7 : Baudrate = 19200
;   Acc = 8 : Baudrate = 14400
;   Acc = 9 : Baudrate = 9600
;   Acc = A : Baudrate = 4800
;   Acc = B : Baudrate = 2400
;   Acc = C : Baudrate = 1200
; Return        : A=0: Pass
;                 A=1: Level error
; Destroy       : A, Y 
; ======================================================================================
F_UART_Baudrate:
_F_UART_Baudrate:
	CMP		#0Dh
	BCC		L_BaudrateSel?
	LDA		#1
	RTS
	
L_BaudrateSel?:
	CLC
	ROL		A
	TAY
	LDA		T_BaudrateSel,Y
	STA		P_UART_BaudRate_LB
	LDA		T_BaudrateSel+1,Y
	STA		P_UART_BaudRate_HB
	LDA		T_BaudrateSel_FMD,Y
	STA		P_UART_FMD
	LDA     #0
    RTS

T_BaudrateSel:
	.DW		D_Baudrate_460800, D_Baudrate_230400, D_Baudrate_115200, D_Baudrate_76800
	.DW		D_Baudrate_57600, D_Baudrate_38400, D_Baudrate_28800, D_Baudrate_19200
	.DW		D_Baudrate_14400, D_Baudrate_9600, D_Baudrate_4800, D_Baudrate_2400
	.DW		D_Baudrate_1200
	
T_BaudrateSel_FMD:	
	.DW		D_FMD_460800, D_FMD_230400, D_FMD_115200, D_FMD_76800
	.DW		D_FMD_57600, D_FMD_38400, D_FMD_28800, D_FMD_19200
	.DW		D_FMD_14400, D_FMD_9600, D_FMD_4800, D_FMD_2400
	.DW		D_FMD_1200	
	
	RTS	
	
; =======================================================================================
; Function name : F_UART_Disable
; Purpose       : Disable UART function
; Parameter     : None
; Return        : None
; Destroy       : A
; ======================================================================================
F_UART_Disable:	
_F_UART_Disable:
	BIT		P_UART_Status2
	BPL		F_UART_Disable		; wait tx transfer complete
	LDA		#0
	STA		P_UART_Ctrl1
	RTS
	
; =======================================================================================
; Function name : F_UART_GetStatus
; Purpose       : Get UART Status (P_UART_Status)
; Parameter     : None 
; Return        : 	Acc = 0 , Status Pass
;					Acc = 1 , FrameError
;					Acc = 2 , ParityError
;					Acc = 3 , BreakError	
;					Acc = 4 , OverrunError
; Destroy       : A
; ======================================================================================	
F_UART_GetStatus:	
_F_UART_GetStatus:		
	LDA		P_UART_RX_Status	
	AND		#D_FrameErrorFlag+D_ParityErrorFlag+D_BreakErrorFlag+D_OverrunErrorFlag
	STA		R_UARTRX_Status
	BEQ		L_UART_Status_Pass?
	
	LDA		P_UART_RX_Status
	AND		#D_FrameErrorFlag
	BNE		L_FrameError?
	
	LDA		P_UART_RX_Status
	AND		#D_ParityErrorFlag
	BNE		L_ParityError?
	
	LDA		P_UART_RX_Status
	AND		#D_BreakErrorFlag
	BNE		L_BreakError?	
	
	LDA		P_UART_RX_Status
	AND		#D_OverrunErrorFlag
	BNE		L_OverrunError?
	
	
L_UART_Status_Pass?:			
	LDA		#0				
	RTS
L_FrameError?:
	LDA		#1
	RTS
L_ParityError?:
	LDA		#2
	RTS	
L_BreakError?:
	LDA		#3
	RTS		
L_OverrunError?:
	LDA		#4
	RTS
	
; =======================================================================================
; Function name : IsUARTBusy
; Purpose       : Check UART Busy Flag
; Parameter     : None
; Return        : A :0:Idle, others:Busy
; Destroy       : A 
; ======================================================================================    
IsUARTBusy:
_IsUARTBusy:
	STA		P_WDT_Clear
    LDA     P_UART_Status2
    AND     #D_UARTBusy
    BNE		IsUARTBusy
    RTS	
  
