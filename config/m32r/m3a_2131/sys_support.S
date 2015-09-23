/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2000-2003 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
 *  Copyright (C) 2007 by Embedded and Real-Time Systems Laboratory
 *              Graduate School of Information Science, Nagoya Univ., JAPAN
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
 *  @(#) $Id: sys_support.S,v 1.2 2007/05/30 08:38:51 honda Exp $
 */

/*
 *	�������åȥ����ƥ��¸�⥸�塼�� ������֥��������M3A-2131�ѡ�
 */

#define	_MACRO_ONLY

#include <m32rasm.inc>
#include <s_services.h>

/*
 *  ���٥�Υ������åȥ����ƥ��¸�ν����
 *
 *  �������ȥ��åץ⥸�塼�����ǡ�����ν���������˸ƤӽФ���롥
 */
	.macro	out		addr, val
		ld24	r0, \addr
		seth	r1, #((\val) >> 16)
		or3		r1, r1, #((\val) & 0xffff)
		st		r1, @r0
	.endm

	.macro	outh	addr, val
		ld24	r0, #(\addr)
		ldi		r1, #(\val)
		sth		r1, @r0
	.endm

	.macro	outb	addr, val
		ld24	r0, #(\addr)
		ldi		r1, #(\val)
		stb		r1, @r0

	.endm

Function hardware_init_hook

	outb	PLLCR+3,   0x1			/* PLL�����å�ư��� */
	out		BSELCR(1), 0x0fffb50f	/* �����Х����֥��å�������ѡ�SDRAM�� */

	/* PIO������ */
	outh	PMOD(0),   0x0100	/* �����Х�BSEL1����� */
	outh	PMOD(1),   0x1		/* �����Х�RD/WR */
	outh	PMOD(2),   0x1		/* �����Х�WS3 */
	outh	PMOD(3),   0x5555	/* �����Х� */
	outh	PMOD(4),   0x5555	/* �����Х� */
	outh	PMOD(5),   0x0555	/* ��������I/O */
	outh	PMOD(6),   0x0555	/* ��������I/O */

	outh	SDIR0+2,   0x182

	/* SDRAM����� */
	ld24	r0, SDIR1+3
	ldi		r1, 1
	stb		r1, @r0
	addi	r0, -2
L1:	ldb		r1, @r0
	bnez	r1, L1					/* DINST�ӥåȤ����ꥢ�����Ƚ������λ */

	outb	SDBR+3, 0x2
	outh	SDRF1+2, 0x0020
	outh	SDMOD(0)+2, 0
	out		SDADR(0), 0x01000042	/* 0x01000000, 32bit, bank 4, 16MB */
	outh	SDTR(0)+2,0x0001

	outb	SDRF1+1, 1				/* ��ե�å���ͭ�� */
	outb	SDER(0)+3, 1			/* SDRAMͭ�� */
	outb	CPUCLKCR+1, 0x2			/* CPU�����å��Ȥ���PLL�����å������ */
	rts

Function software_init_hook
	rts

Function vxget_tim
	rts