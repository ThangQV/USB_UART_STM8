;stm8/

	;#include "mapping.inc"
	#include "stm8s105c_s.inc"
	
	#define hseen #0; присвоим названию бита hseen значение #0 
	#define swen #1; присвоим названию бита swen значение #1
	#define clock #$B4; тактирование от генератора
	#define cssen #0; присвоим названию бита cssen значение #0

usb_rx_buff.b EQU $10
usb_rx_fifo.b EQU $11

	interrupt EXTI1_Interrupt
EXTI1_Interrupt.l
	mov PB_CR2,#$0
	;bres PD_ODR,#0
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
token:
	clrw Y
	ld A,#20 ;пропускаем SYNC, он нам не нужен (24 такта с начала прерывания)
SYNC:
	dec A
	jrne SYNC
	nop
	nop
	nop
	nop
	nop
	nop
	;nop
	;nop
	;nop
	nop
	nop
	nop
	nop
rx_byte:
	;ld A, PB_IDR
	;ld (usb_rx_buff,Y), A
	;ldw X, #8 ;PID 8 бит записываем в usb_rx_buff[0]
	;ld A,(usb_rx_buff,Y)  ;pin 0 mask
rcv_bit_0:
	ld A, PB_IDR
	ld PD_ODR,A
	sll usb_rx_buff
	add A, usb_rx_buff
	ld usb_rx_buff,A
	
rcv_bit_1:
	;nop
	;nop
	nop
	nop
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
	ld A, PB_IDR
	cp A,PE_IDR
	jreq reti_entry
	ld PD_ODR,A
	sll usb_rx_buff
	add A, usb_rx_buff
	ld usb_rx_buff,A
	
rcv_bit_2:
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
	nop
	nop
	nop
	nop
	nop
	ld A, PB_IDR
	ld PD_ODR,A
	sll usb_rx_buff
	add A, usb_rx_buff
	ld usb_rx_buff,A
	
rcv_bit_3:
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
	nop
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
	nop
	nop
	nop
	nop
	nop
	ld A, PB_IDR
	ld PD_ODR,A
	sll usb_rx_buff
	add A, usb_rx_buff
	ld usb_rx_buff,A
	
	
rcv_bit_4:
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
	nop
	nop
	nop
	nop
	ld A, PB_IDR
	ld PD_ODR,A
	sll usb_rx_buff
	add A, usb_rx_buff
	ld usb_rx_buff,A
	
rcv_bit_5:
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
	nop
	nop
	nop
	nop
	ld A, PB_IDR
	ld PD_ODR,A
	sll usb_rx_buff
	add A, usb_rx_buff
	ld usb_rx_buff,A
	
rcv_bit_6:
	nop
	nop
	nop
	nop
	;nop
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
	ld A, PB_IDR
	ld PD_ODR,A
	sll usb_rx_buff
	add A, usb_rx_buff
	ld usb_rx_buff,A
	
	
rcv_bit_7:
	nop
	nop
	nop
	nop
	;nop
	ld A, PB_IDR
	ld PD_ODR,A
	sll usb_rx_buff
	add A, usb_rx_buff
	ld usb_rx_buff,A

;added_stuffed_bit:
	
	
	ld (usb_rx_fifo,Y),A
	incw Y
	nop
	nop
	;nop
	;cp A, PA_IDR
	;jreq reti_entry	
	jp rx_byte
reti_entry:	
	;bset PD_ODR, #0
	;rim
	;mov PB_CR2,#0
	;rim
	;bres PD_ODR,#0
	;bres PD_ODR,#0
	;bset PD_ODR,#0
	;bres PD_ODR,#0
	;rim
	;decw Y
	mov PB_CR2,#$01
	;ld A, (usb_rx_fifo,Y)
	;ld PD_ODR, A
	iret


	end
