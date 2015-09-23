/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2006 by Witz Corporation, JAPAN
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
 *  @(#) $Id: makeoffset.c,v 1.1 2006/04/10 08:19:25 honda Exp $
 */


/*
 *	offset.inc (�⤷���� offset.h) �ˤĤ���
 *
 *	  offset.inc �Ϲ�¤�Τ���������Ǥ���¤�Τ���Ƭ���鲿�Х����ܤ�
 *	¸�ߤ��뤫�Ȥ������Ȥ�, ����Υӥåȥե�����ɤ���Ƭ����
 *	���Х�����β��ӥå��ܤ�¸�ߤ��뤫, �Ȥ��������
 *	������֥����ե������Ϳ���뤿���¸�ߤ��Ƥ���.
 *
 *	  offset.inc �ե��������Ȥ�, ñ�ʤ륷��ܥ�����ե�����Ǥ���.
 *	����ܥ�Ȥ��äƤ�������륷��ܥ��̾�Τˤϥѥ����󤬤���,
 *	�礭��ʬ���Ƽ���3�����ʬ��Ǥ���.
 *
 *	<��¤��̾>_<����̾>	(��) TCB_sp, TCB_pc, TCB_enatex �ʤ�
 *	<��¤��̾>_<����̾>_bit	(��) TCB_enatex_bit �ʤ�
 *	<��¤��̾>_<����̾>_mask (��) TCB_enatex_mask �ʤ�
 *
 *	(��)
 *		TCB_texptn		equ		14
 *		TCB_sp			equ		20
 *		TCB_pc			equ		24
 *		TCB_enatex		equ		12
 *		TCB_enatex_bit	equ		14
 *		TCB_enatex_mask	equ		0x4000
 *
 *	  ���֤Ϥ������������Ǥ���¤�Τ���Ƭ���鲿�Х�����ˤ��뤫
 *	�Ȥ������Ȥ򼨤����ͤˤĤ����٥��̾��.
 *	  �����ܤ�����Υӥåȥե��������ΥӥåȤ�, ���̤��������
 *	���ӥå��ܤˤ��뤫�Ȥ������Ȥ򼨤����ͤˤĤ����٥��̾��. 
 *	0����Ϥޤ���ͤ�ɽ������. �ǤⲼ�̤ΥӥåȤ���0�ӥåȤǤ���.
 *	  �����ܤ���ۤɤ� <��¤��̾>_<����̾>_bit �Ȥ��Ϣ���뤬,
 *	����Υӥåȥե��������ΥӥåȤΥޥ����ͤ�̾��.
 *	*_bit �� *_mask ���ͤδ֤ˤϼ��δط�������.
 *		(*_mask) == (1 << *_bit)
 *	(��) TCB_enatex_bit �� 14 �λ�, TCB_enatex_mask �� 0x4000
 *
 *	  ���ʤߤ�TLCS-900L1��¸���μ����Ǥ�, ����ӥåȤΥ����å��ʤɤ�
 *	�ӥå�̿�ᥢ�ɥ�å��󥰤���Ѥ��Ƥ���Τ� *_mask �Ȥ�����٥��
 *	���Ѥ��Ƥ��ʤ�.
 */

#include "jsp_kernel.h"
#include "task.h"


void makeoffset(void);

void
makeoffset()
{
	Asm("; BEGIN TCB_texptn\n");
	(((TCB *)0)->texptn) |= (TEXPTN)1;
	Asm("; END");

	Asm("; BEGIN TCB_sp\n");
	(((TCB *)0)->tskctxb.xsp) = (VP)1;
	Asm("; END");

	Asm("; BEGIN TCB_pc\n");
	(((TCB *)0)->tskctxb.pc)();
	Asm("; END");

	Asm("; BEGIN TCB_enatex\n");
	(((TCB *)0)->enatex) = 1;
	Asm("; END");
}
