#lang typed/racket
(provide read-input-file)

(: read-lines (Input-Port -> (Listof String)))
(define (read-lines file)
  (for/list
      ([line (in-lines file)]
       #:unless (eof-object? line))
    line))

(: read-input-file (String -> (Listof String)))
(define (read-input-file filename)
  (call-with-input-file (string->path filename) read-lines))
