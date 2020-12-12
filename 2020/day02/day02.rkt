#!/usr/bin/env racket
#lang typed/racket
(require "input.rkt")

(struct breakdown
  ([min : Integer]
   [max : Integer]
   [char : Char]
   [password : String]))

(: count-chars (String Char -> Integer))
(define (count-chars str chr)
  (for/sum
      ([x : Char str])
    (if (equal? x chr) 1 0)))

(: first-char (String -> Char))
(define (first-char str)
  (string-ref str 0))

(: string->integer-or-die (String -> Integer))
(define (string->integer-or-die str)
  (let
      ([rx (regexp-match? #px"^\\d*$" str)])
    (if
     (false? rx)
     (raise "Not an integer value")
     (let
         ([num (string->number str)])
       (if
        (exact-integer? num)
        num
        (raise "Not an integer"))))))

(: test-password (breakdown -> Integer))
(define (test-password bd)
  (let
      ([count (count-chars (breakdown-password bd) (breakdown-char bd))])
    (if (and (>= (breakdown-min bd) count) (<= (breakdown-max bd) count)) 1 0)))



(: parse-line (String -> breakdown))
(define (parse-line line)
  (let
      ([rx (regexp-match #px"(^\\d*)-(\\d*) ([a-z]): ([a-z]*)$" line)])
    (if
     (false? rx)
     (raise "regexp failed")
     
     (breakdown
       (string->integer-or-die (second rx))
       (string->integer-or-die (third rx))
       (string-ref (fourth rx) 0)
       (fifth rx)))))

;(: is-valid-password (breakdown -> Integer))
;(define (is-valid-password bd)
;  (let
;      (
  
(: part-one (String -> Integer))
(define (part-one filename)
  (for/sum
      ([line (read-input-file filename)])
    (test-password (parse-line line))))

(part-one "input.txt")

#|
#!/usr/bin/env perl -w
# day02.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";
    my $valid_password_1 = 0;
    my $valid_password_2 = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        $valid_password_1 += is_valid_password_1($line);
        $valid_password_2 += is_valid_password_2($line);
    }

    close($fh);
    print "Valid password count 1 = $valid_password_1\n";
    print "Valid password count 2 = $valid_password_2\n";
}

sub is_valid_password_1 {
    my $line = shift;

    $line =~ /^(\d*)-(\d*) ([a-z]): ([a-z]*)$/;
    my $min = $1;
    my $max = $2;
    my $char = $3;
    my $password = $4;
    my $count = () = $password =~ /$char/g;

    if ($count >= $min and $count <= $max) {
        return 1;
    }

    return 0;
}

sub is_valid_password_2 {
    my $line = shift;

    $line =~ /^(\d*)-(\d*) ([a-z]): ([a-z]*)$/;
    my $pos1 = $1 - 1;
    my $pos2 = $2 - 1;
    my $char = $3;
    my $password = $4;
    my $match1 = substr($password, $pos1, 1);
    my $match2 = substr($password, $pos2, 1);

    return ($match1 eq $char) + ($match2 eq $char) == 1;
}

main();
|#