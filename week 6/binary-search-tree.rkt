;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname binary-search-tree) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; constants

(define TEXT-SIZE 14)
(define TEXT-COLOR "black")

(define KEY-VAL-SEP ":")

(define VSPACE (rectangle 1 10 "solid" "white"))
(define HSPACE (rectangle 10 1 "solid" "white"))

(define MTTREE (rectangle 20 10 "solid" "white"))
  

(define-struct node (key val l r))
;; BST (Binary Search Tree) is one of:
;; - false
;; - (make-node Integer String BST BST)
;; interp. false means no BST or empty BST
;;         key is the node key
;;         val is the node value
;;         l and r are the left and rigth subtree
;; INVARIANT: for a given node:
;;       key is > all the keys in its left child
;;       key is < all the keys in its right child
;;       the same key never appears twice in the tree
(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             (make-node 50 "dug" false false)))
(define BST10
  (make-node 10 "why" BST3 BST42))

#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)   ; Integer
              (node-val t)   ; String
              (fn-for-bst (node-r t))     ; BST
              (fn-for-bst (node-l t)))])) ; BST

;; template rules used:
;; - one of: two cases
;; - atomic distinct: false
;; - (make-node Integer String BST BST)
;; - self reference: (node-l t) has type BST

;; =============
;; FUNCTIONS

;; BT Natural -> String or false
;; try to fnid node with the given key, if it is found then produce a value, if not then produce false
(check-expect (lookup-key BST0 99) false)
(check-expect (lookup-key BST1  1) "abc")
(check-expect (lookup-key BST1  0) false) 
(check-expect (lookup-key BST1 99) false)
(check-expect (lookup-key BST10 1) "abc") ; left then left
(check-expect (lookup-key BST10 4) "dcj") ; left then right
(check-expect (lookup-key BST10 27) "wit") ; right then left
(check-expect (lookup-key BST10 50) "dug") ; right then right

; (define (lookup-key t k) "") ;stub

;; took ttemplate from BST, added additional parameter k
(define (lookup-key t k)
  (cond [(false? t) false]
        [else
         (cond [(= k (node-key t)) 
                (node-val t)]
               [(< k (node-key t)) 
                (lookup-key (node-l t) k)] 
               [(> k (node-key t)) 
                (lookup-key (node-r t) k)])]))

;; BST -> Image
;; produces a rendering of the binary tree
(check-expect (render-bst false) MTTREE)
(check-expect (render-bst BST1) (above (text (string-append "1" KEY-VAL-SEP "abc")
                                             TEXT-SIZE
                                             TEXT-COLOR)
                                       VSPACE
                                       (beside (render-bst false)
                                               HSPACE
                                               (render-bst false))))
(check-expect (render-bst BST4) (above (text (string-append "4" KEY-VAL-SEP "dcj")
                                             TEXT-SIZE
                                             TEXT-COLOR)
                                       VSPACE
                                       (beside (render-bst false)
                                               HSPACE
                                               (render-bst (make-node 7 "ruf" false false)))))
(check-expect (render-bst BST3) (above (text (string-append "3" KEY-VAL-SEP "ilk")
                                             TEXT-SIZE
                                             TEXT-COLOR)
                                       VSPACE
                                       (beside (render-bst BST1)
                                               HSPACE
                                               (render-bst BST4))))
                                       

; (define (render-bst t) (square 0 "solid" "white")) ;stub

(define (render-bst t)
  (cond [(false? t) MTTREE]
        [else
         (above (text (string-append (number->string (node-key t)) KEY-VAL-SEP (node-val t))
                    TEXT-SIZE
                    TEXT-COLOR)
                VSPACE                    
              (beside (render-bst (node-l t))
                      HSPACE
                      (render-bst (node-r t))))]))
         
