; or disclosed in whole in part without prior written permission.
;       (C) COPYRIGHT 2009   Generalplus TECHNOLOGY CO.                            
;                   ALL RIGHTS RESERVED
; The entire notice above must be reproduced on all authorized copies.
;==================================================================================
;==================================================================================
; Name                  : lcd.inc
; Applied Body          : GPL815PX
; Programmer            : yanxiaodu
; Description           : lcd macro
; History version       : v1.0  2011/06/21 by yanxiaodu first modify
;==================================================================================

;==========================================
; Compiler parameter define
;==========================================
.SYNTAX 6502
.LINKLIST
.SYMBOLS

;==========================================
; Constant define area
;==========================================



;==========================================
; Include file area
;==========================================



;==========================================
; External declare area
;==========================================

;==========================================
; Public declare area
;==========================================



;==========================================
;Variable RAM declare area
;==========================================


;==========================================
; code starting 
;==========================================
.CODE

;=============================
;X:byte index. A:mask bit
; ==============================================
; Macro name	: %F_SetByteBit 
; Purpose	    : set BYTE Bit
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
%F_SetByteBit: .MACRO
		STA		R_Temp0
		LDA		R_LcdBuff,X			; use buffer directly
		ORA		R_Temp0
		STA		R_LcdBuff,X
		.ENDM
;======
;X:byte index. A:mask bit
; ==============================================
; Macro name	: %F_ClearByteBit 
; Purpose	    : Clear BYTE Bit
; Parameter		: A,X
; Return    	: 
; Destroy	    : 
; Stack depth	: 2
; ==============================================
%F_ClearByteBit: .MACRO
		STA		R_Temp0
		LDA		R_LcdBuff,X			; use buffer directly
		ORA		R_Temp0
		EOR		R_Temp0
		STA		R_LcdBuff,X
		.ENDM

;
;LCDConvert		.MACRO  com,seg
;			DB	com*06H+(seg/8)+00H,1<<(seg.AND.07H)	
;			
;			.ENDM
;			
;%LCD7S        .MACRO   i1c,i1s,i2c,i2s,i3c,i3s,i4c,i4s,i5c,i5s,i6c,i6s,i7c,i7s
;               LCDConvert    i1c,i1s
;               LCDConvert    i2c,i2s
;               LCDConvert    i3c,i3s
;               LCDConvert    i4c,i4s
;               LCDConvert    i5c,i5s
;               LCDConvert    i6c,i6s
;               LCDConvert    i7c,i7s
;               .ENDM
;               
;%LCD8S:        .MACRO   i1c,i1s,i2c,i2s,i3c,i3s,i4c,i4s,i5c,i5s,i6c,i6s,i7c,i7s,i8c,i8s
;               LCDConvert    i1c,i1s
;               LCDConvert    i2c,i2s
;               LCDConvert    i3c,i3s
;               LCDConvert    i4c,i4s
;               LCDConvert    i5c,i5s
;               LCDConvert    i6c,i6s
;               LCDConvert    i7c,i7s
;		       LCDConvert    i8c,i8s
;               .ENDM  	
;;================================================================
;Kind   :Count Loop
;================================================================		                    
%DJNZ:               .MACRO       Var,Lable    ;  !=0
                      DEC          Var
                      BNE          Lable
                     .ENDM
		
;----------------------------------------------------------
;/***********************************************/
;         i.L=1 
%bits:   .MACRO   i,L             ;BYTE i;  
          lda     i               ;ex.  
          ora     #L              ;  %bits 10H,_BIT0
		                   ;  10H.0=1
          sta     i               ;
         .ENDM    

;/***********************************************/
;         i.L=0
%bitr:   .MACRO   i,L             ;BYTE i;  
          lda     i               ;ex.  
          and     #.NOT.L         ;  %bitr 10H,_BIT0;  10H.0=0
          sta     i
         .ENDM    

;/***********************************************/
;         if(i.L==1) goto N
%btst:   .MACRO   i,L,N           ;BYTE i;  
          lda     i               ;ex.   
          and     #L              ;  %btst 10H,_BIT0,N
          bne     N               ;  if(10H.0=1) goto N 
         .ENDM    
                                  
;/***********************************************/
;         if(i.L==0) goto N
%btsf:   .MACRO   i,L,N           ;BYTE i;    
          lda     i               ;ex.   
          and     #L              ;  %btsf 10H,_BIT0,N
          beq     N               ;  if(10H.0=0) goto N 
         .ENDM    
  		                    
