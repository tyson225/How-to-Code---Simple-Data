;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdf-quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Image, Image -> Boolean
;; determines if the first image is larger than the second

(check-expect (images? (circle 10 "solid" "blue") (circle 15 "solid" "blue")) false)
(check-expect (images? (circle 15 "outline" "red") (circle 10 "solid" "blue")) true)
(check-expect (images? (square 10 "solid" "purple") (square 15 "solid" "purple")) false)
(check-expect (images? (square 15 "solid" "purple") (square 10 "solid" "purple")) true)

;(define (images? img-1 img-2) false) ;stub

;(define (images? img-1 img-1)
;  (... img-1 img-2)) ;template

(define (images? img-1 img-2)
  (and (> (image-width img-1) (image-width img-2))
       (> (image-height img-1) (image-height img-2))))
  
  
  

