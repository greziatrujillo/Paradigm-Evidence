#lang racket
;;Author: Grezia Trujillo
;;Date: 4 June 2026
;;Project: Functional solution to Shortest path in binary matrix
;;Purpose of the project: Pathfinding problem will be solved using
;;a functional paradigm, to properly understand the
;;construct of functional programming and how it affects this
;;particular solution

;;cells will be identified as row, column (r,c)
(define (row pos)
  (first pos))

(define (col pos)
  (second pos))

;;define the grid
(define grid
  '((0 0 0)
    (1 1 0)
    (1 1 0)))

(define grid2
  '((0 1)
    (1 0)))

(define grid3
  '((0 1 1)
    (0 0 1)
    (1 1 1)))

;;test is row and col functions are giving correct position
;;(row '(2 3))
;;(col '(4 5))

;;grid size n
(define (grid-size grid)
  (length grid))

;;test for grid size, should be 3 (n=3)
;;(grid-size grid)

;;bounds and limits
(define(bounds pos grid)
  (let ([r (row pos)]
        [c (col pos)]
        [n (grid-size grid)])
    (and
     (>= r 0)
     (< r n)
     (>= c 0)
     (< c n))))

;;cell value of the position
(define (cell-value pos grid)
  (let ([r (row pos)]
        [c (col pos)])
    (list-ref (list-ref grid r)c)))

;;determine valid positions and limits
(define(valid-pos pos grid)
  (and
   (bounds pos grid)
   (= (cell-value pos grid) 0)))

;;(valid-pos '(0 0)grid)
;;(valid-pos '(1 0)grid)

;;possible directions
(define directions
  '((-1 -1)
    (-1 0)
    (-1 1)
    (0 -1)
    (0 1)
    (1 -1)
    (1 0)
    (1 1)))

;;actually move
(define (move pos offset)
    (list
     (+ (row pos) (row offset))
     (+ (col pos) (col offset))))

;;(move '(2 3) '(-1 1))

;;neighbors to the current cell (keep valid positions)
(define (neighbors pos grid)
  (let ([next-cells
         (map (lambda (dir)
           (move pos dir))
       directions)])
        (filter (lambda (next-cell)
            (valid-pos next-cell grid))
          next-cells)))

;;(neighbors '(1 0)grid)
;;(neighbors '(0 0)grid)

;;take multiple positions and return their neighbors
;;this is like working on one level
(define (expand frontier grid)
  (apply append
         (map (lambda (pos)
                (neighbors pos grid))
                frontier)))

;;(expand '((0 1)) grid)

;;get rid of visited cells to narrow down results
(define (remove-visited next-cells visited)
  (filter (lambda (cell)
            (not(member cell visited)))
            next-cells))

;;(remove-visited
;; '((0 0) (0 2) (1 2))
;; '((0 0) (0 1)))

;;actual function to search and return distance
;;using recursion
(define (bfs frontier visited distance grid destination)
  (cond
    ;;base case next cell is destination
    [(member destination frontier) distance]
    
    ;;base case there is no viable path (-1)
    [(empty? frontier) -1]
    
    ;;otherwise continue recursing through
    [else
     (let* ([expanded (expand frontier grid)]
            [next-frontier (remove-visited expanded visited)]
            [new-visited (append visited next-frontier)])
           (bfs
            next-frontier
            new-visited
            (+ distance 1)
            grid
            destination))]))

(define (shortest-path grid)
  (let* ([n (grid-size grid)]
         [destination (list (- n 1)(- n 1))])

    (if (or (not (valid-pos '(0 0) grid))
            (not (valid-pos destination grid)))
        -1
        ;;provide initial values (distance of 1 at origin)
        (bfs '((0 0))
             '((0 0))
             1
             grid
             destination))))

;;test the grids
(shortest-path grid)
(shortest-path grid2)
(shortest-path grid3)