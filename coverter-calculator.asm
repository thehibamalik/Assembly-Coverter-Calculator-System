.data

choice: .asciiz "For Body Mass Index Calculator press a, for Fahrenheit to Celsius converter press b, for Pounds to Kilograms converter press c, for Fibonacci sequence calculator press d: \n"

prompt2: .asciiz "Enter your height in meters: \n"

prompt3: .asciiz "Enter your weight in kilograms: \n"

prompt4: .asciiz "Enter yours weight (in pounds) that you would like to convert: \n"

prompt7: .asciiz "Enter the temperature in Fahrenheits: \n"

answer3: .asciiz "The temperature in celsius is: "

answer: .asciiz "The body mass index is: "

answer2: .asciiz "The weight in kilograms is: "

prompt5: .asciiz "Enter the sequence index: \n"

prompt6: .asciiz "The Fibonacci value is: \n"

#output: .asciiz "The Fibonacci value is: \n 0"

num: .float 0.0

number1: .float 1.8

number2: .float 2.2046

number3: .float 32.0

number4: .word 1

newline: .asciiz "\n"



.text

.globl main


main:

#Main menu

#Show main prompt
li $v0,4
la $a0,choice
syscall

#Get input
li $v0,12
syscall

#Save input
move $t2,$v0

#Print newline character
li $v0, 4
la, $a0, newline
syscall

#Branch based on the input
beq $t2,97 ,bmi
beq $t2,98 ,temperature
beq $t2,99 ,pounds
beq $t2,100 ,fibonnaci

#If branch does not occur at this point, repeat the prompt
j main



#---------------------------------------------------------------------
#			BMI Calculator
#---------------------------------------------------------------------

bmi:

# Prompt height
li $v0, 4
la, $a0, prompt2
syscall

# Load input into saved register $s0
li $v0 6
syscall

lwc1 $f4, num
add.s $f13, $f0, $f4


# Prompt weight
li $v0, 4
la, $a0, prompt3
syscall

# Load input into saved register $s0
li $v0 6
syscall

lwc1 $f5, num
add.s $f21, $f0, $f5


#Calculations
mul.s $f14, $f13, $f13
cvt.s.w $f14, $f14
cvt.s.w $f21, $f21
div.s $f22, $f21, $f14 # $f22=$f21/$f14


#print string before result
li $v0, 4
la $a0, answer
syscall

#print result
li $v0, 2
mov.s $f12, $f22
syscall

#new line
li $v0, 4
la $a0, newline
syscall

#Finish
j endprogram



#---------------------------------------------------------------------
#			Fahrenheit to Celsius
#---------------------------------------------------------------------

temperature:

#display prompt
li $v0, 4
la, $a0, prompt7
syscall

#read
li $v0, 6
syscall

#Perform calculation
lwc1 $f1, number3	#$f1 = 32
sub.s $f0, $f0, $f1	#$f0 = $f0 - $f1 (F-32)
lwc1 $f1, number1	#$f1 = 1.8
div.s $f12, $f0, $f1	#$f2 = $f0 / $f1 (F / 1.8)

#Print final prompt
li $v0, 4
la $a0, answer3
syscall

#Print result
li $v0, 2
syscall

#new line
li $v0, 4
la $a0, newline
syscall

#Finish
j endprogram



#---------------------------------------------------------------------
#			Pounds to Kilogram
#---------------------------------------------------------------------

pounds:

#Show prompt
li $v0, 4
la $a0, prompt4
syscall

#Read input
li $v0 6
syscall

#Perform conversion
lwc1 $f2, number2    # $f2 = 2.2046
div.s $f12, $f0, $f2 #$f12 = lb / $f2

#Print final prompt
li $v0, 4
la $a0, answer2
syscall

#Print result
li $v0, 2
syscall

#new line
li $v0, 4
la $a0, newline
syscall

#Finish
j endprogram



#---------------------------------------------------------------------
#			N Fibonnaci Number
#---------------------------------------------------------------------

fibonnaci:
#Show prompt
li $v0, 4
la $a0, prompt5
syscall

#Read N
li $v0 5
syscall

#Preparing registers for fibonnaci sequence
lw $t1, number4
and $t2, $t2, 0
and $t3, $t3, 0
move $t4, $v0	# $t4 = N

fiboloop:

	#Add t1 and t2
	add $t3, $t1, $t2
	
	#Clean $t1 and copy the value of $t2 into $t1
	and $t1, $t1, 0
	add $t1, $t1, $t2
	
	#Clean $t2 and copy the value of $t3 into $t2
	and $t2, $t2, 0
	add $t2, $t2, $t3
	
	#Decrease loop control
	addi $t4, $t4, -1
	
	
	#Repeat until t4 is 0
	bgt $t4, 0, fiboloop


#print string before result
li $v0, 4
la $a0, prompt6
syscall

#print result
li $v0, 1
move $a0, $t3
syscall

#new line
li $v0, 4
la $a0, newline
syscall

#Finish
j endprogram


#End point used on all segments
endprogram:
li $v0,10
syscall