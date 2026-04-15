D_Bit0					equ		01H
D_Bit1					equ		02H
D_Bit2					equ		04H
D_Bit3					equ		08H
D_Bit4					equ		10H
D_Bit5					equ		20H
D_Bit6					equ		40H
D_Bit7					equ		80H


;==========================================================================
LCDConvert		.MACRO  com,seg
			DB	com*10H+(seg/8)+00H,1<<(seg.AND.07H)	;GPL813P01;
			
			.ENDM
			
%LCD7S        .MACRO   i1c,i1s,i2c,i2s,i3c,i3s,i4c,i4s,i5c,i5s,i6c,i6s,i7c,i7s
               LCDConvert    i1c,i1s
               LCDConvert    i2c,i2s
               LCDConvert    i3c,i3s
               LCDConvert    i4c,i4s
               LCDConvert    i5c,i5s
               LCDConvert    i6c,i6s
               LCDConvert    i7c,i7s
               .ENDM
               
%LCD8S:        .MACRO   i1c,i1s,i2c,i2s,i3c,i3s,i4c,i4s,i5c,i5s,i6c,i6s,i7c,i7s,i8c,i8s
               LCDConvert    i1c,i1s
               LCDConvert    i2c,i2s
               LCDConvert    i3c,i3s
               LCDConvert    i4c,i4s
               LCDConvert    i5c,i5s
               LCDConvert    i6c,i6s
               LCDConvert    i7c,i7s
		       LCDConvert    i8c,i8s
               .ENDM  
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
 