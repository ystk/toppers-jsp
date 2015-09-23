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
 *  @(#) $Id: sys_config.c,v 1.2 2007/05/28 02:03:55 honda Exp $
 */

/*
 *	�������åȥ����ƥ��¸�⥸�塼���M3A-ZA36�ѡ�
 */
#include <sys_rename.h>
#include <s_services.h>

#include "jsp_kernel.h"
#include <hw_serial.h>

/*
 *  �������åȥ����ƥ��¸�ν����
 */
void
sys_initialize()
{
	/* UART����� */
	sil_wrb_mem((void *)(SIOCR(CONSOLE_PORTID-1)+3), 0);

	/* �ݡ��Ȥ򳫤�(UART0) */
	sil_wrb_mem((void *)PDATA(5), 0);
	sil_wrb_mem((void *)PDIR(5),  0x80);

	/* UART, Non-parity, 1 stop-bit */
	sil_wrb_mem((void *)(SIOMOD0(CONSOLE_PORTID-1)+3), 0);

	/* 8bit, internal clock */
	sil_wrh_mem((void *)(SIOMOD1(CONSOLE_PORTID-1)+2), 0x0800);

	/* M32R(32102) - f(BLK)=10MHz��57600bps */
	sil_wrh_mem((void *)(SIOBAUR(CONSOLE_PORTID-1)+2), SERIAL_CLKDIV);
	sil_wrb_mem((void *)(SIORBAUR(CONSOLE_PORTID-1)+3), SERIAL_CLKCMP);

	/* ���ơ��������ꥢ, ������ư��� */
	sil_wrb_mem((void *)(SIOCR(CONSOLE_PORTID-1)+2), 0x3);
	sil_wrb_mem((void *)(SIOCR(CONSOLE_PORTID-1)+3), 0x3);

	/* TxD,RxD�ԥ�ͭ��(UART0) */
	sil_wrh_mem((void *)PMOD(5), 0x5500);
}

/*
 *  �������åȥ����ƥ�ν�λ
 */
void
sys_exit(void)
{
	dis_int();
	*(volatile unsigned char *)(ICUIMASK+1) = 0;
	while(1==1)
	{
		/* ��������ϥ⡼�ɤذܹ� */
		__asm(	"stb	%0, @%1	\n"
				"ldb	%0, @%1 \n"
			  	"nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop"
			: : "r"(1), "r"(CLKMOD+3) );
	}
}

/*
 *  �������åȥ����ƥ��ʸ������
 */
void
sys_putc(char c)
{
	if(c == '\n')
		sys_putc('\r');
	while( (sil_reb_mem((void *)(SIOSTS(CONSOLE_PORTID-1)+3)) & 0x1) == 0);	/* ������λ�Ԥ� */
	sil_wrb_mem((void *)(SIOTXB(CONSOLE_PORTID-1)+3), c);	/* ��ʸ������ */
}