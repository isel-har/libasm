section .text
    global ft_list_remove_if

ft_list_remove_if:

_1:

    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov qword [rbp - 8], rdi
    mov qword [rbp - 16], rsi
    mov qword [rbp - 24], rdx
    mov qword [rbp - 32], rcx


    mov rax, qword [rbp - 8]
    cmp qword rax, 0
    je _end
    cmp qword [rax], 0
    je _end

_2:
    mov rax, qword [rbp - 8]
    mov rax, [rax]
    mov rdi, [rax]

    mov rsi, [rbp - 16]
    mov rcx, qword [rbp - 24]
    call rcx

    cmp eax, 0
    jne _3

_4: ; if equal here!

    mov rax, qword [rbp - 8]
    mov rax, qword [rax]
    mov qword [rbp - 40], rax


    ; *begin_list = (*begin_list)->next;
    mov rax, qword [rbp - 8]
    mov rax, [rax]
    mov rax, qword [rax + 8]
    ; now rax holds pointer that points to next node!

    mov rcx, qword [rbp - 8] ; 
    mov qword [rcx], rax ; fetch the original pointer againe
    mov rdi, qword [rbp - 40]
    mov rax, qword [rbp - 32]


    call rax

    mov	rdi, qword  [rbp - 8]
	mov	rsi, qword  [rbp - 16]
	mov	rdx, qword  [rbp - 24]
	mov	rcx, qword  [rbp - 32]

	call	ft_list_remove_if
	jmp	_end

_3:

    mov rax, qword [rbp - 8]
    mov rax, qword [rax]
    add rax, 8
    mov rdi, rax

    mov	rsi, qword  [rbp - 16] ; prepare the arguments
	mov	rdx, qword  [rbp - 24]
	mov	rcx, qword  [rbp - 32]

    call ft_list_remove_if

_end:
    add rsp, 48
    pop rbp
    ret
