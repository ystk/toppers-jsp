/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 *
 *  Copyright (C) 2000-2003 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
 *  Copyright (C) 2001-2003 by Industrial Technology Institute,
 *                              Miyagi Prefectural Government, JAPAN
 *
 *  上記著作権者は，以下の (1)〜(4) の条件か，Free Software Foundation 
 *  によって公表されている GNU General Public License の Version 2 に記
 *  述されている条件を満たす場合に限り，本ソフトウェア（本ソフトウェア
 *  を改変したものを含む．以下同じ）を使用・複製・改変・再配布（以下，
 *  利用と呼ぶ）することを無償で許諾する．
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
 * 
 *  本ソフトウェアは，無保証で提供されているものである．上記著作権者お
 *  よびTOPPERSプロジェクトは，本ソフトウェアに関して，その適用可能性も
 *  含めて，いかなる保証も行わない．また，本ソフトウェアの利用により直
 *  接的または間接的に生じたいかなる損害に関しても，その責任を負わない．
 *
 *  @(#) $Id: shelf.stub.ld,v 1.5 2005/07/06 00:45:07 honda Exp $
 */

OUTPUT_FORMAT("elf32-sh","elf32-sh","elf32-sh")
OUTPUT_ARCH(sh)
STARTUP(start.o);

PROVIDE (__stack = 0) ;
PROVIDE(_hardware_init_hook = 0);
PROVIDE(_software_init_hook = 0);
PROVIDE(_software_term_hook = 0);
PROVIDE(_memcpy = __dummy_memcpy);

MEMORY {
	/* internal ROM area: 0x000000 - 0x07ffff */
	rom		: o = 0x000000, l = 0x080000
        vector		: o = 0x000000, l = 0x000400
		romexe		: o = 0x000400, l = 0x800000

	/* external RAM area: 0x200000 - 0x21ffff */
	ram		: o = 0x200000, l = 0x020000

	/* internal RAM area: 0xffffd000 - 0xffffffff */
	sram	: o = 0xffffd000, l = 0x003000
        readwrite	: o = 0xffffd000, l = 0x002c00
}

SECTIONS
{
    .vector :
	{
		*(.vector)
    } > vector
    .init :
	{
        KEEP (*(.init))
    }
    .text :
	{
        __text = . ;
        *(.text .stub .text.* .gnu.linkonce.t.*)
    } > romexe
    .fini :
    {
        KEEP (*(.fini))
    }
    _etext = . ;
    PROVIDE (etext = .) ;
    .varrom :
    {
        *(.rodata .rodata.* .gnu.linkonce.r.*)
    } > romexe
    .rodata :
    {
        *(.rodata .rodata.* .gnu.linkonce.r.*)
    } > romexe
    . = ALIGN(4) ;
    .eh_frame : { KEEP (*(.eh_frame)) }
    .gcc_except_table : { *(.gcc_except_table) }
    .ctors :
    {
        KEEP (*crtbegin.o(.ctors))
        KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
        KEEP (*(SORT(.ctors.*)))
        KEEP (*(.ctors))
    } > romexe
    .dtors :
    {
        KEEP (*crtbegin.o(.dtors))
        KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
        KEEP (*(SORT(.dtors.*)))
        KEEP (*(.dtors))
    } > romexe
    __idata_start = . ;
    .data : AT(__idata_start) 
    {
        __data_start = . ;
        *(.data)
    } > ram
    __idata_end = __idata_start + SIZEOF(.data) ;
    _edata  = . ;
    PROVIDE (edata = .) ;
    . = ALIGN(4) ;
    __bss_start = . ;
    .bss :
    {
        *(.bss)
        *(COMMON)
    } > ram
    _end = . ;
    __bss_end = . ;
	.var :
	{
		*(.var)
	} > readwrite
    PROVIDE (end = .) ;
    .comment        0 : { *(.comment) }
    .debug          0 : { *(.debug) }
    .line           0 : { *(.line) }
    .debug_srcinfo  0 : { *(.debug_srcinfo) }
    .debug_sfnames  0 : { *(.debug_sfnames) }
    .debug_aranges  0 : { *(.debug_aranges) }
    .debug_pubnames 0 : { *(.debug_pubnames) }
}
