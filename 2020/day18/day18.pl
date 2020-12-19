#!/usr/bin/env perl -w
# day18.pl ---

use warnings;
use strict;

sub main {
    my $answer1 = 0;
    my $answer2 = 0;
    my $file_name = "input.txt";

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);

        $answer1 += parse_calc_1($line);
        $answer2 += parse_calc_2($line);
    }

    print "Part 1 = $answer1\n";
    print "Part 2 = $answer2\n";
}

sub parse_calc_1 {
    my $calc = shift;

    if ($calc =~ /^(.*)\(([\d|\+|\*| ]*)\)(.*)$/) {
        return parse_calc_1($1 . parse_calc_1($2) . $3);
    }

    if ($calc =~ /^\d+$/) {
        return $calc;
    }

    if ($calc =~ /^(\d+ [\+|\*] \d+)(.*)$/) {
        return parse_calc_1(eval($1) . $2);
    }

    die "Invalid string\n";
}

sub parse_calc_2 {
    my $line = shift;

    if ($line =~ /^[\d|\+|\*| ]*$/) {
        return eval_no_parens($line);
    }

    if ($line =~ /^(.*)\(([\d|\+|\*| ]*)\)(.*)$/) {
        return parse_calc_2($1 . parse_calc_2($2) . $3);
    }

    die "Invalid string $line\n";
}

sub eval_no_parens {
    my $line = shift;

    if (not $line =~ /^[\d|\+|\*| ]*$/) {
        die "Invalid line $line in eval_no_parens";
    }

    # Only one
    if ($line =~ /^[\d|\+| ]*$/ or $line =~ /^[\d|\*| ]*$/) {
        return eval($line);
    }

    if ($line =~ /^(\d+ \+ \d+)( .*)$/) {
        return eval_no_parens(eval($1) . $2);
    }

    if ($line =~ /^(.* )(\d+ \+ \d+)$/) {
        return eval_no_parens($1 . eval($2));
    }

    if ($line =~ /^(.* )(\d+ \+ \d+)( .*)$/) {
        return eval_no_parens($1 . eval($2) . $3);
    }

    die "eval_no_params fallthrough\n";
}

main();

#print parse_calc_3("1 + (2 * 3) + (4 * (5 + 6))") . "\n";
#print parse_calc_3("2 * 3 + (4 * 5)") . "\n";
#print parse_calc_3("5 + (8 * 3 + 9 + 3 * 4 * 3)") . "\n";
#print parse_calc_3("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") . "\n";
#print "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2\n";

#print "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2" . "\n";
#print parse_calc_3("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") . "\n";
#print "Answer = " . eval_no_parens("123") . "\n";
#print "Answer = " . eval_no_parens("12 + 13") . "\n";
#print "Answer = " . eval_no_parens("12 * 12") . "\n";
#print "Answer = " . eval_no_parens("1 + 2 + 3 + 4 + 5") . "\n";
#print "Answer = " . eval_no_parens("1 * 2 * 3 * 4 * 5") . "\n";
#print "Answer = " . eval_no_parens("1 + 2 * 3 + 4 + 5") . "\n";
