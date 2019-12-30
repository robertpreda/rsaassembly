.data
    .balign 4
        p: .word 0
    .balign 4
        q: .word 0
    .balign 4
        n: .word 0
    .balign 4
        e: .word 0
    .balign 4
        d: .word 0
    .balign 4
        phi: .word 0 
    .balign 4
        lr_bu: .word 0
    .balign 4
        lr_bu_2: .word 0


.global main
.func main

mod:

    _loop:
        cmp r2, #0
        blt _end_loop
        sub r2, r2, r1
        cmp r2, #0
        blt _loop
        mov r0, r2
        b _loop
        _end_loop:
            mov r4,r0
            ldr r0, =mod_func_leave
            bl printf
            mov r0, r4

            ldr r10, addr_lr_bu
            ldr lr, [r10]
            bx lr

get_d:
    
    ldr r3, addr_e
    ldr r3, [r3]

    ldr r4, addr_phi
    ldr r4, [r4]

    mov r5, #1



    @ r3 = e, r4 = phi
    d_loop:
        ldr r0, =string_fmt
        mov r1, r5
        mov r6, r5
        bl printf
        mov r5, r6
        mul r0, r3, r5
        mov r1, r4
        bl mod

        cmp r0, #1
        beq done_d
        add r5, r5, #1
        b d_loop

        
    done_d:
        ldr r6, addr_d
        str r5, [r6]
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

get_e:
    

    mov r5, #2 @ r5 = iterator

    _e_loop:

        ldr r3, addr_phi
        ldr r3, [r3] @ r3 = phi

        ldr r4, addr_n
        ldr r4, [r4] @r4 = n

        cmp r5, r3
        beq end_e
        mov r0, r3
        mov r1, r5
   
        bl gcd
        mov r6, r0 @ r6 = gcd(i, phi)

        mov r0, r4
        mov r1, r5
        bl gcd
        mov r1, r0
        mov r7, r1

       
        mov r1, r6
        mov r2, r7

        cmp r6, #1
        bne incr
        cmp r7, #1
        bne incr
        b end_e
        incr:
            add r5, r5, #1
            b _e_loop
    end_e:
        ldr r9, addr_e
        str r5, [r9]

        b store_e
        bx lr

main:

    ldr r0, =string_welcome
    bl printf

    @ input of p
    ldr r0, =string_fmt
    ldr r1, addr_p

    bl scanf


    @ print value of p
    ldr r0, =string_p  @ p = %d
    ldr r1, addr_p
    ldr r1, [r1]
    bl printf @ calls printf(r0, r1)
    

    @  input q
    ldr r0, =string_fmt
    ldr r1, addr_q
    bl scanf @ calls scanf(r0, r1), returns the value read through r1s

    @ print value of q
    ldr r0, =string_q
    ldr r1, addr_q
    ldr r1, [r1]
    bl printf

    @ calculate modulus
    ldr r1, addr_p
    ldr r1, [r1]

    ldr r2, addr_q
    ldr r2, [r2]

    mul r3, r1, r2
    mov r9, r3

    ldr r0, =string_mul_fmt
    bl printf

    @ store modulus
    ldr r4, addr_n
    str r9, [r4]

    @ print modulus
    ldr r0, =string_modulus
    ldr r1, addr_n
    ldr r1, [r1]
    bl printf

    @ get phi
    @ getting p and q into regs
    ldr r3, addr_p
    ldr r3, [r3]

    ldr r4, addr_q
    ldr r4, [r4]

    @ calculating phi (totient)
    ldr r3, addr_p
    ldr r3, [r3]
    sub r3, r3, #1

    ldr r4, addr_q
    ldr r4, [r4]
    sub r4, r4, #1
    mul r6, r3, r4
    ldr r5, =phi
    str r6, [r5]

    ldr r0, =string_phi
    ldr r1, addr_phi
    ldr r1, [r1]
    bl printf

    ldr r7, addr_lr_bu
    str lr, [r7]
    bl get_e
    mov r4, r0

    store_e: 

    @ print e
    ldr r0, =string_e
    ldr r1, addr_e
    ldr r1, [r1]
    bl printf

    ldr r7, addr_lr_bu
    str lr, [r7]
    bl get_d

    @ print d
    ldr r0, =string_d
    ldr r1, addr_d
    ldr r1, [r1]
    bl printf


_exit:
    mov r7, #1
    swi 0


addr_p :   .word p
addr_q :   .word q
addr_n :   .word n
addr_e :   .word e
addr_d :   .word d
addr_phi:  .word phi
addr_lr_bu: .word lr_bu
addr_lr_bu_2: .word lr_bu_2

done: .asciz "Done with e\n"
shit: .asciz "shit: %d\n"
string_welcome: .asciz "Rivest-Shamir-Adleman: \n"
string_modulus: .asciz "The modulus is: %d\n"
string_check_p_q: .asciz "Hue hue: %d %d\n"
string_p: .asciz "p = %d\n"
string_q: .asciz "q = %d\n"
string_phi: .asciz "phi = %d\n"
string_e: .asciz "e = %d\n"
string_d: .asciz "d = %d\n"
string_shit_2: .asciz "shit again cacaia: %d %d\n"
string_waiting: .asciz "Calculating e...\n"
string_fututi: .asciz "De ce pizda ma-tii nu vrei sa mergi? r0 = %d, r1 = %d\n"
string_fututi_2: .asciz "TEST IN PULA MEA? r0 = %d, r1 = %d\n"
string_gcd: .asciz "r0 = %d and r1 = %d\n"
string_finished_loop: .asciz "Finished calculating e\n"
string_fmt: .asciz "Ceva numar: %d\n"
string_mul_fmt: .asciz "%d x %d = %d\n"
string_inside_gcd: .asciz "Inside gcd: r0 = %d, r1 = %d\n"
string_inside_e: .asciz "phi = %d, n = %d\n"
done_it_1: .asciz "Done it 1\n"
done_it_2: .asciz "Done it 2\n"
mod_func: .asciz "Hello modulus: %d %d\n"
mod_func_leave: .asciz "Bye modulus\n"
hello_d: .asciz "Hello d: %d %d\n"
enter_loop: .asciz "hello loop: %d %d\n"
exit_loop: .asciz "Modulus: %d\n"
string_inside_d_loop: .asciz "%d %d\n"