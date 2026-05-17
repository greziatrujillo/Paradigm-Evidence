# E3: Paradigm-Evidence, using different paradigms to solve one problem and compare the solutions. 


## Description
For this project, I have looked into the ICPC North Central NA Regional Contest official problem set of 2023. I have chosen problem E: Sun and Moon. I chose this purely for the name of the problem. For context, this problem states that an eclipse is when the sun and moon are aligned at specific positions, where the number of years since the position and until the position are known for both the sun and moon. The solution must be when the next eclipse will be based on these details.

The input receives integers <b>ds, ys, dm, ym</b> and results in an integer <b>x</b>.

The d variables represent how many years ago and the y variables represent how many years until the correct position. x is the output, otherwise the result of how many years until the next eclipse. 

Using this context, I have come to the conclusion that using a functional paradigm would be best considering the transformation of data as it parses through the math to get the possible outcome. Functions will largely be used in the proposed solution, allowing lambda calculus to aid in the process.

## Models
Using the functional paradigm avoids loops and updating of variables that could cause confusion. Instead, we turn to recursion, where the function receives a new argument until it reaches the base case or solution. 

To structure this correctly, we will have a way to receive values, a way to parse through those values, a way to test them (the main function), and a way for the user to input values.

It is also important to understand the arithmetic involved. Down below is a visual representation of how this can be solved by hand. Important to note that this is largely based on brute force of choosing and discarding values in order for both equations to be true. BOTH must be true in order for the set of values to work.



 Using the values provided by the ICPC example, we can corroborate that the set of values do indeed work. Other examples are provided of finding more sets of values that would work.






Also provided is an example of how the arithmetic proves a set of values does not work. Notice how one of the equations is not true.





## Implementation:

Functional programming is commonly implemented in Racket through lambda calculus, so I will be using Racket to implement the solution considering this is a straightforward mathematical process. 

Lambda calculus “is based on function abstraction, to generalise expressions through the introduction of names, and function application, to evaluate generalised expressions by giving names particular values” (Michaelson, n.d.). This essentially allows us to declare an abstract function without having to define it separately. For example, align is the function that will be executed when called and instead of defining the modulus function before align with a different name, it can be declared within the definition of align. 

### Racket implementation
Within the program, I define <i>align</i> which essentially validates that the sun or moon are aligned at x year, this is by using the modulus operator, which must be equal to 0. Reminder the modulus operator is used to find the remainder, in this case the remainder must be 0.  The declaration of lambda allows me to input various arguments and define the modulus function. Without the lambda declaration, Racket interprets the code as giving multiple arguments (as if align was receiving the expression as another variable). 




This is followed up by the definition of the function <i>eclipse</i> where it receives the entire set of values (which have been established in the models section) to verify that both the sun and moon are aligned at x year. Once again, notice the lambda declaration which allows the modulus to be implemented when align is recalled with the new set of variables (x ds ys dm ym). The <i>and</i> makes sure to return true if and only if both the sun and moon are aligned at x year (Flatt & Findler, 2025). Otherwise, false will be returned.





Since it is difficult to parse through possible solutions and return a value as one would with python or c++ in a regular solution, the functional paradigm allows us to work with conditional statements that will return boolean values. In this case, since this is an imperative paradigm there is more focus on establishing the exact flow, which is why there must be a correct x year given with the set of sun and moon values to get true.

## Tests
### Functional paradigm
For the functional paradigm, it is implemented in Racket in the file <b>sunMoonFunctional.rkt</b>. Since the solution ended up being shorter and to save the complexities of Racket test files, the tests are within the racket file. Upon running the code, the terminal will display the result of the number sets.

It is imperative the user has DrRacket installed or they will be unable to run the file. For more information, <a href = “https://racket-lang.org/” >this resource </a> will aid in the download. 





Shown above, four sets of values should print out true and the final three sets should print out false. In the above model section, all correct value sets have been proven by hand, and one false set was proven by hand. The other false sets were randomly generated numbers.

The only truth set not proven by hand was <b>(eclipse 1 2 3 4 5)</b> which was a random test that coincidentally gave true. For sake of amusement I kept it. 

### Other paradigm
For the second implementation, since I am using prolog, the user must consult the sunMoonLogic.pl file into the designated prolog terminal. Once the file has been loaded and the message true. is received, you can begin testing out with the following query:<br/>

<b> search(X, Ds, Ys, Dm, Ym, Res). </b><br/>

Remember that Res will continue to be a variable in all queries, but all other variables must have a number instead. Likewise, there is the <b>logic_test.pl</b> file which has a few tests similar to the functional solution tests. Instead of returning true or false, it should return the numerical value of Res, which represents the x year of when the eclipse will happen.

## Analysis:
Regarding space and time complexity, both would be O(n). Since the modulus is run every time for every year, the time complexity would be O(n). These values are temporarily stored for every set that is parsed, therefore the space complexity is O(n). Since we are using the functional paradigm in Racket with recursion, conditionals, and booleans, concepts which are optimized, the time complexity is decent for using Racket to solve this problem.

### Second paradigm
While we have used a functional paradigm, we can use a different approach to solve the same problem. In this case, I have chosen to compare a functional solution with a solution using logic in Prolog. While it is very similar, this paradigm allows a more declarative approach, in other words, we can “specify the problem's logic and let the system derive the solution (Edet, 2024, pp. 26–34). Within the solution, there are rules and constraints set down that will be followed in order to deduce the correct result upon the input of a query (Edet, 2024, pp. 26–34). 

In this solution, align is declared as a rule where 0 must be the modulus in order to verify the sun and moon are aligned on x year. Reminder that Prolog takes variables with a starting capital letter. <br/>





This is followed by the declaration of eclipse, with the rules that both the sun and moon must be aligned on x year depending on the year since and until that are given. <br/>





From this, we can create a recursion with a base case. The base case states that when the x year given is indeed the correct result for when the sun and moon align for an eclipse, then no recursion is needed. Otherwise, if the x year given is not correct, the program will recall eclipse, which recalls align and increment x year by 1 until it reaches a correct x year. <br/>



 <br/>

To prove this, there are 2 queries made, one with the correct x year and the other with the incorrect x year. Both have the same result of 7.<br/>




As clearly shown, the first query receives the exact data set the ICPC provides, which reaches the base case and does not have to recurse through the above declarations, but rather just verify. On the other hand, the incorrect input of x year has multiple iterations until it reaches the first correct year. For the sake of time and space, only part of the trace process will be shown for the second query.

While the x year is still input, it is not like the functional program where you must provide the correct set for it to be true or false. In this solution, even if the x is provided, the program itself will figure out the correct year according to Ds, Ys, Dm, and Ym. Providing an input for x year just allows for recursion with a base case.

Similar to the functional solution, the time and space complexity are both also O(n) since it similarly runs through the expressions for every possible year.

While concurrency seems useful in this case considering the computations for sun and moon can be split and completed, where the results come together in the end to get x, this paradigm is much more typical with more complex processes. This problem does not need a large amount of computation power, so there is no point in using concurrency to represent a small task.

## References 
Edet, T. (2024). Declarative Programming: Achieving Effortless Software Through Logic-Based Programs (pp. 26–34). Amazon. <br/>

Flatt, M., & Findler, R. B. (2025). The Racket Guide (8.18 ed.). Lulu.com. https://download.racket-lang.org/releases/8.18/pdf-doc/guide.pdf <br/>

ICPC. (2023). Official Problem Set. Retrieved from https://icpcarchive.github.io/North%20America%20Contests/North%20Central%20Regional%20Contest/2022%20North%20Central%20Regional%20Contest/problems.pdf <br/>

Michaelson, G. (n.d.). AN INTRODUCTION TO FUNCTIONAL PROGRAMMING THROUGH LAMBDA CALCULUS. University of Rochester. Retrieved from University of Rochester website: https://www.cs.rochester.edu/~brown/173/readings/LCBook.pdf

