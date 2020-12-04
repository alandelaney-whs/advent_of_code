#!/usr/bin/env perl -w
# day01.pl ---

use strict;
use warnings;

sub main {
    my @values = [];
    my $file_name = "input.txt";
    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        push @values, $line;
    }

    close($fh);

    my $line_count = scalar(@values);

    for (my $i = 0; $i < $line_count - 1; $i++) {
        for (my $j = $i + 1; $j < $line_count; $j++) {
            my $sum = $values[$i] + $values[$j];
            if ($sum == 2020) {
                my $product = $values[$i] * $values[$j];
                print "Part 1: $product\n";
            }
        }
    }

    for (my $i = 0; $i < $line_count - 2; $i++) {
        for (my $j = $i + 1; $j < $line_count - 1; $j++) {
            for (my $k = $j + 1; $k < $line_count; $k++) {
                my $sum = $values[$i] + $values[$j] + $values[$k];
                if ($sum == 2020) {
                    my $product = $values[$i] * $values[$j] * $values[$k];
                    print "Part 2: $product\n";
                }
            }
        }
    }
}

main();
