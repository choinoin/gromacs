;#
;# $Id$
;#
;# Gromacs 4.0                         Copyright (c) 1991-2003 
;# David van der Spoel, Erik Lindahl
;#
;# This program is free software; you can redistribute it and/or
;# modify it under the terms of the GNU General Public License
;# as published by the Free Software Foundation; either version 2
;# of the License, or (at your option) any later version.
;#
;# To help us fund GROMACS development, we humbly ask that you cite
;# the research papers on the package. Check out http://www.gromacs.org
;# 
;# And Hey:
;# Gnomes, ROck Monsters And Chili Sauce
;#

;# These files require GNU binutils 2.10 or later, since we
;# use intel syntax for portability, or a recent version 
;# of NASM that understands Extended 3DNow and SSE2 instructions.
;# (NASM is normally only used with MS Visual C++).
;# Since NASM and gnu as disagree on some definitions and use 
;# completely different preprocessing options I have to introduce a
;# trick: NASM uses ';' for comments, while gnu as uses '#' on x86.
;# Gnu as treats ';' as a line break, i.e. ignores it. This is the
;# reason why all comments need both symbols...
;# The source is written for GNU as, with intel syntax. When you use
;# NASM we redefine a couple of things. The false if-statement around 
;# the following code is seen by GNU as, but NASM doesn't see it, so 
;# the code inside is read by NASM but not gcc.

; .if 0    # block below only read by NASM
%define .section	section
%define .long		dd
%define .align		align
%define .globl		global
;# NASM only wants 'dword', not 'dword ptr'.
%define ptr
.equiv          .equiv                  2
   %1 equ %2
%endmacro
; .endif                   # End of NASM-specific block
; .intel_syntax noprefix   # Line only read by gnu as


	
.globl nb_kernel234_x86_64_sse2
.globl _nb_kernel234_x86_64_sse2
nb_kernel234_x86_64_sse2:	
_nb_kernel234_x86_64_sse2:	
;#	Room for return address and rbp (16 bytes)
.equiv          nb234_fshift,           16
.equiv          nb234_gid,              24
.equiv          nb234_pos,              32
.equiv          nb234_faction,          40
.equiv          nb234_charge,           48
.equiv          nb234_p_facel,          56
.equiv          nb234_argkrf,           64
.equiv          nb234_argcrf,           72
.equiv          nb234_Vc,               80
.equiv          nb234_type,             88
.equiv          nb234_p_ntype,          96
.equiv          nb234_vdwparam,         104
.equiv          nb234_Vvdw,             112
.equiv          nb234_p_tabscale,       120
.equiv          nb234_VFtab,            128
.equiv          nb234_invsqrta,         136
.equiv          nb234_dvda,             144
.equiv          nb234_p_gbtabscale,     152
.equiv          nb234_GBtab,            160
.equiv          nb234_p_nthreads,       168
.equiv          nb234_count,            176
.equiv          nb234_mtx,              184
.equiv          nb234_outeriter,        192
.equiv          nb234_inneriter,        200
.equiv          nb234_work,             208
	;# stack offsets for local variables  
	;# bottom of stack is cache-aligned for sse2 use 
.equiv          nb234_ixO,              0
.equiv          nb234_iyO,              16
.equiv          nb234_izO,              32
.equiv          nb234_ixH1,             48
.equiv          nb234_iyH1,             64
.equiv          nb234_izH1,             80
.equiv          nb234_ixH2,             96
.equiv          nb234_iyH2,             112
.equiv          nb234_izH2,             128
.equiv          nb234_ixM,              144
.equiv          nb234_iyM,              160
.equiv          nb234_izM,              176
.equiv          nb234_jxO,              192
.equiv          nb234_jyO,              208
.equiv          nb234_jzO,              224
.equiv          nb234_jxH1,             240
.equiv          nb234_jyH1,             256
.equiv          nb234_jzH1,             272
.equiv          nb234_jxH2,             288
.equiv          nb234_jyH2,             304
.equiv          nb234_jzH2,             320
.equiv          nb234_jxM,              336
.equiv          nb234_jyM,              352
.equiv          nb234_jzM,              368
.equiv          nb234_dxOO,             384
.equiv          nb234_dyOO,             400
.equiv          nb234_dzOO,             416
.equiv          nb234_dxH1H1,           432
.equiv          nb234_dyH1H1,           448
.equiv          nb234_dzH1H1,           464
.equiv          nb234_dxH1H2,           480
.equiv          nb234_dyH1H2,           496
.equiv          nb234_dzH1H2,           512
.equiv          nb234_dxH1M,            528
.equiv          nb234_dyH1M,            544
.equiv          nb234_dzH1M,            560
.equiv          nb234_dxH2H1,           576
.equiv          nb234_dyH2H1,           592
.equiv          nb234_dzH2H1,           608
.equiv          nb234_dxH2H2,           624
.equiv          nb234_dyH2H2,           640
.equiv          nb234_dzH2H2,           656
.equiv          nb234_dxH2M,            672
.equiv          nb234_dyH2M,            688
.equiv          nb234_dzH2M,            704
.equiv          nb234_dxMH1,            720
.equiv          nb234_dyMH1,            736
.equiv          nb234_dzMH1,            752
.equiv          nb234_dxMH2,            768
.equiv          nb234_dyMH2,            784
.equiv          nb234_dzMH2,            800
.equiv          nb234_dxMM,             816
.equiv          nb234_dyMM,             832
.equiv          nb234_dzMM,             848
.equiv          nb234_qqMM,             864
.equiv          nb234_qqMH,             880
.equiv          nb234_qqHH,             896
.equiv          nb234_two,              912
.equiv          nb234_c6,               944
.equiv          nb234_c12,              960
.equiv          nb234_vctot,            976
.equiv          nb234_Vvdwtot,          992
.equiv          nb234_fixO,             1008
.equiv          nb234_fiyO,             1024
.equiv          nb234_fizO,             1040
.equiv          nb234_fixH1,            1056
.equiv          nb234_fiyH1,            1072
.equiv          nb234_fizH1,            1088
.equiv          nb234_fixH2,            1104
.equiv          nb234_fiyH2,            1120
.equiv          nb234_fizH2,            1136
.equiv          nb234_fixM,             1152
.equiv          nb234_fiyM,             1168
.equiv          nb234_fizM,             1184
.equiv          nb234_fjxO,             1200
.equiv          nb234_fjyO,             1216
.equiv          nb234_fjzO,             1232
.equiv          nb234_fjxH1,            1248
.equiv          nb234_fjyH1,            1264
.equiv          nb234_fjzH1,            1280
.equiv          nb234_fjxH2,            1296
.equiv          nb234_fjyH2,            1312
.equiv          nb234_fjzH2,            1328
.equiv          nb234_fjxM,             1344
.equiv          nb234_fjyM,             1360
.equiv          nb234_fjzM,             1376
.equiv          nb234_half,             1392
.equiv          nb234_three,            1408
.equiv          nb234_tsc,              1424
.equiv          nb234_fstmp ,           1440
.equiv          nb234_rsqOO,            1456
.equiv          nb234_rsqH1H1,          1472
.equiv          nb234_rsqH1H2,          1488
.equiv          nb234_rsqH1M,           1504
.equiv          nb234_rsqH2H1,          1520
.equiv          nb234_rsqH2H2,          1536
.equiv          nb234_rsqH2M,           1552
.equiv          nb234_rsqMH1,           1568
.equiv          nb234_rsqMH2,           1584
.equiv          nb234_rsqMM,            1600
.equiv          nb234_rinvOO,           1616
.equiv          nb234_rinvH1H1,         1632
.equiv          nb234_rinvH1H2,         1648
.equiv          nb234_rinvH1M,          1664
.equiv          nb234_rinvH2H1,         1680
.equiv          nb234_rinvH2H2,         1696
.equiv          nb234_rinvH2M,          1712
.equiv          nb234_rinvMH1,          1728
.equiv          nb234_rinvMH2,          1744
.equiv          nb234_rinvMM,           1760
.equiv          nb234_krf,              1776
.equiv          nb234_crf,              1792
.equiv          nb234_is3,              1808
.equiv          nb234_ii3,              1812
.equiv          nb234_nri,              1816
.equiv          nb234_iinr,             1824
.equiv          nb234_jindex,           1832
.equiv          nb234_jjnr,             1840
.equiv          nb234_shift,            1848
.equiv          nb234_shiftvec,         1856
.equiv          nb234_facel,            1864
.equiv          nb234_innerjjnr,        1872
.equiv          nb234_innerk,           1880
.equiv          nb234_n,                1884
.equiv          nb234_nn1,              1888
.equiv          nb234_nouter,           1892
.equiv          nb234_ninner,           1896
	push rbp
	mov  rbp, rsp
	push rbx
	femms
	sub rsp, 1912		;# local variable stack space (n*16+8)

	;# zero 32-bit iteration counters
	mov eax, 0
	mov [rsp + nb234_nouter], eax
	mov [rsp + nb234_ninner], eax

	mov edi, [rdi]
	mov [rsp + nb234_nri], edi
	mov [rsp + nb234_iinr], rsi
	mov [rsp + nb234_jindex], rdx
	mov [rsp + nb234_jjnr], rcx
	mov [rsp + nb234_shift], r8
	mov [rsp + nb234_shiftvec], r9
	mov rsi, [rbp + nb234_p_facel]
	movsd xmm0, [rsi]
	movsd [rsp + nb234_facel], xmm0

	mov rsi, [rbp + nb234_argkrf]
	mov rdi, [rbp + nb234_argcrf]
	movsd xmm1, [rsi]
	movsd xmm2, [rdi]
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0
	movapd [rsp + nb234_krf], xmm1
	movapd [rsp + nb234_crf], xmm2

	mov rax, [rbp + nb234_p_tabscale]
	movsd xmm3, [rax]
	shufpd xmm3, xmm3, 0
	movapd [rsp + nb234_tsc], xmm3

	;# create constant floating-point factors on stack
	mov eax, 0x00000000     ;# lower half of double half IEEE (hex)
	mov ebx, 0x3fe00000
	mov [rsp + nb234_half], eax
	mov [rsp + nb234_half + 4], ebx
	movsd xmm1, [rsp + nb234_half]
	shufpd xmm1, xmm1, 0    ;# splat to all elements
	movapd xmm3, xmm1
	addpd  xmm3, xmm3       ;# one
	movapd xmm2, xmm3
	addpd  xmm2, xmm2       ;# two
	addpd  xmm3, xmm2	;# three
	movapd [rsp + nb234_half], xmm1
	movapd [rsp + nb234_two], xmm2
	movapd [rsp + nb234_three], xmm3

	;# assume we have at least one i particle - start directly 
	mov   rcx, [rsp + nb234_iinr]       ;# rcx = pointer into iinr[] 	
	mov   ebx, [rcx]	    ;# ebx =ii 

	mov   rdx, [rbp + nb234_charge]
	movsd xmm3, [rdx + rbx*8 + 24]	
	movsd xmm4, xmm3	
	movsd xmm5, [rdx + rbx*8 + 8]	

	movsd xmm6, [rsp + nb234_facel]
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm5
	mulsd  xmm5, xmm5
	mulsd  xmm3, xmm6
	mulsd  xmm4, xmm6
	mulsd  xmm5, xmm6
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb234_qqMM], xmm3
	movapd [rsp + nb234_qqMH], xmm4
	movapd [rsp + nb234_qqHH], xmm5
	
	xorpd xmm0, xmm0
	mov   rdx, [rbp + nb234_type]
	mov   ecx, [rdx + rbx*4]
	shl   ecx, 1
	mov   edx, ecx
	mov rdi, [rbp + nb234_p_ntype]
	imul  ecx, [rdi]      ;# rcx = ntia = 2*ntype*type[ii0] 
	add   edx, ecx
	mov   rax, [rbp + nb234_vdwparam]
	movlpd xmm0, [rax + rdx*8]
	movlpd xmm1, [rax + rdx*8 + 8]
	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	movapd [rsp + nb234_c6], xmm0
	movapd [rsp + nb234_c12], xmm1

.nb234_threadloop:
        mov   rsi, [rbp + nb234_count]          ;# pointer to sync counter
        mov   eax, [rsi]
.nb234_spinlock:
        mov   ebx, eax                          ;# ebx=*count=nn0
        add   ebx, 1                           ;# ebx=nn1=nn0+10
        lock cmpxchg [rsi], ebx                 ;# write nn1 to *counter,
                                                ;# if it hasnt changed.
                                                ;# or reread *counter to eax.
        pause                                   ;# -> better p4 performance
        jnz .nb234_spinlock

        ;# if(nn1>nri) nn1=nri
        mov ecx, [rsp + nb234_nri]
        mov edx, ecx
        sub ecx, ebx
        cmovle ebx, edx                         ;# if(nn1>nri) nn1=nri
        ;# Cleared the spinlock if we got here.
        ;# eax contains nn0, ebx contains nn1.
        mov [rsp + nb234_n], eax
        mov [rsp + nb234_nn1], ebx
        sub ebx, eax                            ;# calc number of outer lists
	mov esi, eax				;# copy n to esi
        jg  .nb234_outerstart
        jmp .nb234_end

.nb234_outerstart:
	;# ebx contains number of outer iterations
	add ebx, [rsp + nb234_nouter]
	mov [rsp + nb234_nouter], ebx

.nb234_outer:
	mov   rax, [rsp + nb234_shift]      ;# eax = pointer into shift[] 
	mov   ebx, [rax+rsi*4]		;# ebx=shift[n] 
	
	lea   ebx, [ebx + ebx*2]    ;# ebx=3*is 
	mov   [rsp + nb234_is3],ebx    	;# store is3 

	mov   rax, [rsp + nb234_shiftvec]   ;# eax = base of shiftvec[] 

	movsd xmm0, [rax + rbx*8]
	movsd xmm1, [rax + rbx*8 + 8]
	movsd xmm2, [rax + rbx*8 + 16] 

	mov   rcx, [rsp + nb234_iinr]       ;# ecx = pointer into iinr[] 	
	mov   ebx, [rcx+rsi*4]	    ;# ebx =ii 

	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	movapd xmm6, xmm0
	movapd xmm7, xmm1

	lea   ebx, [ebx + ebx*2]	;# ebx = 3*ii=ii3 
	mov   rax, [rbp + nb234_pos]    ;# eax = base of pos[]  
	mov   [rsp + nb234_ii3], ebx		

	addsd xmm3, [rax + rbx*8] 	;# ox
	addsd xmm4, [rax + rbx*8 + 8] 	;# oy
	addsd xmm5, [rax + rbx*8 + 16]	;# oz	
	addsd xmm6, [rax + rbx*8 + 24] 	;# h1x
	addsd xmm7, [rax + rbx*8 + 32] 	;# h1y
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	shufpd xmm6, xmm6, 0
	shufpd xmm7, xmm7, 0
	movapd [rsp + nb234_ixO], xmm3
	movapd [rsp + nb234_iyO], xmm4
	movapd [rsp + nb234_izO], xmm5
	movapd [rsp + nb234_ixH1], xmm6
	movapd [rsp + nb234_iyH1], xmm7

	movsd xmm6, xmm2
	movsd xmm3, xmm0
	movsd xmm4, xmm1
	movsd xmm5, xmm2
	addsd xmm6, [rax + rbx*8 + 40] ;# h1z
	addsd xmm0, [rax + rbx*8 + 48] ;# h2x
	addsd xmm1, [rax + rbx*8 + 56] ;# h2y
	addsd xmm2, [rax + rbx*8 + 64] ;# h2z
	addsd xmm3, [rax + rbx*8 + 72] ;# mx
	addsd xmm4, [rax + rbx*8 + 80] ;# my
	addsd xmm5, [rax + rbx*8 + 88] ;# mz

	shufpd xmm6, xmm6, 0
	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb234_izH1], xmm6
	movapd [rsp + nb234_ixH2], xmm0
	movapd [rsp + nb234_iyH2], xmm1
	movapd [rsp + nb234_izH2], xmm2
	movapd [rsp + nb234_ixM], xmm3
	movapd [rsp + nb234_iyM], xmm4
	movapd [rsp + nb234_izM], xmm5

	;# clear vctot and i forces 
	xorpd xmm4, xmm4
	movapd [rsp + nb234_vctot], xmm4
	movapd [rsp + nb234_Vvdwtot], xmm4
	movapd [rsp + nb234_fixO], xmm4
	movapd [rsp + nb234_fiyO], xmm4
	movapd [rsp + nb234_fizO], xmm4
	movapd [rsp + nb234_fixH1], xmm4
	movapd [rsp + nb234_fiyH1], xmm4
	movapd [rsp + nb234_fizH1], xmm4
	movapd [rsp + nb234_fixH2], xmm4
	movapd [rsp + nb234_fiyH2], xmm4
	movapd [rsp + nb234_fizH2], xmm4
	movapd [rsp + nb234_fixM], xmm4
	movapd [rsp + nb234_fiyM], xmm4
	movapd [rsp + nb234_fizM], xmm4
	
	mov   rax, [rsp + nb234_jindex]
	mov   ecx, [rax + rsi*4]	     ;# jindex[n] 
	mov   edx, [rax + rsi*4 + 4]	     ;# jindex[n+1] 
	sub   edx, ecx               ;# number of innerloop atoms 

	mov   rsi, [rbp + nb234_pos] 
	mov   rdi, [rbp + nb234_faction]	
	mov   rax, [rsp + nb234_jjnr]
	shl   ecx, 2
	add   rax, rcx
	mov   [rsp + nb234_innerjjnr], rax     ;# pointer to jjnr[nj0] 
	mov   ecx, edx
	sub   edx,  2
	add   ecx, [rsp + nb234_ninner]
	mov   [rsp + nb234_ninner], ecx
	add   edx, 0
	mov   [rsp + nb234_innerk], edx    ;# number of innerloop atoms 
	jge   .nb234_unroll_loop
	jmp   .nb234_checksingle
.nb234_unroll_loop:
	;# twice unrolled innerloop here 
	mov   rdx, [rsp + nb234_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]	
	mov   ebx, [rdx + 4] 
	
	add qword ptr [rsp + nb234_innerjjnr],  8 ;# advance pointer (unrolled 2) 

	mov rsi, [rbp + nb234_pos]       ;# base of pos[] 

	lea   eax, [eax + eax*2]     ;# replace jnr with j3 
	lea   ebx, [ebx + ebx*2]	
	
	;# move j coordinates to local temp variables 
	;# load ox, oy, oz, h1x
	movlpd xmm0, [rsi + rax*8]
	movlpd xmm2, [rsi + rbx*8]
	movhpd xmm0, [rsi + rax*8 + 8]
	movhpd xmm2, [rsi + rbx*8 + 8]
	movlpd xmm3, [rsi + rax*8 + 16]
	movlpd xmm5, [rsi + rbx*8 + 16]
	movhpd xmm3, [rsi + rax*8 + 24]
	movhpd xmm5, [rsi + rbx*8 + 24]
	movapd xmm1, xmm0 
	movapd xmm4, xmm3
	unpcklpd xmm0, xmm2 ;# ox 
	unpckhpd xmm1, xmm2 ;# oy
	unpcklpd xmm3, xmm5 ;# ox 
	unpckhpd xmm4, xmm5 ;# oy
	movapd 	[rsp + nb234_jxO], xmm0
	movapd 	[rsp + nb234_jyO], xmm1
	movapd 	[rsp + nb234_jzO], xmm3
	movapd 	[rsp + nb234_jxH1], xmm4
	
	;# load h1y, h1z, h2x, h2y 
	movlpd xmm0, [rsi + rax*8 + 32]
	movlpd xmm2, [rsi + rbx*8 + 32]
	movhpd xmm0, [rsi + rax*8 + 40]
	movhpd xmm2, [rsi + rbx*8 + 40]
	movlpd xmm3, [rsi + rax*8 + 48]
	movlpd xmm5, [rsi + rbx*8 + 48]
	movhpd xmm3, [rsi + rax*8 + 56]
	movhpd xmm5, [rsi + rbx*8 + 56]
	movapd xmm1, xmm0 
	movapd xmm4, xmm3
	unpcklpd xmm0, xmm2 ;# h1y
	unpckhpd xmm1, xmm2 ;# h1z
	unpcklpd xmm3, xmm5 ;# h2x
	unpckhpd xmm4, xmm5 ;# h2y
	movapd 	[rsp + nb234_jyH1], xmm0
	movapd 	[rsp + nb234_jzH1], xmm1
	movapd 	[rsp + nb234_jxH2], xmm3
	movapd 	[rsp + nb234_jyH2], xmm4
	
	;# load h2z, mx, my, mz
	movlpd xmm0, [rsi + rax*8 + 64]
	movlpd xmm2, [rsi + rbx*8 + 64]
	movhpd xmm0, [rsi + rax*8 + 72]
	movhpd xmm2, [rsi + rbx*8 + 72]
	movlpd xmm3, [rsi + rax*8 + 80]
	movlpd xmm5, [rsi + rbx*8 + 80]
	movhpd xmm3, [rsi + rax*8 + 88]
	movhpd xmm5, [rsi + rbx*8 + 88]
	movapd xmm1, xmm0 
	movapd xmm4, xmm3
	unpcklpd xmm0, xmm2 ;# h2z
	unpckhpd xmm1, xmm2 ;# mx
	unpcklpd xmm3, xmm5 ;# my
	unpckhpd xmm4, xmm5 ;# mz
	movapd 	[rsp + nb234_jzH2], xmm0
	movapd 	[rsp + nb234_jxM], xmm1
	movapd 	[rsp + nb234_jyM], xmm3
	movapd 	[rsp + nb234_jzM], xmm4
	
	;# start calculating pairwise distances
	movapd xmm0, [rsp + nb234_ixO]
	movapd xmm1, [rsp + nb234_iyO]
	movapd xmm2, [rsp + nb234_izO]
	movapd xmm3, [rsp + nb234_ixH1]
	movapd xmm4, [rsp + nb234_iyH1]
	movapd xmm5, [rsp + nb234_izH1]
	subpd  xmm0, [rsp + nb234_jxO]
	subpd  xmm1, [rsp + nb234_jyO]
	subpd  xmm2, [rsp + nb234_jzO]
	subpd  xmm3, [rsp + nb234_jxH1]
	subpd  xmm4, [rsp + nb234_jyH1]
	subpd  xmm5, [rsp + nb234_jzH1]
	movapd [rsp + nb234_dxOO], xmm0
	movapd [rsp + nb234_dyOO], xmm1
	movapd [rsp + nb234_dzOO], xmm2
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	movapd [rsp + nb234_dxH1H1], xmm3
	movapd [rsp + nb234_dyH1H1], xmm4
	movapd [rsp + nb234_dzH1H1], xmm5
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb234_rsqOO], xmm0
	movapd [rsp + nb234_rsqH1H1], xmm3

	movapd xmm0, [rsp + nb234_ixH1]
	movapd xmm1, [rsp + nb234_iyH1]
	movapd xmm2, [rsp + nb234_izH1]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subpd  xmm0, [rsp + nb234_jxH2]
	subpd  xmm1, [rsp + nb234_jyH2]
	subpd  xmm2, [rsp + nb234_jzH2]
	subpd  xmm3, [rsp + nb234_jxM]
	subpd  xmm4, [rsp + nb234_jyM]
	subpd  xmm5, [rsp + nb234_jzM]
	movapd [rsp + nb234_dxH1H2], xmm0
	movapd [rsp + nb234_dyH1H2], xmm1
	movapd [rsp + nb234_dzH1H2], xmm2
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	movapd [rsp + nb234_dxH1M], xmm3
	movapd [rsp + nb234_dyH1M], xmm4
	movapd [rsp + nb234_dzH1M], xmm5
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb234_rsqH1H2], xmm0
	movapd [rsp + nb234_rsqH1M], xmm3

	movapd xmm0, [rsp + nb234_ixH2]
	movapd xmm1, [rsp + nb234_iyH2]
	movapd xmm2, [rsp + nb234_izH2]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subpd  xmm0, [rsp + nb234_jxH1]
	subpd  xmm1, [rsp + nb234_jyH1]
	subpd  xmm2, [rsp + nb234_jzH1]
	subpd  xmm3, [rsp + nb234_jxH2]
	subpd  xmm4, [rsp + nb234_jyH2]
	subpd  xmm5, [rsp + nb234_jzH2]
	movapd [rsp + nb234_dxH2H1], xmm0
	movapd [rsp + nb234_dyH2H1], xmm1
	movapd [rsp + nb234_dzH2H1], xmm2
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	movapd [rsp + nb234_dxH2H2], xmm3
	movapd [rsp + nb234_dyH2H2], xmm4
	movapd [rsp + nb234_dzH2H2], xmm5
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb234_rsqH2H1], xmm0
	movapd [rsp + nb234_rsqH2H2], xmm3

	movapd xmm0, [rsp + nb234_ixH2]
	movapd xmm1, [rsp + nb234_iyH2]
	movapd xmm2, [rsp + nb234_izH2]
	movapd xmm3, [rsp + nb234_ixM]
	movapd xmm4, [rsp + nb234_iyM]
	movapd xmm5, [rsp + nb234_izM]
	subpd  xmm0, [rsp + nb234_jxM]
	subpd  xmm1, [rsp + nb234_jyM]
	subpd  xmm2, [rsp + nb234_jzM]
	subpd  xmm3, [rsp + nb234_jxH1]
	subpd  xmm4, [rsp + nb234_jyH1]
	subpd  xmm5, [rsp + nb234_jzH1]
	movapd [rsp + nb234_dxH2M], xmm0
	movapd [rsp + nb234_dyH2M], xmm1
	movapd [rsp + nb234_dzH2M], xmm2
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	movapd [rsp + nb234_dxMH1], xmm3
	movapd [rsp + nb234_dyMH1], xmm4
	movapd [rsp + nb234_dzMH1], xmm5
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm4, xmm3
	addpd  xmm4, xmm5
	movapd [rsp + nb234_rsqH2M], xmm0
	movapd [rsp + nb234_rsqMH1], xmm4

	movapd xmm0, [rsp + nb234_ixM]
	movapd xmm1, [rsp + nb234_iyM]
	movapd xmm2, [rsp + nb234_izM]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subpd  xmm0, [rsp + nb234_jxH2]
	subpd  xmm1, [rsp + nb234_jyH2]
	subpd  xmm2, [rsp + nb234_jzH2]
	subpd  xmm3, [rsp + nb234_jxM]
	subpd  xmm4, [rsp + nb234_jyM]
	subpd  xmm5, [rsp + nb234_jzM]
	movapd [rsp + nb234_dxMH2], xmm0
	movapd [rsp + nb234_dyMH2], xmm1
	movapd [rsp + nb234_dzMH2], xmm2
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	movapd [rsp + nb234_dxMM], xmm3
	movapd [rsp + nb234_dyMM], xmm4
	movapd [rsp + nb234_dzMM], xmm5
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm4, xmm3
	addpd  xmm4, xmm5
	movapd [rsp + nb234_rsqMH2], xmm0
	movapd [rsp + nb234_rsqMM], xmm4
	
	;# Invsqrt form rsq M-H2 (rsq in xmm0) and MM (rsq in xmm4) 
	cvtpd2ps xmm1, xmm0
	cvtpd2ps xmm5, xmm4
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1   ;# luA
	cvtps2pd xmm5, xmm5   ;# luB
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234_half] ;# iter1 
	mulpd   xmm7, [rsp + nb234_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234_half] ;# rinv 
	movapd [rsp + nb234_rinvMH2], xmm1
	movapd [rsp + nb234_rinvMM], xmm5

	movapd xmm0, [rsp + nb234_rsqOO]
	movapd xmm4, [rsp + nb234_rsqH1H1]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234_half] ;# iter1 of  
	mulpd   xmm7, [rsp + nb234_half] ;# iter1 of  

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234_half] ;# rinv
	movapd [rsp + nb234_rinvOO], xmm1
	movapd [rsp + nb234_rinvH1H1], xmm5

	movapd xmm0, [rsp + nb234_rsqH1H2]
	movapd xmm4, [rsp + nb234_rsqH1M]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234_half] ;# iter1 
	mulpd   xmm7, [rsp + nb234_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234_half] ;# rinv 
	movapd [rsp + nb234_rinvH1H2], xmm1
	movapd [rsp + nb234_rinvH1M], xmm5

	movapd xmm0, [rsp + nb234_rsqH2H1]
	movapd xmm4, [rsp + nb234_rsqH2H2]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234_half] ;# iter1a 
	mulpd   xmm7, [rsp + nb234_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234_half] ;# rinv 
	movapd [rsp + nb234_rinvH2H1], xmm1
	movapd [rsp + nb234_rinvH2H2], xmm5

	movapd xmm0, [rsp + nb234_rsqMH1]
	movapd xmm4, [rsp + nb234_rsqH2M]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234_half] ;# iter1a 
	mulpd   xmm7, [rsp + nb234_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234_half] ;# rinv 
	movapd [rsp + nb234_rinvMH1], xmm1
	movapd [rsp + nb234_rinvH2M], xmm5

	;# start with OO interaction 
	movapd xmm0, [rsp + nb234_rinvOO] 
	movapd xmm4, [rsp + nb234_rsqOO]
	
		mulpd xmm4, xmm0	;# xmm4=r 
	mulpd xmm4, [rsp + nb234_tsc]
	
	cvttpd2pi mm6, xmm4	;# mm6 = lu idx 
	cvtpi2pd xmm5, mm6
	subpd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 

	pslld mm6, 3		;# idx *= 8 
	
	movd mm0, eax	
	movd mm1, ebx

	mov  rsi, [rbp + nb234_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6

	;# dispersion 
	movlpd xmm4, [rsi + rax*8]	;# Y1 	
	movlpd xmm3, [rsi + rbx*8]	;# Y2 
	movhpd xmm4, [rsi + rax*8 + 8]	;# Y1 F1 	
	movhpd xmm3, [rsi + rbx*8 + 8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [rsi + rax*8 + 16]	;# G1
	movlpd xmm3, [rsi + rbx*8 + 16]	;# G2
	movhpd xmm6, [rsi + rax*8 + 24]	;# G1 H1 	
	movhpd xmm3, [rsi + rbx*8 + 24]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# dispersion table ready, in xmm4-xmm7 	
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm7, [rsp + nb234_two]	;# two*Heps2 
	addpd  xmm7, xmm6
	addpd  xmm7, xmm5 ;# xmm7=FF 
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 

	movapd xmm4, [rsp + nb234_c6]
	mulpd  xmm7, xmm4	 ;# fijD 
	mulpd  xmm5, xmm4	 ;# Vvdw6 

	;# put scalar force on stack Update Vvdwtot directly 
	addpd  xmm5, [rsp + nb234_Vvdwtot]
	xorpd  xmm3, xmm3
	mulpd  xmm7, [rsp + nb234_tsc]
	subpd  xmm3, xmm7
	movapd [rsp + nb234_fstmp], xmm3
	movapd [rsp + nb234_Vvdwtot], xmm5

	;# repulsion 
	movlpd xmm4, [rsi + rax*8 + 32]	;# Y1 	
	movlpd xmm3, [rsi + rbx*8 + 32]	;# Y2 
	movhpd xmm4, [rsi + rax*8 + 40]	;# Y1 F1 	
	movhpd xmm3, [rsi + rbx*8 + 40]	;# Y2 F2 

	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [rsi + rax*8 + 48]	;# G1
	movlpd xmm3, [rsi + rbx*8 + 48]	;# G2
	movhpd xmm6, [rsi + rax*8 + 56]	;# G1 H1 	
	movhpd xmm3, [rsi + rbx*8 + 56]	;# G2 H2 

	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	
	;# table ready, in xmm4-xmm7 	
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm7, [rsp + nb234_two]	;# two*Heps2 
	addpd  xmm7, xmm6
	addpd  xmm7, xmm5 ;# xmm7=FF 
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	
	movapd xmm4, [rsp + nb234_c12]
	mulpd  xmm7, xmm4 
	mulpd  xmm5, xmm4  
	
	addpd  xmm5, [rsp + nb234_Vvdwtot]
	movapd xmm3, [rsp + nb234_fstmp]
	mulpd  xmm7, [rsp + nb234_tsc]
	subpd  xmm3, xmm7
	movapd [rsp + nb234_Vvdwtot], xmm5

	mulpd  xmm0, xmm3
	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	movd eax, mm0	
	movd ebx, mm1

	xorpd xmm3, xmm3
	movapd xmm4, xmm3
	movapd xmm5, xmm3
	mulpd xmm0, [rsp + nb234_dxOO]
	mulpd xmm1, [rsp + nb234_dyOO]
	mulpd xmm2, [rsp + nb234_dzOO]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixO]
	addpd xmm1, [rsp + nb234_fiyO]
	addpd xmm2, [rsp + nb234_fizO]
	movapd [rsp + nb234_fjxO], xmm3
	movapd [rsp + nb234_fjyO], xmm4
	movapd [rsp + nb234_fjzO], xmm5
	movapd [rsp + nb234_fixO], xmm0
	movapd [rsp + nb234_fiyO], xmm1
	movapd [rsp + nb234_fizO], xmm2

	;# H1-H1 interaction 
	movapd xmm0, [rsp + nb234_rinvH1H1]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqH1H1] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqHH] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6

	movapd xmm1, xmm0
	movapd xmm2, xmm0

	xorpd xmm3, xmm3
	movapd xmm4, xmm3
	movapd xmm5, xmm3
	mulpd xmm0, [rsp + nb234_dxH1H1]
	mulpd xmm1, [rsp + nb234_dyH1H1]
	mulpd xmm2, [rsp + nb234_dzH1H1]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixH1]
	addpd xmm1, [rsp + nb234_fiyH1]
	addpd xmm2, [rsp + nb234_fizH1]
	movapd [rsp + nb234_fjxH1], xmm3
	movapd [rsp + nb234_fjyH1], xmm4
	movapd [rsp + nb234_fjzH1], xmm5
	movapd [rsp + nb234_fixH1], xmm0
	movapd [rsp + nb234_fiyH1], xmm1
	movapd [rsp + nb234_fizH1], xmm2

	;# H1-H2 interaction  
	movapd xmm0, [rsp + nb234_rinvH1H2]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqH1H2] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqHH] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0

	xorpd xmm3, xmm3
	movapd xmm4, xmm3
	movapd xmm5, xmm3
	mulpd xmm0, [rsp + nb234_dxH1H2]
	mulpd xmm1, [rsp + nb234_dyH1H2]
	mulpd xmm2, [rsp + nb234_dzH1H2]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixH1]
	addpd xmm1, [rsp + nb234_fiyH1]
	addpd xmm2, [rsp + nb234_fizH1]
	movapd [rsp + nb234_fjxH2], xmm3
	movapd [rsp + nb234_fjyH2], xmm4
	movapd [rsp + nb234_fjzH2], xmm5
	movapd [rsp + nb234_fixH1], xmm0
	movapd [rsp + nb234_fiyH1], xmm1
	movapd [rsp + nb234_fizH1], xmm2

	;# H1-M interaction 
	movapd xmm0, [rsp + nb234_rinvH1M]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqH1M] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqMH] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6

	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	xorpd xmm3, xmm3
	movapd xmm4, xmm3
	movapd xmm5, xmm3
	mulpd xmm0, [rsp + nb234_dxH1M]
	mulpd xmm1, [rsp + nb234_dyH1M]
	mulpd xmm2, [rsp + nb234_dzH1M]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixH1]
	addpd xmm1, [rsp + nb234_fiyH1]
	addpd xmm2, [rsp + nb234_fizH1]
	movapd [rsp + nb234_fjxM], xmm3
	movapd [rsp + nb234_fjyM], xmm4
	movapd [rsp + nb234_fjzM], xmm5
	movapd [rsp + nb234_fixH1], xmm0
	movapd [rsp + nb234_fiyH1], xmm1
	movapd [rsp + nb234_fizH1], xmm2

	;# H2-H1 interaction 
	movapd xmm0, [rsp + nb234_rinvH2H1]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqH2H1] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqHH] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	movapd xmm3, [rsp + nb234_fjxH1]
	movapd xmm4, [rsp + nb234_fjyH1]
	movapd xmm5, [rsp + nb234_fjzH1]
	mulpd xmm0, [rsp + nb234_dxH2H1]
	mulpd xmm1, [rsp + nb234_dyH2H1]
	mulpd xmm2, [rsp + nb234_dzH2H1]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixH2]
	addpd xmm1, [rsp + nb234_fiyH2]
	addpd xmm2, [rsp + nb234_fizH2]
	movapd [rsp + nb234_fjxH1], xmm3
	movapd [rsp + nb234_fjyH1], xmm4
	movapd [rsp + nb234_fjzH1], xmm5
	movapd [rsp + nb234_fixH2], xmm0
	movapd [rsp + nb234_fiyH2], xmm1
	movapd [rsp + nb234_fizH2], xmm2

	;# H2-H2 interaction 
	movapd xmm0, [rsp + nb234_rinvH2H2]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqH2H2] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqHH] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	movapd xmm3, [rsp + nb234_fjxH2]
	movapd xmm4, [rsp + nb234_fjyH2]
	movapd xmm5, [rsp + nb234_fjzH2]
	mulpd xmm0, [rsp + nb234_dxH2H2]
	mulpd xmm1, [rsp + nb234_dyH2H2]
	mulpd xmm2, [rsp + nb234_dzH2H2]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixH2]
	addpd xmm1, [rsp + nb234_fiyH2]
	addpd xmm2, [rsp + nb234_fizH2]
	movapd [rsp + nb234_fjxH2], xmm3
	movapd [rsp + nb234_fjyH2], xmm4
	movapd [rsp + nb234_fjzH2], xmm5
	movapd [rsp + nb234_fixH2], xmm0
	movapd [rsp + nb234_fiyH2], xmm1
	movapd [rsp + nb234_fizH2], xmm2

	;# H2-M interaction 
	movapd xmm0, [rsp + nb234_rinvH2M]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqH2M] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqMH] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0

	movapd xmm3, [rsp + nb234_fjxM]
	movapd xmm4, [rsp + nb234_fjyM]
	movapd xmm5, [rsp + nb234_fjzM]
	mulpd xmm0, [rsp + nb234_dxH2M]
	mulpd xmm1, [rsp + nb234_dyH2M]
	mulpd xmm2, [rsp + nb234_dzH2M]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixH2]
	addpd xmm1, [rsp + nb234_fiyH2]
	addpd xmm2, [rsp + nb234_fizH2]
	movapd [rsp + nb234_fjxM], xmm3
	movapd [rsp + nb234_fjyM], xmm4
	movapd [rsp + nb234_fjzM], xmm5
	movapd [rsp + nb234_fixH2], xmm0
	movapd [rsp + nb234_fiyH2], xmm1
	movapd [rsp + nb234_fizH2], xmm2

	;# M-H1 interaction 
	movapd xmm0, [rsp + nb234_rinvMH1]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqMH1] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqMH] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0

	movapd xmm3, [rsp + nb234_fjxH1]
	movapd xmm4, [rsp + nb234_fjyH1]
	movapd xmm5, [rsp + nb234_fjzH1]
	mulpd xmm0, [rsp + nb234_dxMH1]
	mulpd xmm1, [rsp + nb234_dyMH1]
	mulpd xmm2, [rsp + nb234_dzMH1]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixM]
	addpd xmm1, [rsp + nb234_fiyM]
	addpd xmm2, [rsp + nb234_fizM]
	movapd [rsp + nb234_fjxH1], xmm3
	movapd [rsp + nb234_fjyH1], xmm4
	movapd [rsp + nb234_fjzH1], xmm5
	movapd [rsp + nb234_fixM], xmm0
	movapd [rsp + nb234_fiyM], xmm1
	movapd [rsp + nb234_fizM], xmm2

	;# M-H2 interaction 
	movapd xmm0, [rsp + nb234_rinvMH2]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqMH2] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqMH] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	movapd xmm3, [rsp + nb234_fjxH2]
	movapd xmm4, [rsp + nb234_fjyH2]
	movapd xmm5, [rsp + nb234_fjzH2]
	mulpd xmm0, [rsp + nb234_dxMH2]
	mulpd xmm1, [rsp + nb234_dyMH2]
	mulpd xmm2, [rsp + nb234_dzMH2]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixM]
	addpd xmm1, [rsp + nb234_fiyM]
	addpd xmm2, [rsp + nb234_fizM]
	movapd [rsp + nb234_fjxH2], xmm3
	movapd [rsp + nb234_fjyH2], xmm4
	movapd [rsp + nb234_fjzH2], xmm5
	movapd [rsp + nb234_fixM], xmm0
	movapd [rsp + nb234_fiyM], xmm1
	movapd [rsp + nb234_fizM], xmm2

	;# M-M interaction 
	movapd xmm0, [rsp + nb234_rinvMM]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234_rsqMM] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234_crf]
	mulpd  xmm6, [rsp + nb234_qqMM] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulpd  xmm5, [rsp + nb234_two]
	subpd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulpd  xmm7, [rsp + nb234_qqMM] ;# xmm7 = coul part of fscal 
	
	addpd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulpd  xmm0, xmm7
	movapd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0

	movapd xmm3, [rsp + nb234_fjxM]
	movapd xmm4, [rsp + nb234_fjyM] 
	movapd xmm5, [rsp + nb234_fjzM]
	mulpd xmm0, [rsp + nb234_dxMM]
	mulpd xmm1, [rsp + nb234_dyMM]
	mulpd xmm2, [rsp + nb234_dzMM]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	addpd xmm0, [rsp + nb234_fixM]
	addpd xmm1, [rsp + nb234_fiyM]
	addpd xmm2, [rsp + nb234_fizM]
	movapd [rsp + nb234_fjxM], xmm3
	movapd [rsp + nb234_fjyM], xmm4
	movapd [rsp + nb234_fjzM], xmm5
	movapd [rsp + nb234_fixM], xmm0
	movapd [rsp + nb234_fiyM], xmm1
	movapd [rsp + nb234_fizM], xmm2

	mov rdi, [rbp + nb234_faction]
	
	;# Did all interactions - now update j forces 
	;# Step1 - transpose fjxO, fjyO and fjzO, fjxH1
	movapd xmm0, [rsp + nb234_fjxO]
	movapd xmm1, [rsp + nb234_fjyO]
	movapd xmm2, [rsp + nb234_fjzO]
	movapd xmm3, [rsp + nb234_fjxH1]
	movapd xmm4, xmm0
	movapd xmm5, xmm2
	unpcklpd xmm0, xmm1   ;# fjOxA fjOyA
	unpckhpd xmm4, xmm1   ;# fjOxB fjOyB
	unpcklpd xmm2, xmm3   ;# fjOzA fjH1xA
	unpckhpd xmm5, xmm3   ;# fjOzB fjH1xB
	movlpd xmm1, [rdi + rax*8]
	movlpd xmm3, [rdi + rbx*8]
	movhpd xmm1, [rdi + rax*8 + 8]
	movhpd xmm3, [rdi + rbx*8 + 8]
	movlpd xmm6, [rdi + rax*8 + 16]
	movlpd xmm7, [rdi + rbx*8 + 16]
	movhpd xmm6, [rdi + rax*8 + 24]
	movhpd xmm7, [rdi + rbx*8 + 24]
	addpd  xmm1, xmm0
	addpd  xmm3, xmm4
	addpd  xmm6, xmm2
	addpd  xmm7, xmm5
	movlpd [rdi + rax*8],      xmm1
	movlpd [rdi + rbx*8],      xmm3
	movhpd [rdi + rax*8 + 8],  xmm1
	movhpd [rdi + rbx*8 + 8],  xmm3
	movlpd [rdi + rax*8 + 16], xmm6
	movlpd [rdi + rbx*8 + 16], xmm7
	movhpd [rdi + rax*8 + 24], xmm6
	movhpd [rdi + rbx*8 + 24], xmm7

	;# Step2 - transpose fjyH1, fjzH1 and fjxH2, fjyH2
	movapd xmm0, [rsp + nb234_fjyH1]
	movapd xmm1, [rsp + nb234_fjzH1]
	movapd xmm2, [rsp + nb234_fjxH2]
	movapd xmm3, [rsp + nb234_fjyH2]
	movapd xmm4, xmm0
	movapd xmm5, xmm2
	unpcklpd xmm0, xmm1   ;# fjOxA fjOyA
	unpckhpd xmm4, xmm1   ;# fjOxB fjOyB
	unpcklpd xmm2, xmm3   ;# fjOzA fjH1xA
	unpckhpd xmm5, xmm3   ;# fjOzB fjH1xB
	movlpd xmm1, [rdi + rax*8 + 32]
	movlpd xmm3, [rdi + rbx*8 + 32]
	movhpd xmm1, [rdi + rax*8 + 40]
	movhpd xmm3, [rdi + rbx*8 + 40]
	movlpd xmm6, [rdi + rax*8 + 48]
	movlpd xmm7, [rdi + rbx*8 + 48]
	movhpd xmm6, [rdi + rax*8 + 56]
	movhpd xmm7, [rdi + rbx*8 + 56]
	addpd  xmm1, xmm0
	addpd  xmm3, xmm4
	addpd  xmm6, xmm2
	addpd  xmm7, xmm5
	movlpd [rdi + rax*8 + 32], xmm1
	movlpd [rdi + rbx*8 + 32], xmm3
	movhpd [rdi + rax*8 + 40], xmm1
	movhpd [rdi + rbx*8 + 40], xmm3
	movlpd [rdi + rax*8 + 48], xmm6
	movlpd [rdi + rbx*8 + 48], xmm7
	movhpd [rdi + rax*8 + 56], xmm6
	movhpd [rdi + rbx*8 + 56], xmm7

	;# Step3 - transpose fjzH2, fjxM and fjyM, fjzM
	movapd xmm0, [rsp + nb234_fjzH2]
	movapd xmm1, [rsp + nb234_fjxM]
	movapd xmm2, [rsp + nb234_fjyM]
	movapd xmm3, [rsp + nb234_fjzM]
	movapd xmm4, xmm0
	movapd xmm5, xmm2
	unpcklpd xmm0, xmm1   ;# fjOxA fjOyA
	unpckhpd xmm4, xmm1   ;# fjOxB fjOyB
	unpcklpd xmm2, xmm3   ;# fjOzA fjH1xA
	unpckhpd xmm5, xmm3   ;# fjOzB fjH1xB
	movlpd xmm1, [rdi + rax*8 + 64]
	movlpd xmm3, [rdi + rbx*8 + 64]
	movhpd xmm1, [rdi + rax*8 + 72]
	movhpd xmm3, [rdi + rbx*8 + 72]
	movlpd xmm6, [rdi + rax*8 + 80]
	movlpd xmm7, [rdi + rbx*8 + 80]
	movhpd xmm6, [rdi + rax*8 + 88]
	movhpd xmm7, [rdi + rbx*8 + 88]
	addpd  xmm1, xmm0
	addpd  xmm3, xmm4
	addpd  xmm6, xmm2
	addpd  xmm7, xmm5
	movlpd [rdi + rax*8 + 64], xmm1
	movlpd [rdi + rbx*8 + 64], xmm3
	movhpd [rdi + rax*8 + 72], xmm1
	movhpd [rdi + rbx*8 + 72], xmm3
	movlpd [rdi + rax*8 + 80], xmm6
	movlpd [rdi + rbx*8 + 80], xmm7
	movhpd [rdi + rax*8 + 88], xmm6
	movhpd [rdi + rbx*8 + 88], xmm7

	;# should we do one more iteration? 
	sub dword ptr [rsp + nb234_innerk],  2
	jl    .nb234_checksingle
	jmp   .nb234_unroll_loop
.nb234_checksingle:
	mov   edx, [rsp + nb234_innerk]
	and   edx, 1
	jnz   .nb234_dosingle
	jmp   .nb234_updateouterdata
.nb234_dosingle:
	mov   rdx, [rsp + nb234_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]

	mov rsi, [rbp + nb234_pos]       ;# base of pos[] 

	lea   eax, [eax + eax*2]     ;# replace jnr with j3 
	
	;# move j coordinates to local temp variables 
	;# load ox, oy, oz, h1x
	movlpd xmm0, [rsi + rax*8]
	movhpd xmm0, [rsi + rax*8 + 8]
	movlpd xmm1, [rsi + rax*8 + 16]
	movhpd xmm1, [rsi + rax*8 + 24]
	movlpd xmm2, [rsi + rax*8 + 32]
	movhpd xmm2, [rsi + rax*8 + 40]
	movlpd xmm3, [rsi + rax*8 + 48]
	movhpd xmm3, [rsi + rax*8 + 56]
	movlpd xmm4, [rsi + rax*8 + 64]
	movhpd xmm4, [rsi + rax*8 + 72]
	movlpd xmm5, [rsi + rax*8 + 80]
	movhpd xmm5, [rsi + rax*8 + 88]
	movsd  [rsp + nb234_jxO], xmm0
	movsd  [rsp + nb234_jzO], xmm1
	movsd  [rsp + nb234_jyH1], xmm2
	movsd  [rsp + nb234_jxH2], xmm3
	movsd  [rsp + nb234_jzH2], xmm4
	movsd  [rsp + nb234_jyM], xmm5
	unpckhpd xmm0, xmm0
	unpckhpd xmm1, xmm1
	unpckhpd xmm2, xmm2
	unpckhpd xmm3, xmm3
	unpckhpd xmm4, xmm4
	unpckhpd xmm5, xmm5
	movsd  [rsp + nb234_jyO], xmm0
	movsd  [rsp + nb234_jxH1], xmm1
	movsd  [rsp + nb234_jzH1], xmm2
	movsd  [rsp + nb234_jyH2], xmm3
	movsd  [rsp + nb234_jxM], xmm4
	movsd  [rsp + nb234_jzM], xmm5

	;# start calculating pairwise distances
	movapd xmm0, [rsp + nb234_ixO]
	movapd xmm1, [rsp + nb234_iyO]
	movapd xmm2, [rsp + nb234_izO]
	movapd xmm3, [rsp + nb234_ixH1]
	movapd xmm4, [rsp + nb234_iyH1]
	movapd xmm5, [rsp + nb234_izH1]
	subsd  xmm0, [rsp + nb234_jxO]
	subsd  xmm1, [rsp + nb234_jyO]
	subsd  xmm2, [rsp + nb234_jzO]
	subsd  xmm3, [rsp + nb234_jxH1]
	subsd  xmm4, [rsp + nb234_jyH1]
	subsd  xmm5, [rsp + nb234_jzH1]
	movapd [rsp + nb234_dxOO], xmm0
	movapd [rsp + nb234_dyOO], xmm1
	movapd [rsp + nb234_dzOO], xmm2
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	movapd [rsp + nb234_dxH1H1], xmm3
	movapd [rsp + nb234_dyH1H1], xmm4
	movapd [rsp + nb234_dzH1H1], xmm5
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb234_rsqOO], xmm0
	movapd [rsp + nb234_rsqH1H1], xmm3

	movapd xmm0, [rsp + nb234_ixH1]
	movapd xmm1, [rsp + nb234_iyH1]
	movapd xmm2, [rsp + nb234_izH1]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subsd  xmm0, [rsp + nb234_jxH2]
	subsd  xmm1, [rsp + nb234_jyH2]
	subsd  xmm2, [rsp + nb234_jzH2]
	subsd  xmm3, [rsp + nb234_jxM]
	subsd  xmm4, [rsp + nb234_jyM]
	subsd  xmm5, [rsp + nb234_jzM]
	movapd [rsp + nb234_dxH1H2], xmm0
	movapd [rsp + nb234_dyH1H2], xmm1
	movapd [rsp + nb234_dzH1H2], xmm2
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	movapd [rsp + nb234_dxH1M], xmm3
	movapd [rsp + nb234_dyH1M], xmm4
	movapd [rsp + nb234_dzH1M], xmm5
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb234_rsqH1H2], xmm0
	movapd [rsp + nb234_rsqH1M], xmm3

	movapd xmm0, [rsp + nb234_ixH2]
	movapd xmm1, [rsp + nb234_iyH2]
	movapd xmm2, [rsp + nb234_izH2]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subsd  xmm0, [rsp + nb234_jxH1]
	subsd  xmm1, [rsp + nb234_jyH1]
	subsd  xmm2, [rsp + nb234_jzH1]
	subsd  xmm3, [rsp + nb234_jxH2]
	subsd  xmm4, [rsp + nb234_jyH2]
	subsd  xmm5, [rsp + nb234_jzH2]
	movapd [rsp + nb234_dxH2H1], xmm0
	movapd [rsp + nb234_dyH2H1], xmm1
	movapd [rsp + nb234_dzH2H1], xmm2
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	movapd [rsp + nb234_dxH2H2], xmm3
	movapd [rsp + nb234_dyH2H2], xmm4
	movapd [rsp + nb234_dzH2H2], xmm5
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb234_rsqH2H1], xmm0
	movapd [rsp + nb234_rsqH2H2], xmm3

	movapd xmm0, [rsp + nb234_ixH2]
	movapd xmm1, [rsp + nb234_iyH2]
	movapd xmm2, [rsp + nb234_izH2]
	movapd xmm3, [rsp + nb234_ixM]
	movapd xmm4, [rsp + nb234_iyM]
	movapd xmm5, [rsp + nb234_izM]
	subsd  xmm0, [rsp + nb234_jxM]
	subsd  xmm1, [rsp + nb234_jyM]
	subsd  xmm2, [rsp + nb234_jzM]
	subsd  xmm3, [rsp + nb234_jxH1]
	subsd  xmm4, [rsp + nb234_jyH1]
	subsd  xmm5, [rsp + nb234_jzH1]
	movapd [rsp + nb234_dxH2M], xmm0
	movapd [rsp + nb234_dyH2M], xmm1
	movapd [rsp + nb234_dzH2M], xmm2
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	movapd [rsp + nb234_dxMH1], xmm3
	movapd [rsp + nb234_dyMH1], xmm4
	movapd [rsp + nb234_dzMH1], xmm5
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm4, xmm3
	addsd  xmm4, xmm5
	movapd [rsp + nb234_rsqH2M], xmm0
	movapd [rsp + nb234_rsqMH1], xmm4

	movapd xmm0, [rsp + nb234_ixM]
	movapd xmm1, [rsp + nb234_iyM]
	movapd xmm2, [rsp + nb234_izM]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subsd  xmm0, [rsp + nb234_jxH2]
	subsd  xmm1, [rsp + nb234_jyH2]
	subsd  xmm2, [rsp + nb234_jzH2]
	subsd  xmm3, [rsp + nb234_jxM]
	subsd  xmm4, [rsp + nb234_jyM]
	subsd  xmm5, [rsp + nb234_jzM]
	movapd [rsp + nb234_dxMH2], xmm0
	movapd [rsp + nb234_dyMH2], xmm1
	movapd [rsp + nb234_dzMH2], xmm2
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	movapd [rsp + nb234_dxMM], xmm3
	movapd [rsp + nb234_dyMM], xmm4
	movapd [rsp + nb234_dzMM], xmm5
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm4, xmm3
	addsd  xmm4, xmm5
	movapd [rsp + nb234_rsqMH2], xmm0
	movapd [rsp + nb234_rsqMM], xmm4

	;# Invsqrt form rsq M-H2 (rsq in xmm0) and MM (rsq in xmm4) 
	cvtsd2ss xmm1, xmm0
	cvtsd2ss xmm5, xmm4
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1   ;# luA
	cvtss2sd xmm5, xmm5   ;# luB
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234_half] ;# iter1 
	mulsd   xmm7, [rsp + nb234_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234_half] ;# rinv 
	movapd [rsp + nb234_rinvMH2], xmm1
	movapd [rsp + nb234_rinvMM], xmm5

	movapd xmm0, [rsp + nb234_rsqOO]
	movapd xmm4, [rsp + nb234_rsqH1H1]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234_half] ;# iter1 of  
	mulsd   xmm7, [rsp + nb234_half] ;# iter1 of  

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234_half] ;# rinv
	movapd [rsp + nb234_rinvOO], xmm1
	movapd [rsp + nb234_rinvH1H1], xmm5

	movapd xmm0, [rsp + nb234_rsqH1H2]
	movapd xmm4, [rsp + nb234_rsqH1M]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234_half] ;# iter1 
	mulsd   xmm7, [rsp + nb234_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234_half] ;# rinv 
	movapd [rsp + nb234_rinvH1H2], xmm1
	movapd [rsp + nb234_rinvH1M], xmm5

	movapd xmm0, [rsp + nb234_rsqH2H1]
	movapd xmm4, [rsp + nb234_rsqH2H2]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234_half] ;# iter1a 
	mulsd   xmm7, [rsp + nb234_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234_half] ;# rinv 
	movapd [rsp + nb234_rinvH2H1], xmm1
	movapd [rsp + nb234_rinvH2H2], xmm5

	movapd xmm0, [rsp + nb234_rsqMH1]
	movapd xmm4, [rsp + nb234_rsqH2M]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234_half] ;# iter1a 
	mulsd   xmm7, [rsp + nb234_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234_half] ;# rinv 
	movapd [rsp + nb234_rinvMH1], xmm1
	movapd [rsp + nb234_rinvH2M], xmm5

	;# start with OO interaction 
	movsd xmm0, [rsp + nb234_rinvOO] 
	movsd xmm4, [rsp + nb234_rsqOO]
	
	mulsd xmm4, xmm0	;# xmm4=r 
	mulsd xmm4, [rsp + nb234_tsc]
	
	cvttsd2si ebx, xmm4	;# mm6 = lu idx 
	cvtsi2sd xmm5, ebx
	subsd xmm4, xmm5
	movsd xmm1, xmm4	;# xmm1=eps 
	movsd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 

	shl ebx, 3
	
	mov  rsi, [rbp + nb234_VFtab]

	;# dispersion 
	movlpd xmm4, [rsi + rbx*8]	;# Y1 	
	movhpd xmm4, [rsi + rbx*8 + 8]	;# Y1 F1 	
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [rsi + rbx*8 + 16]	;# G1
	movhpd xmm6, [rsi + rbx*8 + 24]	;# G1 H1 	
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# dispersion table ready, in xmm4-xmm7 	
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm7, [rsp + nb234_two]	;# two*Heps2 
	addsd  xmm7, xmm6
	addsd  xmm7, xmm5 ;# xmm7=FF 
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 

	movsd xmm4, [rsp + nb234_c6]
	mulsd  xmm7, xmm4	 ;# fijD 
	mulsd  xmm5, xmm4	 ;# Vvdw6 

	;# put scalar force on stack Update Vvdwtot directly 
	addsd  xmm5, [rsp + nb234_Vvdwtot]
	xorpd  xmm3, xmm3
	mulsd  xmm7, [rsp + nb234_tsc]
	subsd  xmm3, xmm7
	movsd [rsp + nb234_fstmp], xmm3
	movsd [rsp + nb234_Vvdwtot], xmm5

	;# repulsion 
	movlpd xmm4, [rsi + rbx*8 + 32]	;# Y1 	
	movhpd xmm4, [rsi + rbx*8 + 40]	;# Y1 F1 	

	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [rsi + rbx*8 + 48]	;# G1
	movhpd xmm6, [rsi + rbx*8 + 56]	;# G1 H1 	

	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	
	;# table ready, in xmm4-xmm7 	
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm7, [rsp + nb234_two]	;# two*Heps2 
	addsd  xmm7, xmm6
	addsd  xmm7, xmm5 ;# xmm7=FF 
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	
	movsd xmm4, [rsp + nb234_c12]
	mulsd  xmm7, xmm4 
	mulsd  xmm5, xmm4  
	
	addsd  xmm5, [rsp + nb234_Vvdwtot]
	movsd xmm3, [rsp + nb234_fstmp]
	mulsd  xmm7, [rsp + nb234_tsc]
	subsd  xmm3, xmm7
	movsd [rsp + nb234_Vvdwtot], xmm5

	mulsd  xmm0, xmm3
	movsd xmm1, xmm0
	movsd xmm2, xmm0

	xorpd xmm3, xmm3
	movapd xmm4, xmm3
	movapd xmm5, xmm3
	mulsd xmm0, [rsp + nb234_dxOO]
	mulsd xmm1, [rsp + nb234_dyOO]
	mulsd xmm2, [rsp + nb234_dzOO]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixO]
	addsd xmm1, [rsp + nb234_fiyO]
	addsd xmm2, [rsp + nb234_fizO]
	movsd [rsp + nb234_fjxO], xmm3
	movsd [rsp + nb234_fjyO], xmm4
	movsd [rsp + nb234_fjzO], xmm5
	movsd [rsp + nb234_fixO], xmm0
	movsd [rsp + nb234_fiyO], xmm1
	movsd [rsp + nb234_fizO], xmm2

	;# H1-H1 interaction 
	movsd xmm0, [rsp + nb234_rinvH1H1]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqH1H1] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqHH] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	xorpd xmm3, xmm3
	movapd xmm4, xmm3
	movapd xmm5, xmm3
	mulsd xmm0, [rsp + nb234_dxH1H1]
	mulsd xmm1, [rsp + nb234_dyH1H1]
	mulsd xmm2, [rsp + nb234_dzH1H1]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixH1]
	addsd xmm1, [rsp + nb234_fiyH1]
	addsd xmm2, [rsp + nb234_fizH1]
	movsd [rsp + nb234_fjxH1], xmm3
	movsd [rsp + nb234_fjyH1], xmm4
	movsd [rsp + nb234_fjzH1], xmm5
	movsd [rsp + nb234_fixH1], xmm0
	movsd [rsp + nb234_fiyH1], xmm1
	movsd [rsp + nb234_fizH1], xmm2

	;# H1-H2 interaction  
	movsd xmm0, [rsp + nb234_rinvH1H2]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqH1H2] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqHH] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	xorpd xmm3, xmm3
	movapd xmm4, xmm3
	movapd xmm5, xmm3
	mulsd xmm0, [rsp + nb234_dxH1H2]
	mulsd xmm1, [rsp + nb234_dyH1H2]
	mulsd xmm2, [rsp + nb234_dzH1H2]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixH1]
	addsd xmm1, [rsp + nb234_fiyH1]
	addsd xmm2, [rsp + nb234_fizH1]
	movsd [rsp + nb234_fjxH2], xmm3
	movsd [rsp + nb234_fjyH2], xmm4
	movsd [rsp + nb234_fjzH2], xmm5
	movsd [rsp + nb234_fixH1], xmm0
	movsd [rsp + nb234_fiyH1], xmm1
	movsd [rsp + nb234_fizH1], xmm2

	;# H1-M interaction 
	movsd xmm0, [rsp + nb234_rinvH1M]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqH1M] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqMH] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6

	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	xorpd xmm3, xmm3
	movapd xmm4, xmm3
	movapd xmm5, xmm3
	mulsd xmm0, [rsp + nb234_dxH1M]
	mulsd xmm1, [rsp + nb234_dyH1M]
	mulsd xmm2, [rsp + nb234_dzH1M]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixH1]
	addsd xmm1, [rsp + nb234_fiyH1]
	addsd xmm2, [rsp + nb234_fizH1]
	movsd [rsp + nb234_fjxM], xmm3
	movsd [rsp + nb234_fjyM], xmm4
	movsd [rsp + nb234_fjzM], xmm5
	movsd [rsp + nb234_fixH1], xmm0
	movsd [rsp + nb234_fiyH1], xmm1
	movsd [rsp + nb234_fizH1], xmm2

	;# H2-H1 interaction 
	movsd xmm0, [rsp + nb234_rinvH2H1]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqH2H1] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqHH] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	movapd xmm3, [rsp + nb234_fjxH1]
	movapd xmm4, [rsp + nb234_fjyH1]
	movapd xmm5, [rsp + nb234_fjzH1]
	mulsd xmm0, [rsp + nb234_dxH2H1]
	mulsd xmm1, [rsp + nb234_dyH2H1]
	mulsd xmm2, [rsp + nb234_dzH2H1]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixH2]
	addsd xmm1, [rsp + nb234_fiyH2]
	addsd xmm2, [rsp + nb234_fizH2]
	movsd [rsp + nb234_fjxH1], xmm3
	movsd [rsp + nb234_fjyH1], xmm4
	movsd [rsp + nb234_fjzH1], xmm5
	movsd [rsp + nb234_fixH2], xmm0
	movsd [rsp + nb234_fiyH2], xmm1
	movsd [rsp + nb234_fizH2], xmm2

	;# H2-H2 interaction 
	movsd xmm0, [rsp + nb234_rinvH2H2]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqH2H2] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqHH] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6
	
	movsd xmm1, xmm0
	movsd xmm2, xmm0

	movsd xmm3, [rsp + nb234_fjxH2]
	movsd xmm4, [rsp + nb234_fjyH2]
	movsd xmm5, [rsp + nb234_fjzH2]
	mulsd xmm0, [rsp + nb234_dxH2H2]
	mulsd xmm1, [rsp + nb234_dyH2H2]
	mulsd xmm2, [rsp + nb234_dzH2H2]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixH2]
	addsd xmm1, [rsp + nb234_fiyH2]
	addsd xmm2, [rsp + nb234_fizH2]
	movsd [rsp + nb234_fjxH2], xmm3
	movsd [rsp + nb234_fjyH2], xmm4
	movsd [rsp + nb234_fjzH2], xmm5
	movsd [rsp + nb234_fixH2], xmm0
	movsd [rsp + nb234_fiyH2], xmm1
	movsd [rsp + nb234_fizH2], xmm2

	;# H2-M interaction 
	movsd xmm0, [rsp + nb234_rinvH2M]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqH2M] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqMH] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0

	movapd xmm3, [rsp + nb234_fjxM]
	movapd xmm4, [rsp + nb234_fjyM]
	movapd xmm5, [rsp + nb234_fjzM]
	mulsd xmm0, [rsp + nb234_dxH2M]
	mulsd xmm1, [rsp + nb234_dyH2M]
	mulsd xmm2, [rsp + nb234_dzH2M]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixH2]
	addsd xmm1, [rsp + nb234_fiyH2]
	addsd xmm2, [rsp + nb234_fizH2]
	movsd [rsp + nb234_fjxM], xmm3
	movsd [rsp + nb234_fjyM], xmm4
	movsd [rsp + nb234_fjzM], xmm5
	movsd [rsp + nb234_fixH2], xmm0
	movsd [rsp + nb234_fiyH2], xmm1
	movsd [rsp + nb234_fizH2], xmm2

	;# M-H1 interaction 
	movsd xmm0, [rsp + nb234_rinvMH1]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqMH1] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqMH] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0

	movapd xmm3, [rsp + nb234_fjxH1]
	movapd xmm4, [rsp + nb234_fjyH1]
	movapd xmm5, [rsp + nb234_fjzH1]
	mulsd xmm0, [rsp + nb234_dxMH1]
	mulsd xmm1, [rsp + nb234_dyMH1]
	mulsd xmm2, [rsp + nb234_dzMH1]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixM]
	addsd xmm1, [rsp + nb234_fiyM]
	addsd xmm2, [rsp + nb234_fizM]
	movsd [rsp + nb234_fjxH1], xmm3
	movsd [rsp + nb234_fjyH1], xmm4
	movsd [rsp + nb234_fjzH1], xmm5
	movsd [rsp + nb234_fixM], xmm0
	movsd [rsp + nb234_fiyM], xmm1
	movsd [rsp + nb234_fizM], xmm2

	;# M-H2 interaction 
	movsd xmm0, [rsp + nb234_rinvMH2]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqMH2] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqMH] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0
	
	movapd xmm3, [rsp + nb234_fjxH2]
	movapd xmm4, [rsp + nb234_fjyH2]
	movapd xmm5, [rsp + nb234_fjzH2]
	mulsd xmm0, [rsp + nb234_dxMH2]
	mulsd xmm1, [rsp + nb234_dyMH2]
	mulsd xmm2, [rsp + nb234_dzMH2]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixM]
	addsd xmm1, [rsp + nb234_fiyM]
	addsd xmm2, [rsp + nb234_fizM]
	movsd [rsp + nb234_fjxH2], xmm3
	movsd [rsp + nb234_fjyH2], xmm4
	movsd [rsp + nb234_fjzH2], xmm5
	movsd [rsp + nb234_fixM], xmm0
	movsd [rsp + nb234_fiyM], xmm1
	movsd [rsp + nb234_fizM], xmm2

	;# M-M interaction 
	movsd xmm0, [rsp + nb234_rinvMM]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234_rsqMM] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234_crf]
	mulsd  xmm6, [rsp + nb234_qqMM] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	mulsd  xmm5, [rsp + nb234_two]
	subsd  xmm7, xmm5	;# xmm7=rinv-2*krsq 
	mulsd  xmm7, [rsp + nb234_qqMM] ;# xmm7 = coul part of fscal 
	
	addsd  xmm6, [rsp + nb234_vctot] ;# local vctot summation variable 
	mulsd  xmm0, xmm7
	movsd [rsp + nb234_vctot], xmm6
	
	movapd xmm1, xmm0
	movapd xmm2, xmm0

	movapd xmm3, [rsp + nb234_fjxM]
	movapd xmm4, [rsp + nb234_fjyM]
	movapd xmm5, [rsp + nb234_fjzM]
	mulsd xmm0, [rsp + nb234_dxMM]
	mulsd xmm1, [rsp + nb234_dyMM]
	mulsd xmm2, [rsp + nb234_dzMM]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	addsd xmm0, [rsp + nb234_fixM]
	addsd xmm1, [rsp + nb234_fiyM]
	addsd xmm2, [rsp + nb234_fizM]
	movsd [rsp + nb234_fjxM], xmm3
	movsd [rsp + nb234_fjyM], xmm4
	movsd [rsp + nb234_fjzM], xmm5
	movsd [rsp + nb234_fixM], xmm0
	movsd [rsp + nb234_fiyM], xmm1
	movsd [rsp + nb234_fizM], xmm2

	mov rdi, [rbp + nb234_faction]

	;# Did all interactions - now update j forces 
	;# Step1 - merge forces
	movlpd xmm0, [rsp + nb234_fjxO]
	movlpd xmm1, [rsp + nb234_fjzO]
	movlpd xmm2, [rsp + nb234_fjyH1]
	movlpd xmm3, [rsp + nb234_fjxH2]
	movlpd xmm4, [rsp + nb234_fjzH2]
	movlpd xmm5, [rsp + nb234_fjyM]

	movhpd xmm0, [rsp + nb234_fjyO]
	movhpd xmm1, [rsp + nb234_fjxH1]
	movhpd xmm2, [rsp + nb234_fjzH1]
	movhpd xmm3, [rsp + nb234_fjyH2]
	movhpd xmm4, [rsp + nb234_fjxM]
	movhpd xmm5, [rsp + nb234_fjzM]

	movlps xmm6, [rdi + rax*8]
	movhps xmm6, [rdi + rax*8 + 8]
	movlps xmm7, [rdi + rax*8 + 16]
	movhps xmm7, [rdi + rax*8 + 24]
	addpd  xmm0, xmm6
	addpd  xmm1, xmm7
	movlps xmm6, [rdi + rax*8 + 32]
	movhps xmm6, [rdi + rax*8 + 40]
	movlps xmm7, [rdi + rax*8 + 48]
	movhps xmm7, [rdi + rax*8 + 56]
	addpd  xmm2, xmm6
	addpd  xmm3, xmm7
	movlps xmm6, [rdi + rax*8 + 64]
	movhps xmm6, [rdi + rax*8 + 72]
	movlps xmm7, [rdi + rax*8 + 80]
	movhps xmm7, [rdi + rax*8 + 88]
	addpd  xmm4, xmm6
	addpd  xmm5, xmm7
	
	movlpd [rdi + rax*8],      xmm0
	movhpd [rdi + rax*8 + 8],  xmm0
	movlpd [rdi + rax*8 + 16], xmm1
	movhpd [rdi + rax*8 + 24], xmm1
	movlpd [rdi + rax*8 + 32], xmm2
	movhpd [rdi + rax*8 + 40], xmm2
	movlpd [rdi + rax*8 + 48], xmm3
	movhpd [rdi + rax*8 + 56], xmm3
	movlpd [rdi + rax*8 + 64], xmm4
	movhpd [rdi + rax*8 + 72], xmm4
	movlpd [rdi + rax*8 + 80], xmm5
	movhpd [rdi + rax*8 + 88], xmm5
	
.nb234_updateouterdata:
	mov   ecx, [rsp + nb234_ii3]
	mov   rdi, [rbp + nb234_faction]
	mov   rsi, [rbp + nb234_fshift]
	mov   edx, [rsp + nb234_is3]

	;# accumulate  Oi forces in xmm0, xmm1, xmm2 
	movapd xmm0, [rsp + nb234_fixO]
	movapd xmm1, [rsp + nb234_fiyO]
	movapd xmm2, [rsp + nb234_fizO]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	movapd xmm3, xmm0	
	movapd xmm4, xmm1	
	movapd xmm5, xmm2	

	;# increment i force 
	movsd  xmm3, [rdi + rcx*8]
	movsd  xmm4, [rdi + rcx*8 + 8]
	movsd  xmm5, [rdi + rcx*8 + 16]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [rdi + rcx*8],     xmm3
	movsd  [rdi + rcx*8 + 8], xmm4
	movsd  [rdi + rcx*8 + 16], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	movapd xmm6, xmm0
	movsd xmm7, xmm2
	unpcklpd xmm6, xmm1

	;# accumulate H1i forces in xmm0, xmm1, xmm2 
	movapd xmm0, [rsp + nb234_fixH1]
	movapd xmm1, [rsp + nb234_fiyH1]
	movapd xmm2, [rsp + nb234_fizH1]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	;# increment i force 
	movsd  xmm3, [rdi + rcx*8 + 24]
	movsd  xmm4, [rdi + rcx*8 + 32]
	movsd  xmm5, [rdi + rcx*8 + 40]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [rdi + rcx*8 + 24], xmm3
	movsd  [rdi + rcx*8 + 32], xmm4
	movsd  [rdi + rcx*8 + 40], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	addsd xmm7, xmm2
	unpcklpd xmm0, xmm1
	addpd xmm6, xmm0

	;# accumulate H2i forces in xmm0, xmm1, xmm2 
	movapd xmm0, [rsp + nb234_fixH2]
	movapd xmm1, [rsp + nb234_fiyH2]
	movapd xmm2, [rsp + nb234_fizH2]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	movapd xmm3, xmm0	
	movapd xmm4, xmm1	
	movapd xmm5, xmm2	

	;# increment i force 
	movsd  xmm3, [rdi + rcx*8 + 48]
	movsd  xmm4, [rdi + rcx*8 + 56]
	movsd  xmm5, [rdi + rcx*8 + 64]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [rdi + rcx*8 + 48], xmm3
	movsd  [rdi + rcx*8 + 56], xmm4
	movsd  [rdi + rcx*8 + 64], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	addsd xmm7, xmm2
	unpcklpd xmm0, xmm1
	addpd xmm6, xmm0

	;# accumulate Mi forces in xmm0, xmm1, xmm2 
	movapd xmm0, [rsp + nb234_fixM]
	movapd xmm1, [rsp + nb234_fiyM]
	movapd xmm2, [rsp + nb234_fizM]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	movapd xmm3, xmm0	
	movapd xmm4, xmm1	
	movapd xmm5, xmm2	

	;# increment i force 
	movsd  xmm3, [rdi + rcx*8 + 72]
	movsd  xmm4, [rdi + rcx*8 + 80]
	movsd  xmm5, [rdi + rcx*8 + 88]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [rdi + rcx*8 + 72], xmm3
	movsd  [rdi + rcx*8 + 80], xmm4
	movsd  [rdi + rcx*8 + 88], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	addsd xmm7, xmm2
	unpcklpd xmm0, xmm1
	addpd xmm6, xmm0

	;# increment fshift force 
	movlpd xmm3, [rsi + rdx*8]
	movhpd xmm3, [rsi + rdx*8 + 8]
	movsd  xmm4, [rsi + rdx*8 + 16]
	addpd  xmm3, xmm6
	addsd  xmm4, xmm7
	movlpd [rsi + rdx*8],      xmm3
	movhpd [rsi + rdx*8 + 8],  xmm3
	movsd  [rsi + rdx*8 + 16], xmm4

	;# get n from stack
	mov esi, [rsp + nb234_n]
        ;# get group index for i particle 
        mov   rdx, [rbp + nb234_gid]      	;# base of gid[]
        mov   edx, [rdx + rsi*4]		;# ggid=gid[n]

	;# accumulate total potential energy and update it 
	movapd xmm7, [rsp + nb234_vctot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
        
	;# add earlier value from mem 
	mov   rax, [rbp + nb234_Vc]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
	;# accumulate total lj energy and update it 
	movapd xmm7, [rsp + nb234_Vvdwtot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 

	;# add earlier value from mem 
	mov   rax, [rbp + nb234_Vvdw]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
        ;# finish if last 
        mov ecx, [rsp + nb234_nn1]
	;# esi already loaded with n
	inc esi
        sub ecx, esi
        jecxz .nb234_outerend

        ;# not last, iterate outer loop once more!  
        mov [rsp + nb234_n], esi
        jmp .nb234_outer
.nb234_outerend:
        ;# check if more outer neighborlists remain
        mov   ecx, [rsp + nb234_nri]
	;# esi already loaded with n above
        sub   ecx, esi
        jecxz .nb234_end
        ;# non-zero, do one more workunit
        jmp   .nb234_threadloop
.nb234_end:
	mov eax, [rsp + nb234_nouter]
	mov ebx, [rsp + nb234_ninner]
	mov rcx, [rbp + nb234_outeriter]
	mov rdx, [rbp + nb234_inneriter]
	mov [rcx], eax
	mov [rdx], ebx

	add rsp, 1912
	femms

	pop rbx
	pop	rbp
	ret



	
.globl nb_kernel234nf_x86_64_sse2
.globl _nb_kernel234nf_x86_64_sse2
nb_kernel234nf_x86_64_sse2:	
_nb_kernel234nf_x86_64_sse2:	
;#	Room for return address and rbp (16 bytes)
.equiv          nb234nf_fshift,         16
.equiv          nb234nf_gid,            24
.equiv          nb234nf_pos,            32
.equiv          nb234nf_faction,        40
.equiv          nb234nf_charge,         48
.equiv          nb234nf_p_facel,        56
.equiv          nb234nf_argkrf,         64
.equiv          nb234nf_argcrf,         72
.equiv          nb234nf_Vc,             80
.equiv          nb234nf_type,           88
.equiv          nb234nf_p_ntype,        96
.equiv          nb234nf_vdwparam,       104
.equiv          nb234nf_Vvdw,           112
.equiv          nb234nf_p_tabscale,     120
.equiv          nb234nf_VFtab,          128
.equiv          nb234nf_invsqrta,       136
.equiv          nb234nf_dvda,           144
.equiv          nb234nf_p_gbtabscale,   152
.equiv          nb234nf_GBtab,          160
.equiv          nb234nf_p_nthreads,     168
.equiv          nb234nf_count,          176
.equiv          nb234nf_mtx,            184
.equiv          nb234nf_outeriter,      192
.equiv          nb234nf_inneriter,      200
.equiv          nb234nf_work,           208
	;# stack offsets for local variables  
	;# bottom of stack is cache-aligned for sse2 use 
.equiv          nb234nf_ixO,            0
.equiv          nb234nf_iyO,            16
.equiv          nb234nf_izO,            32
.equiv          nb234nf_ixH1,           48
.equiv          nb234nf_iyH1,           64
.equiv          nb234nf_izH1,           80
.equiv          nb234nf_ixH2,           96
.equiv          nb234nf_iyH2,           112
.equiv          nb234nf_izH2,           128
.equiv          nb234nf_ixM,            144
.equiv          nb234nf_iyM,            160
.equiv          nb234nf_izM,            176
.equiv          nb234nf_jxO,            192
.equiv          nb234nf_jyO,            208
.equiv          nb234nf_jzO,            224
.equiv          nb234nf_jxH1,           240
.equiv          nb234nf_jyH1,           256
.equiv          nb234nf_jzH1,           272
.equiv          nb234nf_jxH2,           288
.equiv          nb234nf_jyH2,           304
.equiv          nb234nf_jzH2,           320
.equiv          nb234nf_jxM,            336
.equiv          nb234nf_jyM,            352
.equiv          nb234nf_jzM,            368
.equiv          nb234nf_qqMM,           384
.equiv          nb234nf_qqMH,           400
.equiv          nb234nf_qqHH,           416
.equiv          nb234nf_tsc,            432
.equiv          nb234nf_c6,             448
.equiv          nb234nf_c12,            464
.equiv          nb234nf_vctot,          480
.equiv          nb234nf_Vvdwtot,        496
.equiv          nb234nf_half,           512
.equiv          nb234nf_three,          528
.equiv          nb234nf_rsqOO,          544
.equiv          nb234nf_rsqH1H1,        560
.equiv          nb234nf_rsqH1H2,        576
.equiv          nb234nf_rsqH1M,         592
.equiv          nb234nf_rsqH2H1,        608
.equiv          nb234nf_rsqH2H2,        624
.equiv          nb234nf_rsqH2M,         640
.equiv          nb234nf_rsqMH1,         656
.equiv          nb234nf_rsqMH2,         672
.equiv          nb234nf_rsqMM,          688
.equiv          nb234nf_rinvOO,         704
.equiv          nb234nf_rinvH1H1,       720
.equiv          nb234nf_rinvH1H2,       736
.equiv          nb234nf_rinvH1M,        752
.equiv          nb234nf_rinvH2H1,       768
.equiv          nb234nf_rinvH2H2,       784
.equiv          nb234nf_rinvH2M,        800
.equiv          nb234nf_rinvMH1,        816
.equiv          nb234nf_rinvMH2,        832
.equiv          nb234nf_rinvMM,         848
.equiv          nb234nf_krf,            864
.equiv          nb234nf_crf,            880
.equiv          nb234nf_is3,            896
.equiv          nb234nf_ii3,            900
.equiv          nb234nf_nri,            904
.equiv          nb234nf_iinr,           912
.equiv          nb234nf_jindex,         920
.equiv          nb234nf_jjnr,           928
.equiv          nb234nf_shift,          936
.equiv          nb234nf_shiftvec,       944
.equiv          nb234nf_facel,          952
.equiv          nb234nf_innerjjnr,      960
.equiv          nb234nf_innerk,         968
.equiv          nb234nf_n,              972
.equiv          nb234nf_nn1,            976
.equiv          nb234nf_nouter,         980
.equiv          nb234nf_ninner,         984
	push rbp
	mov  rbp, rsp
	push rbx
	femms
	sub rsp, 1000		;# local variable stack space (n*16+8)

	;# zero 32-bit iteration counters
	mov eax, 0
	mov [rsp + nb234nf_nouter], eax
	mov [rsp + nb234nf_ninner], eax

	mov edi, [rdi]
	mov [rsp + nb234nf_nri], edi
	mov [rsp + nb234nf_iinr], rsi
	mov [rsp + nb234nf_jindex], rdx
	mov [rsp + nb234nf_jjnr], rcx
	mov [rsp + nb234nf_shift], r8
	mov [rsp + nb234nf_shiftvec], r9
	mov rsi, [rbp + nb234nf_p_facel]
	movsd xmm0, [rsi]
	movsd [rsp + nb234nf_facel], xmm0

	mov rax, [rbp + nb234nf_p_tabscale]
	movsd xmm3, [rax]
	shufpd xmm3, xmm3, 0
	movapd [rsp + nb234nf_tsc], xmm3

	mov rsi, [rbp + nb234nf_argkrf]
	mov rdi, [rbp + nb234nf_argcrf]
	movsd xmm1, [rsi]
	movsd xmm2, [rdi]
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0
	movapd [rsp + nb234nf_krf], xmm1
	movapd [rsp + nb234nf_crf], xmm2

	;# create constant floating-point factors on stack
	mov eax, 0x00000000     ;# lower half of double half IEEE (hex)
	mov ebx, 0x3fe00000
	mov [rsp + nb234nf_half], eax
	mov [rsp + nb234nf_half + 4], ebx
	movsd xmm1, [rsp + nb234nf_half]
	shufpd xmm1, xmm1, 0    ;# splat to all elements
	movapd xmm3, xmm1
	addpd  xmm3, xmm3       ;# one
	movapd xmm2, xmm3
	addpd  xmm2, xmm2       ;# two
	addpd  xmm3, xmm2	;# three
	movapd [rsp + nb234nf_half], xmm1
	movapd [rsp + nb234nf_three], xmm3
	
	;# assume we have at least one i particle - start directly 
	mov   rcx, [rsp + nb234nf_iinr]       ;# rcx = pointer into iinr[] 	
	mov   ebx, [rcx]	    ;# ebx =ii 

	mov   rdx, [rbp + nb234nf_charge]
	movsd xmm3, [rdx + rbx*8 + 24]	
	movsd xmm4, xmm3	
	movsd xmm5, [rdx + rbx*8 + 8]	

	movsd xmm6, [rsp + nb234nf_facel]
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm5
	mulsd  xmm5, xmm5
	mulsd  xmm3, xmm6
	mulsd  xmm4, xmm6
	mulsd  xmm5, xmm6
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb234nf_qqMM], xmm3
	movapd [rsp + nb234nf_qqMH], xmm4
	movapd [rsp + nb234nf_qqHH], xmm5
	
	xorpd xmm0, xmm0
	mov   rdx, [rbp + nb234nf_type]
	mov   ecx, [rdx + rbx*4]
	shl   ecx, 1
	mov   edx, ecx
	mov rdi, [rbp + nb234nf_p_ntype]
	imul  ecx, [rdi]      ;# rcx = ntia = 2*ntype*type[ii0] 
	add   edx, ecx
	mov   rax, [rbp + nb234nf_vdwparam]
	movlpd xmm0, [rax + rdx*8]
	movlpd xmm1, [rax + rdx*8 + 8]
	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	movapd [rsp + nb234nf_c6], xmm0
	movapd [rsp + nb234nf_c12], xmm1

.nb234nf_threadloop:
        mov   rsi, [rbp + nb234nf_count]          ;# pointer to sync counter
        mov   eax, [rsi]
.nb234nf_spinlock:
        mov   ebx, eax                          ;# ebx=*count=nn0
        add   ebx, 1                           ;# ebx=nn1=nn0+10
        lock cmpxchg [rsi], ebx                 ;# write nn1 to *counter,
                                                ;# if it hasnt changed.
                                                ;# or reread *counter to eax.
        pause                                   ;# -> better p4 performance
        jnz .nb234nf_spinlock

        ;# if(nn1>nri) nn1=nri
        mov ecx, [rsp + nb234nf_nri]
        mov edx, ecx
        sub ecx, ebx
        cmovle ebx, edx                         ;# if(nn1>nri) nn1=nri
        ;# Cleared the spinlock if we got here.
        ;# eax contains nn0, ebx contains nn1.
        mov [rsp + nb234nf_n], eax
        mov [rsp + nb234nf_nn1], ebx
        sub ebx, eax                            ;# calc number of outer lists
	mov esi, eax				;# copy n to esi
        jg  .nb234nf_outerstart
        jmp .nb234nf_end

.nb234nf_outerstart:
	;# ebx contains number of outer iterations
	add ebx, [rsp + nb234nf_nouter]
	mov [rsp + nb234nf_nouter], ebx

.nb234nf_outer:
	mov   rax, [rsp + nb234nf_shift]      ;# eax = pointer into shift[] 
	mov   ebx, [rax+rsi*4]		;# ebx=shift[n] 
	
	lea   ebx, [ebx + ebx*2]    ;# ebx=3*is 
	mov   [rsp + nb234nf_is3],ebx    	;# store is3 

	mov   rax, [rsp + nb234nf_shiftvec]   ;# eax = base of shiftvec[] 

	movsd xmm0, [rax + rbx*8]
	movsd xmm1, [rax + rbx*8 + 8]
	movsd xmm2, [rax + rbx*8 + 16] 

	mov   rcx, [rsp + nb234nf_iinr]       ;# ecx = pointer into iinr[] 	
	mov   ebx, [rcx+rsi*4]	    ;# ebx =ii 

	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	movapd xmm6, xmm0
	movapd xmm7, xmm1

	lea   ebx, [ebx + ebx*2]	;# ebx = 3*ii=ii3 
	mov   rax, [rbp + nb234nf_pos]    ;# eax = base of pos[]  
	mov   [rsp + nb234nf_ii3], ebx		

	addsd xmm3, [rax + rbx*8] 	;# ox
	addsd xmm4, [rax + rbx*8 + 8] 	;# oy
	addsd xmm5, [rax + rbx*8 + 16]	;# oz	
	addsd xmm6, [rax + rbx*8 + 24] 	;# h1x
	addsd xmm7, [rax + rbx*8 + 32] 	;# h1y
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	shufpd xmm6, xmm6, 0
	shufpd xmm7, xmm7, 0
	movapd [rsp + nb234nf_ixO], xmm3
	movapd [rsp + nb234nf_iyO], xmm4
	movapd [rsp + nb234nf_izO], xmm5
	movapd [rsp + nb234nf_ixH1], xmm6
	movapd [rsp + nb234nf_iyH1], xmm7

	movsd xmm6, xmm2
	movsd xmm3, xmm0
	movsd xmm4, xmm1
	movsd xmm5, xmm2
	addsd xmm6, [rax + rbx*8 + 40] ;# h1z
	addsd xmm0, [rax + rbx*8 + 48] ;# h2x
	addsd xmm1, [rax + rbx*8 + 56] ;# h2y
	addsd xmm2, [rax + rbx*8 + 64] ;# h2z
	addsd xmm3, [rax + rbx*8 + 72] ;# mx
	addsd xmm4, [rax + rbx*8 + 80] ;# my
	addsd xmm5, [rax + rbx*8 + 88] ;# mz

	shufpd xmm6, xmm6, 0
	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb234nf_izH1], xmm6
	movapd [rsp + nb234nf_ixH2], xmm0
	movapd [rsp + nb234nf_iyH2], xmm1
	movapd [rsp + nb234nf_izH2], xmm2
	movapd [rsp + nb234nf_ixM], xmm3
	movapd [rsp + nb234nf_iyM], xmm4
	movapd [rsp + nb234nf_izM], xmm5

	;# clear vctot
	xorpd xmm4, xmm4
	movapd [rsp + nb234nf_vctot], xmm4
	movapd [rsp + nb234nf_Vvdwtot], xmm4
	
	mov   rax, [rsp + nb234nf_jindex]
	mov   ecx, [rax + rsi*4]	     ;# jindex[n] 
	mov   edx, [rax + rsi*4 + 4]	     ;# jindex[n+1] 
	sub   edx, ecx               ;# number of innerloop atoms 

	mov   rsi, [rbp + nb234nf_pos] 
	mov   rdi, [rbp + nb234nf_faction]	
	mov   rax, [rsp + nb234nf_jjnr]
	shl   ecx, 2
	add   rax, rcx
	mov   [rsp + nb234nf_innerjjnr], rax     ;# pointer to jjnr[nj0] 
	mov   ecx, edx
	sub   edx,  2
	add   ecx, [rsp + nb234nf_ninner]
	mov   [rsp + nb234nf_ninner], ecx
	add   edx, 0
	mov   [rsp + nb234nf_innerk], edx    ;# number of innerloop atoms 
	jge   .nb234nf_unroll_loop
	jmp   .nb234nf_checksingle
.nb234nf_unroll_loop:
	;# twice unrolled innerloop here 
	mov   rdx, [rsp + nb234nf_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]	
	mov   ebx, [rdx + 4] 
	
	add qword ptr [rsp + nb234nf_innerjjnr],  8 ;# advance pointer (unrolled 2) 

	mov rsi, [rbp + nb234nf_pos]       ;# base of pos[] 

	lea   eax, [eax + eax*2]     ;# replace jnr with j3 
	lea   ebx, [ebx + ebx*2]	
	
	;# move j coordinates to local temp variables 
	;# load ox, oy, oz, h1x
	movlpd xmm0, [rsi + rax*8]
	movlpd xmm2, [rsi + rbx*8]
	movhpd xmm0, [rsi + rax*8 + 8]
	movhpd xmm2, [rsi + rbx*8 + 8]
	movlpd xmm3, [rsi + rax*8 + 16]
	movlpd xmm5, [rsi + rbx*8 + 16]
	movhpd xmm3, [rsi + rax*8 + 24]
	movhpd xmm5, [rsi + rbx*8 + 24]
	movapd xmm1, xmm0 
	movapd xmm4, xmm3
	unpcklpd xmm0, xmm2 ;# ox 
	unpckhpd xmm1, xmm2 ;# oy
	unpcklpd xmm3, xmm5 ;# ox 
	unpckhpd xmm4, xmm5 ;# oy
	movapd 	[rsp + nb234nf_jxO], xmm0
	movapd 	[rsp + nb234nf_jyO], xmm1
	movapd 	[rsp + nb234nf_jzO], xmm3
	movapd 	[rsp + nb234nf_jxH1], xmm4
	
	;# load h1y, h1z, h2x, h2y 
	movlpd xmm0, [rsi + rax*8 + 32]
	movlpd xmm2, [rsi + rbx*8 + 32]
	movhpd xmm0, [rsi + rax*8 + 40]
	movhpd xmm2, [rsi + rbx*8 + 40]
	movlpd xmm3, [rsi + rax*8 + 48]
	movlpd xmm5, [rsi + rbx*8 + 48]
	movhpd xmm3, [rsi + rax*8 + 56]
	movhpd xmm5, [rsi + rbx*8 + 56]
	movapd xmm1, xmm0 
	movapd xmm4, xmm3
	unpcklpd xmm0, xmm2 ;# h1y
	unpckhpd xmm1, xmm2 ;# h1z
	unpcklpd xmm3, xmm5 ;# h2x
	unpckhpd xmm4, xmm5 ;# h2y
	movapd 	[rsp + nb234nf_jyH1], xmm0
	movapd 	[rsp + nb234nf_jzH1], xmm1
	movapd 	[rsp + nb234nf_jxH2], xmm3
	movapd 	[rsp + nb234nf_jyH2], xmm4
	
	;# load h2z, mx, my, mz
	movlpd xmm0, [rsi + rax*8 + 64]
	movlpd xmm2, [rsi + rbx*8 + 64]
	movhpd xmm0, [rsi + rax*8 + 72]
	movhpd xmm2, [rsi + rbx*8 + 72]
	movlpd xmm3, [rsi + rax*8 + 80]
	movlpd xmm5, [rsi + rbx*8 + 80]
	movhpd xmm3, [rsi + rax*8 + 88]
	movhpd xmm5, [rsi + rbx*8 + 88]
	movapd xmm1, xmm0 
	movapd xmm4, xmm3
	unpcklpd xmm0, xmm2 ;# h2z
	unpckhpd xmm1, xmm2 ;# mx
	unpcklpd xmm3, xmm5 ;# my
	unpckhpd xmm4, xmm5 ;# mz
	movapd 	[rsp + nb234nf_jzH2], xmm0
	movapd 	[rsp + nb234nf_jxM], xmm1
	movapd 	[rsp + nb234nf_jyM], xmm3
	movapd 	[rsp + nb234nf_jzM], xmm4
	
	;# start calculating pairwise distances
	movapd xmm0, [rsp + nb234nf_ixO]
	movapd xmm1, [rsp + nb234nf_iyO]
	movapd xmm2, [rsp + nb234nf_izO]
	movapd xmm3, [rsp + nb234nf_ixH1]
	movapd xmm4, [rsp + nb234nf_iyH1]
	movapd xmm5, [rsp + nb234nf_izH1]
	subpd  xmm0, [rsp + nb234nf_jxO]
	subpd  xmm1, [rsp + nb234nf_jyO]
	subpd  xmm2, [rsp + nb234nf_jzO]
	subpd  xmm3, [rsp + nb234nf_jxH1]
	subpd  xmm4, [rsp + nb234nf_jyH1]
	subpd  xmm5, [rsp + nb234nf_jzH1]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb234nf_rsqOO], xmm0
	movapd [rsp + nb234nf_rsqH1H1], xmm3

	movapd xmm0, [rsp + nb234nf_ixH1]
	movapd xmm1, [rsp + nb234nf_iyH1]
	movapd xmm2, [rsp + nb234nf_izH1]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subpd  xmm0, [rsp + nb234nf_jxH2]
	subpd  xmm1, [rsp + nb234nf_jyH2]
	subpd  xmm2, [rsp + nb234nf_jzH2]
	subpd  xmm3, [rsp + nb234nf_jxM]
	subpd  xmm4, [rsp + nb234nf_jyM]
	subpd  xmm5, [rsp + nb234nf_jzM]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb234nf_rsqH1H2], xmm0
	movapd [rsp + nb234nf_rsqH1M], xmm3

	movapd xmm0, [rsp + nb234nf_ixH2]
	movapd xmm1, [rsp + nb234nf_iyH2]
	movapd xmm2, [rsp + nb234nf_izH2]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subpd  xmm0, [rsp + nb234nf_jxH1]
	subpd  xmm1, [rsp + nb234nf_jyH1]
	subpd  xmm2, [rsp + nb234nf_jzH1]
	subpd  xmm3, [rsp + nb234nf_jxH2]
	subpd  xmm4, [rsp + nb234nf_jyH2]
	subpd  xmm5, [rsp + nb234nf_jzH2]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb234nf_rsqH2H1], xmm0
	movapd [rsp + nb234nf_rsqH2H2], xmm3

	movapd xmm0, [rsp + nb234nf_ixH2]
	movapd xmm1, [rsp + nb234nf_iyH2]
	movapd xmm2, [rsp + nb234nf_izH2]
	movapd xmm3, [rsp + nb234nf_ixM]
	movapd xmm4, [rsp + nb234nf_iyM]
	movapd xmm5, [rsp + nb234nf_izM]
	subpd  xmm0, [rsp + nb234nf_jxM]
	subpd  xmm1, [rsp + nb234nf_jyM]
	subpd  xmm2, [rsp + nb234nf_jzM]
	subpd  xmm3, [rsp + nb234nf_jxH1]
	subpd  xmm4, [rsp + nb234nf_jyH1]
	subpd  xmm5, [rsp + nb234nf_jzH1]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm4, xmm3
	addpd  xmm4, xmm5
	movapd [rsp + nb234nf_rsqH2M], xmm0
	movapd [rsp + nb234nf_rsqMH1], xmm4

	movapd xmm0, [rsp + nb234nf_ixM]
	movapd xmm1, [rsp + nb234nf_iyM]
	movapd xmm2, [rsp + nb234nf_izM]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subpd  xmm0, [rsp + nb234nf_jxH2]
	subpd  xmm1, [rsp + nb234nf_jyH2]
	subpd  xmm2, [rsp + nb234nf_jzH2]
	subpd  xmm3, [rsp + nb234nf_jxM]
	subpd  xmm4, [rsp + nb234nf_jyM]
	subpd  xmm5, [rsp + nb234nf_jzM]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm4, xmm3
	addpd  xmm4, xmm5
	movapd [rsp + nb234nf_rsqMH2], xmm0
	movapd [rsp + nb234nf_rsqMM], xmm4
	
	;# Invsqrt form rsq M-H2 (rsq in xmm0) and MM (rsq in xmm4) 
	cvtpd2ps xmm1, xmm0
	cvtpd2ps xmm5, xmm4
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1   ;# luA
	cvtps2pd xmm5, xmm5   ;# luB
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234nf_half] ;# iter1 
	mulpd   xmm7, [rsp + nb234nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234nf_half] ;# rinv 
	movapd [rsp + nb234nf_rinvMH2], xmm1
	movapd [rsp + nb234nf_rinvMM], xmm5

	movapd xmm0, [rsp + nb234nf_rsqOO]
	movapd xmm4, [rsp + nb234nf_rsqH1H1]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234nf_half] ;# iter1 of  
	mulpd   xmm7, [rsp + nb234nf_half] ;# iter1 of  

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234nf_half] ;# rinv
	movapd [rsp + nb234nf_rinvOO], xmm1
	movapd [rsp + nb234nf_rinvH1H1], xmm5

	movapd xmm0, [rsp + nb234nf_rsqH1H2]
	movapd xmm4, [rsp + nb234nf_rsqH1M]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234nf_half] ;# iter1 
	mulpd   xmm7, [rsp + nb234nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234nf_half] ;# rinv 
	movapd [rsp + nb234nf_rinvH1H2], xmm1
	movapd [rsp + nb234nf_rinvH1M], xmm5

	movapd xmm0, [rsp + nb234nf_rsqH2H1]
	movapd xmm4, [rsp + nb234nf_rsqH2H2]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234nf_half] ;# iter1a 
	mulpd   xmm7, [rsp + nb234nf_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234nf_half] ;# rinv 
	movapd [rsp + nb234nf_rinvH2H1], xmm1
	movapd [rsp + nb234nf_rinvH2H2], xmm5

	movapd xmm0, [rsp + nb234nf_rsqMH1]
	movapd xmm4, [rsp + nb234nf_rsqH2M]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb234nf_half] ;# iter1a 
	mulpd   xmm7, [rsp + nb234nf_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb234nf_half] ;# rinv 
	movapd [rsp + nb234nf_rinvMH1], xmm1
	movapd [rsp + nb234nf_rinvH2M], xmm5

	;# start with OO interaction 
	movapd xmm0, [rsp + nb234nf_rinvOO] 
	movapd xmm4, [rsp + nb234nf_rsqOO]
	
		mulpd xmm4, xmm0	;# xmm4=r 
	mulpd xmm4, [rsp + nb234nf_tsc]
	
	cvttpd2pi mm6, xmm4	;# mm6 = lu idx 
	cvtpi2pd xmm5, mm6
	subpd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 

	pslld mm6, 3		;# idx *= 8 
	
	movd mm0, eax	
	movd mm1, ebx

	mov  rsi, [rbp + nb234nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6

	;# dispersion 
	movlpd xmm4, [rsi + rax*8]	;# Y1 	
	movlpd xmm3, [rsi + rbx*8]	;# Y2 
	movhpd xmm4, [rsi + rax*8 + 8]	;# Y1 F1 	
	movhpd xmm3, [rsi + rbx*8 + 8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [rsi + rax*8 + 16]	;# G1
	movlpd xmm3, [rsi + rbx*8 + 16]	;# G2
	movhpd xmm6, [rsi + rax*8 + 24]	;# G1 H1 	
	movhpd xmm3, [rsi + rbx*8 + 24]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# dispersion table ready, in xmm4-xmm7 	
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 

	movapd xmm4, [rsp + nb234nf_c6]
	mulpd  xmm5, xmm4	 ;# Vvdw6 

	;# Update Vvdwtot directly 
	addpd  xmm5, [rsp + nb234nf_Vvdwtot]
	movapd [rsp + nb234nf_Vvdwtot], xmm5

	;# repulsion 
	movlpd xmm4, [rsi + rax*8 + 32]	;# Y1 	
	movlpd xmm3, [rsi + rbx*8 + 32]	;# Y2 
	movhpd xmm4, [rsi + rax*8 + 40]	;# Y1 F1 	
	movhpd xmm3, [rsi + rbx*8 + 40]	;# Y2 F2 

	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [rsi + rax*8 + 48]	;# G1
	movlpd xmm3, [rsi + rbx*8 + 48]	;# G2
	movhpd xmm6, [rsi + rax*8 + 56]	;# G1 H1 	
	movhpd xmm3, [rsi + rbx*8 + 56]	;# G2 H2 

	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	
	;# table ready, in xmm4-xmm7 	
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	
	movapd xmm4, [rsp + nb234nf_c12]
	mulpd  xmm5, xmm4  
	
	addpd  xmm5, [rsp + nb234nf_Vvdwtot]
	movapd [rsp + nb234nf_Vvdwtot], xmm5

	;# H1-H1 interaction 
	movapd xmm0, [rsp + nb234nf_rinvH1H1]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqH1H1] ;# xmm5=krsq 
	movapd xmm6, xmm5
	addpd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm6, [rsp + nb234nf_crf]
	mulpd  xmm6, [rsp + nb234nf_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 	
	addpd  xmm6, [rsp + nb234nf_vctot] ;# local vctot summation variable 

	;# H1-H2 interaction  
	movapd xmm0, [rsp + nb234nf_rinvH1H2]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqH1H2] ;# xmm5=krsq 
	movapd xmm4, xmm5
	addpd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm4, [rsp + nb234nf_crf]
	mulpd  xmm4, [rsp + nb234nf_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 	
	addpd  xmm6, xmm4

	;# H1-M interaction 
	movapd xmm0, [rsp + nb234nf_rinvH1M]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqH1M] ;# xmm5=krsq 
	movapd xmm4, xmm5
	addpd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm4, [rsp + nb234nf_crf]
	mulpd  xmm4, [rsp + nb234nf_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addpd  xmm6, xmm4

	;# H2-H1 interaction 
	movapd xmm0, [rsp + nb234nf_rinvH2H1]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqH2H1] ;# xmm5=krsq 
	movapd xmm4, xmm5
	addpd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm4, [rsp + nb234nf_crf]
	mulpd  xmm4, [rsp + nb234nf_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addpd  xmm6, xmm4

	;# H2-H2 interaction 
	movapd xmm0, [rsp + nb234nf_rinvH2H2]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqH2H2] ;# xmm5=krsq 
	movapd xmm4, xmm5
	addpd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm4, [rsp + nb234nf_crf]
	mulpd  xmm4, [rsp + nb234nf_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addpd  xmm6, xmm4

	;# H2-M interaction 
	movapd xmm0, [rsp + nb234nf_rinvH2M]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqH2M] ;# xmm5=krsq 
	movapd xmm4, xmm5
	addpd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm4, [rsp + nb234nf_crf]
	mulpd  xmm4, [rsp + nb234nf_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addpd  xmm6, xmm4

	;# M-H1 interaction 
	movapd xmm0, [rsp + nb234nf_rinvMH1]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqMH1] ;# xmm5=krsq 
	movapd xmm4, xmm5
	addpd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm4, [rsp + nb234nf_crf]
	mulpd  xmm4, [rsp + nb234nf_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addpd  xmm6, xmm4

	;# M-H2 interaction 
	movapd xmm0, [rsp + nb234nf_rinvMH2]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqMH2] ;# xmm5=krsq 
	movapd xmm4, xmm5
	addpd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm4, [rsp + nb234nf_crf]
	mulpd  xmm4, [rsp + nb234nf_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addpd  xmm6, xmm4

	;# M-M interaction 
	movapd xmm0, [rsp + nb234nf_rinvMM]
	movapd xmm7, xmm0	;# xmm7=rinv 
	movapd xmm5, [rsp + nb234nf_krf]
	mulpd  xmm0, xmm0	;# xmm0=rinvsq 

	mulpd  xmm5, [rsp + nb234nf_rsqMM] ;# xmm5=krsq 
	movapd xmm4, xmm5
	addpd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subpd  xmm4, [rsp + nb234nf_crf]
	mulpd  xmm4, [rsp + nb234nf_qqMM] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addpd  xmm6, xmm4
	movapd [rsp + nb234nf_vctot], xmm6
	
	;# should we do one more iteration? 
	sub dword ptr [rsp + nb234nf_innerk],  2
	jl    .nb234nf_checksingle
	jmp   .nb234nf_unroll_loop
.nb234nf_checksingle:
	mov   edx, [rsp + nb234nf_innerk]
	and   edx, 1
	jnz   .nb234nf_dosingle
	jmp   .nb234nf_updateouterdata
.nb234nf_dosingle:
	mov   rdx, [rsp + nb234nf_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]

	mov rsi, [rbp + nb234nf_pos]       ;# base of pos[] 

	lea   eax, [eax + eax*2]     ;# replace jnr with j3 
	
	;# move j coordinates to local temp variables 
	;# load ox, oy, oz, h1x
	movlpd xmm0, [rsi + rax*8]
	movhpd xmm0, [rsi + rax*8 + 8]
	movlpd xmm1, [rsi + rax*8 + 16]
	movhpd xmm1, [rsi + rax*8 + 24]
	movlpd xmm2, [rsi + rax*8 + 32]
	movhpd xmm2, [rsi + rax*8 + 40]
	movlpd xmm3, [rsi + rax*8 + 48]
	movhpd xmm3, [rsi + rax*8 + 56]
	movlpd xmm4, [rsi + rax*8 + 64]
	movhpd xmm4, [rsi + rax*8 + 72]
	movlpd xmm5, [rsi + rax*8 + 80]
	movhpd xmm5, [rsi + rax*8 + 88]
	movsd  [rsp + nb234nf_jxO], xmm0
	movsd  [rsp + nb234nf_jzO], xmm1
	movsd  [rsp + nb234nf_jyH1], xmm2
	movsd  [rsp + nb234nf_jxH2], xmm3
	movsd  [rsp + nb234nf_jzH2], xmm4
	movsd  [rsp + nb234nf_jyM], xmm5
	unpckhpd xmm0, xmm0
	unpckhpd xmm1, xmm1
	unpckhpd xmm2, xmm2
	unpckhpd xmm3, xmm3
	unpckhpd xmm4, xmm4
	unpckhpd xmm5, xmm5
	movsd  [rsp + nb234nf_jyO], xmm0
	movsd  [rsp + nb234nf_jxH1], xmm1
	movsd  [rsp + nb234nf_jzH1], xmm2
	movsd  [rsp + nb234nf_jyH2], xmm3
	movsd  [rsp + nb234nf_jxM], xmm4
	movsd  [rsp + nb234nf_jzM], xmm5

	;# start calculating pairwise distances
	movapd xmm0, [rsp + nb234nf_ixO]
	movapd xmm1, [rsp + nb234nf_iyO]
	movapd xmm2, [rsp + nb234nf_izO]
	movapd xmm3, [rsp + nb234nf_ixH1]
	movapd xmm4, [rsp + nb234nf_iyH1]
	movapd xmm5, [rsp + nb234nf_izH1]
	subsd  xmm0, [rsp + nb234nf_jxO]
	subsd  xmm1, [rsp + nb234nf_jyO]
	subsd  xmm2, [rsp + nb234nf_jzO]
	subsd  xmm3, [rsp + nb234nf_jxH1]
	subsd  xmm4, [rsp + nb234nf_jyH1]
	subsd  xmm5, [rsp + nb234nf_jzH1]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb234nf_rsqOO], xmm0
	movapd [rsp + nb234nf_rsqH1H1], xmm3

	movapd xmm0, [rsp + nb234nf_ixH1]
	movapd xmm1, [rsp + nb234nf_iyH1]
	movapd xmm2, [rsp + nb234nf_izH1]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subsd  xmm0, [rsp + nb234nf_jxH2]
	subsd  xmm1, [rsp + nb234nf_jyH2]
	subsd  xmm2, [rsp + nb234nf_jzH2]
	subsd  xmm3, [rsp + nb234nf_jxM]
	subsd  xmm4, [rsp + nb234nf_jyM]
	subsd  xmm5, [rsp + nb234nf_jzM]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb234nf_rsqH1H2], xmm0
	movapd [rsp + nb234nf_rsqH1M], xmm3

	movapd xmm0, [rsp + nb234nf_ixH2]
	movapd xmm1, [rsp + nb234nf_iyH2]
	movapd xmm2, [rsp + nb234nf_izH2]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subsd  xmm0, [rsp + nb234nf_jxH1]
	subsd  xmm1, [rsp + nb234nf_jyH1]
	subsd  xmm2, [rsp + nb234nf_jzH1]
	subsd  xmm3, [rsp + nb234nf_jxH2]
	subsd  xmm4, [rsp + nb234nf_jyH2]
	subsd  xmm5, [rsp + nb234nf_jzH2]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb234nf_rsqH2H1], xmm0
	movapd [rsp + nb234nf_rsqH2H2], xmm3

	movapd xmm0, [rsp + nb234nf_ixH2]
	movapd xmm1, [rsp + nb234nf_iyH2]
	movapd xmm2, [rsp + nb234nf_izH2]
	movapd xmm3, [rsp + nb234nf_ixM]
	movapd xmm4, [rsp + nb234nf_iyM]
	movapd xmm5, [rsp + nb234nf_izM]
	subsd  xmm0, [rsp + nb234nf_jxM]
	subsd  xmm1, [rsp + nb234nf_jyM]
	subsd  xmm2, [rsp + nb234nf_jzM]
	subsd  xmm3, [rsp + nb234nf_jxH1]
	subsd  xmm4, [rsp + nb234nf_jyH1]
	subsd  xmm5, [rsp + nb234nf_jzH1]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm4, xmm3
	addsd  xmm4, xmm5
	movapd [rsp + nb234nf_rsqH2M], xmm0
	movapd [rsp + nb234nf_rsqMH1], xmm4

	movapd xmm0, [rsp + nb234nf_ixM]
	movapd xmm1, [rsp + nb234nf_iyM]
	movapd xmm2, [rsp + nb234nf_izM]
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	subsd  xmm0, [rsp + nb234nf_jxH2]
	subsd  xmm1, [rsp + nb234nf_jyH2]
	subsd  xmm2, [rsp + nb234nf_jzH2]
	subsd  xmm3, [rsp + nb234nf_jxM]
	subsd  xmm4, [rsp + nb234nf_jyM]
	subsd  xmm5, [rsp + nb234nf_jzM]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm4, xmm3
	addsd  xmm4, xmm5
	movapd [rsp + nb234nf_rsqMH2], xmm0
	movapd [rsp + nb234nf_rsqMM], xmm4

	;# Invsqrt form rsq M-H2 (rsq in xmm0) and MM (rsq in xmm4) 
	cvtsd2ss xmm1, xmm0
	cvtsd2ss xmm5, xmm4
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1   ;# luA
	cvtss2sd xmm5, xmm5   ;# luB
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234nf_half] ;# iter1 
	mulsd   xmm7, [rsp + nb234nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234nf_half] ;# rinv 
	movapd [rsp + nb234nf_rinvMH2], xmm1
	movapd [rsp + nb234nf_rinvMM], xmm5

	movapd xmm0, [rsp + nb234nf_rsqOO]
	movapd xmm4, [rsp + nb234nf_rsqH1H1]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234nf_half] ;# iter1 of  
	mulsd   xmm7, [rsp + nb234nf_half] ;# iter1 of  

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234nf_half] ;# rinv
	movapd [rsp + nb234nf_rinvOO], xmm1
	movapd [rsp + nb234nf_rinvH1H1], xmm5

	movapd xmm0, [rsp + nb234nf_rsqH1H2]
	movapd xmm4, [rsp + nb234nf_rsqH1M]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234nf_half] ;# iter1 
	mulsd   xmm7, [rsp + nb234nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234nf_half] ;# rinv 
	movapd [rsp + nb234nf_rinvH1H2], xmm1
	movapd [rsp + nb234nf_rinvH1M], xmm5

	movapd xmm0, [rsp + nb234nf_rsqH2H1]
	movapd xmm4, [rsp + nb234nf_rsqH2H2]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234nf_half] ;# iter1a 
	mulsd   xmm7, [rsp + nb234nf_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234nf_half] ;# rinv 
	movapd [rsp + nb234nf_rinvH2H1], xmm1
	movapd [rsp + nb234nf_rinvH2H2], xmm5

	movapd xmm0, [rsp + nb234nf_rsqMH1]
	movapd xmm4, [rsp + nb234nf_rsqH2M]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb234nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb234nf_half] ;# iter1a 
	mulsd   xmm7, [rsp + nb234nf_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb234nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb234nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb234nf_half] ;# rinv 
	movapd [rsp + nb234nf_rinvMH1], xmm1
	movapd [rsp + nb234nf_rinvH2M], xmm5

	;# start with OO interaction 
	movsd xmm0, [rsp + nb234nf_rinvOO] 
	movsd xmm4, [rsp + nb234nf_rsqOO]
	
	mulsd xmm4, xmm0	;# xmm4=r 
	mulsd xmm4, [rsp + nb234nf_tsc]
	
	cvttsd2si ebx, xmm4	;# mm6 = lu idx 
	cvtsi2sd xmm5, ebx
	subsd xmm4, xmm5
	movsd xmm1, xmm4	;# xmm1=eps 
	movsd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 

	shl ebx, 3
	
	mov  rsi, [rbp + nb234nf_VFtab]

	;# dispersion 
	movlpd xmm4, [rsi + rbx*8]	;# Y1 	
	movhpd xmm4, [rsi + rbx*8 + 8]	;# Y1 F1 	
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [rsi + rbx*8 + 16]	;# G1
	movhpd xmm6, [rsi + rbx*8 + 24]	;# G1 H1 	
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# dispersion table ready, in xmm4-xmm7 	
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 

	movsd xmm4, [rsp + nb234nf_c6]
	mulsd  xmm5, xmm4	 ;# Vvdw6 

	;# Update Vvdwtot directly 
	addsd  xmm5, [rsp + nb234nf_Vvdwtot]
	movsd [rsp + nb234nf_Vvdwtot], xmm5

	;# repulsion 
	movlpd xmm4, [rsi + rbx*8 + 32]	;# Y1 	
	movhpd xmm4, [rsi + rbx*8 + 40]	;# Y1 F1 	

	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [rsi + rbx*8 + 48]	;# G1
	movhpd xmm6, [rsi + rbx*8 + 56]	;# G1 H1 	

	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	
	;# table ready, in xmm4-xmm7 	
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	
	movsd xmm4, [rsp + nb234nf_c12]
	mulsd  xmm5, xmm4  
	
	addsd  xmm5, [rsp + nb234nf_Vvdwtot]
	movsd [rsp + nb234nf_Vvdwtot], xmm5

	;# H1-H1 interaction 
	movsd xmm0, [rsp + nb234nf_rinvH1H1]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqH1H1] ;# xmm5=krsq 
	movsd xmm6, xmm5
	addsd  xmm6, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm6, [rsp + nb234nf_crf]
	mulsd  xmm6, [rsp + nb234nf_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, [rsp + nb234nf_vctot] ;# local vctot summation variable 

	;# H1-H2 interaction  
	movsd xmm0, [rsp + nb234nf_rinvH1H2]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqH1H2] ;# xmm5=krsq 
	movsd  xmm4, xmm5
	addsd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm4, [rsp + nb234nf_crf]
	mulsd  xmm4, [rsp + nb234nf_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, xmm4

	;# H1-M interaction 
	movsd xmm0, [rsp + nb234nf_rinvH1M]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqH1M] ;# xmm5=krsq 
	movsd  xmm4, xmm5
	addsd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm4, [rsp + nb234nf_crf]
	mulsd  xmm4, [rsp + nb234nf_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, xmm4

	;# H2-H1 interaction 
	movsd xmm0, [rsp + nb234nf_rinvH2H1]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqH2H1] ;# xmm5=krsq 
	movsd  xmm4, xmm5
	addsd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm4, [rsp + nb234nf_crf]
	mulsd  xmm4, [rsp + nb234nf_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, xmm4

	;# H2-H2 interaction 
	movsd xmm0, [rsp + nb234nf_rinvH2H2]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqH2H2] ;# xmm5=krsq 
	movsd  xmm4, xmm5
	addsd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm4, [rsp + nb234nf_crf]
	mulsd  xmm4, [rsp + nb234nf_qqHH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, xmm4

	;# H2-M interaction 
	movsd xmm0, [rsp + nb234nf_rinvH2M]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqH2M] ;# xmm5=krsq 
	movsd  xmm4, xmm5
	addsd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm4, [rsp + nb234nf_crf]
	mulsd  xmm4, [rsp + nb234nf_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, xmm4

	;# M-H1 interaction 
	movsd xmm0, [rsp + nb234nf_rinvMH1]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqMH1] ;# xmm5=krsq 
	movsd  xmm4, xmm5
	addsd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm4, [rsp + nb234nf_crf]
	mulsd  xmm4, [rsp + nb234nf_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, xmm4

	;# M-H2 interaction 
	movsd xmm0, [rsp + nb234nf_rinvMH2]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqMH2] ;# xmm5=krsq 
	movsd  xmm4, xmm5
	addsd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm4, [rsp + nb234nf_crf]
	mulsd  xmm4, [rsp + nb234nf_qqMH] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, xmm4

	;# M-M interaction 
	movsd xmm0, [rsp + nb234nf_rinvMM]
	movsd xmm7, xmm0	;# xmm7=rinv 
	movsd xmm5, [rsp + nb234nf_krf]
	mulsd  xmm0, xmm0	;# xmm0=rinvsq 

	mulsd  xmm5, [rsp + nb234nf_rsqMM] ;# xmm5=krsq 
	movsd  xmm4, xmm5
	addsd  xmm4, xmm7	;# xmm6=rinv+ krsq 
	subsd  xmm4, [rsp + nb234nf_crf]
	mulsd  xmm4, [rsp + nb234nf_qqMM] ;# xmm6=voul=qq*(rinv+ krsq-crf) 
	addsd  xmm6, xmm4
	movsd [rsp + nb234nf_vctot], xmm6
	
.nb234nf_updateouterdata:
	;# get n from stack
	mov esi, [rsp + nb234nf_n]
        ;# get group index for i particle 
        mov   rdx, [rbp + nb234nf_gid]      	;# base of gid[]
        mov   edx, [rdx + rsi*4]		;# ggid=gid[n]

	;# accumulate total potential energy and update it 
	movapd xmm7, [rsp + nb234nf_vctot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
        
	;# add earlier value from mem 
	mov   rax, [rbp + nb234nf_Vc]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
	;# accumulate total lj energy and update it 
	movapd xmm7, [rsp + nb234nf_Vvdwtot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 

	;# add earlier value from mem 
	mov   rax, [rbp + nb234nf_Vvdw]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
        ;# finish if last 
        mov ecx, [rsp + nb234nf_nn1]
	;# esi already loaded with n
	inc esi
        sub ecx, esi
        jecxz .nb234nf_outerend

        ;# not last, iterate outer loop once more!  
        mov [rsp + nb234nf_n], esi
        jmp .nb234nf_outer
.nb234nf_outerend:
        ;# check if more outer neighborlists remain
        mov   ecx, [rsp + nb234nf_nri]
	;# esi already loaded with n above
        sub   ecx, esi
        jecxz .nb234nf_end
        ;# non-zero, do one more workunit
        jmp   .nb234nf_threadloop
.nb234nf_end:
	mov eax, [rsp + nb234nf_nouter]
	mov ebx, [rsp + nb234nf_ninner]
	mov rcx, [rbp + nb234nf_outeriter]
	mov rdx, [rbp + nb234nf_inneriter]
	mov [rcx], eax
	mov [rdx], ebx

	add rsp, 1000
	femms

	pop rbx
	pop	rbp
	ret

