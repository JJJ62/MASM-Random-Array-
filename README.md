# MASM-Random-Array-

Description:
  Write and test a MASM program to perform the following tasks:
    1. Introduce the program.
    2. Get a user request in the range [min = 10 .. max = 200].
    3. Generate request random integers in the range [lo = 100 .. hi = 999], storing them in consecutive elements
    of an array.
    4. Display the list of integers before sorting, 10 numbers per line.
    5. Sort the list in descending order (i.e., largest first).
    6. Calculate and display the median value, rounded to the nearest integer.
    7. Display the sorted list, 10 numbers per line.

Requirements:
  1. The title, programmer's name, and brief instructions must be displayed on the screen.
  2. The program must validate the user’s request.
  3. min, max, lo, and hi must be declared and used as global constants. Strings may be declared as global
     variables or constants except for the in displayList procedure.
  4. The program must be constructed using procedures. At least the following procedures are required:
    A. main
    B. introduction
    C. get data {parameters: request (reference)}
    D. fill array {parameters: request (value), array (reference)}
    E. sort list {parameters: array (reference), request (value)}
      i. exchange elements (for most sorting algorithms): {parameters: array[i] (reference),
          array[j] (reference), where i and j are the indexes of elements to be exchanged}
    F. display median {parameters: array (reference), request (value)}
    G. display list {parameters: array (reference), request (value), title (reference)}
  5. Parameters must be passed by value or by reference on the system stack as noted above.
  6. There must be just one procedure to display the list. This procedure must be called twice: once to display
     the unsorted list, and once to display the sorted list.
  7. Procedures (except main) should not reference .data segment variables by name. request, array, and titles
     for the sorted/unsorted lists should be declared in the .data segment, but procedures must use them as
     parameters. Procedures may use local variables when appropriate. Global constants are OK.
  8. The program must use appropriate addressing modes for array elements.
  9. The two lists must be identified when they are displayed (use the title parameter for the display procedure).
  10. The program must be fully documented. This includes a complete header block for the program and for
      each procedure, and a comment outline to explain each section of code.
  11. The code and the output must be well-formatted.
