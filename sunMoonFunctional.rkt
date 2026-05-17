#lang racket
;;Author: Grezia Trujillo
;;Date: 22 May 2026
;;Project: Functional paradigm solution to Sun and Moon problem E
;;Purpose of the project: Sun and Moon problem will be solved using
;;a functional paradigm, with the use of functions and lambda calculus
;;as it best avoids loops and confusing states of variables


;;check to see is sun or moon is aligned at x year
(define align
  (lambda (x s m)
    (= (modulo (+ x s) m) 0)))

;;both must be aligned for the eclipse
(define eclipse
  (lambda (x ds ys dm ym)
    (cond
      [(and (align x ds ys)
               (align x dm ym)) true]
    [else false])))

;;test different values
;;sets that will give true
(eclipse 7 3 10 1 2)
(eclipse 9 1 2 9 3)
(eclipse 11 1 2 4 5)
(eclipse 1 2 3 4 5)

;;sets that will give false
(eclipse 2 1 5 3 4)
(eclipse 5 8 2 3 4)
(eclipse 4 6 7 2 0)