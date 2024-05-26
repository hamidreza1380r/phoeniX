.text


# Function: quicksort
# Parameters:
#   a0 = start index of the array to be sorted
#   a1 = end index of the array to be sorted
quicksort:
    # Save the return address and frame pointer
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s0, 4(sp)
    sw s1, 0(sp)

    # Base case: if start >= end, return
    bge a0, a1, quicksort_end

    # Save the start and end indices
    mv s0, a0
    mv s1, a1

    # Partition the array
    jal ra, partition

    # Recursively sort the left and right partitions
    mv a1, a0
    mv a0, s0
    jal ra, quicksort
    mv a0, a1
    addi a1, a1, 1
    mv a1, s1
    jal ra, quicksort

quicksort_end:
    # Restore the return address and frame pointer
    lw s1, 0(sp)
    lw s0, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    ret

# Function: partition
# Parameters:
#   a0 = start index of the array to be partitioned
#   a1 = end index of the array to be partitioned
# Returns:
#   a0 = new index of the pivot element
partition:
    # Choose the last element as the pivot
    la t0, array
    slli t0, a1, 2
    add t0, t0, t0
    add t0, t0, t0
    lw t0, (t0)

    # Initialize left and right pointers
    mv t1, a0
    mv t2, a1
    addi t2, t2, -1

partition_loop:
    # Move left pointer to the right until an element >= pivot is found
    partition_loop_left:
        bge t1, t2, partition_done
        la t3, array
        slli t3, t1, 2
        add t3, t3, t3
        add t3, t3, t3
        lw t3, (t3)
        blt t3, t0, partition_loop_left_inc
        j partition_loop_left_done
        partition_loop_left_inc:
            addi t1, t1, 1
            j partition_loop_left
    partition_loop_left_done:

    # Move right pointer to the left until an element < pivot is found
    partition_loop_right:
        bge t1, t2, partition_done
        la t3, array
        slli t3, t2, 2
        add t3, t3, t3
        add t3, t3, t3
        lw t3, (t3)
        bge t3, t0, partition_loop_right_dec
        j partition_loop_right_done
        partition_loop_right_dec:
            addi t2, t2, -1
            j partition_loop_right
    partition_loop_right_done:

    # If left pointer is less than right pointer, swap elements
    blt t1, t2, partition_swap
    j partition_done

partition_swap:
    # Swap elements at left and right pointers
    la t3, array
    slli t4, t1, 2
    add t4, t4, t4
    add t4, t4, t4
    lw t5, (t4)
    slli t4, t2, 2
    add t4, t4, t4
    add t4, t4, t4
    lw t6, (t4)
    sw t6, (t3)
    sw t5, (t3)
    j partition_loop

partition_done:
    # Partition is done, return the new pivot index
    addi a0, t1, 1
    ret