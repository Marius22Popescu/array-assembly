.data

a:
	.skip 40
i:
	.word 
n:
	.word 0
s:
	.word 0
p1:
	.asciz "Enter a number:"
p2:
	.asciz "Your number is found at index:%d\n"
p3:
	.asciz "Enter a number to search:\n"
p4:	
	.asciz "Not found\n"
format:
	.asciz "%d"
return:
	.word 0
return2:
	.word 0

.text

search:
	ldr r3, addressOfReturn2
	str lr, [r3]
	
        mov r4, r0 //adress of array
        mov r5, r1 //#10
        mov r6, r2 //#serch
	mov r7, #0 //i
	
	b tests
	
loops:
	ldr r1, [r4, +r7, LSL #2]
	cmp r1, r6
	beq equal
	add r7, r7, #1

tests:
	cmp r7, r5
	blt loops

equal:	
	ldr r0, addressOfP2
	mov r1, r7
	bx lr

.global main

main:
	ldr r1, addressOfReturn
	str lr, [r1]

	ldr r4, addressOfA
	ldr r5, addressOfI
	mov r6, #0
	str r6, [r5]
	b test
	
loop:	
        ldr r0, addressOfP1
        bl printf

	ldr r0, addressOfFormat
 	ldr r1, addressOfN
	bl scanf
	
        ldr r4, addressOfA
        ldr r1, addressOfN
        ldr r1, [r1]
        str r1, [r4, +r6, LSL #2] 
	
	add r6, r6, #1

test:
	cmp r6, #10
	blt loop  
end:
	mov r0, r6 

	ldr r0, addressOfP3
	bl printf

	ldr r7, addressOfS

	ldr r0, addressOfFormat
	ldr r1, addressOfS
	bl scanf

	ldr r1, addressOfS
	ldr r7, [r1]
	
	ldr r0, addressOfA
	mov r1, #10
	ldr r2, addressOfS
	ldr r2, [r2] 
	bl search
 
	mov r1, r1 
	mov r9, #10
	cmp r1, r9
	beq equal3

noequal:
	ldr r0, addressOfP2
	mov r1, r1
	bl printf
	b end2

equal3:
	ldr r0, addressOfP4
	bl printf
	
        ldr r1, addressOfReturn
        ldr lr, [r1]
        bx lr
end2:
	ldr r1, addressOfReturn
	ldr lr, [r1] 
	bx lr

addressOfA: .word a
addressOfI: .word i
addressOfN: .word n
addressOfS: .word s
addressOfP1: .word p1
addressOfP2: .word p2
addressOfP3: .word p3
addressOfP4: .word p4
addressOfFormat: .word format
addressOfReturn: .word return
addressOfReturn2: .word return2
.global printf
.global scanf
