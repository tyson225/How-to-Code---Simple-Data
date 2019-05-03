;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname natural-numbers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Natural is one of:
;; - empty
;; - (add1 Natural)
;; interp. a natural number
(define N0 0)         ; 0
(define N1 (add1 N0)) ; 1
(define N2 (add1 N1)) ; 2

(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... n           ; template rules don't put this in
                          ; but it seems to be used a lot so
                          ; we put it in.
          (fn-for-natural (sub1 n)))]))

;; Template rules used:
;; - one-of: two cases
;; - atomic distinct: 0
;; - compound: (add1 Natural)
;; - self-reference: (sub1 n) is Natural

;; Natural -> Natural
;; produce some sort of natural between 0 to n inclusive
(check-expect (sum 0) 0)
(check-expect (sum 1) 1)
(check-expect (sum 3) (+ 3 2 1 0))

;(define (sum n) 0) ; 0

(define (sum n)
  (cond [(zero? n) 0]
        [else
         (+ n                        
           (sum (sub1 n)))]))

;; Natural -> ListOfNatural
;; produce cons and cons n -1 ... empty not including 0
(check-expect (to-list 0) empty)
(check-expect (to-list 1) (cons 1 empty))
(check-expect (to-list 2) (cons 2 (cons 1 empty)))

;(define (to-list n) empty) ; stub

(define (to-list n)
  (cond [(zero? n ) empty]
        [else
         (cons n
               (to-list (sub1 n)))]))
        
  
  