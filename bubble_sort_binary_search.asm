.data

A:			.space 80  	# create integer array with 20 elements ( A[20] )
size_prompt:		.asciiz 	"Enter array size (between 1 and 20): "
array_prompt:		.asciiz 	"A["
sorted_array_prompt:	.asciiz 	"Sorted A["
close_bracket: 		.asciiz 	"] = "
search_prompt:		.asciiz		"Enter search value: "
not_found:		.asciiz		" not in sorted A"
newline: 		.asciiz 	"\n" 	

.text

main:	
	# ----------------------------------------------------------------------------------
	# Do not modify
	#
	# MIPS code that performs the C-code below:
	#
	# 	int A[20];
	#	int size = 0;
	#	int v = 0;
	#
	#	printf("Enter array size [between 1 and 20]: " );
	#	scanf( "%d", &size );
	#
	#	for (int i=0; i<size; i++ ) {
	#
	#		printf( "A[%d] = ", i );
	#		scanf( "%d", &A[i]  );
	#
	#	}
	#
	#	printf( "Enter search value: " );
	#	scanf( "%d", &v  );
	#
	# ----------------------------------------------------------------------------------
	
	la $16, A			# store address of array A in $16
  
	add $17, $0, $0			# create variable "size" ($17) and set to 0
	add $18, $0, $0			# create search variable "v" ($18) and set to 0
	add $8, $0, $0			# create variable "i" ($8) and set to 0

	addi $2, $0, 4  		# system call (4) to print string
	la $4, size_prompt 		# put string memory address in register $4
	syscall           		# print string
  
	addi $2, $0, 5			# system call (5) to get integer from user and store in register $2
	syscall				# get user input for variable "size"
	add $17, $0, $2		        # copy to register $17, b/c we'll reuse $2
  
prompt_loop:
	# ----------------------------------------------------------------------------------
	slt $9, $8, $17		# if( i < size ) $9 = 1 (true), else $9 = 0 (false)
	beq $9, $0, end_prompt_loop	 
	sll $10, $8, 2			# multiply i * 4 (4-byte word offset)
				
  	addi $2, $0, 4  		# print "A["
  	la $4, array_prompt 			
  	syscall  
  	         			
  	addi $2, $0, 1			# print	value of i (in base-10)
  	add $4, $0, $8			
  	syscall	
  					
  	addi $2, $0, 4  		# print "] = "
  	la $4, close_bracket		
  	syscall					
  	
  	addi $2, $0, 5			# get input from user and store in $2
  	syscall 			
	
	add $11, $16, $10		# A[i] = address of A + ( i * 4 )
	sw $2, 0($11)			# A[i] = $2 
	addi $8, $8, 1		        # i = i + 1
		
	j prompt_loop			# jump to beginning of loop
	# ----------------------------------------------------------------------------------	
end_prompt_loop:

	addi $2, $0, 4  		# print "Enter search value: "
  	la $4, search_prompt 			
  	syscall 
  	
  	addi $2, $0, 5			# system call (5) to get integer from user and store in register $2
	syscall				# get user input for variable "v"
	add $18, $0, $2		        # copy to register $18, b/c we'll reuse $2

	# ----------------------------------------------------------------------------------
	# TODO:	PART 1
	#	Write the MIPS-code that performs the the C-code (bubble sort) shown below.
	#	The above code has already created array A and A[0] to A[size-1] have been 
	#	entered by the user. After the bubble sort has been completed, the values in
	#	A are sorted in increasing order, i.e. A[0] holds the smallest value and 
	#	A[size -1] holds the largest value.
	#	
	#	int t = 0;
	#	
	#	for ( int i=0; i<size-1; i++ ) {
	#		for ( int j=0; j<size-1-i; j++ ) {
 	#			if ( A[j] > A[j+1] ) {
	#				t = A[j+1];
	#				A[j+1] = A[j];
	#				A[j] = t;
	#			}
	#		}
	#	}
	#			
	# ----------------------------------------------------------------------------------
	

	# ----------------------------------------------------------------------------------
	# TODO:	PART 2
	#	Write the MIPS-code that performs the C-code (binary search) shown below.
	#	The array A has already been sorted by your code above in PART 1, where A[0] 
	#	holds the smallest value and A[size -1] holds the largest value, and v holds 
	# 	the search value entered by the user
	#	
	#	int left = 0;
	# 	int right = size - 1;
	#	int middle = 0;
	#	int element_index = -1;
 	#
	#	while ( left <= right ) { 
      	#
      	#		middle = left + (right - left) / 2; 
	#
      	#		if ( A[middle] == v) {
      	#    			element_index = middle;
      	#    			break;
      	#		}
      	#
      	#		if ( A[middle] < v ) {
      	#    			left = middle + 1; 
      	#		} else {
      	#    			right = middle - 1;
    	#		} 
	#	}
	#
	#	if ( element_index < 0 ) {
    	#		printf( "%d not in sorted A\n", v );
    	#	} else {
    	#		printf( "Sorted A[%d] = %d\n", element_index, v );
    	#	}
	# ----------------------------------------------------------------------------------

  	
# ----------------------------------------------------------------------------------
# Do not modify the exit
# ----------------------------------------------------------------------------------
exit:                     
  addi $2, $0, 10      		# system call (10) exits the program
  syscall               	# exit the program
  
