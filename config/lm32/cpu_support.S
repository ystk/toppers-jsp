/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2000-2003 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
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
 *  @(#) $Id: cpu_support.S,v 1.14 2007/07/27 11:28:44 honda Exp $
 */

#define _MACRO_ONLY
#include "offset.h"
#include "jsp_kernel.h"

	.text
	.globl dispatch
	.globl exit_and_dispatch

dispatch:
	addi    sp, sp, -120
	sw      (sp+4),   r1
	sw      (sp+8),   r2
	sw      (sp+12),  r3
    sw      (sp+16),  r4
    sw      (sp+20),  r5
    sw      (sp+24),  r6
    sw      (sp+28),  r7
    sw      (sp+32),  r8
    sw      (sp+36),  r9
    sw      (sp+40),  r10
    sw      (sp+44),  r11
    sw      (sp+48),  r12
    sw      (sp+52),  r13
    sw      (sp+56),  r14
    sw      (sp+60),  r15
    sw      (sp+64),  r16
    sw      (sp+68),  r17
    sw      (sp+72),  r18
    sw      (sp+76),  r19
    sw      (sp+80),  r20
    sw      (sp+84),  r21
    sw      (sp+88),  r22
    sw      (sp+92),  r23
    sw      (sp+96),  r24
    sw      (sp+100), r25
    sw      (sp+104), r26
    sw      (sp+108), r27
    sw      (sp+112), ra
    sw      (sp+116), ea
    sw      (sp+120), ba
   
    mvhi	r1, hi(runtsk)
	ori     r1, r1, lo(runtsk)
	lw      r1, (r1+0)
	mvhi    r2, hi(dispatch_r)
	ori     r2, r2, lo(dispatch_r)
	sw      (r1+TCB_sp), sp
	sw      (r1+TCB_pc), r2
	bi      dispatcher

exit_and_dispatch:
	mvhi    r1, hi(exception_count)
	ori     r1, r1, lo(exception_count)
	sw      (r1+0), r0

	rcsr   r1, ie
    andi   r1, r1, 0x6
	wcsr   ie, r1	

dispatcher:
	mvhi    r1, hi(schedtsk)
	ori     r1, r1, lo(schedtsk)
	lw      r1, (r1+0)

    mvhi    r2, hi(runtsk)
	ori     r2, r2, lo(runtsk)

    sw      (r2+0), r1

    be      r1, r0, dispatcher_2
	nop

dispatcher_1:
	lw      sp, (r1+TCB_sp)
	lw      r1, (r1+TCB_pc)
	b       r1
	nop

dispatcher_2:
	
	mvhi   r2, hi(exception_count)
	ori    r2, r2, lo(exception_count)
	ori    r3, r0, 1
	sw     (r2+0), r3

	mvhi   r3, hi(_fstack)
	ori    r3, r3, lo(_fstack)
	mv     sp, r3
	
	rcsr   r1, ie
    ori    r1, r1, 0x1
	wcsr   ie, r1

	nop

	rcsr   r1, ie
	andi   r1, r1, 0x6
	wcsr   ie, r1

	mvhi    r1, hi(exception_count)
	ori     r1, r1, lo(exception_count)
	sw      (r1+0), r0

	bi     dispatcher

dispatch_r:
    lw      r1,  (sp+4)
    lw      r2,  (sp+8) 
    lw      r3,  (sp+12) 
    lw      r4,  (sp+16) 
    lw      r5,  (sp+20) 
    lw      r6,  (sp+24) 
    lw      r7,  (sp+28) 
    lw      r8,  (sp+32) 
    lw      r9,  (sp+36) 
    lw      r10, (sp+40)
    lw      r11, (sp+44)
    lw      r12, (sp+48)
    lw      r13, (sp+52)
    lw      r14, (sp+56)
    lw      r15, (sp+60)
    lw      r16, (sp+64)
    lw      r17, (sp+68)
    lw      r18, (sp+72)
    lw      r19, (sp+76)
    lw      r20, (sp+80)
    lw      r21, (sp+84)
    lw      r22, (sp+88)
    lw      r23, (sp+92)
    lw      r24, (sp+96)
    lw      r25, (sp+100)
    lw      r26, (sp+104)
    lw      r27, (sp+108)
    lw      ra,  (sp+112)
    lw      ea,  (sp+116)
    lw      ba,  (sp+120)
	addi    sp, sp, 120

    mvhi	r1, hi(runtsk)
	ori     r1, r1, lo(runtsk)
	lw      r1, (r1+0)	
	
	lw      r2, (r1+TCB_enatex)
	andi    r2, r2, TCB_enatex_mask
	be      r2, r0, dispatcher_r_1
	nop
	lw      r2, (r1+TCB_texptn)
	be      r2, r0, dispatcher_r_1
	nop
	bi      call_texrtn
	nop	

dispatcher_r_1:
	ret
	nop
	
	.globl activate_r
activate_r:

	mvhi    r2, hi(runtsk)
	ori     r2, r2, lo(runtsk)
	lw      r2, (r2+0)
	
	lw      r2, (r2+TCB_tinib)
	lw      r3, (r2+TINIB_task)
	lw      r1, (r2+TINIB_exinf)

	rcsr    r2, ie
	ori     r2, r2, 0x1
	wcsr    ie, r2
	
	mvhi    ra, hi(ext_tsk)
	ori     ra, ra, lo(ext_tsk)
	
	b       r3
	nop

	.text
	.globl ret_int
	.globl ret_exc
ret_int:
ret_exc:
    mvhi    r1, hi(enadsp)
    ori     r1, r1, lo(enadsp)
	lw      r1, (r1+0)
	be      r1, r0, ret_int_1

	mvhi    r1, hi(runtsk)
    ori     r1, r1, lo(runtsk)
    lw      r1, (r1+0)

    mvhi    r2, hi(schedtsk)
    ori     r2, r2, lo(schedtsk)
    lw      r2, (r2+0)
    be      r1, r2, ret_int_1

	addi    sp, sp, -120
	sw      (sp+4),   r1
	sw      (sp+8),   r2
	sw      (sp+12),  r3
    sw      (sp+16),  r4
    sw      (sp+20),  r5
    sw      (sp+24),  r6
    sw      (sp+28),  r7
    sw      (sp+32),  r8
    sw      (sp+36),  r9
    sw      (sp+40),  r10
    sw      (sp+44),  r11
    sw      (sp+48),  r12
    sw      (sp+52),  r13
    sw      (sp+56),  r14
    sw      (sp+60),  r15
    sw      (sp+64),  r16
    sw      (sp+68),  r17
    sw      (sp+72),  r18
    sw      (sp+76),  r19
    sw      (sp+80),  r20
    sw      (sp+84),  r21
    sw      (sp+88),  r22
    sw      (sp+92),  r23
    sw      (sp+96),  r24
    sw      (sp+100), r25
    sw      (sp+104), r26
    sw      (sp+108), r27
    sw      (sp+112), ra
    sw      (sp+116), ea
    sw      (sp+120), ba

    sw      (r1+TCB_sp), sp
	mvhi    r2, hi(ret_int_r)
	ori     r2, r2, lo(ret_int_r)
    sw      (r1+TCB_pc), r2

    bi      dispatcher

ret_int_r:
    lw      r1,  (sp+4)
    lw      r2,  (sp+8) 
    lw      r3,  (sp+12) 
    lw      r4,  (sp+16) 
    lw      r5,  (sp+20) 
    lw      r6,  (sp+24) 
    lw      r7,  (sp+28) 
    lw      r8,  (sp+32) 
    lw      r9,  (sp+36) 
    lw      r10, (sp+40)
    lw      r11, (sp+44)
    lw      r12, (sp+48)
    lw      r13, (sp+52)
    lw      r14, (sp+56)
    lw      r15, (sp+60)
    lw      r16, (sp+64)
    lw      r17, (sp+68)
    lw      r18, (sp+72)
    lw      r19, (sp+76)
    lw      r20, (sp+80)
    lw      r21, (sp+84)
    lw      r22, (sp+88)
    lw      r23, (sp+92)
    lw      r24, (sp+96)
    lw      r25, (sp+100)
    lw      r26, (sp+104)
    lw      r27, (sp+108)
    lw      ra,  (sp+112)
    lw      ea,  (sp+116)
    lw      ba,  (sp+120)
	addi    sp, sp, 120

ret_int_1:
	mvhi    r1, hi(runtsk)
    ori     r1, r1, lo(runtsk)
    lw      r1, (r1+0)

    lw      r2, (r1+TCB_enatex)
	mvhi    r3, hi(TCB_enatex_mask)
	ori     r3, r3, lo(TCB_enatex_mask)
	be      r2, r3, ret_int_2

	lw      r2, (r1+TCB_texptn)
	be      r2, r0, ret_int_2

	calli   call_texrtn

ret_int_2:
	addi    sp, sp, 4
	lw      ra, (sp+0)
	ret

