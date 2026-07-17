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

; .char_position:

; 	xor rcx, rcx

; .cp_loop:

; 	mov dl, byte [rdi + rcx]
; 	cmp dl, 0
; 	je .cp_end

; 	cmp dl, dil
; 	je .return_pos

; 	inc rcx
; 	jmp .cp_loop

; .cp_end:
; 	mov rcx, -1
; 	ret

; .return_pos:
; 	ret


_ft_atoi_base:

	;initialize stack frame with 48 bytes
	push rbp
	mov rbp, rsp
	sub rsp, 48

	mov qword [rbp - 8], rdi ; first arg
	mov qword [rbp - 16], rsi ; second arg

	mov qword [rbp - 24], 0; result
	mov qword [rbp - 32], 1 ; sign


	mov rdi, rsi
	call _valid_base
	cmp eax, 0
	je return_

	call strlen
	mov qword [rbp - 36], rax
	xor rax, rax

	mov rdi, qword [rbp - 8]

.skip_spaces:

	mov dl, byte [rdi + rax]

	cmp dl, 32
	jne _update_sign
	; cmp dl, 9
	; jnge .update_sign
	; cmp dl, 13
	; jnle .update_sign


	inc rax
	jmp .skip_spaces
	; mov eax, dword [rbp - 32]

_update_sign:

	mov dl, byte [rdi + rax]

	cmp dl, 45
	jne _check_plus

_check_sign:
	cmp dl, 45
	je neg_

_inc:
	inc rax
	jmp _update_sign

neg_:

	mov rbx, qword [rbp - 32]
	neg rbx
	mov qword [rbp - 32], rbx
	jmp _inc


_check_plus:
	cmp dl, 43
	jne _end_skip
	jmp _inc




_end_skip:
	jmp return_

; 	mov dil, byte [rdi + rax]
; 	call char_position
; 	; mov qword [rbp - 24], rcx

; .convert_loop:

; 	mov dl, byte [rdi + rax]

; 	cmp dl, 0
; 	je .convert_end
; 	cmp dl, -1
; 	je .convert_end

; 	mov rdx, qword [rbp - 20]
; 	mul rdx, qword [rbp - 8]
; 	add rdx, rcx

; 	inc rax

; 	mov dil, byte [rdi + rax]
; 	call char_position

; 	jmp .convert_loop

; .convert_end:

; 	mov eax, dword [rbp - 16]
; 	mov ebx, dword [rbp - 20]
; 	mul eax, ebx

return_:
	add rsp, 48
	pop rbp
	ret
