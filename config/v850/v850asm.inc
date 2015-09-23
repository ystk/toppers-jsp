/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2000 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
 * 
 *  �嵭����Ԥϡ��ʲ��ξ������������˸¤ꡤ�ܥ��եȥ��������ܥ�
 *  �եȥ���������Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ�������ѡ�����
 *  �ۡʰʲ������ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
 *  (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
 *      ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
 *      ����������˴ޤޤ�Ƥ��뤳�ȡ�
 *  (2) �ܥ��եȥ�������Х��ʥꥳ���ɤη��ޤ��ϵ�����Ȥ߹����������
 *      �Ѥ�����ˤϡ����Τ����줫�ξ������������ȡ�
 *    (a) ���Ѥ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭������
 *        ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *    (b) ���Ѥη��֤��̤�������ˡ�ˤ�äơ��嵭����Ԥ���𤹤�
 *        ���ȡ�
 *  (3) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
 *      ������⡤�嵭����Ԥ����դ��뤳�ȡ�
 * 
 *  �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥϡ�
 *  �ܥ��եȥ������˴ؤ��ơ�����Ŭ�Ѳ�ǽ����ޤ�ơ������ʤ��ݾڤ�Ԥ�
 *  �ʤ����ޤ����ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū����������
 *  ���ʤ�»���˴ؤ��Ƥ⡤������Ǥ�����ʤ���
 * 
 *  @(#) $Id: v850asm.inc,v 1.1 2000/11/24 03:41:29 takayuki Exp $
 */

/*
 *  V850������֥��Ѥ�����������ե�����
 */


	/*
	 * ��٥������ Lea (Load Effective Address)
	 */
	 
	.macro	Lea name, destination
	movhi	hi(\name), r0, \destination
	movea	lo(\name), \destination, \destination
	.endm


	/*
	 * �ؿ���� Function
	 *
	 *   �ؿ�̾�Ȥ��ƻȤ���٥���դ� �������Ԥ�
	 */
	 
	.macro	Function name
	.text
	.align	4
	.globl	\name
	.type	\name,@function
\name:
	.endm

	/*
	 * ��٥���� Label
	 *
	 *   �ؿ�̾�Ȥ��ƻȤ���٥���դ�Ԥ�
	 */
	
	.macro	Label name
	.globl	\name
	.type	\name,@function
\name:
	.endm

	/*
	 * �����å���� - �ץå���
	 */
	
	.macro	Push source
	add		-4, r3
	st.w	\source, 0[r3]
	.endm
	
	/*
	 * �����å���� - �ݥå�
	 */
	
	.macro	Pop dest
	ld.w	0[r3],\dest
	add		4, r3
	.endm

	/*
	 * �����å���� - ������å�����
	 */
	.macro	PushScratchRegisters
	st.w	r12,  -4[r3]
	st.w	r13,  -8[r3]
	st.w	r14, -12[r3]
	st.w	r15, -16[r3]
	st.w	r16, -20[r3]
	st.w	r17, -24[r3]
	st.w	r18, -28[r3]
	st.w	r19, -32[r3]
	add		-32, r3
	.endm
	
	/*
	 * �����å���� - ������å�����
	 */
	.macro	PopScratchRegisters
	add		32, r3
	ld.w	 -4[r3], r12
	ld.w	 -8[r3], r13
	ld.w	-12[r3], r14
	ld.w	-16[r3], r15
	ld.w	-20[r3], r16
	ld.w	-24[r3], r17
	ld.w	-28[r3], r18
	ld.w	-32[r3], r19
	.endm