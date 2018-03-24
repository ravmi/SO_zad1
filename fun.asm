; popraw stale
; sprawdz czy te co miealy byc nieruszone sa nieruszone
; do i have to fix the stack
; sprawdz jak ze zmiennymi

section .bss ;unitialized data
fd_in:             resd 1 ;file descripor of opened file
buf:               resb chunk_size; the buffor used to hold chunks read from file
received_size      resd 1 ;how much did read read
section .rodata ;read only data
set_size:         equ 256
chunk_size:       equ 4096
section .data ;initalized data
zero_occured:     db 0
should_be_counter: dd 0
current_counter:  dd 0
openflags:        dd 0        ; means read_only
set:              times set_size db 0 ; what does the set consits of, boolean
occurences:       times set_size db 0 ; after first 0 we use this array to check repetitions

section .text
    global _start

prog_exit_ok:
    mov rax, 60  ; syscall code for sys_exit
    xor rdi, rdi ; zeroing exit code
    syscall

prog_exit_fail:
    mov rax, 60 ; syscall code for sys_exit
    mov rdi, 1  ; 1 as exit code (error occured)
    syscall

read_to_buf:
    mov rax, 0       ; syscall for read
    mov rdi, [fd_in] ; file descriptor as argument
    mov rsi, buf     ; buffor
    mov rdx, chunk_size       ; length
    syscall
    ret

close_file:
    mov rax, 3 ;close
    mov rdi, [fd_in]
    syscall
    ret

clean_occurences:
    mov [current_counter], 0
    mov rax, 0
    clean_loop:
        mov [occurences + rax], 0
        inc rax
        cmp rax, set_size
        jne clean_loop

_start:
  ;rbx, r12-r15
    mov rax, [rsp]     ;
    cmp rax, 2         ; comparing 
    jne prog_exit_fail ; if number of arguments is not equal 2, the exit with 1
    mov rbx, [rsp + 16] ; skipping path, first cli argument is there

    mov rax, 2 ;syscall for open
    mov rdi, rbx ;rdi holds filename, we can use it to call red anow
    mov rsi, [openflags] ;flags
    mov rdx, 0777 ;mode
    syscall

    mov [fd_in], rax ;open returned file descriptor

    read_chunks_no_zero_loop: ; we read from the file here, zero did not occur yet
        call read_to_buf    ; rax keeps number of read bytes
        mov r12, rax         ; r12 - number of byts
        cmp r12, -1         ; error?
        je read_done_fail ; if number of arguments is not equal 2, the exit with 1
        cmp r12, 0          ; end of the file?
        je read_done_fail         ; leave the loop and end the program

        mov r11, 0
        process_chunk_no_zero_loop:      ;r12 hold number of cycles, r11 the iterator
            cmp r11, r12
            je read_chunks_no_zero_loop   ;iterator reached the limit, we have to read a new chunk of data
            ;code here, rbx is counter (from 0), rcx is loop limit - don't use them!!!
            ; [buf + rbx] is current element
            mov r13, [buf + r11] ; the value in this iteration is in rdx := r13
            inc r11                ;increment loop counter

            cmp val, 0
            je val_is_zero
            cmp [set + val], 1
            je val_present:

            val_not_present: ; otherwise
                mov [buf + r11], 11 ; possible error
                inc [should_be_counter]
                jmp process_chunk_no_zero_loop ; continue the innter loop if it's not
            val_is_zero:
                mov [zero_occured], 1
                jmp process_chunk_zero_occured_loop
            val_present:
                read_done_fail

    read_chunks_zero_occured_loop: ; we read from the file here, zero did not occur yet
        call read_to_buf    ; rax keeps number of read bytes
        mov r12, rax         ; r12 - number of byts
        cmp r12, -1         ; error?
        je read_done_fail ; if number of arguments is not equal 2, the exit with 1
        cmp r12, 0          ; end of the file?
        je read_done_ok         ; leave the loop and end the program

        mov r11, 0
        process_chunk_zero_occured_loop:      ;r12 hold number of cycles, r11 the iterator
            cmp r11, r12
            je read_chunks_zero_occured_loop   ;iterator reached the limit, we have to read a new chunk of data

            ;code here, rbx is counter (from 0), rcx is loop limit - don't use them!!!
            ; [buf + rbx] is current element

            mov r13, [buf + r11] ; the value in this iteration is in rdx := r13
            inc r11                ;increment loop counter

            cmp r13, 0
            je val_is_zero_2
            ;otherwise

            val_not_zero_2: ;otherwise
                cmp [current_counter], [should_be_counter]
                jne read_done_fail
                ;othwerise
                call clean_occurences
                jmp process_chunk_zero_occured_loop
            val_is_zero_2:
                cmp [set + r13], 0
                je read_done_fail
                cmp [occurences + r13], 1
                je read_done_fail
                ;othwerise
                mov [occurences + val], 1
                inc [current_counter]
                jmp process_chunk_zero_occured_loop ; continue the innter loop if it's not

    read_done_ok:
        call close_file
        call prog_exit_ok

    read_done_fail:
        call close_file
        call prog_exit_fail

