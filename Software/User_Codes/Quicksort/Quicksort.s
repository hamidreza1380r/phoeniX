   
li s2, 0
li a0, 3
sw a0, 0(s2)

li s2, 4
li a0, 5
sw a0, 0(s2)

li s2, 8
li a0, 1
sw a0, 0(s2)

li s2, 12
li a0, 2
sw a0, 0(s2)

li s2, 16
li a0, 4
sw a0, 0(s2)

li s2, 20
li a0, 16
sw a0, 0(s2)

begin:
    li s1,0
    li a1,0
    lw t0,0(s2)
for:
    lw t1,0(s1)
    bge t0,t1,pivot
pivot:
    lw s9,0(s1)
    lw t3,4(a1)
    ble t3,t0,chng
    addi a1,a1,4
    j pivot
chng:
    sw t3,0(s1) 
    sw t1,4(a1)
    addi a1,a1,4
    beq a1,s2,SHR
    addi s1,s1,4
    j for
SHR:
    addi s1,s1,-4
    lw a3,0(s1)       
    li a5,0 
    li s3,0
forRL:
    lw a4,0(a5) 
    bge a4,a3,RL
    addi a5,a5,4
    j forRL
RL:
    lw s2,4(a5)
    ble s2,a3,chngR
    addi s3,s3,4
    j RL
chngR:
    sw s2,0(a5)
    sw a4,4(s3)
    addi s3,s3,4
    beq s3,s1,SHL
    addi a5,a5,4
    j forRL

SHL:
    lw s4,0(s2)         
    addi s5,s1,4
    addi s6,s1,4
forLR:
    lw s7,0(s5)         
    bge s7,s4,LR
    addi s5,s5,4
LR:
    lw s0,0(s5)
    lw s8,4(s6)
    ble s8,s4,chngL
    addi s6,s6,4
    j LR
chngL:
    sw s8,0(s5)
    sw s7,4(s6)
    addi s6,s6,4
    beq s6,s2,Exit
Exit:
   ebreak