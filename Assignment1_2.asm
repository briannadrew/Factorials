# Program: Calculate Factorials (Assignment 1)
# Name: Brianna Drew
# Username: briannadrew
# ID: 0622446
# Date Created: 01/25/19
# Last Modified: 01/26/19

.data
# messaages to be called to be printed out:
prompt: .asciiz "Enter a positive integer! "
error: .asciiz "This is not a positive integer. Please try again."
resultout: .asciiz "The factorial of your integer is: "
.text

main:
	li $t1, 1 # store integer 1 in register $t1
	inpint:
		la $a0, prompt # load input integer prompt
		li $v0, 4 # print prompt to enter a positive integer
		syscall
		li $v0, 5 # read integer from user input
		syscall
		add $t0, $v0, $zero # move the input integer to register $t0
		bgtz $t0, factorial # if the input integer is greater than 0, branch to factorial to calculate the factorial
		beqz $t0, result # if the input integer is 0, branch to result (as we know it is 1, and result is already set to 1 at $t1)
		# if the input integer is not greater than or equal to 0 (if it is negative)...
		la $a0, error # load error message
		li $v0, 4 # print error message
		syscall
		b inpint # branch to inpint (ask for integer again)
		
	factorial:
		mulo $t1, $t1, $t0 # multiply input integer and integer in $t1 and store result in $t1
		sub $t0, $t0, 1 #decrease input integer by 1
		bgtz $t0, factorial # if the input integer is still greater than 1, branch to factorial again (like a while loop)
		b result # when the input integer has decreased to 0, branch to result
			
	result:
		la $a0, resultout # load message introducing result of factorial
		li $v0, 4 # print message introducing result of factorial
		syscall
		move $a0, $t1 # move resulting integer from $t1 to $a0
		li $v0, 1 # print resulting integer
		syscall
		b end # branch to end

end:
	.macro done # macro definition to end program
	li $v0, 10 # end program
	syscall
	.end_macro
	done # call macro definition to end program
		
