section .text
    global _ft_list_sort

_ft_list_sort:

    ;rdi first arg, rsi second arg

    push rbp ; save the base pointer
    mov rbp, rsp ; copy stack pointer value to base pointer
    sub rsp, 40 ; create the gap/stack frame with variables size

    cmp rdi, 0
    je _end_loop
    
    cmp [rdi], 0
    je _end_loop

    cmp rsi, 0
    je _end_loop


    mov qword [rbp - 8], rdi ; save first parameter in stack
    mov qword [rbp - 16], rsi ; add second parameter in stack

    mov rax, qword [rbp - 8]
    mov rax, qword [rax]

    mov qword [rbp - 32], rax

_main_loop:

    mov rax, qword [rbp - 32]; copy the current value to rax register
    cmp qword [rax + 8], 0 ; fetch current + 8 which is the offest for next pointer and compare with null
    je _end_loop ; if equalt end the loop

    ;prepare parameters before function call

    mov rcx, qword [rax + 8]
    mov rdi, qword [rcx]

    mov rsi, qword [rax]

    mov rcx, qword [rbp - 16]
    call rcx

    cmp eax, 0
    jge _mov_next

_swap:
    ; data_store = current->data;
	; current->data = current->next->data;
	; current->next->data = data_store;
	; current = *begin_list;


    mov rax, qword [rbp - 32]
    mov rax, [rax]
    mov qword [rbp - 24], rax


    ; current->next->data
    mov rax, qword [rbp - 32]
    mov rcx, [rax + 8]
    mov rax, [rcx]
    ; current->data
    mov rcx, qword [rbp - 32]
    mov [rcx], rax ; =


    ; current->next->data = data_store;

    mov rax, qword [rbp - 32]
    mov rcx, [rax + 8]

    mov rdx, qword [rbp - 24]
    mov [rcx], rdx


    mov rax, qword [rbp - 8]
    mov rcx, [rax]

    mov qword [rbp - 32], rcx

    jmp _main_loop


_mov_next:

    mov rax, qword [rbp - 32]
    mov rax, qword [rax + 8]
    mov qword [rbp - 32], rax

    jmp _main_loop


_end_loop:
    ; release the stack frame and return
	add	rsp, 40
    pop rbp
    ret
