;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname itemization-02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Data definition

;; TLight is one of:
;; - false
;; - "red"
;; - "yellow
;; - "green"
;; interp. false means the light is disabled, otherwise the color of the light
(define TL1 false)
(define TL2 "red")

(define (fn-for-tlight tl)
  (cond [(false? tl) (...)]
        [(string=? tl "red")) (...)]
        [(string=? tl "yellow")) (...)]
        [(string=? tl "green")) (...)]))

;; Templated rules used:
;; - one of 4 cases:
;; - atomic distinct false
;; - atomic distinct "red"
;; - atomic distinct "yellow"
;; - atomic distinct "green"