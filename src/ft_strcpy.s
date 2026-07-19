section .text
    global ft_strcpy


ft_strcpy:
    ;1-arg:rdi, 2-arg:rsi
    xor rax, rax ; initialize rax to zero with xor operation as optimized convention

_start_loop:

    mov dl, byte [rsi + rax]      ; fetch and copy byte the current byte to dl register (general purpose register for data)
    cmp dl, 0                ; check for null terminator
    je _end_loop              ; if the current byte is null jump to end ins

    mov  [rdi + rax], dl      ; copy the byte to dest at the same position of the source

    inc rax                  ; inc rax register
    jmp _start_loop           ; jump back to start_loop ins


_end_loop:
    mov byte [rdi + rax], 0  ; copy the null terminator character as 1 byte

    mov rax, rdi             ; copy rdi which is the dest address to rax (register used for return value)
    ret                      ; then return rax 
