/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2000-2003 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
 *  Copyright (C) 2001-2003 by Industrial Technology Institute,
 *                              Miyagi Prefectural Government, JAPAN
 *  Copyright (C) 2001-2003 by Dep. of Computer Science and Engineering
 *                   Tomakomai National College of Technology, JAPAN
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
 *  @(#) $Id: cpu_defs.h,v 1.8 2003/11/11 10:07:15 honda Exp $
 */

#ifndef _CPU_DEFS_H_
#define _CPU_DEFS_H_

/*
 *  �ץ����å��˰�¸�������
 */

#define H8

/*
 *  ������ƥ��å������
 */

#define	TIC_NUME	1		/* ������ƥ��å��μ�����ʬ�� */
#define	TIC_DENO	1		/* ������ƥ��å��μ�����ʬ�� */

#define	STACK_SIZE	1024		/* �������Υ����å������� */

/*
 *  CPU �ΥХ��Ƚ�˴ؤ������
 */

#define SIL_ENDIAN		SIL_ENDIAN_BIG

#ifndef _MACRO_ONLY

typedef	UINT	INHNO;			/* ����ߥϥ�ɥ��ֹ� */
typedef	UINT	EXCNO;			/* CPU�㳰�ϥ�ɥ��ֹ� */

/*
 *  �������åȥ����ƥ��¸�Υ����ӥ�������
 */

   /*
    * cpu_defs.h��sys_defs.h�򥤥󥯥롼�ɤ�����֤�
    * �ط���SUPPORT_VXGET_TIM�ޥ����ǤϰϤޤʤ�
    * ��_MACRO_ONLY�ޥ����ǰϤ�С���ʬ��
   */

typedef	UD  SYSUTIM;	/* ��ǽɾ���ѥ����ƥ���� */

extern ER   vxget_tim(SYSUTIM *pk_sysutim);

/*
 *  �����ƥ�����ǽ���
 */

Inline void
kernel_abort (void)
{
	while (1)
		;
	}

#endif /* _MACRO_ONLY */

#endif /* _CPU_DEFS_H_ */