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





.globl nb_kernel410_x86_64_sse2
.globl _nb_kernel410_x86_64_sse2
nb_kernel410_x86_64_sse2:	
_nb_kernel410_x86_64_sse2:	
;#	Room for return address and rbp (16 bytes)
.equiv          nb410_fshift,           16
.equiv          nb410_gid,              24
.equiv          nb410_pos,              32
.equiv          nb410_faction,          40
.equiv          nb410_charge,           48
.equiv          nb410_p_facel,          56
.equiv          nb410_argkrf,           64
.equiv          nb410_argcrf,           72
.equiv          nb410_Vc,               80
.equiv          nb410_type,             88
.equiv          nb410_p_ntype,          96
.equiv          nb410_vdwparam,         104
.equiv          nb410_Vvdw,             112
.equiv          nb410_p_tabscale,       120
.equiv          nb410_VFtab,            128
.equiv          nb410_invsqrta,         136
.equiv          nb410_dvda,             144
.equiv          nb410_p_gbtabscale,     152
.equiv          nb410_GBtab,            160
.equiv          nb410_p_nthreads,       168
.equiv          nb410_count,            176
.equiv          nb410_mtx,              184
.equiv          nb410_outeriter,        192
.equiv          nb410_inneriter,        200
.equiv          nb410_work,             208
	;# stack offsets for local variables  
	;# bottom of stack is cache-aligned for sse2 use 
.equiv          nb410_ix,               0
.equiv          nb410_iy,               16
.equiv          nb410_iz,               32
.equiv          nb410_iq,               48
.equiv          nb410_dx,               64
.equiv          nb410_dy,               80
.equiv          nb410_dz,               96
.equiv          nb410_two,              112
.equiv          nb410_six,              128
.equiv          nb410_twelve,           144
.equiv          nb410_gbtsc,            160
.equiv          nb410_qq,               176
.equiv          nb410_c6,               192
.equiv          nb410_c12,              208
.equiv          nb410_fscal,            224
.equiv          nb410_vctot,            240
.equiv          nb410_Vvdwtot,          256
.equiv          nb410_fix,              272
.equiv          nb410_fiy,              288
.equiv          nb410_fiz,              304
.equiv          nb410_half,             320
.equiv          nb410_three,            336
.equiv          nb410_r,                352
.equiv          nb410_isai,             368
.equiv          nb410_isaprod,          384
.equiv          nb410_dvdasum,          400
.equiv          nb410_gbscale,          416
.equiv          nb410_nri,              432
.equiv          nb410_iinr,             440
.equiv          nb410_jindex,           448
.equiv          nb410_jjnr,             456
.equiv          nb410_shift,            464
.equiv          nb410_shiftvec,         472
.equiv          nb410_facel,            480
.equiv          nb410_innerjjnr,        488
.equiv          nb410_ii,               496
.equiv          nb410_is3,              500
.equiv          nb410_ii3,              504
.equiv          nb410_ntia,             508
.equiv          nb410_innerk,           512
.equiv          nb410_n,                516
.equiv          nb410_nn1,              520
.equiv          nb410_ntype,            524
.equiv          nb410_nouter,           528
.equiv          nb410_ninner,           532
	push rbp
	mov  rbp, rsp
	push rbx

	
	femms
	sub rsp, 552		;# local variable stack space (n*16+8)

	;# zero 32-bit iteration counters
	mov eax, 0
	mov [rsp + nb410_nouter], eax
	mov [rsp + nb410_ninner], eax

	mov edi, [rdi]
	mov [rsp + nb410_nri], edi
	mov [rsp + nb410_iinr], rsi
	mov [rsp + nb410_jindex], rdx
	mov [rsp + nb410_jjnr], rcx
	mov [rsp + nb410_shift], r8
	mov [rsp + nb410_shiftvec], r9
	mov rdi, [rbp + nb410_p_ntype]
	mov edi, [rdi]
	mov [rsp + nb410_ntype], edi
	mov rsi, [rbp + nb410_p_facel]
	movsd xmm0, [rsi]
	movsd [rsp + nb410_facel], xmm0

	mov rbx, [rbp + nb410_p_gbtabscale]
	movsd xmm4, [rbx]
	shufpd xmm4, xmm4, 0
	movapd [rsp + nb410_gbtsc],  xmm4

	;# create constant floating-point factors on stack
	mov eax, 0x00000000     ;# lower half of double half IEEE (hex)
	mov ebx, 0x3fe00000
	mov [rsp + nb410_half], eax
	mov [rsp + nb410_half + 4], ebx
	movsd xmm1, [rsp + nb410_half]
	shufpd xmm1, xmm1, 0    ;# splat to all elements
	movapd xmm3, xmm1
	addpd  xmm3, xmm3       ;# one
	movapd xmm2, xmm3
	addpd  xmm2, xmm2       ;# two
	addpd  xmm3, xmm2	;# three
	movapd xmm4, xmm3
	addpd  xmm4, xmm4       ;# six
	movapd xmm5, xmm4
	addpd  xmm5, xmm5       ;# twelve
	movapd [rsp + nb410_half], xmm1
	movapd [rsp + nb410_two], xmm2
	movapd [rsp + nb410_three], xmm3
	movapd [rsp + nb410_six], xmm4
	movapd [rsp + nb410_twelve], xmm5

.nb410_threadloop:
        mov   rsi, [rbp + nb410_count]          ;# pointer to sync counter
        mov   eax, [rsi]
.nb410_spinlock:
        mov   ebx, eax                          ;# ebx=*count=nn0
        add   ebx, 1                           ;# ebx=nn1=nn0+10
        lock cmpxchg [rsi], ebx                 ;# write nn1 to *counter,
                                                ;# if it hasnt changed.
                                                ;# or reread *counter to eax.
        pause                                   ;# -> better p4 performance
        jnz .nb410_spinlock

        ;# if(nn1>nri) nn1=nri
        mov ecx, [rsp + nb410_nri]
        mov edx, ecx
        sub ecx, ebx
        cmovle ebx, edx                         ;# if(nn1>nri) nn1=nri
        ;# Cleared the spinlock if we got here.
        ;# eax contains nn0, ebx contains nn1.
        mov [rsp + nb410_n], eax
        mov [rsp + nb410_nn1], ebx
        sub ebx, eax                            ;# calc number of outer lists
	mov esi, eax				;# copy n to esi
        jg  .nb410_outerstart
        jmp .nb410_end

.nb410_outerstart:
	;# ebx contains number of outer iterations
	add ebx, [rsp + nb410_nouter]
	mov [rsp + nb410_nouter], ebx

.nb410_outer:
	mov   rax, [rsp + nb410_shift]      ;# rax = pointer into shift[] 
	mov   ebx, [rax+rsi*4]		;# rbx=shift[n] 
	
	lea   ebx, [ebx + ebx*2]    ;# ebx=3*is 
	mov   [rsp + nb410_is3],ebx    	;# store is3 

	mov   rax, [rsp + nb410_shiftvec]   ;# rax = base of shiftvec[] 

	movsd xmm0, [rax + rbx*8]
	movsd xmm1, [rax + rbx*8 + 8]
	movsd xmm2, [rax + rbx*8 + 16] 

	mov   rcx, [rsp + nb410_iinr]       ;# rcx = pointer into iinr[] 	
	mov   ebx, [rcx+rsi*4]	    ;# ebx =ii 
	mov   [rsp + nb410_ii], ebx

	mov   rdx, [rbp + nb410_charge]
	movsd xmm3, [rdx + rbx*8]	
	mulsd xmm3, [rsp + nb410_facel]
	shufpd xmm3, xmm3, 0

	mov   rdx, [rbp + nb410_invsqrta]	;# load invsqrta[ii]
	movsd xmm4, [rdx + rbx*8]
	shufpd xmm4, xmm4, 0

    	mov   rdx, [rbp + nb410_type] 
    	mov   edx, [rdx + rbx*4]
    	imul  edx, [rsp + nb410_ntype]
    	shl   edx, 1
    	mov   [rsp + nb410_ntia], edx
	
	lea   ebx, [ebx + ebx*2]	;# ebx = 3*ii=ii3 
	mov   rax, [rbp + nb410_pos]    ;# rax = base of pos[]  

	addsd xmm0, [rax + rbx*8]
	addsd xmm1, [rax + rbx*8 + 8]
	addsd xmm2, [rax + rbx*8 + 16]

	movapd [rsp + nb410_iq], xmm3
	movapd [rsp + nb410_isai], xmm4

	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0

	movapd [rsp + nb410_ix], xmm0
	movapd [rsp + nb410_iy], xmm1
	movapd [rsp + nb410_iz], xmm2

	mov   [rsp + nb410_ii3], ebx
	
	;# clear vctot and i forces 
	xorpd xmm4, xmm4
	movapd [rsp + nb410_vctot], xmm4
	movapd [rsp + nb410_Vvdwtot], xmm4
	movapd [rsp + nb410_dvdasum], xmm4
	movapd [rsp + nb410_fix], xmm4
	movapd [rsp + nb410_fiy], xmm4
	movapd [rsp + nb410_fiz], xmm4
	
	mov   rax, [rsp + nb410_jindex]
	mov   ecx, [rax + rsi*4]	     ;# jindex[n] 
	mov   edx, [rax + rsi*4 + 4]	     ;# jindex[n+1] 
	sub   edx, ecx               ;# number of innerloop atoms 

	mov   rsi, [rbp + nb410_pos]
	mov   rdi, [rbp + nb410_faction]	
	mov   rax, [rsp + nb410_jjnr]
	shl   ecx, 2
	add   rax, rcx
	mov   [rsp + nb410_innerjjnr], rax     ;# pointer to jjnr[nj0] 
	mov   ecx, edx
	sub   edx,  2
	add   ecx, [rsp + nb410_ninner]
	mov   [rsp + nb410_ninner], ecx
	add   edx, 0
	mov   [rsp + nb410_innerk], edx    ;# number of innerloop atoms 
	jge   .nb410_unroll_loop
	jmp   .nb410_checksingle
.nb410_unroll_loop:	
	;# twice unrolled innerloop here 
	mov   rdx, [rsp + nb410_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]	
	mov   ebx, [rdx + 4]              
	add qword ptr [rsp + nb410_innerjjnr],  8 ;# advance pointer (unrolled 2) 

	;# load isaj
	mov rsi, [rbp + nb410_invsqrta]
	movlpd xmm2, [rsi + rax*8]
	movhpd xmm2, [rsi + rbx*8]
	mulpd  xmm2, [rsp + nb410_isai]
	movapd [rsp + nb410_isaprod], xmm2	
	movapd xmm1, xmm2
	mulpd xmm1, [rsp + nb410_gbtsc]
	movapd [rsp + nb410_gbscale], xmm1
	
	mov rsi, [rbp + nb410_charge]    ;# base of charge[] 
	movlpd xmm3, [rsi + rax*8]
	movhpd xmm3, [rsi + rbx*8]

	mulpd xmm2, [rsp + nb410_iq]
	mulpd  xmm3, xmm2
	movapd [rsp + nb410_qq], xmm3	
	
	movd  mm0, eax		;# use mmx registers as temp storage 
	movd  mm1, ebx
	
	mov rsi, [rbp + nb410_type]
	mov eax, [rsi + rax*4]
	mov ebx, [rsi + rbx*4]
	mov rsi, [rbp + nb410_vdwparam]
	shl eax, 1
	shl ebx, 1
	mov edi, [rsp + nb410_ntia]
	add eax, edi
	add ebx, edi

	movlpd xmm6, [rsi + rax*8]	;# c6a
	movlpd xmm7, [rsi + rbx*8]	;# c6b
	movhpd xmm6, [rsi + rax*8 + 8]	;# c6a c12a 
	movhpd xmm7, [rsi + rbx*8 + 8]	;# c6b c12b 
	movapd xmm4, xmm6
	unpcklpd xmm4, xmm7
	unpckhpd xmm6, xmm7
	
	movd  eax, mm0
	movd  ebx, mm1
	movapd [rsp + nb410_c6], xmm4
	movapd [rsp + nb410_c12], xmm6
	
	mov rsi, [rbp + nb410_pos]       ;# base of pos[] 

	movd  mm2, eax
	movd  mm3, ebx
	lea   eax, [eax + eax*2]     ;# replace jnr with j3 
	lea   ebx, [ebx + ebx*2]	

	;# move two coordinates to xmm0-xmm2 	
	movlpd xmm0, [rsi + rax*8]
	movlpd xmm1, [rsi + rax*8 + 8]
	movlpd xmm2, [rsi + rax*8 + 16]
	movhpd xmm0, [rsi + rbx*8]
	movhpd xmm1, [rsi + rbx*8 + 8]
	movhpd xmm2, [rsi + rbx*8 + 16]		
	
	;# move ix-iz to xmm4-xmm6 
	movapd xmm4, [rsp + nb410_ix]
	movapd xmm5, [rsp + nb410_iy]
	movapd xmm6, [rsp + nb410_iz]

	;# calc dr 
	subpd xmm4, xmm0
	subpd xmm5, xmm1
	subpd xmm6, xmm2

	;# store dr 
	movapd [rsp + nb410_dx], xmm4
	movapd [rsp + nb410_dy], xmm5
	movapd [rsp + nb410_dz], xmm6
	;# square it 
	mulpd xmm4,xmm4
	mulpd xmm5,xmm5
	mulpd xmm6,xmm6
	addpd xmm4, xmm5
	addpd xmm4, xmm6
	;# rsq in xmm4 

	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm5, xmm5
	cvtps2pd xmm2, xmm5	;# lu in low xmm2 

	;# lookup seed in xmm2 
	movapd xmm5, xmm2	;# copy of lu 
	mulpd xmm2, xmm2	;# lu*lu 
	movapd xmm1, [rsp + nb410_three]
	mulpd xmm2, xmm4	;# rsq*lu*lu 			
	movapd xmm0, [rsp + nb410_half]
	subpd xmm1, xmm2	;# 30-rsq*lu*lu 
	mulpd xmm1, xmm5	
	mulpd xmm1, xmm0	;# xmm0=iter1 of rinv (new lu) 

	movapd xmm5, xmm1	;# copy of lu 
	mulpd xmm1, xmm1	;# lu*lu 
	movapd xmm2, [rsp + nb410_three]
	mulpd xmm1, xmm4	;# rsq*lu*lu 			
	movapd xmm0, [rsp + nb410_half]
	subpd xmm2, xmm1	;# 30-rsq*lu*lu 
	mulpd xmm2, xmm5	
	mulpd xmm0, xmm2	;# xmm0=rinv 
	
	mulpd xmm4, xmm0	;# xmm4=r 
	movapd [rsp + nb410_r], xmm4
	mulpd xmm4, [rsp + nb410_gbscale]

	cvttpd2pi mm6, xmm4	;# mm6 = lu idx 
	cvtpi2pd xmm5, mm6
	subpd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	
	movd mm0, eax	
	movd mm1, ebx

	mov  rsi, [rbp + nb410_GBtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm7, [rsp + nb410_two]	;# two*Heps2 
	movapd xmm3, [rsp + nb410_qq]
	addpd  xmm7, xmm6
	addpd  xmm7, xmm5 ;# xmm7=FF 
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
	mulpd  xmm3, xmm7 ;# fijC=FF*qq 
	;# get jnr from regs
	movd ecx, mm2
	movd edx, mm3
	mov rsi, [rbp + nb410_dvda]
	
	;# Calculate dVda
	xorpd xmm7, xmm7
	mulpd xmm3, [rsp + nb410_gbscale]
	movapd xmm6, xmm3
	mulpd  xmm6, [rsp + nb410_r]
	addpd  xmm6, xmm5
	addpd  xmm5, [rsp + nb410_vctot]
	movapd [rsp + nb410_vctot], xmm5 

	;# xmm6=(vcoul+fijC*r)
	subpd  xmm7, xmm6
	movapd xmm6, xmm7
	
	;# update dvdasum
	addpd  xmm7, [rsp + nb410_dvdasum]
	movapd [rsp + nb410_dvdasum], xmm7 

	;# update j atoms dvdaj
	movhlps xmm7, xmm6
	addsd  xmm6, [rsi + rcx*8]
	addsd  xmm7, [rsi + rdx*8]
	movsd  [rsi + rcx*8], xmm6
	movsd  [rsi + rdx*8], xmm7
	
	;# L-J 
	movapd xmm4, xmm0
	mulpd  xmm4, xmm0	;# xmm4=rinvsq 

	movapd xmm6, xmm4
	mulpd  xmm6, xmm4
	
	mulpd  xmm6, xmm4	;# xmm6=rinvsix 
	movapd xmm4, xmm6
	mulpd  xmm4, xmm4	;# xmm4=rinvtwelve 
	mulpd  xmm6, [rsp + nb410_c6]
	mulpd  xmm4, [rsp + nb410_c12]
	movapd xmm7, [rsp + nb410_Vvdwtot]
	addpd  xmm7, xmm4
	mulpd  xmm4, [rsp + nb410_twelve]
	subpd  xmm7, xmm6
	mulpd  xmm6, [rsp + nb410_six]
	movapd [rsp + nb410_Vvdwtot], xmm7
	subpd  xmm4, xmm6
	mulpd  xmm4, xmm0
	subpd  xmm4, xmm3
	mulpd  xmm4, xmm0

	movapd xmm0, [rsp + nb410_dx]
	movapd xmm1, [rsp + nb410_dy]
	movapd xmm2, [rsp + nb410_dz]

	movd eax, mm0	
	movd ebx, mm1

	mov    rdi, [rbp + nb410_faction]
	mulpd  xmm0, xmm4
	mulpd  xmm1, xmm4
	mulpd  xmm2, xmm4
	;# xmm0-xmm2 contains tx-tz (partial force) 
	;# now update f_i 
	movapd xmm3, [rsp + nb410_fix]
	movapd xmm4, [rsp + nb410_fiy]
	movapd xmm5, [rsp + nb410_fiz]
	addpd  xmm3, xmm0
	addpd  xmm4, xmm1
	addpd  xmm5, xmm2
	movapd [rsp + nb410_fix], xmm3
	movapd [rsp + nb410_fiy], xmm4
	movapd [rsp + nb410_fiz], xmm5
	;# the fj's - start by accumulating forces from memory 
	movlpd xmm3, [rdi + rax*8]
	movlpd xmm4, [rdi + rax*8 + 8]
	movlpd xmm5, [rdi + rax*8 + 16]
	movhpd xmm3, [rdi + rbx*8]
	movhpd xmm4, [rdi + rbx*8 + 8]
	movhpd xmm5, [rdi + rbx*8 + 16]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	movlpd [rdi + rax*8], xmm3
	movlpd [rdi + rax*8 + 8], xmm4
	movlpd [rdi + rax*8 + 16], xmm5
	movhpd [rdi + rbx*8], xmm3
	movhpd [rdi + rbx*8 + 8], xmm4
	movhpd [rdi + rbx*8 + 16], xmm5
	
	;# should we do one more iteration? 
	sub dword ptr [rsp + nb410_innerk],  2
	jl    .nb410_checksingle
	jmp   .nb410_unroll_loop
.nb410_checksingle:
	mov   edx, [rsp + nb410_innerk]
	and   edx, 1
	jnz    .nb410_dosingle
	jmp    .nb410_updateouterdata
.nb410_dosingle:
	mov rsi, [rbp + nb410_charge]
	mov rdx, [rbp + nb410_invsqrta]
	mov rdi, [rbp + nb410_pos]
	mov   rcx, [rsp + nb410_innerjjnr]
	mov   eax, [rcx]
	
	xorpd  xmm6, xmm6
	movapd xmm7, xmm6
	movsd  xmm7, [rdx + rax*8]
	movlpd xmm6, [rsi + rax*8]	;# xmm6(0) has the charge
	mulsd  xmm7, [rsp + nb410_isai]
	movapd [rsp + nb410_isaprod], xmm7
	movapd xmm1, xmm7
	mulpd xmm1, [rsp + nb410_gbtsc]
	movapd [rsp + nb410_gbscale], xmm1
	
	mulsd  xmm7, [rsp + nb410_iq]
	mulsd  xmm6, xmm7
	movapd [rsp + nb410_qq], xmm6
	
	movd  mm0, eax		;# use mmx registers as temp storage 
	mov rsi, [rbp + nb410_type]
	mov eax, [rsi + rax*4]
	mov rsi, [rbp + nb410_vdwparam]
	shl eax, 1
	mov edi, [rsp + nb410_ntia]
	add eax, edi

	movlpd xmm6, [rsi + rax*8]	;# c6a
	movhpd xmm6, [rsi + rax*8 + 8]	;# c6a c12a 
	xorpd xmm7, xmm7
	movapd xmm4, xmm6
	unpcklpd xmm4, xmm7
	unpckhpd xmm6, xmm7
	
	movd  eax, mm0
	movapd [rsp + nb410_c6], xmm4
	movapd [rsp + nb410_c12], xmm6
	
	mov rsi, [rbp + nb410_pos]       ;# base of pos[]
	
	movd  mm2, eax
	lea   eax, [eax + eax*2]     ;# replace jnr with j3 

	;# move coordinates to xmm0-xmm2 	
	movlpd xmm0, [rsi + rax*8]
	movlpd xmm1, [rsi + rax*8 + 8]
	movlpd xmm2, [rsi + rax*8 + 16]
	
	;# move ix-iz to xmm4-xmm6 
	movapd xmm4, [rsp + nb410_ix]
	movapd xmm5, [rsp + nb410_iy]
	movapd xmm6, [rsp + nb410_iz]

	;# calc dr 
	subsd xmm4, xmm0
	subsd xmm5, xmm1
	subsd xmm6, xmm2

	;# store dr 
	movapd [rsp + nb410_dx], xmm4
	movapd [rsp + nb410_dy], xmm5
	movapd [rsp + nb410_dz], xmm6
	;# square it 
	mulsd xmm4,xmm4
	mulsd xmm5,xmm5
	mulsd xmm6,xmm6
	addsd xmm4, xmm5
	addsd xmm4, xmm6
	;# rsq in xmm4 

	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm5, xmm5
	cvtss2sd xmm2, xmm5	;# lu in low xmm2 

	;# lookup seed in xmm2 
	movapd xmm5, xmm2	;# copy of lu 
	mulsd xmm2, xmm2	;# lu*lu 
	movapd xmm1, [rsp + nb410_three]
	mulsd xmm2, xmm4	;# rsq*lu*lu 			
	movapd xmm0, [rsp + nb410_half]
	subsd xmm1, xmm2	;# 30-rsq*lu*lu 
	mulsd xmm1, xmm5	
	mulsd xmm1, xmm0	;# xmm0=iter1 of rinv (new lu) 

	movapd xmm5, xmm1	;# copy of lu 
	mulsd xmm1, xmm1	;# lu*lu 
	movapd xmm2, [rsp + nb410_three]
	mulsd xmm1, xmm4	;# rsq*lu*lu 			
	movapd xmm0, [rsp + nb410_half]
	subsd xmm2, xmm1	;# 30-rsq*lu*lu 
	mulsd xmm2, xmm5	
	mulsd xmm0, xmm2	;# xmm0=rinv 
	
	mulsd xmm4, xmm0	;# xmm4=r 
	movapd [rsp + nb410_r], xmm4
	mulsd xmm4, [rsp + nb410_gbscale]

	movd mm0, eax	
	cvttsd2si eax, xmm4	;# mm6 = lu idx 
	cvtsi2sd xmm5, eax
	subsd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	
	mov  rsi, [rbp + nb410_GBtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm7, [rsp + nb410_two]	;# two*Heps2 
	movapd xmm3, [rsp + nb410_qq]
	addsd  xmm7, xmm6
	addsd  xmm7, xmm5 ;# xmm7=FF 
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
	mulsd  xmm3, xmm7 ;# fijC=FF*qq 
	;# get jnr from regs
	movd ebx, mm2
	mov rsi, [rbp + nb410_dvda]
	
	;# Calculate dVda
	xorpd xmm7, xmm7
	mulsd xmm3, [rsp + nb410_gbscale]
	movsd xmm6, xmm3
	mulsd  xmm6, [rsp + nb410_r]
	addsd  xmm6, xmm5
	addsd  xmm5, [rsp + nb410_vctot]
	movsd [rsp + nb410_vctot], xmm5 

	;# xmm6=(vcoul+fijC*r)
	subpd xmm7, xmm7
	movsd xmm6, xmm7
	
	;# update dvdasum
	addsd  xmm7, [rsp + nb410_dvdasum]
	movsd [rsp + nb410_dvdasum], xmm7 

	;# update j atoms dvdaj
	addsd  xmm6, [rsi + rbx*8]
	movsd  [rsi + rbx*8], xmm6
	
	;# L-J 
	movapd xmm4, xmm0
	mulsd  xmm4, xmm0	;# xmm4=rinvsq 


	movapd xmm6, xmm4
	mulsd  xmm6, xmm4

	mulsd  xmm6, xmm4	;# xmm6=rinvsix 
	movapd xmm4, xmm6
	mulsd  xmm4, xmm4	;# xmm4=rinvtwelve 
	mulsd  xmm6, [rsp + nb410_c6]
	mulsd  xmm4, [rsp + nb410_c12]
	movapd xmm7, [rsp + nb410_Vvdwtot]
	addsd  xmm7, xmm4
	mulsd  xmm4, [rsp + nb410_twelve]
	subsd  xmm7, xmm6
	mulsd  xmm6, [rsp + nb410_six]
	movlpd [rsp + nb410_Vvdwtot], xmm7
	subsd  xmm4, xmm6
	mulsd  xmm4, xmm0
	subsd  xmm4, xmm3
	mulsd  xmm4, xmm0

	movapd xmm0, [rsp + nb410_dx]
	movapd xmm1, [rsp + nb410_dy]
	movapd xmm2, [rsp + nb410_dz]

	movd eax, mm0	

	mov    rdi, [rbp + nb410_faction]
	mulsd  xmm0, xmm4
	mulsd  xmm1, xmm4
	mulsd  xmm2, xmm4
	;# xmm0-xmm2 contains tx-tz (partial force) 
	;# now update f_i 
	movapd xmm3, [rsp + nb410_fix]
	movapd xmm4, [rsp + nb410_fiy]
	movapd xmm5, [rsp + nb410_fiz]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movlpd [rsp + nb410_fix], xmm3
	movlpd [rsp + nb410_fiy], xmm4
	movlpd [rsp + nb410_fiz], xmm5
	;# the fj's - start by accumulating forces from memory 
	movlpd xmm3, [rdi + rax*8]
	movlpd xmm4, [rdi + rax*8 + 8]
	movlpd xmm5, [rdi + rax*8 + 16]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	movlpd [rdi + rax*8], xmm3
	movlpd [rdi + rax*8 + 8], xmm4
	movlpd [rdi + rax*8 + 16], xmm5
	
.nb410_updateouterdata:
	mov   ecx, [rsp + nb410_ii3]
	mov   rdi, [rbp + nb410_faction]
	mov   rsi, [rbp + nb410_fshift]
	mov   edx, [rsp + nb410_is3]

	;# accumulate i forces in xmm0, xmm1, xmm2 
	movapd xmm0, [rsp + nb410_fix]
	movapd xmm1, [rsp + nb410_fiy]
	movapd xmm2, [rsp + nb410_fiz]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

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

	;# increment fshift force  
	movsd  xmm3, [rsi + rdx*8]
	movsd  xmm4, [rsi + rdx*8 + 8]
	movsd  xmm5, [rsi + rdx*8 + 16]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [rsi + rdx*8],     xmm3
	movsd  [rsi + rdx*8 + 8], xmm4
	movsd  [rsi + rdx*8 + 16], xmm5

	;# get n from stack
	mov esi, [rsp + nb410_n]
        ;# get group index for i particle 
        mov   rdx, [rbp + nb410_gid]      	;# base of gid[]
        mov   edx, [rdx + rsi*4]		;# ggid=gid[n]

	;# accumulate total potential energy and update it 
	movapd xmm7, [rsp + nb410_vctot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 

	;# add earlier value from mem 
	mov   rax, [rbp + nb410_Vc]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
	;# accumulate total lj energy and update it 
	movapd xmm7, [rsp + nb410_Vvdwtot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
	
	;# add earlier value from mem 
	mov   rax, [rbp + nb410_Vvdw]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
	;# accumulate dVda and update it 
	movapd xmm7, [rsp + nb410_dvdasum]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
	
	mov edx, [rsp + nb410_ii]
	mov rax, [rbp + nb410_dvda]
	addsd xmm7, [rax + rdx*8]
	movsd [rax + rdx*8], xmm7
	
        ;# finish if last 
        mov ecx, [rsp + nb410_nn1]
	;# esi already loaded with n
	inc esi
        sub ecx, esi
        jecxz .nb410_outerend

        ;# not last, iterate outer loop once more!  
        mov [rsp + nb410_n], esi
        jmp .nb410_outer
.nb410_outerend:
        ;# check if more outer neighborlists remain
        mov   ecx, [rsp + nb410_nri]
	;# esi already loaded with n above
        sub   ecx, esi
        jecxz .nb410_end
        ;# non-zero, do one more workunit
        jmp   .nb410_threadloop
.nb410_end:
	mov eax, [rsp + nb410_nouter]
	mov ebx, [rsp + nb410_ninner]
	mov rcx, [rbp + nb410_outeriter]
	mov rdx, [rbp + nb410_inneriter]
	mov [rcx], eax
	mov [rdx], ebx

	add rsp, 552
	femms

	pop rbx
	pop	rbp
	ret









.globl nb_kernel410nf_x86_64_sse2
.globl _nb_kernel410nf_x86_64_sse2
nb_kernel410nf_x86_64_sse2:	
_nb_kernel410nf_x86_64_sse2:	
;#	Room for return address and rbp (16 bytes)
.equiv          nb410nf_fshift,         16
.equiv          nb410nf_gid,            24
.equiv          nb410nf_pos,            32
.equiv          nb410nf_faction,        40
.equiv          nb410nf_charge,         48
.equiv          nb410nf_p_facel,        56
.equiv          nb410nf_argkrf,         64
.equiv          nb410nf_argcrf,         72
.equiv          nb410nf_Vc,             80
.equiv          nb410nf_type,           88
.equiv          nb410nf_p_ntype,        96
.equiv          nb410nf_vdwparam,       104
.equiv          nb410nf_Vvdw,           112
.equiv          nb410nf_p_tabscale,     120
.equiv          nb410nf_VFtab,          128
.equiv          nb410nf_invsqrta,       136
.equiv          nb410nf_dvda,           144
.equiv          nb410nf_p_gbtabscale,   152
.equiv          nb410nf_GBtab,          160
.equiv          nb410nf_p_nthreads,     168
.equiv          nb410nf_count,          176
.equiv          nb410nf_mtx,            184
.equiv          nb410nf_outeriter,      192
.equiv          nb410nf_inneriter,      200
.equiv          nb410nf_work,           208
	;# stack offsets for local variables  
	;# bottom of stack is cache-aligned for sse2 use 
.equiv          nb410nf_ix,             0
.equiv          nb410nf_iy,             16
.equiv          nb410nf_iz,             32
.equiv          nb410nf_iq,             48
.equiv          nb410nf_two,            64
.equiv          nb410nf_gbtsc,          80
.equiv          nb410nf_qq,             96
.equiv          nb410nf_c6,             112
.equiv          nb410nf_c12,            128
.equiv          nb410nf_vctot,          144
.equiv          nb410nf_Vvdwtot,        160
.equiv          nb410nf_half,           176
.equiv          nb410nf_three,          192
.equiv          nb410nf_r,              208
.equiv          nb410nf_isai,           224
.equiv          nb410nf_isaprod,        240
.equiv          nb410nf_gbscale,        256
.equiv          nb410nf_nri,            272
.equiv          nb410nf_iinr,           280
.equiv          nb410nf_jindex,         288
.equiv          nb410nf_jjnr,           296
.equiv          nb410nf_shift,          304
.equiv          nb410nf_shiftvec,       312
.equiv          nb410nf_facel,          320
.equiv          nb410nf_innerjjnr,      328
.equiv          nb410nf_ii,             336
.equiv          nb410nf_is3,            340
.equiv          nb410nf_ii3,            344
.equiv          nb410nf_ntia,           348
.equiv          nb410nf_innerk,         352
.equiv          nb410nf_n,              356
.equiv          nb410nf_nn1,            360
.equiv          nb410nf_ntype,          364
.equiv          nb410nf_nouter,         368
.equiv          nb410nf_ninner,         372
	push rbp
	mov  rbp, rsp
	push rbx

	
	femms
	sub rsp, 392		;# local variable stack space (n*16+8)

	;# zero 32-bit iteration counters
	mov eax, 0
	mov [rsp + nb410nf_nouter], eax
	mov [rsp + nb410nf_ninner], eax

	mov edi, [rdi]
	mov [rsp + nb410nf_nri], edi
	mov [rsp + nb410nf_iinr], rsi
	mov [rsp + nb410nf_jindex], rdx
	mov [rsp + nb410nf_jjnr], rcx
	mov [rsp + nb410nf_shift], r8
	mov [rsp + nb410nf_shiftvec], r9
	mov rdi, [rbp + nb410nf_p_ntype]
	mov edi, [rdi]
	mov [rsp + nb410nf_ntype], edi
	mov rsi, [rbp + nb410nf_p_facel]
	movsd xmm0, [rsi]
	movsd [rsp + nb410nf_facel], xmm0

	mov rbx, [rbp + nb410nf_p_gbtabscale]
	movsd xmm4, [rbx]
	shufpd xmm4, xmm4, 0
	movapd [rsp + nb410nf_gbtsc],  xmm4

	;# create constant floating-point factors on stack
	mov eax, 0x00000000     ;# lower half of double half IEEE (hex)
	mov ebx, 0x3fe00000
	mov [rsp + nb410nf_half], eax
	mov [rsp + nb410nf_half + 4], ebx
	movsd xmm1, [rsp + nb410nf_half]
	shufpd xmm1, xmm1, 0    ;# splat to all elements
	movapd xmm3, xmm1
	addpd  xmm3, xmm3       ;# one
	movapd xmm2, xmm3
	addpd  xmm2, xmm2       ;# two
	addpd  xmm3, xmm2	;# three
	movapd [rsp + nb410nf_half], xmm1
	movapd [rsp + nb410nf_two], xmm2
	movapd [rsp + nb410nf_three], xmm3

.nb410nf_threadloop:
        mov   rsi, [rbp + nb410nf_count]          ;# pointer to sync counter
        mov   eax, [rsi]
.nb410nf_spinlock:
        mov   ebx, eax                          ;# ebx=*count=nn0
        add   ebx, 1                           ;# ebx=nn1=nn0+10
        lock cmpxchg [rsi], ebx                 ;# write nn1 to *counter,
                                                ;# if it hasnt changed.
                                                ;# or reread *counter to eax.
        pause                                   ;# -> better p4 performance
        jnz .nb410nf_spinlock

        ;# if(nn1>nri) nn1=nri
        mov ecx, [rsp + nb410nf_nri]
        mov edx, ecx
        sub ecx, ebx
        cmovle ebx, edx                         ;# if(nn1>nri) nn1=nri
        ;# Cleared the spinlock if we got here.
        ;# eax contains nn0, ebx contains nn1.
        mov [rsp + nb410nf_n], eax
        mov [rsp + nb410nf_nn1], ebx
        sub ebx, eax                            ;# calc number of outer lists
	mov esi, eax				;# copy n to esi
        jg  .nb410nf_outerstart
        jmp .nb410nf_end

.nb410nf_outerstart:
	;# ebx contains number of outer iterations
	add ebx, [rsp + nb410nf_nouter]
	mov [rsp + nb410nf_nouter], ebx

.nb410nf_outer:
	mov   rax, [rsp + nb410nf_shift]      ;# rax = pointer into shift[] 
	mov   ebx, [rax+rsi*4]		;# rbx=shift[n] 
	
	lea   ebx, [ebx + ebx*2]    ;# ebx=3*is 
	mov   [rsp + nb410nf_is3],ebx    	;# store is3 

	mov   rax, [rsp + nb410nf_shiftvec]   ;# rax = base of shiftvec[] 

	movsd xmm0, [rax + rbx*8]
	movsd xmm1, [rax + rbx*8 + 8]
	movsd xmm2, [rax + rbx*8 + 16] 

	mov   rcx, [rsp + nb410nf_iinr]       ;# rcx = pointer into iinr[] 	
	mov   ebx, [rcx+rsi*4]	    ;# ebx =ii 
	mov   [rsp + nb410nf_ii], ebx

	mov   rdx, [rbp + nb410nf_charge]
	movsd xmm3, [rdx + rbx*8]	
	mulsd xmm3, [rsp + nb410nf_facel]
	shufpd xmm3, xmm3, 0

	mov   rdx, [rbp + nb410nf_invsqrta]	;# load invsqrta[ii]
	movsd xmm4, [rdx + rbx*8]
	shufpd xmm4, xmm4, 0

   	mov   rdx, [rbp + nb410nf_type] 
   	mov   edx, [rdx + rbx*4]
   	imul  edx, [rsp + nb410nf_ntype]
   	shl   edx, 1
    mov   [rsp + nb410nf_ntia], edx
	
	lea   ebx, [ebx + ebx*2]	;# ebx = 3*ii=ii3 
	mov   rax, [rbp + nb410nf_pos]    ;# rax = base of pos[]  

	addsd xmm0, [rax + rbx*8]
	addsd xmm1, [rax + rbx*8 + 8]
	addsd xmm2, [rax + rbx*8 + 16]

	movapd [rsp + nb410nf_iq], xmm3
	movapd [rsp + nb410nf_isai], xmm4

	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0

	movapd [rsp + nb410nf_ix], xmm0
	movapd [rsp + nb410nf_iy], xmm1
	movapd [rsp + nb410nf_iz], xmm2

	mov   [rsp + nb410nf_ii3], ebx
	
	;# clear vctot and Vvdwtot
	xorpd xmm4, xmm4
	movapd [rsp + nb410nf_vctot], xmm4
	movapd [rsp + nb410nf_Vvdwtot], xmm4
	
	mov   rax, [rsp + nb410nf_jindex]
	mov   ecx, [rax + rsi*4]	     ;# jindex[n] 
	mov   edx, [rax + rsi*4 + 4]	     ;# jindex[n+1] 
	sub   edx, ecx               ;# number of innerloop atoms 

	mov   rsi, [rbp + nb410nf_pos]
	mov   rdi, [rbp + nb410nf_faction]	
	mov   rax, [rsp + nb410nf_jjnr]
	shl   ecx, 2
	add   rax, rcx
	mov   [rsp + nb410nf_innerjjnr], rax     ;# pointer to jjnr[nj0] 
	mov   ecx, edx
	sub   edx,  2
	add   ecx, [rsp + nb410nf_ninner]
	mov   [rsp + nb410nf_ninner], ecx
	add   edx, 0
	mov   [rsp + nb410nf_innerk], edx    ;# number of innerloop atoms 
	jge   .nb410nf_unroll_loop
	jmp   .nb410nf_checksingle
.nb410nf_unroll_loop:	
	;# twice unrolled innerloop here 
	mov   rdx, [rsp + nb410nf_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]	
	mov   ebx, [rdx + 4]              
	add qword ptr [rsp + nb410nf_innerjjnr],  8 ;# advance pointer (unrolled 2) 

	;# load isaj
	mov rsi, [rbp + nb410nf_invsqrta]
	movlpd xmm2, [rsi + rax*8]
	movhpd xmm2, [rsi + rbx*8]
	mulpd  xmm2, [rsp + nb410nf_isai]
	movapd [rsp + nb410nf_isaprod], xmm2	
	movapd xmm1, xmm2
	mulpd xmm1, [rsp + nb410nf_gbtsc]
	movapd [rsp + nb410nf_gbscale], xmm1
	
	mov rsi, [rbp + nb410nf_charge]    ;# base of charge[] 
	movlpd xmm3, [rsi + rax*8]
	movhpd xmm3, [rsi + rbx*8]

	mulpd xmm2, [rsp + nb410nf_iq]
	mulpd  xmm3, xmm2
	movapd [rsp + nb410nf_qq], xmm3	
	
	movd  mm0, eax		;# use mmx registers as temp storage 
	movd  mm1, ebx
	
	mov rsi, [rbp + nb410nf_type]
	mov eax, [rsi + rax*4]
	mov ebx, [rsi + rbx*4]
	mov rsi, [rbp + nb410nf_vdwparam]
	shl eax, 1
	shl ebx, 1
	mov edi, [rsp + nb410nf_ntia]
	add eax, edi
	add ebx, edi

	movlpd xmm6, [rsi + rax*8]	;# c6a
	movlpd xmm7, [rsi + rbx*8]	;# c6b
	movhpd xmm6, [rsi + rax*8 + 8]	;# c6a c12a 
	movhpd xmm7, [rsi + rbx*8 + 8]	;# c6b c12b 

	movapd xmm4, xmm6
	unpcklpd xmm4, xmm7
	unpckhpd xmm6, xmm7
	
	movd  eax, mm0
	movd  ebx, mm1
	movapd [rsp + nb410nf_c6], xmm4
	movapd [rsp + nb410nf_c12], xmm6
	
	mov rsi, [rbp + nb410nf_pos]       ;# base of pos[] 

	movd  mm2, eax
	movd  mm3, ebx
	lea   eax, [eax + eax*2]     ;# replace jnr with j3 
	lea   ebx, [ebx + ebx*2]	

	;# move two coordinates to xmm0-xmm2 	
	movlpd xmm0, [rsi + rax*8]
	movlpd xmm1, [rsi + rax*8 + 8]
	movlpd xmm2, [rsi + rax*8 + 16]
	movhpd xmm0, [rsi + rbx*8]
	movhpd xmm1, [rsi + rbx*8 + 8]
	movhpd xmm2, [rsi + rbx*8 + 16]		
	
	;# move ix-iz to xmm4-xmm6 
	movapd xmm4, [rsp + nb410nf_ix]
	movapd xmm5, [rsp + nb410nf_iy]
	movapd xmm6, [rsp + nb410nf_iz]

	;# calc dr 
	subpd xmm4, xmm0
	subpd xmm5, xmm1
	subpd xmm6, xmm2

	;# square dr 
	mulpd xmm4,xmm4
	mulpd xmm5,xmm5
	mulpd xmm6,xmm6
	addpd xmm4, xmm5
	addpd xmm4, xmm6
	;# rsq in xmm4 

	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm5, xmm5
	cvtps2pd xmm2, xmm5	;# lu in low xmm2 

	;# lookup seed in xmm2 
	movapd xmm5, xmm2	;# copy of lu 
	mulpd xmm2, xmm2	;# lu*lu 
	movapd xmm1, [rsp + nb410nf_three]
	mulpd xmm2, xmm4	;# rsq*lu*lu 			
	movapd xmm0, [rsp + nb410nf_half]
	subpd xmm1, xmm2	;# 30-rsq*lu*lu 
	mulpd xmm1, xmm5	
	mulpd xmm1, xmm0	;# xmm0=iter1 of rinv (new lu) 

	movapd xmm5, xmm1	;# copy of lu 
	mulpd xmm1, xmm1	;# lu*lu 
	movapd xmm2, [rsp + nb410nf_three]
	mulpd xmm1, xmm4	;# rsq*lu*lu 			
	movapd xmm0, [rsp + nb410nf_half]
	subpd xmm2, xmm1	;# 30-rsq*lu*lu 
	mulpd xmm2, xmm5	
	mulpd xmm0, xmm2	;# xmm0=rinv 
	
	mulpd xmm4, xmm0	;# xmm4=r 
	movapd [rsp + nb410nf_r], xmm4
	mulpd xmm4, [rsp + nb410nf_gbscale]

	cvttpd2pi mm6, xmm4	;# mm6 = lu idx 
	cvtpi2pd xmm5, mm6
	subpd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	
	movd mm0, eax	
	movd mm1, ebx

	mov  rsi, [rbp + nb410nf_GBtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb410nf_qq]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  

	addpd  xmm5, [rsp + nb410nf_vctot]
	movapd [rsp + nb410nf_vctot], xmm5 

	;# L-J 
	movapd xmm4, xmm0
	mulpd  xmm4, xmm0	;# xmm4=rinvsq 

	movapd xmm6, xmm4
	mulpd  xmm6, xmm4
	
	mulpd  xmm6, xmm4	;# xmm6=rinvsix 
	movapd xmm4, xmm6
	mulpd  xmm4, xmm4	;# xmm4=rinvtwelve 
	mulpd  xmm6, [rsp + nb410nf_c6]
	mulpd  xmm4, [rsp + nb410nf_c12]
	movapd xmm7, [rsp + nb410nf_Vvdwtot]
	addpd  xmm7, xmm4
	subpd  xmm7, xmm6
	movapd [rsp + nb410nf_Vvdwtot], xmm7

	;# should we do one more iteration? 
	sub dword ptr [rsp + nb410nf_innerk],  2
	jl    .nb410nf_checksingle
	jmp   .nb410nf_unroll_loop
.nb410nf_checksingle:
	mov   edx, [rsp + nb410nf_innerk]
	and   edx, 1
	jnz    .nb410nf_dosingle
	jmp    .nb410nf_updateouterdata
.nb410nf_dosingle:
	mov rsi, [rbp + nb410nf_charge]
	mov rdx, [rbp + nb410nf_invsqrta]
	mov rdi, [rbp + nb410nf_pos]
	mov   rcx, [rsp + nb410nf_innerjjnr]
	mov   eax, [rcx]
	
	xorpd  xmm6, xmm6
	movapd xmm7, xmm6
	movsd  xmm7, [rdx + rax*8]
	movlpd xmm6, [rsi + rax*8]	;# xmm6(0) has the charge
	mulsd  xmm7, [rsp + nb410nf_isai]
	movapd [rsp + nb410nf_isaprod], xmm7
	movapd xmm1, xmm7
	mulpd xmm1, [rsp + nb410nf_gbtsc]
	movapd [rsp + nb410nf_gbscale], xmm1
	
	mulsd  xmm7, [rsp + nb410nf_iq]
	mulsd  xmm6, xmm7
	movapd [rsp + nb410nf_qq], xmm6
	
	movd  mm0, eax		;# use mmx registers as temp storage 
	mov rsi, [rbp + nb410nf_type]
	mov eax, [rsi + rax*4]
	mov rsi, [rbp + nb410nf_vdwparam]
	shl eax, 1
	mov edi, [rsp + nb410nf_ntia]
	add eax, edi

	movlpd xmm6, [rsi + rax*8]	;# c6a
	movhpd xmm6, [rsi + rax*8 + 8]	;# c6a c12a 

	xorpd xmm7, xmm7
	movapd xmm4, xmm6
	unpcklpd xmm4, xmm7
	unpckhpd xmm6, xmm7
	
	movd  eax, mm0
	movapd [rsp + nb410nf_c6], xmm4
	movapd [rsp + nb410nf_c12], xmm6
	
	mov rsi, [rbp + nb410nf_pos]       ;# base of pos[]
	
	movd  mm2, eax
	lea   eax, [eax + eax*2]     ;# replace jnr with j3 

	;# move coordinates to xmm0-xmm2 	
	movlpd xmm0, [rsi + rax*8]
	movlpd xmm1, [rsi + rax*8 + 8]
	movlpd xmm2, [rsi + rax*8 + 16]
	
	;# move ix-iz to xmm4-xmm6 
	movapd xmm4, [rsp + nb410nf_ix]
	movapd xmm5, [rsp + nb410nf_iy]
	movapd xmm6, [rsp + nb410nf_iz]

	;# calc dr 
	subsd xmm4, xmm0
	subsd xmm5, xmm1
	subsd xmm6, xmm2

	;# square it 
	mulsd xmm4,xmm4
	mulsd xmm5,xmm5
	mulsd xmm6,xmm6
	addsd xmm4, xmm5
	addsd xmm4, xmm6
	;# rsq in xmm4 

	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm5, xmm5
	cvtss2sd xmm2, xmm5	;# lu in low xmm2 

	;# lookup seed in xmm2 
	movapd xmm5, xmm2	;# copy of lu 
	mulsd xmm2, xmm2	;# lu*lu 
	movapd xmm1, [rsp + nb410nf_three]
	mulsd xmm2, xmm4	;# rsq*lu*lu 			
	movapd xmm0, [rsp + nb410nf_half]
	subsd xmm1, xmm2	;# 30-rsq*lu*lu 
	mulsd xmm1, xmm5	
	mulsd xmm1, xmm0	;# xmm0=iter1 of rinv (new lu) 

	movapd xmm5, xmm1	;# copy of lu 
	mulsd xmm1, xmm1	;# lu*lu 
	movapd xmm2, [rsp + nb410nf_three]
	mulsd xmm1, xmm4	;# rsq*lu*lu 			
	movapd xmm0, [rsp + nb410nf_half]
	subsd xmm2, xmm1	;# 30-rsq*lu*lu 
	mulsd xmm2, xmm5	
	mulsd xmm0, xmm2	;# xmm0=rinv 
	
	mulsd xmm4, xmm0	;# xmm4=r 
	movapd [rsp + nb410nf_r], xmm4
	mulsd xmm4, [rsp + nb410nf_gbscale]

	movd mm0, eax	
	cvttsd2si eax, xmm4	;# mm6 = lu idx 
	cvtsi2sd xmm5, eax
	subsd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	
	mov  rsi, [rbp + nb410nf_GBtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb410nf_qq]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  

	addsd  xmm5, [rsp + nb410nf_vctot]
	movsd [rsp + nb410nf_vctot], xmm5 

	;# L-J 
	movapd xmm4, xmm0
	mulsd  xmm4, xmm0	;# xmm4=rinvsq 


	movapd xmm6, xmm4
	mulsd  xmm6, xmm4

	mulsd  xmm6, xmm4	;# xmm6=rinvsix 
	movapd xmm4, xmm6
	mulsd  xmm4, xmm4	;# xmm4=rinvtwelve 
	mulsd  xmm6, [rsp + nb410nf_c6]
	mulsd  xmm4, [rsp + nb410nf_c12]
	movapd xmm7, [rsp + nb410nf_Vvdwtot]
	addsd  xmm7, xmm4
	subsd  xmm7, xmm6
	movlpd [rsp + nb410nf_Vvdwtot], xmm7

.nb410nf_updateouterdata:
	mov   ecx, [rsp + nb410nf_ii3]
	mov   edx, [rsp + nb410nf_is3]

	;# get n from stack
	mov esi, [rsp + nb410nf_n]
        ;# get group index for i particle 
        mov   rdx, [rbp + nb410nf_gid]      	;# base of gid[]
        mov   edx, [rdx + rsi*4]		;# ggid=gid[n]

	;# accumulate total potential energy and update it 
	movapd xmm7, [rsp + nb410nf_vctot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 

	;# add earlier value from mem 
	mov   rax, [rbp + nb410nf_Vc]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
	;# accumulate total lj energy and update it 
	movapd xmm7, [rsp + nb410nf_Vvdwtot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
	
	;# add earlier value from mem 
	mov   rax, [rbp + nb410nf_Vvdw]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
        ;# finish if last 
        mov ecx, [rsp + nb410nf_nn1]
	;# esi already loaded with n
	inc esi
        sub ecx, esi
        jecxz .nb410nf_outerend

        ;# not last, iterate outer loop once more!  
        mov [rsp + nb410nf_n], esi
        jmp .nb410nf_outer
.nb410nf_outerend:
        ;# check if more outer neighborlists remain
        mov   ecx, [rsp + nb410nf_nri]
	;# esi already loaded with n above
        sub   ecx, esi
        jecxz .nb410nf_end
        ;# non-zero, do one more workunit
        jmp   .nb410nf_threadloop
.nb410nf_end:
	mov eax, [rsp + nb410nf_nouter]
	mov ebx, [rsp + nb410nf_ninner]
	mov rcx, [rbp + nb410nf_outeriter]
	mov rdx, [rbp + nb410nf_inneriter]
	mov [rcx], eax
	mov [rdx], ebx

	add rsp, 392
	femms

	pop rbx
	pop	rbp
	ret


