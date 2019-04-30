;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname compound-data-definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct player (first last))
;; Player is (make-player String String)
;; interp. (make-player first last) is a jockey player with:
;;         - first is the first name
;;         - last is the last name
(define P1 (make-player "Bobby" "Orr"))
(define P2 (makeplayer "Wayne" "Gretzky"))

(define (fn-for-player p)
  (... (player-first p)   ; String
       (player-last p)))  ; String

;; Template rules used:
;; - Compound: 2 fields
  