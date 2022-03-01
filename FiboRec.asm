.data
text: .asciiz "Enter the sequence number: "
F: .asciiz "\nF("
concat_with_f: .asciiz ") = "
newLine: .asciiz "\n"

.text
main:
la $a0 text   
li $v0 4	
syscall

li $v0 5    #Read the number(n)
syscall

move $t0 $v0    # n to $t0

# Call function to get fibonnacci #n
move $a0 $t0 # function parameter.
move $v0 $t0
jal fiborec    	 #call fib (n)
move $t1 $v0    #result is in $t1

la $a0 F   #Print F(
li $v0 4
syscall

move $a0,$t0    #Print n
li $v0 1
syscall

la $a0 concat_with_f  #Print ) =
li $v0 4
syscall

move $a0 $t1    #Print the answer
li $v0 1
syscall

la $a0 newLine #Print new Line after F(6) = 8'
li $v0 4
syscall

li $v0 10
syscall


## Fib Function starts here
fiborec:
# Compute and return fibonacci number
beq $a0 0 cont_zero   #if equal 0 then return 0
beq $a0 1 cont_one   #if equal 1 then return 1

#Call fibo rec for (n-1)
sub $sp $sp 4   #store the return address on the  stack
sw $ra 0($sp)

sub $a0 $a0 1   #n-1
jal fiborec     #call fib(n-1) recursively
add $a0 $a0 1

lw $ra 0($sp)   #restore the return address from the stack
add $sp $sp 4


sub $sp $sp 4   #push return value to  the stack
sw $v0 0($sp)
#Call fiborec for (n-2)
sub $sp $sp 4   #store return address to the stack
sw $ra 0($sp)

sub $a0 $a0 2   #n-2
jal fiborec     #call fib(n-2) recursively
add $a0 $a0 2

lw $ra 0($sp)   #restore  return address from the  stack
add $sp $sp,4

lw $s7 0($sp)   #Pop the return value from the stack
add $sp $sp,4

add $v0 $v0,$s7 # concatenate fib(n - 2) and fib(n-1)
jr $ra 

cont_zero:
li $v0 0
jr $ra
cont_one:
li $v0 1
jr $ra

