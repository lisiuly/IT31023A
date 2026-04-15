;=====================================================================
; File Name   : cstartup.asm
; Description : Startup routine for GPL815P
;               This file contains the 6502 C startup routine           
;               and must usually be tailored to suit customer's hardware
; Body        : GPL815P series 6502 CPU 
; Toolchain   : gp65cc V0.9x
; Date        : 09/09/2014 
;=====================================================================
.INCLUDE	GPL815P.inc

;=====================================================================
; Basic Settings for User
;=====================================================================
; Initial types:
	INIT_NPAGE:			.DEFL 1				; Initial the NPAGE data
; Actions after main():
;	HINT: please setup only 'ONE' of the followings.
	LOOP_AT_END:		.DEFL 1				; Endless waiting after main()
	SW_BRK:				.DEFL 0				; Entering SBK instruction
	HW_HALT:			.DEFL 0				; Exception of invalid instruction

;=====================================================================
; GLOBAL area
;=====================================================================
	.GLOBAL _V_RESET
	.GLOBAL __program_end
	
;=====================================================================
; EXTERN area
;=====================================================================
	.EXTERN _main									; where to begin execution
	.EXTERN _low_level_init				; user added init code
	.EXTERN _V_NMI

;=====================================================================
; EXTERN area of section info (FIXME, in future)
;=====================================================================
	.EXTERN GPAddressOf_PAGE0
	.EXTERN GPSizeOf_PAGE0
	.EXTERN GPAddressOf_NSEC
	.EXTERN GPSizeOf_NSEC
	.EXTERN GPAddressOf_INIT_TAB			; address of init table
	.EXTERN GPSizeOf_INIT_TAB				; size of init table
	.EXTERN GPAddressOf_CODE				; address of init table

;=====================================================================
; PUBLIC area
;=====================================================================
	.PUBLIC	V_RESET
	.PUBLIC	_P_BANK_Sel

;=====================================================================
; Temporary data area
;=====================================================================
	_P_BANK_Sel:				.EQU	P_BANK_Sel
	
	INS_SRC_ADDR_L:				.EQU 0x00	; low addr of source
	INS_SRC_ADDR_H:				.EQU 0x01	; high addr of source
	
	INS_SRC_SIZE_L:				.EQU 0x02	; low size of source
	INS_SRC_SIZE_H:				.EQU 0x03	; high size of source
	
	INS_DES_ADDR_L:				.EQU 0x04	; low addr of destination
	INS_DES_ADDR_H:				.EQU 0x05	; high addr of destination

	INS_INIT_TAB_SIZE:			.EQU 0x06	; size of INIT_TAB
	
	TEMPCOUNT_SIZE_H:			.EQU 0x07	
	OFFSET_INIT_TAB:			.EQU 0x08
	
	TAB_RCRD_SIZE:				.EQU 0x7	; record size in init table

;=====================================================================
; Starting setup/reset code 
; GSINIT0 - where the execution actually begins
;=====================================================================
GSINIT0:         .SECTION
_V_RESET:
V_RESET:
	CLD						; set default mode
	LDX	#0xFF				; set up stack pointer
	TXS
;=====================================================================
; Call __low_level_init to perform initialization 
; before initializing segments and calling main.
; If the function returns 0 no segment initialization should take place.
; Link with your own version of __low_level_init 
; to override the default action: to do nothing but return 1.
;=====================================================================	
	JSR	_low_level_init
	TAY						; test return value
	BNE seg_init
	JMP seg_init_end		; ready to execute GSINIT
;=====================================================================	
; Copy initialized PROMmed code to shadow RAM and clear
; uninitialized variables.
;=====================================================================	
seg_init:					; seg_init() start

;=======================================
; Copy N_CDATA into N_IDATA (option)
;=======================================
.IF INIT_NPAGE
; Read the size of INIT_TAB
	LDA	#.HIGH8.GPSizeOf_INIT_TAB
	STA	P_BANK_Sel
 	LDA #.LOW.GPSizeOf_INIT_TAB
 	STA INS_INIT_TAB_SIZE
	BEQ skip5
	LDX #0x00
	STX OFFSET_INIT_TAB			; support up to 36 (=255/7) initial xdata sections
loop5:
; Copy N_CDATA into N_IDATA according to the INIT_TAB's record
	JSR _copy_mem
skip6:
; for(INS_INIT_TAB_SIZE; INS_INIT_TAB_SIZE > 0; INS_INIT_TAB_SIZE -= TAB_RCRD_SIZE)
	LDA	INS_INIT_TAB_SIZE
	SEC
	SBC	#TAB_RCRD_SIZE
	STA	INS_INIT_TAB_SIZE
	BNE	loop5
skip5:
	LDA	#.HIGH8.__program_startup
	STA P_BANK_Sel					; save bank ID to _P_BANK_Sel
	JMP seg_init_end				; ready to execute GSINIT
		
_copy_mem:
; Load rescord in INIT_TAB
; Setup start address of des
	LDX OFFSET_INIT_TAB
	LDA GPAddressOf_INIT_TAB, X		; load des's low addr
	STA INS_DES_ADDR_L
	INX
	LDA GPAddressOf_INIT_TAB, X		; load des's high addr
	STA INS_DES_ADDR_H
; Setup start address of source
	INX
	LDA GPAddressOf_INIT_TAB, X		; load src's low addr
	STA INS_SRC_ADDR_L
	INX
	LDA GPAddressOf_INIT_TAB, X		; load src's high addr
	STA INS_SRC_ADDR_H
	INX
	LDA GPAddressOf_INIT_TAB, X		; load bank ID
	STA  P_BANK_Sel				; save bank ID to _P_BANK_Sel
	INX
; Setup size of source
	LDA GPAddressOf_INIT_TAB, X		; load src's low size
	STA INS_SRC_SIZE_L
	INX
	LDA GPAddressOf_INIT_TAB, X		; load src's high size
	STA INS_SRC_SIZE_H
	INX
	STX OFFSET_INIT_TAB
; Start copy
	LDA #0x00
	TAY
	LDX INS_SRC_SIZE_H				; copy blocks
	BEQ skip7
loop6:
	LDA (INS_SRC_ADDR_L), Y
	STA (INS_DES_ADDR_L), Y
	INY
	BNE loop6
	INC INS_SRC_ADDR_H
	INC INS_DES_ADDR_H
	DEX
	BNE loop6
skip7:
	LDX INS_SRC_SIZE_L				; copy the rest
	BEQ skip8
loop7:
	LDA (INS_SRC_ADDR_L), Y
	STA (INS_DES_ADDR_L), Y
	INY
	DEX
	BNE loop7
skip8:
	RTS
.ENDIF

seg_init_end:
; seg_init() end
                 .ENDS

GSFINAL:         .SECTION
	JMP	__program_startup
                 .ENDS

.CODE
__program_startup:
	JSR _main				; execute main()
;=====================================================================	
; Now when we are ready with our C program we must perform a
; system-dependent action. Slecet one of the followings.
;=====================================================================
__program_end:
.IF	LOOP_AT_END
	JMP	$					; 1. Endless Loop
.ENDIF
.IF SW_BRK
	BRK						; 2. BRK for debuggger
.ENDIF
.IF HW_HALT
	.DB 4Bh					; 3. Invalid code
.ENDIF
                 .ENDS

