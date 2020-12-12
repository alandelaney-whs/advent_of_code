#!/usr/bin/env perl -w
# day11.pl ---

use warnings;
use strict;

use constant {
    FLOOR => ".",
    EMPTY => "L",
    OCCUPIED => "#",
}

sub main {
    my $file_name = "input1.txt";
    my $lines = "";
    my $new_lines = "";
    my $rows = 0;
    my $cols = 0;


    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        print "$line\n";
        if ($cols == 0) {
            $cols = length $line;
        }
        $lines .= $line;
        $rows++;
    }

    $new_lines = iterate_line($lines);
    print "$lines\n";
    print "$new_lines\n";
    print "Rows: $rows, cols: $cols\n";

    get_offset("", 27, 0, 5, 20);
    get_offset("", 7, 0, 5, 20);
}

sub iterate_line {
    my $lines = shift;
    my $answer = $lines;
    substr ($answer, 4, 2) = "XX";
    my $c = get_neighbour($lines, 11, 0, 10, 10);
    print "$c\n";
    return $answer;
}

sub get_neighbour {
    my ($lines, $idx, $offset, $max_rows, $max_cols) = @_;
    my $col = $idx % $max_cols;
    my $row = int($idx / $max_cols);

    print "Row = $row, col = $col\n";

    given ($offset) {
        when (0) {
            $row--;
            $col--;
        }
        when (1) {
            $row--;
        }
        when (2) {
            $row--;
            $col++;
        }
        when (3) {
            $col--;
        }
        when (4) {
            $col++;
        }
        when (5) {
            $row++;
            $col--;
        }
        when (6) {
            $row++;
        }
        when (7) {
            $row++;
            $col++;
        }
        default {
            die "Invalid offset\n";
        }
    }

    if ($row < 0 or $col < 0 or $row > $max_rows or $col > $max_cols) {
        return 0;
    }

    my $pos = $col * $max_cols + $row;
    my $char = substr $lines, $pos, 1;
    if ($char eq OCCUPIED) {
        return 1;
    }

    return 0;
}

main();
