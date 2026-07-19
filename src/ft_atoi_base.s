extern ft_strlen

section .text
    global ft_atoi_base


_duplicate:
    xor rax, rax

first_loop_dp:

    mov dl, byte [rdi + rax]
    cmp dl, 0
    je ret_false_v

    mov rcx, rax
    inc rcx

second_loop_dp:

    cmp byte [rdi + rcx], 0
    je ___inc_dp

    cmp dl, byte [rdi + rcx]
    je ret_true_v


    inc rcx
    jmp second_loop_dp


___inc_dp:
    inc rax
    jmp first_loop_dp




is_valid_base:

    ; call strlen to get length of the base
    call ft_strlen ; rax value expected with base length
    mov qword [rsi], rax ; change the value pointed by rsi with rax value

    cmp rax, 2; compare rax with 2
    jl ret_false_v ; if less return false


    call _duplicate ; we can call _duplicate rdi still not changed
    cmp al, 1 ; if returns 1 means duplicates found
    je ret_false_v ; then return false (not valid)


    xor rax, rax ; initialize rax with zero using xor method
    ; mov rdi, qword [rbp - 8] ;
    ;still can use rdi cause not changed at all
_loop_ivb:

    mov dl, byte [rdi + rax]
    cmp dl, 0
    je ret_true_v

    cmp dl, 32
    je ret_false_v
    cmp dl, 43
    je ret_false_v
    cmp dl, 45
    je ret_false_v
    ; one of these cmps if equal to given value jump to return false instruction address!


    cmp dl, 9 ; compare with 9
    jge in_range_v ; if greater or equal jump to in range
    jmp _inc_v ; if not jmp to inc

in_range_v:

    cmp dl, 13 ; compare with max range which is 13
    jle ret_false_v ; if still less or equal means the character in white spaces range the return false
    ;if not complete the instruction below

_inc_v:
    inc rax ; inc rax register
    jmp _loop_ivb ; then jmp to loop instruction


; those be reached only if one of condition is true
ret_false_v:

    xor al, al
    ret

ret_true_v:

    mov al, 1
    ret




;_________________________________________________________________________

digit_position:
    ; expectes dil, rsi as args
    xor rax, rax
_dp_loop:
    mov dl, byte [rsi + rax]
    cmp dl, 0
    je _dp_end

    cmp dil, dl
    je __ret_pos


    inc rax
    jmp _dp_loop


__ret_pos:
    ret

_dp_end:
    mov rax, -1
    ret


ft_atoi_base:

    ;using stack frame
    ; initialize the frame

    push rbp
    mov rbp, rsp
    sub rsp, 58 ; reserve 50 bytes for all local variable/args
;_________________________________________________________________________

    ; arguments
    mov qword [rbp - 8], rdi ; push first arg to  first 8 bytes
    mov qword [rbp - 16], rsi ; push second arg to second 8 bytes


    ;64-bits variables
    mov qword [rbp - 24], 0 ; reserve 8 bytes for the result accumlation
    mov qword [rbp - 32], 0; reserve 8 bytes to save the size of the base
    mov qword [rbp - 40], 0; reserve 8 bytes for the converted digit
    mov qword [rbp - 48], 0 ; reserve 8 bytes for starting postion before convertion!

    ;8-bits variables
    mov byte [rbp - 56], 1; reserve 1 byte for the sign hold only 1 or -1


    cmp rdi, 0
    je __return_0
    cmp rsi, 0
    je __return_0


    mov r12, qword [rbp - 8]

    lea rsi, qword [rbp - 32]; copy the address of size memory bloc
    mov rdi, qword [rbp - 16] ; update rdi again with saved adderss in stack


    call is_valid_base ; expects rdi as the base string and rsi for the size pointer!
    cmp al, 0   ; return boolean with al register 
    je __return_0 ; if equal to zero means not valid jmp to return 0



    ; update rdi and rsi with their real addresses!
    ; mov rdi, qword [rbp - 8] ; hold the first arg to rdi againe
    mov rsi, qword [rbp - 16] ; same with second arg

    xor rax, rax ; initialize rax with zero

;starts skip spaces
skip_spaces:

    mov dl, byte [r12 + rax]; copy the byte
    cmp dl, 32 ; compare with ' '
    je _inc_ssp ; if equal just go inc the rax and jmp again

    ; otherwise
    cmp dl, 9 ;check the first white space
    jge _in_range ; if greater or equal check if still in range

_in_range:
    cmp dl, 13 ; compare with last white space character
    jnle __end_skip_spaces ; if not less or equal then means the current byte not within the range
    ; if less or equal then complete the instruction below


_inc_ssp:
    inc rax
    jmp skip_spaces


__end_skip_spaces:
;end skipping spaces
;starts update sign!


update_sign:

    mov dl, byte [r12 + rax]
    cmp dl, 45
    je _update
    cmp dl, 43
    je ___inc
    jmp _end_update_sign

_update:
    mov cl, byte [rbp - 56]   ; use cl instead of al
    neg cl
    mov byte [rbp - 56], cl

___inc:
    inc rax
    jmp update_sign

_end_update_sign:

    ; before convert the current reached character
    ; need to save rax
    ; and also save the current byte/character to compare
    ; and make rsi the base

    ; mov qword [rbp - 24], 0 ; reserve 8 bytes for the result accumlation
    ; mov qword [rbp - 32], 0; reserve 8 bytes to save the size of the base
    ; mov qword [rbp - 40], 0; reserve 8 bytes for the converted digit
    ; mov qword [rbp - 48], 0 ; reserve 8 bytes for starting postion before convertion!

 ; save the 

    mov qword [rbp - 48], rax; first save the rax, the current position reached
    mov dil, byte [r12 + rax] ; copy the reached byte to dil register to compare


    mov rsi, qword [rbp - 16] ; make rsi have the address of the base again
    call digit_position ; call the function and expect the rax register updated with the digit position
    mov qword [rbp - 40], rax


_convert_loop:

    mov rax, qword [rbp - 48] ; update rax with saved index/pos

    mov dl, byte [r12 + rax] ; copy the current character/byte
    cmp dl, 0 ; compare with zero
    je __end_convert ; if equal to zero end the converstion

    cmp qword [rbp - 40], -1      ; check the saved digit using stack location directly with -1
    je __end_convert ; if equal end the converstion cause the digit not within the given base!

    mov rcx, qword [rbp - 24] ; copy the result to rcx register
    mov rdx , qword [rbp - 32]

    imul rcx, rdx
    add rcx, qword [rbp - 40]
    mov qword [rbp - 24], rcx


    inc rax

    mov qword [rbp - 48], rax ; save the updated rax


    mov dil, byte [r12 + rax]
    mov rsi, qword [rbp - 16]
    call digit_position

    mov qword [rbp - 40], rax
    jmp _convert_loop

__end_convert:

    mov rax, qword [rbp - 24]
    mov cl, byte [rbp - 56]
    cmp cl, -1
    jne __return

    neg rax

__return:
    add rsp, 58
    pop rbp

    ret

__return_0:
    add rsp, 58
    pop rbp

    xor eax, eax
    ret