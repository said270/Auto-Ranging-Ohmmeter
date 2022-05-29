
;CodeVisionAVR C Compiler V3.48b Evaluation
;(C) Copyright 1998-2022 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPMCSR=0x37
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.EQU __FLASH_PAGE_SIZE=0x40

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETW1P
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETD1P_INC
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	.ENDM

	.MACRO __GETD1P_DEC
	LD   R23,-X
	LD   R22,-X
	LD   R31,-X
	LD   R30,-X
	.ENDM

	.MACRO __PUTDP1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTDP1_DEC
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __CPD10
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	.ENDM

	.MACRO __CPD20
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	.ENDM

	.MACRO __ADDD12
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	.ENDM

	.MACRO __ADDD21
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	.ENDM

	.MACRO __SUBD12
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	.ENDM

	.MACRO __SUBD21
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	.ENDM

	.MACRO __ANDD12
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	.ENDM

	.MACRO __ORD12
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	.ENDM

	.MACRO __XORD12
	EOR  R30,R26
	EOR  R31,R27
	EOR  R22,R24
	EOR  R23,R25
	.ENDM

	.MACRO __XORD21
	EOR  R26,R30
	EOR  R27,R31
	EOR  R24,R22
	EOR  R25,R23
	.ENDM

	.MACRO __COMD1
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	.ENDM

	.MACRO __MULD2_2
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	.ENDM

	.MACRO __LSRD1
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	.ENDM

	.MACRO __LSLD1
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	.ENDM

	.MACRO __ASRB4
	ASR  R30
	ASR  R30
	ASR  R30
	ASR  R30
	.ENDM

	.MACRO __ASRW8
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	.ENDM

	.MACRO __LSRD16
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	.ENDM

	.MACRO __LSLD16
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	.ENDM

	.MACRO __CWD1
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	.ENDM

	.MACRO __CWD2
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	.ENDM

	.MACRO __SETMSD1
	SER  R31
	SER  R22
	SER  R23
	.ENDM

	.MACRO __ADDW1R15
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	.ENDM

	.MACRO __ADDW2R15
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	.ENDM

	.MACRO __EQB12
	CP   R30,R26
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __NEB12
	CP   R30,R26
	LDI  R30,1
	BRNE PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12
	CP   R30,R26
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12
	CP   R26,R30
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12
	CP   R26,R30
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12
	CP   R30,R26
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12U
	CP   R30,R26
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12U
	CP   R26,R30
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12U
	CP   R26,R30
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12U
	CP   R30,R26
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __CPW01
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	.ENDM

	.MACRO __CPW02
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	.ENDM

	.MACRO __CPD12
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	.ENDM

	.MACRO __CPD21
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	.ENDM

	.MACRO __BSTB1
	CLT
	TST  R30
	BREQ PC+2
	SET
	.ENDM

	.MACRO __LNEGB1
	TST  R30
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __LNEGW1
	OR   R30,R31
	LDI  R30,1
	BREQ PC+2
	LDI  R30,0
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R5
	.DEF __lcd_y=R4
	.DEF __lcd_maxx=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0xC:
	.DB  0x5,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
_0x0:
	.DB  0x57,0x65,0x6C,0x63,0x6F,0x6D,0x65,0x0
	.DB  0x25,0x75,0x0,0x52,0x3D,0x0,0x20,0x6D
	.DB  0x69,0x63,0x72,0x6F,0x6F,0x68,0x6D,0x0
	.DB  0x20,0x20,0x20,0x20,0x52,0x61,0x6E,0x67
	.DB  0x65,0x20,0x30,0x0,0x20,0x20,0x20,0x20
	.DB  0x52,0x61,0x6E,0x67,0x65,0x20,0x31,0x0
	.DB  0x20,0x6D,0x69,0x6C,0x6C,0x69,0x6F,0x68
	.DB  0x6D,0x0,0x20,0x6F,0x68,0x6D,0x0,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x52,0x61,0x6E,0x67,0x65,0x20,0x32,0x0
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x52,0x61,0x6E,0x67,0x65,0x20,0x33
	.DB  0x0,0x20,0x6B,0x6F,0x68,0x6D,0x0,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x52,0x61,0x6E,0x67,0x65,0x20,0x34,0x0
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x52,0x61,0x6E,0x67,0x65,0x20,0x35
	.DB  0x0,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x52,0x61,0x6E,0x67,0x65,0x20
	.DB  0x36,0x0,0x20,0x4D,0x6F,0x68,0x6D,0x0
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x52,0x61,0x6E,0x67,0x65,0x20,0x37
	.DB  0x0
_0x2020008:
	.DB  0xA
_0x2020009:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
_0x2020016:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
_0x2040003:
	.DB  0x80,0xC0
_0x2060060:
	.DB  0x1
_0x2060000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x08
	.DW  _0x10
	.DW  _0x0*2

	.DW  0x03
	.DW  _0x10+8
	.DW  _0x0*2+11

	.DW  0x0A
	.DW  _0x10+11
	.DW  _0x0*2+14

	.DW  0x0C
	.DW  _0x10+21
	.DW  _0x0*2+24

	.DW  0x03
	.DW  _0x10+33
	.DW  _0x0*2+11

	.DW  0x0A
	.DW  _0x10+36
	.DW  _0x0*2+14

	.DW  0x0C
	.DW  _0x10+46
	.DW  _0x0*2+24

	.DW  0x03
	.DW  _0x10+58
	.DW  _0x0*2+11

	.DW  0x0A
	.DW  _0x10+61
	.DW  _0x0*2+14

	.DW  0x0C
	.DW  _0x10+71
	.DW  _0x0*2+36

	.DW  0x03
	.DW  _0x10+83
	.DW  _0x0*2+11

	.DW  0x0A
	.DW  _0x10+86
	.DW  _0x0*2+48

	.DW  0x0C
	.DW  _0x10+96
	.DW  _0x0*2+36

	.DW  0x03
	.DW  _0x10+108
	.DW  _0x0*2+11

	.DW  0x05
	.DW  _0x10+111
	.DW  _0x0*2+58

	.DW  0x11
	.DW  _0x10+116
	.DW  _0x0*2+63

	.DW  0x03
	.DW  _0x10+133
	.DW  _0x0*2+11

	.DW  0x05
	.DW  _0x10+136
	.DW  _0x0*2+58

	.DW  0x11
	.DW  _0x10+141
	.DW  _0x0*2+80

	.DW  0x03
	.DW  _0x10+158
	.DW  _0x0*2+11

	.DW  0x06
	.DW  _0x10+161
	.DW  _0x0*2+97

	.DW  0x11
	.DW  _0x10+167
	.DW  _0x0*2+103

	.DW  0x03
	.DW  _0x10+184
	.DW  _0x0*2+11

	.DW  0x06
	.DW  _0x10+187
	.DW  _0x0*2+97

	.DW  0x11
	.DW  _0x10+193
	.DW  _0x0*2+120

	.DW  0x03
	.DW  _0x10+210
	.DW  _0x0*2+11

	.DW  0x06
	.DW  _0x10+213
	.DW  _0x0*2+97

	.DW  0x11
	.DW  _0x10+219
	.DW  _0x0*2+137

	.DW  0x03
	.DW  _0x10+236
	.DW  _0x0*2+11

	.DW  0x06
	.DW  _0x10+239
	.DW  _0x0*2+97

	.DW  0x11
	.DW  _0x10+245
	.DW  _0x0*2+137

	.DW  0x03
	.DW  _0x10+262
	.DW  _0x0*2+11

	.DW  0x06
	.DW  _0x10+265
	.DW  _0x0*2+154

	.DW  0x11
	.DW  _0x10+271
	.DW  _0x0*2+160

	.DW  0x01
	.DW  _d10_G101
	.DW  _0x2020008*2

	.DW  0x02
	.DW  __base_y_G102
	.DW  _0x2040003*2

	.DW  0x01
	.DW  __seed_G103
	.DW  _0x2060060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x260

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;unsigned int read_adc(unsigned char adc_input)
; 0000 0028 {

	.CSEG
_read_adc:
; .FSTART _read_adc
; 0000 0029 ADMUX=adc_input | ADC_VREF_TYPE;
	ST   -Y,R17
	MOV  R17,R26
;	adc_input -> R17
	MOV  R30,R17
	ORI  R30,0x40
	OUT  0x7,R30
; 0000 002A // Delay needed for the stabilization of the ADC input voltage
; 0000 002B delay_us(10);
	__DELAY_USB 27
; 0000 002C // Start the AD conversion
; 0000 002D ADCSRA|=(1<<ADSC);
	SBI  0x6,6
; 0000 002E // Wait for the AD conversion to complete
; 0000 002F while ((ADCSRA & (1<<ADIF))==0);
_0x3:
	SBIS 0x6,4
	RJMP _0x3
; 0000 0030 ADCSRA|=(1<<ADIF);
	SBI  0x6,4
; 0000 0031 return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	LD   R17,Y+
	RET
; 0000 0032 }
; .FEND
;void lcd_WriteResult(unsigned long int result){
; 0000 0034 void lcd_WriteResult(unsigned long int result){
_lcd_WriteResult:
; .FSTART _lcd_WriteResult
; 0000 0035 int i=0;
; 0000 0036 unsigned long int num=0;
; 0000 0037 int Size=0;
; 0000 0038 unsigned char   lcd_value2[16];
; 0000 0039 while (result !=0){
	RCALL __PUTPARD2
	SBIW R28,20
	LDI  R30,LOW(0)
	STD  Y+16,R30
	STD  Y+17,R30
	STD  Y+18,R30
	STD  Y+19,R30
	RCALL __SAVELOCR4
;	result -> Y+24
;	i -> R16,R17
;	num -> Y+20
;	Size -> R18,R19
;	lcd_value2 -> Y+4
	__GETWRN 16,17,0
	__GETWRN 18,19,0
_0x6:
	__GETD1S 24
	__CPD10
	BREQ _0x8
; 0000 003A num=result%10;
	RCALL SUBOPT_0x0
	RCALL __MODD21U
	RCALL SUBOPT_0x1
; 0000 003B result=result/10;
	RCALL SUBOPT_0x0
	RCALL __DIVD21U
	__PUTD1S 24
; 0000 003C lcd_value2[Size]=num;
	MOVW R30,R18
	MOVW R26,R28
	ADIW R26,4
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+20
	STD  Z+0,R26
; 0000 003D Size++;
	__ADDWRN 18,19,1
; 0000 003E delay_ms(20);
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
; 0000 003F }
	RJMP _0x6
_0x8:
; 0000 0040 i=Size-1;
	MOVW R30,R18
	SBIW R30,1
	MOVW R16,R30
; 0000 0041 for (i;i>=0;i--){
_0xA:
	TST  R17
	BRMI _0xB
; 0000 0042 lcd_putchar(lcd_value2[i]+48);
	MOVW R26,R28
	ADIW R26,4
	ADD  R26,R16
	ADC  R27,R17
	LD   R30,X
	SUBI R30,-LOW(48)
	MOV  R26,R30
	RCALL _lcd_putchar
; 0000 0043 delay_ms(20);
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0044 }
	__SUBWRN 16,17,1
	RJMP _0xA
_0xB:
; 0000 0045 
; 0000 0046 }
	RCALL __LOADLOCR4
	ADIW R28,28
	RET
; .FEND
;void main(void)
; 0000 004A {
_main:
; .FSTART _main
; 0000 004B 
; 0000 004C unsigned long int test=0;
; 0000 004D float V_out=0;
; 0000 004E unsigned long int    V_in=5;
; 0000 004F float     Res_known;
; 0000 0050 unsigned long int     Res_unknown;
; 0000 0051 unsigned char   lcd_value[16];
; 0000 0052 
; 0000 0053 // Declare your local variables here
; 0000 0054 
; 0000 0055 // Input/Output Ports initialization
; 0000 0056 // Port A initialization
; 0000 0057 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0058 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (1<<DDA2) | (0<<DDA1) | (0<<DDA0);
	SBIW R28,36
	LDI  R24,12
	__GETWRN 22,23,24
	LDI  R30,LOW(_0xC*2)
	LDI  R31,HIGH(_0xC*2)
	RCALL __INITLOCB
;	test -> Y+32
;	V_out -> Y+28
;	V_in -> Y+24
;	Res_known -> Y+20
;	Res_unknown -> Y+16
;	lcd_value -> Y+0
	LDI  R30,LOW(4)
	OUT  0x1A,R30
; 0000 0059 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 005A PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (1<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(2)
	OUT  0x1B,R30
; 0000 005B 
; 0000 005C // Port B initialization
; 0000 005D // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 005E DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(0)
	OUT  0x17,R30
; 0000 005F // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0060 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 0061 
; 0000 0062 // Port C initialization
; 0000 0063 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0064 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 0065 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0066 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 0067 
; 0000 0068 // Port D initialization
; 0000 0069 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 006A DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (1<<DDD0);
	LDI  R30,LOW(1)
	OUT  0x11,R30
; 0000 006B // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 006C PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 006D DDRB=0xff;
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 006E 
; 0000 006F // Timer/Counter 0 initialization
; 0000 0070 // Clock source: System Clock
; 0000 0071 // Clock value: Timer 0 Stopped
; 0000 0072 // Mode: Normal top=0xFF
; 0000 0073 // OC0 output: Disconnected
; 0000 0074 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 0075 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0076 OCR0=0x00;
	OUT  0x3C,R30
; 0000 0077 
; 0000 0078 // Timer/Counter 1 initialization
; 0000 0079 // Clock source: System Clock
; 0000 007A // Clock value: Timer1 Stopped
; 0000 007B // Mode: Normal top=0xFFFF
; 0000 007C // OC1A output: Disconnected
; 0000 007D // OC1B output: Disconnected
; 0000 007E // Noise Canceler: Off
; 0000 007F // Input Capture on Falling Edge
; 0000 0080 // Timer1 Overflow Interrupt: Off
; 0000 0081 // Input Capture Interrupt: Off
; 0000 0082 // Compare A Match Interrupt: Off
; 0000 0083 // Compare B Match Interrupt: Off
; 0000 0084 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0085 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0086 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0087 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0088 ICR1H=0x00;
	OUT  0x27,R30
; 0000 0089 ICR1L=0x00;
	OUT  0x26,R30
; 0000 008A OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 008B OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 008C OCR1BH=0x00;
	OUT  0x29,R30
; 0000 008D OCR1BL=0x00;
	OUT  0x28,R30
; 0000 008E 
; 0000 008F // Timer/Counter 2 initialization
; 0000 0090 // Clock source: System Clock
; 0000 0091 // Clock value: Timer2 Stopped
; 0000 0092 // Mode: Normal top=0xFF
; 0000 0093 // OC2 output: Disconnected
; 0000 0094 ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0095 TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 0096 TCNT2=0x00;
	OUT  0x24,R30
; 0000 0097 OCR2=0x00;
	OUT  0x23,R30
; 0000 0098 
; 0000 0099 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 009A TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 009B 
; 0000 009C // External Interrupt(s) initialization
; 0000 009D // INT0: Off
; 0000 009E // INT1: Off
; 0000 009F // INT2: Off
; 0000 00A0 MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 00A1 MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 00A2 
; 0000 00A3 // USART initialization
; 0000 00A4 // USART disabled
; 0000 00A5 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 00A6 
; 0000 00A7 // Analog Comparator initialization
; 0000 00A8 // Analog Comparator: Off
; 0000 00A9 // The Analog Comparator's positive input is
; 0000 00AA // connected to the AIN0 pin
; 0000 00AB // The Analog Comparator's negative input is
; 0000 00AC // connected to the AIN1 pin
; 0000 00AD ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00AE 
; 0000 00AF // ADC initialization
; 0000 00B0 // ADC Clock frequency: 125.000 kHz
; 0000 00B1 // ADC Voltage Reference: AREF pin
; 0000 00B2 // ADC Auto Trigger Source: ADC Stopped
; 0000 00B3 ADMUX=ADC_VREF_TYPE;
	LDI  R30,LOW(64)
	OUT  0x7,R30
; 0000 00B4 ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (0<<ADPS0);
	LDI  R30,LOW(134)
	OUT  0x6,R30
; 0000 00B5 SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 00B6 
; 0000 00B7 // SPI initialization
; 0000 00B8 // SPI disabled
; 0000 00B9 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 00BA 
; 0000 00BB // TWI initialization
; 0000 00BC // TWI disabled
; 0000 00BD TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 00BE 
; 0000 00BF // Alphanumeric LCD initialization
; 0000 00C0 // Connections are specified in the
; 0000 00C1 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 00C2 // RS: PORTC Bit 0
; 0000 00C3 // RD: PORTC Bit 1
; 0000 00C4 // EN: PORTC Bit 2
; 0000 00C5 // D4: PORTC Bit 4
; 0000 00C6 // D5: PORTC Bit 5
; 0000 00C7 // D6: PORTC Bit 6
; 0000 00C8 // D7: PORTC Bit 7
; 0000 00C9 // Characters/line: 16
; 0000 00CA lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 00CB PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 00CC while (1)
_0xD:
; 0000 00CD 
; 0000 00CE { lcd_clear();
	RCALL _lcd_clear
; 0000 00CF lcd_puts("Welcome") ;
	__POINTW2MN _0x10,0
	RCALL SUBOPT_0x2
; 0000 00D0 delay_ms(300);
; 0000 00D1 // Range in milli ohms //
; 0000 00D2 Res_known=100000;
	__GETD1N 0x47C35000
	RCALL SUBOPT_0x1
; 0000 00D3 lcd_clear();
	RCALL _lcd_clear
; 0000 00D4 PORTB=0x01;
	LDI  R30,LOW(1)
	OUT  0x18,R30
; 0000 00D5 delay_ms(300);
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL SUBOPT_0x3
; 0000 00D6 V_out=read_adc(0);
; 0000 00D7 test=((V_out*5000UL)/1024);
; 0000 00D8 V_out=((V_out*5UL)/1024);
; 0000 00D9 delay_ms(100);
; 0000 00DA sprintf(lcd_value ,"%u",test);
; 0000 00DB 
; 0000 00DC 
; 0000 00DD if(test>=1 && test <=4){
	__CPD2N 0x1
	BRLO _0x12
	RCALL SUBOPT_0x4
	__CPD2N 0x5
	BRLO _0x13
_0x12:
	RJMP _0x11
_0x13:
; 0000 00DE lcd_puts(lcd_value);
	MOVW R26,R28
	RCALL SUBOPT_0x2
; 0000 00DF delay_ms(300);
; 0000 00E0 lcd_clear();
	RCALL SUBOPT_0x5
; 0000 00E1 Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 00E2 lcd_puts("R=");
	__POINTW2MN _0x10,8
	RCALL SUBOPT_0x8
; 0000 00E3 lcd_WriteResult(Res_unknown);
; 0000 00E4 lcd_puts(" microohm");
	__POINTW2MN _0x10,11
	RCALL _lcd_puts
; 0000 00E5 lcd_puts("    Range 0");
	__POINTW2MN _0x10,21
	RCALL SUBOPT_0x9
; 0000 00E6 delay_ms(3000);
; 0000 00E7 }
; 0000 00E8 if(test>=4 && test <=2000){
_0x11:
	RCALL SUBOPT_0x4
	__CPD2N 0x4
	BRLO _0x15
	RCALL SUBOPT_0x4
	__CPD2N 0x7D1
	BRLO _0x16
_0x15:
	RJMP _0x14
_0x16:
; 0000 00E9 lcd_puts(lcd_value);
	MOVW R26,R28
	RCALL SUBOPT_0x2
; 0000 00EA delay_ms(300);
; 0000 00EB lcd_clear();
	RCALL SUBOPT_0x5
; 0000 00EC Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 00ED lcd_puts("R=");
	__POINTW2MN _0x10,33
	RCALL SUBOPT_0xA
; 0000 00EE lcd_WriteResult(Res_unknown*2);
	__LSLD1
	MOVW R26,R30
	MOVW R24,R22
	RCALL _lcd_WriteResult
; 0000 00EF lcd_puts(" microohm");
	__POINTW2MN _0x10,36
	RCALL _lcd_puts
; 0000 00F0 lcd_puts("    Range 0");
	__POINTW2MN _0x10,46
	RCALL SUBOPT_0x9
; 0000 00F1 delay_ms(3000);
; 0000 00F2 }
; 0000 00F3 //           if(test>=1001 && test <=3000){
; 0000 00F4 //          lcd_puts(lcd_value);
; 0000 00F5 //           delay_ms(300);
; 0000 00F6 //           lcd_clear();
; 0000 00F7 //          Res_unknown=((Res_known*V_out)/(V_in-V_out));
; 0000 00F8 //          lcd_puts("R=");
; 0000 00F9 //          lcd_WriteResult(Res_unknown*1.5);
; 0000 00FA //          lcd_puts(" microohm");
; 0000 00FB //          lcd_puts("    Range 0");
; 0000 00FC //          delay_ms(3000);
; 0000 00FD //           }
; 0000 00FE 
; 0000 00FF //  Range near 1 ohm //
; 0000 0100 Res_known=1000;
_0x14:
	RCALL SUBOPT_0xB
; 0000 0101 lcd_clear();
; 0000 0102 PORTB=0x02;
	LDI  R30,LOW(2)
	RCALL SUBOPT_0xC
; 0000 0103 delay_ms(100);
; 0000 0104 V_out=read_adc(0);
; 0000 0105 test=((V_out*5000UL)/1024);
; 0000 0106 V_out=((V_out*5UL)/1024);
; 0000 0107 delay_ms(100);
; 0000 0108 sprintf(lcd_value ,"%u",test);
; 0000 0109 
; 0000 010A 
; 0000 010B if(test>=0 && test <=100){
	__CPD20
	BRLO _0x18
	RCALL SUBOPT_0xD
	BRLO _0x19
_0x18:
	RJMP _0x17
_0x19:
; 0000 010C lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 010D delay_ms(200);
; 0000 010E lcd_clear();
; 0000 010F Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 0110 lcd_puts("R=");
	__POINTW2MN _0x10,58
	RCALL SUBOPT_0xA
; 0000 0111 lcd_WriteResult(Res_unknown*1200);
	__GETD2N 0x4B0
	RCALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	RCALL _lcd_WriteResult
; 0000 0112 lcd_puts(" microohm");
	__POINTW2MN _0x10,61
	RCALL _lcd_puts
; 0000 0113 lcd_puts("    Range 1");
	__POINTW2MN _0x10,71
	RCALL SUBOPT_0x9
; 0000 0114 delay_ms(3000);
; 0000 0115 }
; 0000 0116 if(test>=101 && test <=4500){
_0x17:
	RCALL SUBOPT_0xD
	BRLO _0x1B
	RCALL SUBOPT_0xF
	BRLO _0x1C
_0x1B:
	RJMP _0x1A
_0x1C:
; 0000 0117 lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 0118 delay_ms(200);
; 0000 0119 lcd_clear();
; 0000 011A Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 011B lcd_puts("R=");
	__POINTW2MN _0x10,83
	RCALL SUBOPT_0xA
; 0000 011C lcd_WriteResult(Res_unknown*1.1);
	RCALL SUBOPT_0x10
; 0000 011D lcd_puts(" milliohm");
	__POINTW2MN _0x10,86
	RCALL _lcd_puts
; 0000 011E lcd_puts("    Range 1");
	__POINTW2MN _0x10,96
	RCALL SUBOPT_0x9
; 0000 011F delay_ms(3000);
; 0000 0120 }
; 0000 0121 
; 0000 0122 //  Range near 100 ohm //
; 0000 0123 Res_known=100;
_0x1A:
	RCALL SUBOPT_0x11
; 0000 0124 lcd_clear();
; 0000 0125 PORTB=0x04;
	LDI  R30,LOW(4)
	RCALL SUBOPT_0xC
; 0000 0126 delay_ms(100);
; 0000 0127 V_out=read_adc(0);
; 0000 0128 test=((V_out*5000UL)/1024);
; 0000 0129 V_out=((V_out*5UL)/1024);
; 0000 012A delay_ms(100);
; 0000 012B sprintf(lcd_value ,"%u",test);
; 0000 012C 
; 0000 012D 
; 0000 012E if(test>=500 && test <=4100){
	__CPD2N 0x1F4
	BRLO _0x1E
	RCALL SUBOPT_0x4
	__CPD2N 0x1005
	BRLO _0x1F
_0x1E:
	RJMP _0x1D
_0x1F:
; 0000 012F lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 0130 delay_ms(200);
; 0000 0131 lcd_clear();
; 0000 0132 Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 0133 lcd_puts("R=");
	__POINTW2MN _0x10,108
	RCALL SUBOPT_0xA
; 0000 0134 lcd_WriteResult(Res_unknown*1.1);
	RCALL SUBOPT_0x10
; 0000 0135 lcd_puts(" ohm");
	__POINTW2MN _0x10,111
	RCALL _lcd_puts
; 0000 0136 lcd_puts("         Range 2");
	__POINTW2MN _0x10,116
	RCALL SUBOPT_0x9
; 0000 0137 delay_ms(3000);
; 0000 0138 }
; 0000 0139 
; 0000 013A //  Range near 1k ohm //
; 0000 013B Res_known=1000;
_0x1D:
	RCALL SUBOPT_0xB
; 0000 013C lcd_clear();
; 0000 013D PORTB=0x08;
	LDI  R30,LOW(8)
	RCALL SUBOPT_0xC
; 0000 013E delay_ms(100);
; 0000 013F V_out=read_adc(0);
; 0000 0140 test=((V_out*5000UL)/1024);
; 0000 0141 V_out=((V_out*5UL)/1024);
; 0000 0142 delay_ms(100);
; 0000 0143 sprintf(lcd_value ,"%u",test);
; 0000 0144 
; 0000 0145 
; 0000 0146 if(test>=400 && test <=4500){
	RCALL SUBOPT_0x12
	BRLO _0x21
	RCALL SUBOPT_0xF
	BRLO _0x22
_0x21:
	RJMP _0x20
_0x22:
; 0000 0147 lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 0148 delay_ms(200);
; 0000 0149 lcd_clear();
; 0000 014A Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 014B lcd_puts("R=");
	__POINTW2MN _0x10,133
	RCALL SUBOPT_0x8
; 0000 014C lcd_WriteResult(Res_unknown);
; 0000 014D lcd_puts(" ohm");
	__POINTW2MN _0x10,136
	RCALL _lcd_puts
; 0000 014E lcd_puts("         Range 3");
	__POINTW2MN _0x10,141
	RCALL SUBOPT_0x9
; 0000 014F delay_ms(3000);
; 0000 0150 }
; 0000 0151 
; 0000 0152 
; 0000 0153 //  Range near 10k ohm //
; 0000 0154 Res_known=10;
_0x20:
	RCALL SUBOPT_0x13
; 0000 0155 lcd_clear();
; 0000 0156 PORTB=0x10;
	LDI  R30,LOW(16)
	RCALL SUBOPT_0xC
; 0000 0157 delay_ms(100);
; 0000 0158 V_out=read_adc(0);
; 0000 0159 test=((V_out*5000UL)/1024);
; 0000 015A V_out=((V_out*5UL)/1024);
; 0000 015B delay_ms(100);
; 0000 015C sprintf(lcd_value ,"%u",test);
; 0000 015D 
; 0000 015E 
; 0000 015F if(test>=400 && test <=4500){
	RCALL SUBOPT_0x12
	BRLO _0x24
	RCALL SUBOPT_0xF
	BRLO _0x25
_0x24:
	RJMP _0x23
_0x25:
; 0000 0160 lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 0161 delay_ms(200);
; 0000 0162 lcd_clear();
; 0000 0163 Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 0164 lcd_puts("R=");
	__POINTW2MN _0x10,158
	RCALL SUBOPT_0x8
; 0000 0165 lcd_WriteResult(Res_unknown);
; 0000 0166 lcd_puts(" kohm");
	__POINTW2MN _0x10,161
	RCALL _lcd_puts
; 0000 0167 lcd_puts("         Range 4");
	__POINTW2MN _0x10,167
	RCALL SUBOPT_0x9
; 0000 0168 delay_ms(3000);
; 0000 0169 }
; 0000 016A 
; 0000 016B 
; 0000 016C //  Range near 100k ohm //
; 0000 016D Res_known=100;
_0x23:
	RCALL SUBOPT_0x11
; 0000 016E lcd_clear();
; 0000 016F PORTB=0x20;
	LDI  R30,LOW(32)
	RCALL SUBOPT_0xC
; 0000 0170 delay_ms(100);
; 0000 0171 V_out=read_adc(0);
; 0000 0172 test=((V_out*5000UL)/1024);
; 0000 0173 V_out=((V_out*5UL)/1024);
; 0000 0174 delay_ms(100);
; 0000 0175 sprintf(lcd_value ,"%u",test);
; 0000 0176 
; 0000 0177 
; 0000 0178 if(test>=400 && test <=4000){
	RCALL SUBOPT_0x12
	BRLO _0x27
	RCALL SUBOPT_0x4
	__CPD2N 0xFA1
	BRLO _0x28
_0x27:
	RJMP _0x26
_0x28:
; 0000 0179 lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 017A delay_ms(200);
; 0000 017B lcd_clear();
; 0000 017C Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 017D lcd_puts("R=");
	__POINTW2MN _0x10,184
	RCALL SUBOPT_0x8
; 0000 017E lcd_WriteResult(Res_unknown);
; 0000 017F lcd_puts(" kohm");
	__POINTW2MN _0x10,187
	RCALL _lcd_puts
; 0000 0180 lcd_puts("         Range 5");
	__POINTW2MN _0x10,193
	RCALL SUBOPT_0x9
; 0000 0181 delay_ms(3000);
; 0000 0182 }
; 0000 0183 
; 0000 0184 
; 0000 0185 
; 0000 0186 
; 0000 0187 //  Range near 1Mohm //
; 0000 0188 Res_known=1000;
_0x26:
	RCALL SUBOPT_0xB
; 0000 0189 lcd_clear();
; 0000 018A PORTB=0x40;
	LDI  R30,LOW(64)
	RCALL SUBOPT_0xC
; 0000 018B delay_ms(100);
; 0000 018C V_out=read_adc(0);
; 0000 018D test=((V_out*5000UL)/1024);
; 0000 018E V_out=((V_out*5UL)/1024);
; 0000 018F delay_ms(100);
; 0000 0190 sprintf(lcd_value ,"%u",test);
; 0000 0191 
; 0000 0192 
; 0000 0193 if(test>=300 && test <=3000){
	__CPD2N 0x12C
	BRLO _0x2A
	RCALL SUBOPT_0x14
	BRLO _0x2B
_0x2A:
	RJMP _0x29
_0x2B:
; 0000 0194 lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 0195 delay_ms(200);
; 0000 0196 lcd_clear();
; 0000 0197 Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 0198 lcd_puts("R=");
	__POINTW2MN _0x10,210
	RCALL SUBOPT_0xA
; 0000 0199 lcd_WriteResult(Res_unknown*0.95);
	RCALL __CDF1U
	__GETD2N 0x3F733333
	RCALL SUBOPT_0x15
; 0000 019A lcd_puts(" kohm");
	__POINTW2MN _0x10,213
	RCALL _lcd_puts
; 0000 019B lcd_puts("         Range 6");
	__POINTW2MN _0x10,219
	RCALL SUBOPT_0x9
; 0000 019C delay_ms(3000);
; 0000 019D }
; 0000 019E 
; 0000 019F if(test>=3001 && test <=4900){
_0x29:
	RCALL SUBOPT_0x14
	BRLO _0x2D
	RCALL SUBOPT_0x16
	BRLO _0x2E
_0x2D:
	RJMP _0x2C
_0x2E:
; 0000 01A0 lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 01A1 delay_ms(200);
; 0000 01A2 lcd_clear();
; 0000 01A3 Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 01A4 lcd_puts("R=");
	__POINTW2MN _0x10,236
	RCALL SUBOPT_0xA
; 0000 01A5 lcd_WriteResult(Res_unknown*1.015);
	RCALL __CDF1U
	__GETD2N 0x3F81EB85
	RCALL SUBOPT_0x15
; 0000 01A6 lcd_puts(" kohm");
	__POINTW2MN _0x10,239
	RCALL _lcd_puts
; 0000 01A7 lcd_puts("         Range 6");
	__POINTW2MN _0x10,245
	RCALL SUBOPT_0x9
; 0000 01A8 delay_ms(3000);
; 0000 01A9 }
; 0000 01AA 
; 0000 01AB 
; 0000 01AC 
; 0000 01AD //  Range near 10Mohm //
; 0000 01AE Res_known=10;
_0x2C:
	RCALL SUBOPT_0x13
; 0000 01AF lcd_clear();
; 0000 01B0 PORTB=0x80;
	LDI  R30,LOW(128)
	RCALL SUBOPT_0xC
; 0000 01B1 delay_ms(100);
; 0000 01B2 V_out=read_adc(0);
; 0000 01B3 test=((V_out*5000UL)/1024);
; 0000 01B4 V_out=((V_out*5UL)/1024);
; 0000 01B5 delay_ms(100);
; 0000 01B6 sprintf(lcd_value ,"%u",test);
; 0000 01B7 
; 0000 01B8 
; 0000 01B9 if(test>=200 && test <=4900){
	__CPD2N 0xC8
	BRLO _0x30
	RCALL SUBOPT_0x16
	BRLO _0x31
_0x30:
	RJMP _0x2F
_0x31:
; 0000 01BA lcd_puts(lcd_value);
	RCALL SUBOPT_0xE
; 0000 01BB delay_ms(200);
; 0000 01BC lcd_clear();
; 0000 01BD Res_unknown=((Res_known*V_out)/(V_in-V_out));
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x6
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x7
; 0000 01BE lcd_puts("R=");
	__POINTW2MN _0x10,262
	RCALL SUBOPT_0xA
; 0000 01BF lcd_WriteResult(Res_unknown*0.9);
	RCALL __CDF1U
	__GETD2N 0x3F666666
	RCALL SUBOPT_0x15
; 0000 01C0 lcd_puts(" Mohm");
	__POINTW2MN _0x10,265
	RCALL _lcd_puts
; 0000 01C1 lcd_puts("         Range 7");
	__POINTW2MN _0x10,271
	RCALL SUBOPT_0x9
; 0000 01C2 delay_ms(3000);
; 0000 01C3 }
; 0000 01C4 //      V_out=read_adc(0);
; 0000 01C5 //      V_out=((V_out*5000ULL)/1024);
; 0000 01C6 //      Res_unknown=((Res_known*V_out)/(V_in-V_out));
; 0000 01C7 //
; 0000 01C8 //      sprintf(lcd_value ,"%u",Res_unknown);
; 0000 01C9 //      lcd_puts(lcd_value);
; 0000 01CA //      lcd_puts("ohm");
; 0000 01CB //       lcd_clear();
; 0000 01CC }
_0x2F:
	RJMP _0xD
; 0000 01CD }
_0x32:
	RJMP _0x32
; .FEND

	.DSEG
_0x10:
	.BYTE 0x120
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G100:
; .FSTART _put_buff_G100
	RCALL __SAVELOCR6
	MOVW R18,R26
	LDD  R21,Y+6
	ADIW R26,2
	__GETW1P
	SBIW R30,0
	BREQ _0x2000010
	MOVW R26,R18
	RCALL SUBOPT_0x17
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000012
	__CPWRN 16,17,2
	BRLO _0x2000013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1RNS 18,4
_0x2000012:
	MOVW R26,R18
	ADIW R26,2
	RCALL SUBOPT_0x18
	SBIW R30,1
	ST   Z,R21
_0x2000013:
	MOVW R26,R18
	__GETW1P
	TST  R31
	BRMI _0x2000014
	RCALL SUBOPT_0x18
_0x2000014:
	RJMP _0x2000015
_0x2000010:
	MOVW R26,R18
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2000015:
	RCALL __LOADLOCR6
	ADIW R28,7
	RET
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	RCALL SUBOPT_0x19
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	RCALL SUBOPT_0x19
	RJMP _0x20000CC
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	RCALL SUBOPT_0x1A
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x1B
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	RCALL SUBOPT_0x1A
	RCALL SUBOPT_0x1C
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	RCALL SUBOPT_0x1A
	RCALL SUBOPT_0x1C
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	RCALL SUBOPT_0x1A
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	RCALL SUBOPT_0x1A
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	RCALL SUBOPT_0x17
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	RCALL SUBOPT_0x19
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	RCALL SUBOPT_0x19
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CD
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	RCALL SUBOPT_0x1B
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	RCALL SUBOPT_0x19
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x1B
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000CC:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X+
	LD   R31,X+
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	RCALL __SAVELOCR6
	MOVW R30,R28
	__ADDW1R15
	__GETWRZ 20,21,14
	MOV  R0,R20
	OR   R0,R21
	BRNE _0x2000072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20E0002
_0x2000072:
	MOVW R26,R28
	ADIW R26,8
	__ADDW2R15
	MOVW R16,R26
	__PUTWSR 20,21,8
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	MOVW R26,R28
	ADIW R26,12
	__ADDW2R15
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,12
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20E0002:
	RCALL __LOADLOCR6
	ADIW R28,12
	POP  R15
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G102:
; .FSTART __lcd_write_nibble_G102
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,3
	__DELAY_USB 13
	CBI  0x1B,3
	__DELAY_USB 13
	RJMP _0x20E0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
	__DELAY_USB 133
	ADIW R28,1
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
	LDD  R16,Y+2
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G102)
	SBCI R31,HIGH(-__base_y_G102)
	LD   R30,Z
	ADD  R30,R16
	MOV  R26,R30
	RCALL __lcd_write_data
	MOV  R5,R16
	MOV  R4,R17
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x1D
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x1D
	LDI  R30,LOW(0)
	MOV  R4,R30
	MOV  R5,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R17
	MOV  R17,R26
	CPI  R17,10
	BREQ _0x2040005
	CP   R5,R7
	BRLO _0x2040004
_0x2040005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R4
	MOV  R26,R4
	RCALL _lcd_gotoxy
	CPI  R17,10
	BREQ _0x20E0001
_0x2040004:
	INC  R5
	SBI  0x1B,1
	MOV  R26,R17
	RCALL __lcd_write_data
	CBI  0x1B,1
	RJMP _0x20E0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	RCALL __SAVELOCR4
	MOVW R18,R26
_0x2040008:
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x204000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2040008
_0x204000A:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,3
	SBI  0x1A,1
	SBI  0x1A,2
	CBI  0x1B,3
	CBI  0x1B,1
	CBI  0x1B,2
	MOV  R7,R17
	MOV  R30,R17
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G102,2
	MOV  R30,R17
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G102,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0x1E
	RCALL SUBOPT_0x1E
	RCALL SUBOPT_0x1E
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G102
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20E0001:
	LD   R17,Y+
	RET
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG

	.DSEG
_d10_G101:
	.BYTE 0x8
__base_y_G102:
	.BYTE 0x4
__seed_G103:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x0:
	__GETD2S 24
	__GETD1N 0xA
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x1:
	__PUTD1S 20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2:
	RCALL _lcd_puts
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:530 WORDS
SUBOPT_0x3:
	RCALL _delay_ms
	LDI  R26,LOW(0)
	RCALL _read_adc
	CLR  R22
	CLR  R23
	RCALL __CDF1
	__PUTD1S 28
	__GETD2S 28
	__GETD1N 0x459C4000
	RCALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x44800000
	RCALL __DIVF21
	MOVW R26,R28
	ADIW R26,32
	RCALL __CFD1U
	__PUTDP1
	__GETD2S 28
	__GETD1N 0x40A00000
	RCALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x44800000
	RCALL __DIVF21
	__PUTD1S 28
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,8
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 36
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _sprintf
	ADIW R28,8
	__GETD2S 32
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:37 WORDS
SUBOPT_0x4:
	__GETD2S 32
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:88 WORDS
SUBOPT_0x5:
	RCALL _lcd_clear
	__GETD1S 28
	__GETD2S 20
	RCALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:98 WORDS
SUBOPT_0x6:
	__GETD1S 28
	__GETD2S 24
	RCALL __CDF2U
	RCALL __SWAPD12
	RCALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:68 WORDS
SUBOPT_0x7:
	RCALL __DIVF21
	MOVW R26,R28
	ADIW R26,16
	RCALL __CFD1U
	__PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x8:
	RCALL _lcd_puts
	__GETD2S 16
	RJMP _lcd_WriteResult

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x9:
	RCALL _lcd_puts
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0xA:
	RCALL _lcd_puts
	__GETD1S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xB:
	__GETD1N 0x447A0000
	RCALL SUBOPT_0x1
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0xC:
	OUT  0x18,R30
	LDI  R26,LOW(100)
	LDI  R27,0
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xD:
	RCALL SUBOPT_0x4
	__CPD2N 0x65
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:46 WORDS
SUBOPT_0xE:
	MOVW R26,R28
	RCALL _lcd_puts
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0xF:
	RCALL SUBOPT_0x4
	__CPD2N 0x1195
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x10:
	RCALL __CDF1U
	__GETD2N 0x3F8CCCCD
	RCALL __MULF12
	RCALL __CFD1U
	MOVW R26,R30
	MOVW R24,R22
	RJMP _lcd_WriteResult

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	__GETD1N 0x42C80000
	RCALL SUBOPT_0x1
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x12:
	__CPD2N 0x190
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	__GETD1N 0x41200000
	RCALL SUBOPT_0x1
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x14:
	RCALL SUBOPT_0x4
	__CPD2N 0xBB9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x15:
	RCALL __MULF12
	RCALL __CFD1U
	MOVW R26,R30
	MOVW R24,R22
	RJMP _lcd_WriteResult

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x16:
	RCALL SUBOPT_0x4
	__CPD2N 0x1325
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	ADIW R26,4
	__GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x18:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x19:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x1A:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1B:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1C:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1E:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G102
	__DELAY_USW 200
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	PUSH R26
	PUSH R27
	MOVW R26,R22
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	POP  R27
	POP  R26
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	MOVW R20,R0
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__CDF2U:
	SET
	RJMP __CDF2U0
__CDF2:
	CLT
__CDF2U0:
	RCALL __SWAPD12
	RCALL __CDF1U0

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	MOVW R22,R30
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	MOVW R20,R18
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
