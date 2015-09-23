/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2000-2006 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
 *  Copyright (C) 2005-2006 by Logic Research Co., Ltd.
 * 
 *  �嵭����Ԥϡ��ʲ��� (1)��(4) �ξ�狼��Free Software Foundation 
 *  �ˤ�äƸ�ɽ����Ƥ��� GNU General Public License �� Version 2 �˵�
 *  �Ҥ���Ƥ���������������˸¤ꡤ�ܥ��եȥ��������ܥ��եȥ�����
 *  ����Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ�������ѡ������ۡʰʲ���
 *  ���ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
 *  (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
 *      ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
 *      ����������˴ޤޤ�Ƥ��뤳�ȡ�
 *  (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *      �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
 *      �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
 *      ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *  (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *      �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
 *      �ȡ�
 *    (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
 *        �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *    (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ��������Ȥ�
 *        ��𤹤뤳�ȡ�
 *  (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
 *      ������⡤�嵭����Ԥ����TOPPERS�ץ��������Ȥ����դ��뤳�ȡ�
 * 
 *  �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
 *  ���TOPPERS�ץ��������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����Ŭ�Ѳ�ǽ����
 *  �ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ����������Ѥˤ��ľ
 *  ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤������Ǥ�����ʤ���
 * 
 */


#define _MACRO_ONLY
#include "jsp_kernel.h"
#include "frk_aduc.h"


        /*
         * Vector�ơ��֥�ȥ����ץơ��֥�
         * �������Ϲ��0x3c
         */
        .section .data.vctsram,"a"
        .code 32
        .align 0
        .global vct_tb_sram
vct_tb_sram:
        ldr pc, reset_vector       /* �ꥻ�å�             */
        ldr pc, undef_vector       /* ̤���̿��           */
        ldr pc, swi_vector         /* ���եȥ����������   */
        ldr pc, prefech_vector     /* �ץ�ե��å����ܡ��� */
        ldr pc, data_abort_vector  /* �ǡ������ܡ���       */
         nop
        ldr pc, irq_vector         /* IRQ                  */
        ldr pc, fiq_vector         /* IRQ                  */

/*
 *  �٥������ơ��֥�
 */
reset_vector:
        .long   start
undef_vector:
        .long   undef_exception
swi_vector:
        .long   swi_exception
prefech_vector:
        .long   prefetch_exception
data_abort_vector:
        .long   data_abort_exception
irq_vector:
        .long   irq_exception
fiq_vector:
        .long   fiq_exception




/*
 *  ���٥�Υ������åȥ����ƥ��¸�ν����
 *
 *  �������ȥ��åץ⥸�塼�����ǡ��������������˸ƤӽФ���롥          
 */       

        .text
        .align 2
        .global hardware_init_hook
hardware_init_hook: 
        mov     pc, lr


        .text
        .align 2
        .global software_init_hook
software_init_hook:
        mov     pc, lr

        .text
        .align 2
        .global software_term_hook
software_term_hook:
        mov     pc, lr


/*
 *
 *  ����ߤν����������
 *         
 */        
        .text
        .align 4    
        .global IRQ_Handler
IRQ_Handler:

        /* 
         * ����ߥ⡼�� 
         * 
         * cpsr��spsr_irq�������褬r14_irq(lp)�����ꡤ
         * spsr_irq��r14_irq��r13(sp)_irq�� r14,r13�Ȥʤ롥
         */

        /* 
         *  ��������ư����⡼��(�����ѡ��Х������⡼��)��
         */
        mov   sp,#(CPSR_SVC | CPSR_FIQ_BIT | CPSR_IRQ_BIT) 
        msr   cpsr_all, sp
        stmfd sp!, {r0-r3,ip,lr,pc} /* pc�ϥ��ߡ� */

 
  
        /*
         * spsr��������Ϥ�������뤿���IRQ�⡼�ɤ�
         */
        mov   r0,#(CPSR_IRQ | CPSR_FIQ_BIT | CPSR_IRQ_BIT)
        msr   cpsr,r0
        sub   r0,lr,#4
        mrs   r1,spsr
   
        /*
         *  �����ѡ��Х������⡼�ɤ�
         */
        and   r2,  r1, #CPSR_FIQ_BIT /* FIQ�ӥåȤηѾ� */
        orr   r2,  r2, #(CPSR_SVC|CPSR_IRQ_BIT)        
        msr   cpsr_all, r2
        str   r0, [sp,#0x18] /* Store pc */
        stmfd sp!,{r1}       /* spsr */


        /*
         *  ¿�ų����ߤ�Ƚ��
         */
        ldr     r2, =interrupt_count
        ldr     r3, [r2]
        add     r0,r3,#1
        str     r0, [r2]
        cmp     r3, #0x00

        moveq   r2,sp            /* �ͥ��ȳ����ߤǤʤ���� */
        ldreq   sp,=STACKTOP     /* �����å����ѹ�    */
        stmeqfd sp!,{r2}         /* �����������å�����¸ */


        /*
         *  �������װ���Ƚ�ꡥ
         */
        ldr     r1, =IRQSTA

		ldr     r0, =IRQEN
		ldr     r2, [r0]
		stmfd   sp!, {r2}			/* �ޥ����ӥåȤ����� */

        ldr     r2, [r1]
        mov     r0, #1
		mov		r3, #1
find_bit_loop:
        mov     r1, r3, lsl r0
        tst     r2, r1
        bne     find_bit_end   
        add     r0, r0, #1
        bpl     find_bit_loop
find_bit_end:
        mov     r3, r0
        ldr     r0,=int_mask_table    /* ����ߥޥ����ơ��֥�θƤӽФ�*/
        ldr     r0,[r0,r3,lsl #2]     /* r0<-����ߥޥ���              */    
        ldr     r1, =IRQCLR			  /* ����ߥ쥸�����ؤΥ��å�      */
        str     r0,[r1]

        ldr     r0,  =int_table       /* ����ߵ����ơ��֥���ɤ߽Ф�  */
        ldr     r0,  [r0,r3,lsl #2]   /* r0<-����ߥϥ�ɥ�            */    


        /*
         *  ̤����γ���ߤ������å�
         */
        cmp     r0, #0x00
        beq     undefined_interrupt
        
        /* 
         * �����ߵ��� 
         */                
        mrs     r2, cpsr
        and     r2,  r2, #~CPSR_IRQ_BIT /* ����ߵ��� */
        msr     cpsr,r2

        /* 
         * Call Handler  
         */        
        mov     lr,  pc   
        bx      r0

        /* 
         * �����߶ػ� 
         */
        mrs     r2, cpsr
        and     r2,  r2, #CPSR_FIQ_BIT /* FIQ�ӥåȤηѾ� */         
        orr     r2,  r2, #(CPSR_SVC|CPSR_IRQ_BIT)
        msr     cpsr,r2

        ldmfd   sp!, {r0}                /* �ޥ����ӥåȤ����� */
        ldr     r1,  =IRQEN        /*�����ߵ���*/
        str     r0,  [r1]

        /* 
         * ����ߥͥ��Ȳ��(interrupt_count) �ǥ������ 
         */
        ldr     r2, =interrupt_count
        ldr     r1, [r2]        
        sub     r3, r1, #1                        
        str     r3, [r2]
        cmp     r3, #0x00        
        bne     return_to_task_irq
        
        /* 
         * �����������å������� 
         */
        ldmfd   sp!,{r0}         
        mov     sp, r0        
                
        ldr     r1, =reqflg    /* Check reqflg */
        ldr     r0, [r1]
        cmp     r0, #0
        beq     return_to_task_irq
        mov     r0, #0
        str     r0, [r1]       /* Clear reqflg */
        b       ret_int

return_to_task_irq:
        /*
         *  ��������
         *  �����ߵ��ĤȤʤ뤬����������ƥ����Ⱦ����¸���Ƥ��뤿�ᡤ
         *  ����Ϥʤ�
         */
        ldmfd   sp!,{r1}           /* CPSR���������� */
        mrs     r2, cpsr           /* FIQ��Ѿ�            */
        and     r2, r2, #CPSR_FIQ_BIT
        and     r1, r1, #~CPSR_FIQ_BIT
        orr     r1, r1, r2                 
        msr     spsr, r1           /* �����ߵ���   */
        ldmfd   sp!,{r0-r3,ip,lr,pc}^ /*���������� + ����ߵ��� */

        /*
         *  ̤����γ���ߤ����ä��Ȥ��˸ƤӽФ�
         */    
undefined_interrupt:
         b      undef_interrupt
    
