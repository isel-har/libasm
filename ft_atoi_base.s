extern strlen

section .text
    global _ft_atoi_base


_duplicate:
	xor rax, rax
_main_loop:

	cmp rax, rsi
	jge __ret_0

	mov rcx, rax
	inc rcx

_sec_loop:

	cmp rcx, rsi
	jge _end_sec_loop


	mov dl, byte [rdi + rax]
	cmp byte [rdi + rcx], dl
	je __ret_1

	inc rcx

	jmp _sec_loop

_end_sec_loop:
	inc rax
	jmp _main_loop

__ret_1:
	mov eax, 1
	ret


__ret_0:
	mov eax, 0
	ret


_valid_base:

	call strlen

	cmp rax, 2
	jl	_ret_0

	mov rsi, rax
	call _duplicate

	cmp eax, 0
	jne	_ret_0


	mov rax, 0

__loop:

	mov dl, byte [rdi + rax]
	cmp dl, 0
	je _ret_1

	cmp dl, 9
    cmp dl, ' '
	je _ret_0

    cmp dl, '+'
    je _ret_0

    cmp dl, '-'
    je _ret_0
    cmp dl, 13
    jle _ret_0


	inc rax
	jmp __loop


_ret_1:
	mov eax, 1
	ret

_ret_0:
	mov eax, 0
	ret



;============================================

; _char_position:
; 	xor rcx, rcx
; 	xor eax, eax

; __loop_:

; 	cmp qword [rdi + rcx], 0
; 	je __end_

; 	cmp byte [rdi + rcx], dil
; 	je __pos

; 	inc eax
; 	jmp __loop_

; __pos:
; 	ret

; __end_:
; 	mov eax, -1
; 	ret


_ft_atoi_base:

	; push rbp
	; mov rbp, rsp
	; sub rsp, 48

	; mov qword [rbp - 8], rdi
	; mov qword [rbp - 16], rsi

	call _valid_base
	cmp eax, 0
	; xor rax, rax
	je .return_zero
	; ret
	call strlen
	cmp rax, 2
	jl .return_zero

	mov rax, 1

	; mov eax, dword rax
	; mov eax, dword rax
	; jmp .return_
; 	mov qword [rbp - 24], rax; base length
; 	mov qword [rbp - 32], 0 ; result
; 	mov dword [rbp - 40], 1 ; sign
; 	; mov dword [rbp - 44],

; 	xor rax, rax

; .skip_spaces:

; 	mov dl, byte [rdi + rax]
; 	cmp dl, 32
; 	jne _update_sign
; 	cmp dl, 9
; 	jnge _update_sign
; 	cmp dl, 13
; 	jnle _update_sign


; 	inc rax
; 	jmp .skip_spaces


; _update_sign:

; 	mov dl, [rdi + rax]
; 	cmp dl, 45
; 	jne _convert_dec
; 	cmp dl, 43
; 	jne _convert_dec

; 	cmp dl, 45

; 	mov eax, dword [rbp - 40]
; 	neg eax
; 	mov dword [rbp - 40], eax

; 	inc rax
; 	jmp _update_sign


; _convert_dec:

; 	mov dil, byte [rdi + rax]
; 	call _char_position

; 	mov dword [rbp - 44], eax
	
; _convert_loop:

; 	mov dl, byte [rdi + rax]
; 	cmp dl, 0
; 	je _return
; 	cmp dl, -1
; 	je _return


; 	mov rbx, dword [rbp - 32]
; 	mul rbx, qword [rbp - 24]

; 	add rbx, eax
; 	inc rax

; 	call _char_position

; 	jmp _convert_loop

; _return:
; 	mov eax, qword rbx
; 	mul eax, dword [rbp - 40]
; 	ret




.return_zero:
	; pop rbp
	; add rsp, 48
	xor rax, rax
	ret