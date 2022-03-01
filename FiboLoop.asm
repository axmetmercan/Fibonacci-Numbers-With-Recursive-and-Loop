.data 
	text:  .asciiz "Enter the sequence number : "
	F: .asciiz "\nF("
	concat_with_f:  .asciiz ") = "
	inform: .asciiz "Please n must be a positive integer. "

.text
main:
li $v0,4
la $a0,text	#prints the text string
syscall



li  $v0, 5     	#get input
syscall

			
add $t1,$zero,$v0	#stores the input in $t1

#save user input
addi $sp,$sp,-4
sw  $t1,0($sp)


add $a0,$zero,$t1 # a0 is function parameter referst to t1 
jal LoopFunction  # call LoopFunction
add $t0,$zero,$v0 #takes result from the function return.


li $v0,4
la $a0,F	# prints the 'F=('
syscall


lw $t1,0($sp)	# restor user input 
addi $sp,$sp,4


li $v0,1
add $a0,$t1,$zero # prints the result
syscall


li $v0,4
la $a0,concat_with_f 	# prints the closing bracket
syscall


li $v0,1
add $a0,$t0,$zero 	
syscall


li $v0,10	# finishes the program
syscall


LoopFunction:
addi $s0 $zero 1 
addi $t0 $zero 0 #n1 initial value 0
addi $t1 $zero 1 #n2 initila value 1
addi $t3 $zero 0 #count the items
add $t2 $zero $a0 #total fibonacci number

bge  $t2 $zero continue # checks the value if it is greater or equal to 0
li $v0 4 
la $a0 inform 
syscall	


continue:
bne $t2 $s0 pass # cheks the value if it is equals to 1
li $v0 1 
add $a0 $t0 $zero 
syscall
pass:
While: # in a loop it checks and swaps the values to achieve result of n therm fib.
ble  $t2 $t3 return
add $t5 $t0 $t1
move $t0 $t1
move $t1 $t5
addi $t3 $t3 1
j While

return:
add $v0,$zero,$t0 #returns the value
jr $ra

