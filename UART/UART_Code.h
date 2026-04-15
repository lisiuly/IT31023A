#ifndef _UART_CODE_H
#define _UART_CODE_H


//==================================================================================
// Name                  : UART_Code.h
// Applied Body          : GPL815P Series
// Programmer            : 
// Description           : 
// History version       : v1.0.0
// 1.0.0     2014/10/15  Frank Kung     Oringinal Version
//==================================================================================

//; =======================================================================================
//; Function name : F_UART_Initial
//; Purpose       : Initial UART H/W
//; Parameter     : R_UART_Baudrate
//; Return        : None
//; Destroy       : A
//; ======================================================================================
extern void F_UART_Initial(void);
extern void Countdown(void);
    
//; =======================================================================================
//; Function name : F_UART_Baudrate
//; Purpose       : change UART baudrate 
//; Parameter     : Acc=Level
//;   Acc = 0 : Baudrate = 460800
//;   Acc = 1 : Baudrate = 230400
//;   Acc = 2 : Baudrate = 115200
//;   Acc = 3 : Baudrate = 76800
//;   Acc = 4 : Baudrate = 57600
//;   Acc = 5 : Baudrate = 38400
//;   Acc = 6 : Baudrate = 28800
//;   Acc = 7 : Baudrate = 19200
//;   Acc = 8 : Baudrate = 14400
//;   Acc = 9 : Baudrate = 9600
//;   Acc = A : Baudrate = 4800
//;   Acc = B : Baudrate = 2400
//;   Acc = C : Baudrate = 1200
//; Return        : A=0: Pass
//;                 A=1: Level error
//; Destroy       : A, Y 
//; ======================================================================================
extern void F_UART_Baudrate(void);
 
 
//; =======================================================================================
//; Function name : F_UART_Disable
//; Purpose       : Disable UART function
//; Parameter     : None
//; Return        : None
//; Destroy       : A
//; ======================================================================================
extern void F_UART_Disable(void);	
 
  	
// =======================================================================================
// Function name : F_UART_GetStatus
// Purpose       : Get UART Status (P_UART_Status)
// Parameter     : None 
// Return        : 	Acc = 0 , Status Pass
//					Acc = 1 , FrameError
//					Acc = 2 , ParityError
//					Acc = 3 , BreakError	
//					Acc = 4 , OverrunError
// Destroy       : A
// ======================================================================================	
extern void F_UART_GetStatus(void);

  	
// =======================================================================================
// Function name : IsUARTBusy
// Purpose       : Check UART Busy Flag
// Parameter     : None
// Return        : A :0:Idle, others:Busy
// Destroy       : A 
// ======================================================================================    
extern void IsUARTBusy(void);

// Play time-set confirmation voice constructed from current RTC: "xxxx年xx月xx日xx点xx分设置成功"
extern void Play_SetTimeVoice_FromKey(void);
	
 
//==========================================
// External declare area
//==========================================
extern unsigned char R_UART_Baudrate;
extern unsigned char R_UARTRX_Status;
extern unsigned char R_UART_CNT;

//extern unsigned char Databuff[];
extern unsigned char StatusBuff[];

//extern const unsigned char Tx_data[];
extern unsigned char temp;
extern unsigned char Rx_data_test[];// 接收数据测试备份数组（备份Databuff的前20个有效数据）
extern unsigned char t;               // 备份循环计数变量

extern void F_CheckKeyTone(void);

#endif