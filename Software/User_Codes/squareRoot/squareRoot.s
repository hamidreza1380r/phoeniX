li a0, 20    #input
sqrt:
    li t0, 0  
    li t1, 1  
loop:
    mul t2,t0,t0   
    add t0,t0,t1   
    bge t2,a0,end  
    j loop 

end:
    addi t0,t0,-1 
    mv a0,t0  #output
    ebreak