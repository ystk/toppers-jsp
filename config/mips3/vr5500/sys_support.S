/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2000-2003 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
 *  Copyright (C) 2000-2003 by Industrial Technology Institute,
 *                              Miyagi Prefectural Government, JAPAN
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
 */

#define _MACRO_ONLY

#include "jsp_kernel.h"
#include "offset.h"		/* INT_TABLE_intmask�Τ����ɬ�� */

	.set noreorder
	.align 2

/*
 *  �������åȥϡ��ɥ�������¸������������
 */
	.section .reset
	.global	hardware_init_hook

hardware_init_hook:

	/*
	 * ����å���ν����
	 */
	mtc0	zero, TagLo
	mtc0	zero, TagHi

	li	t0, 0x80003fe0
	li	t1, 0x80000000
loop_I_cache_clear:
	cache	Index_Store_Tag_I, +0(t0)
	cache	Index_Store_Tag_I, +1(t0)
	bne	t0, t1, loop_I_cache_clear
	addiu	t0, t0, -I_CACHE_LINE_SIZE

	li	t0, 0x80003fe0
	li	t1, 0x80000000
loop_D_cache_clear:
	cache	Index_Store_Tag_D, +0(t0)
	cache	Index_Store_Tag_D, +1(t0)
	bne	t0, t1, loop_D_cache_clear
	addiu	t0, t0, -D_CACHE_LINE_SIZE

	/*
	 * TLB�ν����
	 */
	mtc0	zero, PageMask
	mtc0	zero, EntryLo0
	mtc0	zero, EntryLo1

	li	t0, TMAX_TLB
	li	t1, 0xA8000000		/* kseg1 �����DRAM�ν����� */
loop_TLB_clear:
	mtc0	t0, Index
	mtc0	t1, EntryHi
	addiu	t0, t0, -1
	addiu	t1, t1, TLB_VPN2	/* 1�ڡ�����4k�Х��Ȥǡ�2�ڡ���ʬ��
					   �ޥåԥ󥰤��뤿�� */
	tlbwi
	bgez	t0, loop_TLB_clear
	nop

	/*
	 * �ܡ��ɤν����
	 */

	/* SDRAM ����ȥ�����ν���� */
	li	t0, 0x00
	sb	t0, 0xb8006000		/* SRAMC_SWAIT */

	li	t0, 0x02
	sb	t0, 0xb8005000		/* DRAMC_RCD */
	li	t0, 0x02
	sb	t0, 0xb8005010		/* DRAMC_RP */
	li	t0, 0x05
	sb	t0, 0xb8005020		/* DRAMC_RC */
	li	t0, 0x06
	sb	t0, 0xb8005030		/* DRAMC_RRC */
	li	t0, 0x04
	sb	t0, 0xb8005040		/* DRAMC_RAS */
	li	t0, 0x02
	sb	t0, 0xb8005050		/* DRAMC_LAT */
	li	t0, 0x02
	sb	t0, 0xb8005060		/* DRAMC_RSC */
	li	t0, 0x01
	sb	t0, 0xb8005070		/* DRAMC_AP */

	li	t0, 0x00
	sb	t0, 0xb8004000		/* DRAM_INIT */

	/* DRAM��ե�å����ѥ����ޤν���� */
	li	t0, 0xb4
	sb	t0, 0xb9005030		/* PCNTL */
	li	t0, 0x1f
	sb	t0, 0xb9005020		/* PCNT2 */
	li	t0, 0x00
	sb	t0, 0xb9005020		/* PCNT2 */

	/* SRAM�ν���� */

	/* SRAM�����ΰ���Ф��ơ����ٽ񤭹��ߤ�Ԥ�������ɬ�� */
	la	t0, 0xa0000000
	li	t1, 0x00100000-4
loop_sram_clear:
	add	t2, t1, t0
	sw	zero, (t2)
	bgez	t1, loop_sram_clear
	addiu	t1, t1, -4

	/* �����ߥ���ȥ���������� */
	sb	zero, 0xb9000020	/* PIC_INTR��������׵�Υ��ꥢ */
	li	t0, 0x01		/* ��������Τ�����1�ܤΤ߻Ȥ� */
	sb	t0, 0xb9000030		/* PIC_INTEN */

	/*----------*/


	j	ra		/*  �ƤӽФ����إ꥿����  */
	nop

/*============================================================================*/

/* ����߽����˴ؤ��롢������װ���Ƚ��ʬ�������Υ����ƥ��¸�� */

	.align 3
	.section .text
	.global proc_interrupt_sys
	.global int_table	/* ����ߥϥ�ɥ�ε����٥����ơ��֥�
				   cpu_config.h, cpu_config.c����� */

	/*  �ƤӽФ��줿�Ȥ���       */
	/*    a1�˥��ơ������쥸���� */
	/*    a2�˸����쥸����       */
	/*  ���ͤ����äƤ���         */

proc_interrupt_sys:
	and     t2, a2, a1          /*  ������׵�ӥåȤ˥ޥ����򤫤���  */
	andi    t3, t2, Cause_IP0   /*  IP0�ӥåȼ��Ф�  */
	bne     t3, zero, proc_IP0
	andi    t4, t2, Cause_IP1   /*  IP1�ӥåȼ��Ф�  */
	bne     t4, zero, proc_IP1
	andi    t5, t2, Cause_IP2   /*  IP2�ӥåȼ��Ф�  */
	bne     t5, zero, proc_IP2
	andi    t6, t2, Cause_IP3   /*  IP3�ӥåȼ��Ф�  */
	bne     t6, zero, proc_IP3
	andi    t7, t2, Cause_IP4   /*  IP4�ӥåȼ��Ф�  */
	bne     t7, zero, proc_IP4
	andi    t8, t2, Cause_IP5   /*  IP5�ӥåȼ��Ф�  */
	bne     t8, zero, proc_IP5
	andi    t9, t2, Cause_IP6   /*  IP6�ӥåȼ��Ф�  */
	bne     t9, zero, proc_IP6
	nop

/*  MIPS3������٥��ʬ��������٥�Ǥν���	*/
/*    ������װ��ֹ��t0�������		*/
/*    ������׵᥯�ꥢ�Τ���������t1�������	*/
/*    set_ICU_IPM������				*/
proc_IP7:   /*  ������װ�IP7�ʥ����ޡˤξ��  */
	xori    t1, zero, Cause_IP7
	j       set_ICU_IPM
	ori     t0, zero, INTNO_IP7

proc_IP0:   /*  ������װ�IP0�ʥ��եȥ����������0�ˤξ��  */
	xori    t1, zero, Cause_IP0
	j       set_ICU_IPM
	ori     t0, zero, INTNO_IP0

proc_IP1:   /*  ������װ�IP1�ʥ��եȥ����������1�ˤξ��  */
	xori    t1, zero, Cause_IP1
	j       set_ICU_IPM
	ori     t0, zero, INTNO_IP1

proc_IP2:   /*  ������װ�IP2�ξ��  */ 
            /*    ����ߥ���ȥ������¸�����������С��������¹Ԥ���  */
#ifdef PROC_INT0
	PROC_INT0		/* �����ƥ��¸�����������ޥ��� */
	xori    t1, zero, Cause_IP2
	j       set_ICU_IPM
	nop
#else
	xori    t1, zero, Cause_IP2
	j       set_ICU_IPM
	ori     t0, zero, INTNO_IP2
#endif

proc_IP3:   /*  ������װ�IP3�ξ��  */ 
            /*    ����ߥ���ȥ������¸�����������С��������¹Ԥ���  */
#ifdef PROC_INT1
	PROC_INT1		/* �����ƥ��¸�����������ޥ��� */
	xori    t1, zero, Cause_IP3
	j       set_ICU_IPM
	nop
#else
	xori    t1, zero, Cause_IP3
	j       set_ICU_IPM
	ori     t0, zero, INTNO_IP3
#endif

proc_IP4:   /*  ������װ�IP4�ξ��  */ 
            /*    ����ߥ���ȥ������¸�����������С��������¹Ԥ���  */
#ifdef PROC_INT2
	PROC_INT2		/* �����ƥ��¸�����������ޥ��� */
	xori    t1, zero, Cause_IP4
	j       set_ICU_IPM
	nop
#else
	xori    t1, zero, Cause_IP4
	j       set_ICU_IPM
	ori     t0, zero, INTNO_IP4
#endif

proc_IP5:   /*  ������װ�IP5�ξ��  */ 
            /*    ����ߥ���ȥ������¸�����������С��������¹Ԥ���  */
#ifdef PROC_INT3
	PROC_INT3		/* �����ƥ��¸�����������ޥ��� */
	xori    t1, zero, Cause_IP5
	j       set_ICU_IPM
	nop
#else
	xori    t1, zero, Cause_IP5
	j       set_ICU_IPM
	ori     t0, zero, INTNO_IP5
#endif

proc_IP6:   /*  ������װ�IP6�ξ��  */ 
            /*    ����ߥ���ȥ������¸�����������С��������¹Ԥ���  */
#ifdef PROC_INT4
	PROC_INT4		/* �����ƥ��¸�����������ޥ��� */
	xori    t1, zero, Cause_IP6
#else
	xori    t1, zero, Cause_IP6
	ori     t0, zero, INTNO_IP6
#endif

/*  ����ߥ���ȥ������¸�Υޥ�������  */
set_ICU_IPM:

#ifdef SET_ICU_IPM
	SET_ICU_IPM	/* �����ƥ��¸�����������ޥ���		    */
			/*   ������Ԥ��Ȥ��ˤϡ������ˤ�t0��t1�����Ѥ���� */
			/*   ���˲����ʤ��褦�ˡ����դ��ʤ���Фʤ�ʤ���   */
#endif

/*
 *  �����쥸����IP�ӥåȤ��ݻ�����Ƥ���Ƽ����ߤγ�����׵�򥯥ꥢ���롣
 *  t1�ˤϡ�������׵�ӥåȤ�ȿž������Τ����äƤ��롣
 */
	mfc0    t8, Cause
	and     t8, t8, t1
	mtc0    t8, Cause

/*  ���ơ������쥸�����Υޥ��������C����롼����ƤӽФ�  */
/*    t0�˳�����װ��ֹ椬���ꤵ�줿���֤Ǥ��������  */
	la      t3, int_table   /*  �����٥������ɥ쥹  */
	sll     t4, t0, 3       /*  ������װ��ֹ��8��
				      TNT_TABLE���ϡ�
					�ϥ�ɥ�Υ��ɥ쥹(4�Х���)
					��MIPS3�����γ���ߥޥ���(4�Х���)
				      8�Х��ȡ� */
	add     t5, t3, t4      /*  �٥������ɥ쥹�򻻽�  */
	lw      t6, INT_TABLE_intmask(t5)
           		    	/*  IPM(����ߵ��ĥӥå�)�ɤ߽Ф���
				    ����ߥޥ����ʳ����ͤϡ�
					IE�ӥåȤϥ��å�
					EXL�ӥåȤϥꥻ�å�
				    ���֤ˤʤäƤ��롣*/
	lw      t7, (t5)        /*  C����롼������Ƭ���ɥ쥹�ɤ߽Ф�  */

	jalr    ra, t7          /*  C����롼����ƤӽФ�  */
	mtc0    t6, Status      /*  ����ߵ��ġ����ơ������쥸�����Υޥ�������*/

	mfc0    t0, Status
	ori     t0, t0, SR_EXL  /*  ����߶ػߡ�IE�ӥåȤ��ͤ��ݻ����ʤ���Фʤ�
						�ʤ��Τ�EXL�ӥåȤ��Ѥ��롣*/
	mtc0    t0, Status

	/*  CP0�ϥ����ɤΤ���λ��ֲԤ�  */
#ifdef NOP_FOR_CP0_HAZARD
	NOP_FOR_CP0_HAZARD
#endif /* NOP_FOR_CP0_HAZARD */

	j	join_interrupt_and_exception
	nop
