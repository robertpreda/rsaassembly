.data
.balign 4
    lr_bu: .word 0

.global main
.func main

_add:
    add r0, r0, r1
    ldr r2, =lr_bu
    ldr lr, [r2]
    bx lr

gcd:
    _gcd_loop:
        cmp r0, r1
        beq end
        bgt sub_a
        sub r1, r0
        b _gcd_loop
        sub_a: sub r0, r1
        b _gcd_loop
    end:

        bx lr

modulus:
    mov r2, r0
    _loop:
        cmp r2, #0
        blt _end_loop
        sub r2, r2, r1
        cmp r2, #0
        blt _loop
        mov r0, r2
        b _loop
        _end_loop:
            bx lr


main:

    mov r0, #6
    mov r1, #3
    bl modulus
    mov r1, r0
    ldr r0, =fmt
    bl printf

exit:
    mov r7, #1
    swi 0

fmt: .asciz "%d %d\n"

