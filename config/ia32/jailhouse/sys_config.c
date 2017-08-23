/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2000,2001 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
 *  Copyright (C) 2002 by Monami software, Limited Partners.
 *  Copyright (C) 2002 by MURANAKA Masaki
 *  Copyright (C) 2008-     by Monami Software Limited Partnership, JAPAN
 * 
 *  上記著作権者は，以下の(1)〜(4)の条件を満たす場合に限り，本ソフトウェ
 *  ア（本ソフトウェアを改変したものを含む．以下同じ）を使用・複製・改
 *  変・再配布（以下，利用と呼ぶ）することを無償で許諾する．
 *  (1) 本ソフトウェアをソースコードの形で利用する場合には，上記の著作
 *      権表示，この利用条件および下記の無保証規定が，そのままの形でソー
 *      スコード中に含まれていること．
 *  (2) 本ソフトウェアを，ライブラリ形式など，他のソフトウェア開発に使
 *      用できる形で再配布する場合には，再配布に伴うドキュメント（利用
 *      者マニュアルなど）に，上記の著作権表示，この利用条件および下記
 *      の無保証規定を掲載すること．
 *  (3) 本ソフトウェアを，機器に組み込むなど，他のソフトウェア開発に使
 *      用できない形で再配布する場合には，次のいずれかの条件を満たすこ
 *      と．
 *    (a) 再配布に伴うドキュメント（利用者マニュアルなど）に，上記の著
 *        作権表示，この利用条件および下記の無保証規定を掲載すること．
 *    (b) 再配布の形態を，別に定める方法によって，TOPPERSプロジェクトに
 *        報告すること．
 *  (4) 本ソフトウェアの利用により直接的または間接的に生じるいかなる損
 *      害からも，上記著作権者およびTOPPERSプロジェクトを免責すること．
 *      また，本ソフトウェアのユーザまたはエンドユーザからのいかなる理
 *      由に基づく請求からも，上記著作権者およびTOPPERSプロジェクトを
 *      免責すること．
 * 
 *  本ソフトウェアは，無保証で提供されているものである．上記著作権者お
 *  よびTOPPERSプロジェクトは，本ソフトウェアに関して，特定の使用目的
 *  に対する適合性も含めて，いかなる保証も行わない．また，本ソフトウェ
 *  アの利用により直接的または間接的に生じたいかなる損害に関しても，そ
 *  の責任を負わない．
 * 
 *  @(#) $Id: sys_config.c,v 1.1 2004/07/21 02:49:36 monaka Exp $
 */

/*
 *	ターゲットシステム依存モジュール（PC/AT用）
 */

#include "jsp_kernel.h"
#include <sil.h>
#include <i386.h>
#include <irc.h>
#include <irc_inline.h>

FP int_table[0x10]; /* 割込みハンドラのテーブル */

/*
 *  ターゲットシステム依存の初期化
 */
void
sys_initialize()
{
	set_gate_descriptor(0x20, 0x8, interrupt0, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x21, 0x8, interrupt1, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x22, 0x8, interrupt2, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x23, 0x8, interrupt3, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x24, 0x8, interrupt4, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x25, 0x8, interrupt5, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x26, 0x8, interrupt6, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x27, 0x8, interrupt7, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x28, 0x8, interrupt8, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x29, 0x8, interrupt9, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x2a, 0x8, interrupt10, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x2b, 0x8, interrupt11, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x2c, 0x8, interrupt12, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x2d, 0x8, interrupt13, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x2e, 0x8, interrupt14, I386_TYPE_GATE_INTR, 0);
	set_gate_descriptor(0x2f, 0x8, interrupt15, I386_TYPE_GATE_INTR, 0);

	irc_initialize();
}

/*
 *  ターゲットシステムの終了
 */
void
sys_exit(void)
{
	while(1);
}

ER irc_dis_irq(UB irq)
{
	BOOL cpu_locked;

	if (irq > 15) {
		return E_PAR;
	}

	cpu_locked = sense_lock();

	if(!cpu_locked)
	{
		x_lock_cpu();
	}

	if(irq < 8)
	{
		sil_wrb_iop((VP)0x21, sil_reb_iop((VP)0x21) | (1 << irq));
	}
	else
	{
		sil_wrb_iop((VP)0xA1, sil_reb_iop((VP)0xA1) | (1 << (irq - 8)));
	}

	if(!cpu_locked)
	{
		x_unlock_cpu();
	}

	return E_OK;
}

ER irc_ena_irq(UB irq)
{
	BOOL cpu_locked;

	if (irq > 15) {
		return E_PAR;
	}

	cpu_locked = sense_lock();

	if(!cpu_locked)
	{
		x_lock_cpu();
	}

	if(irq < 8)
	{
		sil_wrb_iop((VP)0x21, sil_reb_iop((VP)0x21) & ~(1 << irq));
	}
	else
	{
		sil_wrb_iop((VP)0xA1, sil_reb_iop((VP)0xA1) & ~(1 << (irq - 8)));
	}

	if(!cpu_locked)
	{
		x_unlock_cpu();
	}

	return E_OK;
}

static BOOL jailhouse_use_vmcall = TRUE;
#define JAILHOUSE_HC_DEBUG_CONSOLE_PUTC	8
#define JAILHOUSE_CALL_CODE	\
	"cmpb $0x01, %[use_vmcall]\n\t"\
	"jne 1f\n\t"\
	"vmcall\n\t"\
	"jmp 2f\n\t"\
	"1: vmmcall\n\t"\
	"2:"
#define JAILHOUSE_CALL_RESULT	"=a" (result)
#define JAILHOUSE_USE_VMCALL	[use_vmcall] "m" (jailhouse_use_vmcall)
#define JAILHOUSE_CALL_NUM	"a" (num)
#define JAILHOUSE_CALL_ARG1	"D" (arg1)

static UW jailhouse_call_arg1(UW num, UW arg1)
{
	UW result;

	asm volatile(JAILHOUSE_CALL_CODE
		: JAILHOUSE_CALL_RESULT
		: JAILHOUSE_USE_VMCALL,
		  JAILHOUSE_CALL_NUM, JAILHOUSE_CALL_ARG1
		: "memory");
	return result;
}

static void jailhouse_putc(char c)
{
	jailhouse_call_arg1(JAILHOUSE_HC_DEBUG_CONSOLE_PUTC, c);
}

void sys_putc(char c)
{
    jailhouse_putc(c);
}

void
define_inh(INHNO inhno, FP inthdr)
{
#if 0
	if (inhno >= 256 || inthdr == NULL)
	{
		return; /*??? Should I generate assertion? */
	}
#endif
	int_table[TO_INTNO(inhno)] = inthdr;
}

ER vdef_inh(INHNO inhno, const T_DINH *pk_dinh) {
	BOOL locked;
	if (!(0x20 <= inhno && inhno <= 0x2f)) {
		return E_PAR;
	}
	if (pk_dinh->inhatr != TA_HLNG) {
		return E_RSATR;
	}
	locked = sense_lock();
	if (!locked) {
		x_lock_cpu();
	}
	define_inh(inhno, pk_dinh->inthdr);
	if (!locked) {
		x_unlock_cpu();
	}
	return E_OK;
}
