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

.text

.global main
.func main

is_prime:
    

main:
    @ input of p
    ldr r0, =fmt
    ldr r1, a_p
    bl scanf


    @ print value of p
    ldr r0, =string_p
    ldr r1, a_p
    ldr r1, [r1]
    bl printf
    

    @  input q
    ldr r0, =fmt
    ldr r1, a_q
    bl scanf

    @ print value of q
    ldr r0, =string_q
    ldr r1, a_q
    ldr r1, [r1]
    bl printf

    @ calculate modulus
    ldr r1, a_p
    ldr r1, [r1]
    ldr r2, a_q
    ldr r2, [r2]
    mul r3, r1, r2

    @ print modulus
    ldr r4, a_n
    str r3, [r4]
    ldr r0, =string_modulus
    ldr r1, a_n
    ldr r1, [r1]
    bl printf

    @ get phi
    @ getting p and q into regs
    ldr r2, a_p
    ldr r2, [r2]
    ldr r3, a_q
    ldr r3, [r3]
    @ calculating phi (totient)
    sub r2, #1
    sub r3, #1
    mul r4, r2, r3
    ldr r5, a_phi
    str r4, [r5]

    @ printing phi
    ldr r0, =string_phi
    ldr r1, a_phi
    ldr r1, [r1]
    bl printf

    @ calculating e
    mov r0, #2
    e_loop:
        cmp r0, totient
        beq e_exit
        

    




_exit:
    mov r7, #1
    swi 0


gcd:
   
    




a_p :   .word p
a_q :   .word q
a_n :   .word n
a_e :   .word e
a_d :   .word d
a_phi:  .word phi
string_modulus: .asciz "The modulus is: %d\n"
string_p: .asciz "p = %d\n"
string_q: .asciz "q = %d\n"
string_phi: .asciz "phi = %d\n"
fmt: .asciz "%d"