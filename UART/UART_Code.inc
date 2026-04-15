.IFNDEF _UART_Code_inc_
_UART_Code_inc_:    .EQU    1

;==================================================================================
; The information contained herein is the exclusive property of
; Generalplus Technology Co. And shall not be distributed, reproduced,
; or disclosed in whole in part without prior written permission.
;       (C) COPYRIGHT 2009   Generalplus TECHNOLOGY CO.                            
;                   ALL RIGHTS RESERVED
; The entire notice above must be reproduced on all authorized copies.
;==================================================================================
;==================================================================================
; Name                  : UART_Code.inc
; Applied Body          : GPL815P Series
; Programmer            : 
; Description           : 
; History version       : v1.0.0
; 1.0.0     2014/10/22  Frank Kung     Oringinal Version 
;==================================================================================
; =======================================================================================
; Function name : F_UART_Initial
; Purpose       : Initial UART H/W
; Parameter     : None
; Return        : None
; Destroy       : A
; ======================================================================================
.external F_UART_Initial 

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
; Destroy       : A,Y 
; ======================================================================================
.external F_UART_Baudrate  

; =======================================================================================
; Function name : F_UART_Disable
; Purpose       : Disable UART function
; Parameter     : None
; Return        : None
; Destroy       : A
; ======================================================================================
.external F_UART_Disable

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
.external F_UART_GetStatus

; =======================================================================================
; Function name : IsUARTBusy
; Purpose       : Check UART Busy Flag
; Parameter     : None
; Return        : A :0:Idle, others:Busy
; Destroy       : A 
; ======================================================================================    
.external IsUARTBusy

;==========================================
; External declare area
;==========================================
.external R_UART_Baudrate
.external R_UARTRX_Status
.external R_UART_CNT
.ENDIF
  