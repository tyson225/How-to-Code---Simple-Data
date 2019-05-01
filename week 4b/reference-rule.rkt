;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname reference-rule) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; ========================
;; CONSTANTS

(define FONT-SIZE 24)
(define FONT-COLOR "black")

(define Y-SCALE 1/200)
(define BAR-WIDTH 30)
(define BAR-COLOR "lightblue")

;; ========================
;; Data Definition

(define-struct school (name tuition))
;; school is (make-school String Natural)
;; interp. name is the school's name, tuition is internation students tuition in US Dollars

(define S1 (make-school "School 1" 27797))
(define S2 (make-school "School 2" 23300))
(define S3 (make-school "School 3" 28500))

(define (fn-for-school s)
  (... (school-name s)
       (school-tuition s)))

;; template rules used:
;; - compound: (make-school String Natural)

;; ListOfSchool is one of:
;; - empty
;; - (cons School ListOfSchool)
;; interp. a list of schools
(define LOS1 empty)
(define LOS2 (cons S1 (cons S2 (cons S3 empty))))
#;
(define (fn-for-los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-school (first los))
              (fn-for-los (rest los)))]))

;; template rules used:
;; - one of: 2 cases
;; - stomic distinct: empty
;; - compound: (cons School ListOfSchool)
;; - reference: (first los)
;; - self-reference: (rest los) is ListOfSchool

;; =======================
;; FUNCTIONS

;; ListOfSchool -> Image
;; produce bar chart showing the name and tuition of the list of schools
(check-expect (chart empty) (square 0 "solid" "white"))
(check-expect (chart (cons (make-school "S1" 8000) empty))
              (beside/align "bottom"
                            (overlay/align "center" "bottom"
                                     (rotate 90 (text "S1" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 8000 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 8000 Y-SCALE) "solid" BAR-COLOR))
               (square 0 "solid" "white")))
(check-expect (chart (cons (make-school "S2" 12000) (cons (make-school "S1" 8000) empty)))
              (beside/align "bottom"
                            (overlay/align "center" "bottom"
                                     (rotate 90 (text "S2" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 12000 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 12000 Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text "S1" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 8000 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 8000 Y-SCALE) "solid" BAR-COLOR))
               (square 0 "solid" "white")))


; (define (chart los) (square 0 "solid" "white")) ; stub

(define (chart los)
  (cond [(empty? los) (square 0 "solid" "white")]
        [else
         (beside/align "bottom"
                       (make-bar (first los))
                       (chart (rest los)))]))

;; School -> Image
;; produces the bar for a single school in the bar chart
(check-expect (make-bar (make-school "S1" 8000))
              (overlay/align "center" "bottom"
                        (rotate 90 (text "S1" FONT-SIZE FONT-COLOR))
                        (rectangle BAR-WIDTH (* 8000 Y-SCALE) "outline" "black")
                        (rectangle BAR-WIDTH (* 8000 Y-SCALE) "solid" BAR-COLOR)))
              
; (define (make-bar s) (square 0 "solid" "white")) ; stub

(define (make-bar s)
  (overlay/align "center" "bottom"
                 (rotate 90 (text (school-name s) FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "outline" "black")
                 (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "solid" BAR-COLOR)))