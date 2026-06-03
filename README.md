# E3: Paradigm-Evidence, using different paradigms to solve one problem and compare the solutions. 

## Description
For this project, I have chosen the “Shortest path in binary matrix” problem that I found on leetcode. For context, when given a grid that is <i>[nxn]</i> the solution will be the cells visited to get from the <b>top left</b> to the <b>bottom right</b> cells. It is important to note the movement can be left, down, right, up, and the diagonals (8 directions). The program must find the shortest path. The grid is made up of 0 and 1s, but it can only visit cells of 0 (we can assume cells with 1 are blocked). If there is no valid path, the program will return -1.

The input received is the makeup of the grid and the output is a single integer, which is the shortest path.

Using this context, I have decided to use a functional paradigm. There are multiple functions we would need to establish or add, such as directions, adjacency, limits, and path length among other things. All of these functions will stack on top of each other to work as one to get to the final solution. 

## Models
To be able to properly construct this program, we must put together models to help us understand how this truly works. I will be showing visualizations of how the program could work and what possible functions would be working at the time of executing said step.</br>
</br>

<img width="960" height="426" alt="funcM1" src="https://github.com/user-attachments/assets/54c6a581-77b5-4fe3-a63c-ac996a6728c7" />

Let’s begin with a 4x4 grid, where we know the origin and the destination cell will be the same, but it is important to get some visualization. I have also blocked some cells at random to simulate cells of 1 which cannot be traversed. Since we start at the origin, one cell has been visited, meaning in this first step the length of the path so far is 1. Now we will look for all the other possible steps. 

Some functions I begin to think about are the actual creation of the grid, taking the grid size, and having positions as (r,c) which can later be accessed by other functions.





As shown above, the length is now 2 and there are 2 paths that can be taken. While the right step still has another open path, it will eventually lead to a dead end. Likewise, it will only add an extra step to the path, so we will immediately take the diagonal path. 

Since we will begin searching for the next move, we have to find adjacent cells, access their position and value, and validate if it is within limits/ an open cell. 




Once more, we check all the possible next steps. The top right leads to a dead end, so it will be discarded. The bottom left is a viable path, but will add to the length and eventually lead to the bottom right. Therefore, it is more viable to simply take the path through the bottom right. 

At this point we have moved, so there has to be a function that allows movement and a way to know which direction we have moved. Also, we begin to have many steps (or many nodes at one level) so now we have to validate all of those as well. I will also be keeping a list of visited cells to avoid going backwards.






When checking for all available options, there appear to be three. The bottom left leads to a dead end, so it will be discarded. The right just adds to the length, while the bottom right leads directly to the destination cell. Therefore, the diagonal right path will be taken. 





This leaves us with the shortest path length of four with an ironic straight diagonal path. It is also important to have a counter or function for distance which increments at every cell visited. 

With the process of these models, it is evident that many steps and components need to be taken into account during the process of the program. Not only are we looking at path length, but we are looking at blocked cells, available cells, and even available paths that are valid to the destination but might not be the shortest path. 

This leads to the conclusion that breadth first search (BFS) would be useful, considering the data structure allows for every cell to be checked depending on the current cell and level we are at. Similar to a tree and its nodes. 


## Implementation

I will be using Racket to implement the solution as previously mentioned. There are a myriad of functions that are implemented, and as we move into more complex functions, the use of lambda becomes more apparent. 

Lambda calculus “is based on function abstraction, to generalise expressions through the introduction of names, and function application, to evaluate generalised expressions by giving names particular values” (Michaelson, n.d.). This essentially allows us to declare an abstract function without having to define it separately. This is especially useful for whenever a function will be used once so as to conserve space, considering this program commonly implements functions that are used once within their parent functions.

### Racket implementation
There are many parts to this program, so I will break it down to aid in the explanation and understanding.




I started with defining the structure of the grids and their cells. The position will be (row, column), so it is important to define the first and second position correctly. This will allow us to access the cells on the grid.


Up next, I defined the grid size n since the problem asks for a nxn grid, there is really only one measurement. I pass in the existing grid and get the length. Additionally, I define the bounds and limits of the grid. As we continue to move through the grid and find the next step, it is important to stop the program if the next step is outside the grid or if the cell is blocked. The row and column positions must be 0 or greater, since our origin is at 0, but must be less than n, the size of our grid. 



Now that we have set up the bounds and identification of cells, we have to identify whether the cell is open or blocked. This is done by figuring out if the cell has a value of 0 or 1. Notice we have only been able to get the position of the cell, so now I have created a helper function to get the value of the cell depending on the position we are in. Using the list-ref operation from racket, we can return the element of the given position. This is then used to verify if the cell is a valid position, by not only checking if it is within bounds, but if it is equal to 0, meaning it is an open cell. 



The problem tells us that movements are 8-directional, meaning that it can go (in terms of compass directions to understand better) north, south, west, east, northeast, northwest, southeast, southwest. So, I decided to create directions before I forget in order to have values to reference from, allowing to move positions. Depending on the direction we are moving, we add, subtract or keep the same row and/or column. For example, (-1 -1) we move left and up which is a diagonal, while something like (0 1) is staying in the same row but moving to the right column. This does not actually move the position, so I created a function that takes those directions and depending on the position, will add the direction values to actually move to the new position. We use list to combine the two separate values we get for row and column into our position (r, c). 


Up next, we have to find the adjacent cells. Notice we start to use lambda, since map takes in two values and various functions have to be performed before we can get a value. The first part takes in all directions and applies them to the move function to get the next positions. These are all possible next positions. Next, we have to discard any cells that are not valid, whether they are out of bounds or blocked to keep only the valid adjacent cells to the current position. This is why we use the filter operation. Again, since it receives a condition to filter from a list, we once again implement a lambda to generate the condition while keeping valid positions of the generated adjacent cells (since it is possible not all the next cells are valid). 

This function would produce the adjacent cells at one position, and it could return many values. All these would have to be explored. To keep with the BFS standard of exploring at levels, I made the expand function, which is similar to neighbors but takes in multiple positions. Since this would return some type of matrix, I use apply append to be able to get a large list and not multiple lists in one list. 



The generation of adjacent cells and the valid next cells will produce previously visited cells, so I implemented a function to shave off cells that have already been visited by using a filter that keeps cells that are not members of the visited list. 


Finally, using all the helper functions put together, I can finally construct the actual bfs function, which would allow for the actual parsing of the grid to get the final distance. This puts into action all the previously created functions to achieve a search through recursion. The first base case is when the next expansion includes the destination cell, so we just return the distance. The next base case is if there is no viable path and the destination is unreachable, which is where -1 will be returned. 

Lastly, if the base cases are not reached yet, the search will continue recursively. The program will continue to expand into the adjacent cells, remove already visited cells and add them to the existing visited list, all while adding to the distance and awaiting the destination cell. 


Finally, in order to avoid running the bfs function and inserting all the parameters it asks for, we create a smaller function that wraps everything up. This function is the final function to get the distance from the origin to the destination in a given grid. The problem tells us that while the grid is nxn, the destination will be n-1xn-1 (bottom right corner cell). Since we are calling in the bfs function, we have to give it starting data, which is the origin at the grid and a distance of 1 (starting at the origin means one cell has already been visited). Also, I made sure to establish that if there is no valid next step after the origin OR there is no valid position to the destination, -1 will be returned. 

Obviously a much simpler implementation would be in python or c++ using a queue, but this demonstrates that a pathfinding solution is possible with racket and a functional construct.

### Logic paradigm
For the second implementation, I am using a logic paradigm with Prolog. The differences will be explained in further detail down below, but it is important to note that due to the structure of Prolog, instead of implementing a BFS solution, it will be easier to implement a DFS solution. Prolog will search for all possible paths before backtracking and finding the solution, which is similar to how DFS searches all the children of a node before backtracking and looking at other nodes. 


Using the 3x3 grid example, I created an automata where the states are the cell positions and the transitions are valid cells (must be 0). The reason I did not include any cell states with transitions of 1 is because they would be considered dead states, and while they would help define invalid positions and invalid paths, it does not change that these states would just be hanging there. Also, notice how q1 jumps to q3, and that is because while there is a consecutive path, the shortest path would be that diagonal direction which cuts out an extra cell.




As we begin to see in the Prolog implementation, we have to define the grid not only with its positions, but the values in those positions as well. 



Similar to racket, we must define the 8 possible directions in which the path can move. 


I also created the conditions of the adjacent cells that must be validated as available cells. These will be passed into the recursive function to allow the program to know that these conditions must be met as it creates the path. Upon searching for neighboring cells, it takes the directions established above and adds them to the original position. That new position is validated to see if it's an open cell.



Now, we can recursively search for the correct path. The base case is when the current cell is the destination cell, so now we have a path and the visited list is not very important anymore. Otherwise, the program will continue to search by checking that the cell we will move to is a valid adjacent cell and that it is not a member of the visited list. If true to these conditions, the path will continue building up.



Finally, the previous function will give us the path, but not the distance, so we wrap it up with a simple length operator. Upon consulting this result, we get the shortest path, which is 4 as previously proven to us. 

## Tests
### Functional paradigm
As the program was being developed, tests for different functions were run to verify that they were working correctly. At the end of the file, there are some test functions with the test grids inserted from the examples on Leetcode and one I have created myself.  





Upon running the code, the terminal will display the results. Only the final grid should return -1.

It is important the user has DrRacket installed or they will be unable to run the file. For more information, <a href = “https://racket-lang.org/” >this resource </a> will aid in the download. 



Shown above, the first two values are the distance for their respective graphs. As shown, the final graph prints out a -1 since the destination is unreachable.

###Logic paradigm tests
Since we are keeping it to one grid implementation, we can run the following short tests:

The base case is reached, where the origin is the same as the destination. This is obviously not meant to happen as an original input considering it is required to start at the top left (0,0).


The recursive case where the path is achieved from origin to destination.


A case where the destination is unreachable.



## Análisis:
The implementation of the solution in racket ends up being O(n^2) for both time and space complexity since the grid is nxn. In the worst case scenario it could potentially reach a time complexity of O(n^4) since it will end up checking the visited list possibly many times depending on the size of the grid and the times recursion recalls respective functions.

### Second paradigm
While I have used a functional paradigm, we can use a different approach to solve the same problem. In this case, I have chosen to compare a functional solution with a solution using logic in Prolog. While it is very similar, this paradigm allows a more declarative approach, in other words, we can “specify the problem's logic and let the system derive the solution (Edet, 2024, pp. 26–34). Within the solution, there are rules and constraints set down that will be followed in order to deduce the correct result upon the input of a query (Edet, 2024, pp. 26–34). 

To further establish the difference, think of it this way: functional allows the visualization of the entire process of how to move across the grid. There are validations and functions set in place to be able to correctly reach the destination. All the helper functions, such as neighbors and valid_pos help the ultimate BFS function to be more explicit and easy to follow. 

On the other hand, logic establishes the facts in order to understand the relationships between the cells. These are used in order to define valid positions, neighbors and paths (unlike functional that is defining the next step as it goes, logic continues on a path until it has to backtrack and find the final one). These conditions define a valid solution rather than the process to reach that valid solution.

Implemented in Prolog, instead of a BFS search, I put together a DFS. Where a BFS parses through the cells at levels, DFS searches through the depth of all the cells before having to backtrack. This tracks with the Prolog implementation, where the program will find all possible paths until it is not viable or the shortest, before it begins to backtrack to where it left off in a good spot and continue searching again.

Also, in Prolog the fact has to show not only the row and column for the grid, but its value. Meanwhile, in Racket the program has to access the position and then the value from a list structure. Due to Prolog allowing for backtracking, the program would be able to explore the possible paths since it does not have the explicit control established in the functional solution.

Most importantly, considering these are two paradigms with two different algorithms, it is important to touch on their differences in time to run these. It is a small difference, but Racket takes a few more milliseconds in time to print out the distance of the shortest path. This is most likely due to the amount of functions it has to go through, sometimes recursively multiple times, in order to reach the solution. Meanwhile, Prolog simply has some conditions, two relations and two functions, so while it also recalls functions and backtracks as it goes, it does not have as much information to parse through.

## References 
Edet, T. (2024). Declarative Programming: Achieving Effortless Software Through Logic-Based Programs (pp. 26–34). Amazon. <br/>

Flatt, M., & Findler, R. B. (2025). The Racket Guide (8.18 ed.). Lulu.com. https://download.racket-lang.org/releases/8.18/pdf-doc/guide.pdf <br/>

ICPC. (2023). Official Problem Set. Retrieved from https://icpcarchive.github.io/North%20America%20Contests/North%20Central%20Regional%20Contest/2022%20North%20Central%20Regional%20Contest/problems.pdf <br/>

Michaelson, G. (n.d.). AN INTRODUCTION TO FUNCTIONAL PROGRAMMING THROUGH LAMBDA CALCULUS. University of Rochester. Retrieved from University of Rochester website: https://www.cs.rochester.edu/~brown/173/readings/LCBook.pdf

