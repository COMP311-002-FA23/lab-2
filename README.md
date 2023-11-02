# COMP 311: Lab 2

<details open>
  <summary>Overview</summary>

   * [Download MARS](#download-mars)
   * [Configure MARS](#configure-mars)
   * [Run the example assembly program](#run-the-example-assembly-program)
   * [System Calls](#system-calls)
   * [Part 1: Simple MIPS assembly programs](#part-1-simple-mips-assembly-programs)
      * [Part 1a: Basic I/O and arithmetic](#part-1a-basic-io-and-arithmetic)
      * [Part 1b: Loops](#part-1b-loops)
   * [Part 2: Bubble sort and binary search](#part-2-bubble-sort-and-binary-search)
   * [Submit your assignment](#submit-your-assignment)
</details>

### Download MARS

If you already downloaded MARS for lecture, you can skip this step.

Download MARS [here](https://courses.missouristate.edu/KenVollmar/MARS/MARS_4_5_Aug2014/Mars4_5.jar). Launch it by double-clicking the `.jar` file or running `java -jar Mars4_5.jar`.

You will be prompted to install the Java runtime environment if your computer does not already have it installed.

macOS users, if you're opening the file with double-click, you may have to manually allow this program to run in your security settings. Go to the security page, click the lock in the bottom left-hand corner, enter your password, and allow MARS to run.

**If you run into any issues when launching via double-click, launch via the command instead.**

### Configure MARS

1. Enable pseudo-instructions: go to **Settings**, then select **Permit extended (pseudo) instructions and formats**.
2. Enable compact memory address layout: go to **Settings->Memory Configuration**, and select **Compact, Data at Address 0.** Then press the **Apply and Close** button.

### Run the example assembly program
1. Open `examples/sum.asm` using `File->Open`.
2. Read and understand the program. Predict what the contents of the register file will be after the program has finished executing.
2. Assemble the program by clicking on the icon shown in the image below. 
<img src="/images/assemble.png"
  alt="Assemble icon" />
3. Run the program by clicking on the icon shown in the image below.
<img src="/images/run.png"
  alt="Run icon" />
4. When the program completes, inspect the contents of the register file. Is it what you expected? The result should be in `$8`.

### Debugging 

<img src="/images/debugging.png"
  alt="Debugging tools" />

<img src="/images/breakpoint.png"
  alt="Breakpoint" />

Note: Make sure to reset your program before you begin debugging! (Reset button shown above).

### System Calls
System calls are a way for a user-level program to request services from the operating system (OS). Examples of such services include reading user input, printing, and exiting a program.

To perform a system call, we use the instruction `syscall`. To tell the operating system which operation we are requesting, we set `$2` to the corresponding value. The operating system will read the contents of this register to know which operation to perform. The table below summarizes the requests we will be using in this lab.

| Operation      | System Call Number |
| ----------- | ----------- |
| Print an integer | 1 |
| Print a string   | 4 |
| Read an integer from user input  | 5 |
| Exit the program  | 10 |

If we want to print a value, we first set `$2` to the corresponding system call number, then we place the value we want to print into `$4`.

For example, if we want to print the number 5, we would execute the following three instructions:

```
addi $2 $0 1
addi $4 $0 5
syscall
```

To exit a program, we set `$2` to 10.

```
addi $2 $0 10
syscall
```

If we want to read an integer from user input, the OS will return the input in `$2`. In the following example, we move the user input from `$8` to `$2`.

```
addi	$2, $0, 5
syscall 			
add	$8, $0, $2			
```

## Part 1: Simple MIPS assembly programs

Make sure to comment your code! The TAs will not assist you in office hours if you do not comment your code.

### Part 1a: Basic I/O and arithmetic

You are given a program in MIPS assembly language that computes the area of a rectangle given the width and the height (`io_loop.asm`). The width and height are read from the standard input after prompting the user. Then, the program computes the area and prints it on the standard output. Here's an example scenario:

```
Enter width: 2
Enter height: 4
Rectangle's area: 8
```

Modify the program so that it also calculates and prints the perimeter (i.e., sum of all sides) of the rectangle. Thus, after modification, the example scenario would become the following:

```
Enter width: 2
Enter height: 4
Rectangle's area: 8
Rectangle's perimeter: 12
```

Test your program in MARS on a few different inputs to verify that it is working correctly. You can simply enter the inputs within the MARS "Run I/O" window. Once you are satisfied that the program is working fine within MARS, commit your changes and submit to Gradescope.

### Part 1b: Loops

Modify `io_loop.asm` to make it work on multiple inputs. In particular, it should repeatedly ask for width and height values and print the corresponding area and perimeter until the user enters the value -1 for width. At that point, the program should terminate. Here's an execution scenario:

```
Enter width: 2
Enter height: 4
Rectangle's area: 8
Rectangle's perimeter: 12
Enter width: 5
Enter height: 6
Rectangle's area: 30
Rectangle's perimeter: 22
Enter width: -1
```

Test your program in MARS, and once you are satisfied that it is working properly, commit your changes and submit to Gradescope.

## Part 2: Bubble sort and binary search

In this part, you will write a MIPS program that will first sort an array in numerical order from lowest to highest and then search the array to determine if it contains a particular integer.

The array you are sorting will be generated from user input. This part of the program is already implemented for you. The existing program will also ask the user which value to search for.

Implement your solution in the two `TODO` sections indicated in the `bubble_sort_binary_search.asm` file:
1.  Perform a bubble sort that will order the integers in the array from lowest to highest value.
2. Perform a binary search on the sorted array and indicate whether the search value is present.  If it is present, indicate the index of the array at which it was found.

When implementing your solution, **do not overwrite \$16, \$17, or \$18**

Make sure thay your output matches the format of the following examples exactly. If it does not, it will fail the autograder tests.

### Example 1

```
Enter array size (between 1 and 20): 5
A[0] = -1
A[1] = 2
A[2] = 5
A[3] = -9
A[4] = 8
Enter search value: 4
4 not in sorted A
```

### Example 2

```
Enter array size (between 1 and 20): 4
A[0] = 1
A[1] = 2
A[2] = 10
A[3] = -1
Enter search value: 2
Sorted A[2] = 2
```

### Example 3

```
Enter array size (between 1 and 20): 4
A[0] = 0
A[1] = 0
A[2] = -1
A[3] = -2
Enter search value: 0
Sorted A[2] = 0
```

To check that you have implemented the sort algorithm correctly, read the memory contents. If we use Example 1 above, the memory should look like this once the program has finished executing:
<img src="/images/memory.png"
  alt="Memory" />

If your program is taking more than a few seconds to complete, you probably have an infinite loop. You should use the debugger to step through the program to find the issue.

**Do not overwrite \$16, \$17, or \$18**

## Submit your assignment

Assignments are submitted through [Gradescope](https://www.gradescope.com).

1. Commit and push your changes to your Lab 2 GitHub repo. 
2. Go to the COMP 311 course in Gradescope and click on the assignment called **Lab 2**.
3. Click on the option to **Submit Assignment** and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to Gradescope. When this occurs, grant access to the Comp311 organization.
4. You should see a list of your 311 repositories. Select the one named **lab-2-yourname** and submit it.
5. Your assignment should be autograded within a few seconds and you will receive feedback.
6. If you receive all the points, then you have completed this lab assignment! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.
