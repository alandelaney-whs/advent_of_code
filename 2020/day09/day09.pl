#!/usr/bin/env perl -w
# day09.pl ---

use warnings;
use strict;
use List::Util qw(min max sum);

sub main {
    my $bad_entry = part1();

    if (not $bad_entry) {
        print "No bad entry found";
        return;
    }

    print "Invalid entry found: $bad_entry\n";

    my $min_max = part2($bad_entry);

    if (not $min_max) {
        print "No answer for part 2 found\n";
    } else {
        print "Answer for part 2: $min_max\n";
    }
}

sub part1 {
    my $file_name = "input.txt";
    my @codes = ();
    my $preamble = 25;
    my $answer = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);

        my $len = scalar @codes;
        my $match = 0;

        if ($len < $preamble) {
            push @codes, $line;
        } else {
            my $i = 0;

            while ($i < $preamble - 1 and not $match) {
                my $j = $i + 1;

                while ($j < $preamble and not $match) {
                    $match = $codes[$i] + $codes[$j] == $line;
                    $j++;
                }

                $i++;
            }

            if (not $match) {
                $answer = $line;
                last;
            }

            push @codes, $line;
            shift @codes;
        }
    }

    close($fh);
    return $answer;
}

sub part2 {
    my $file_name = "input.txt";
    my $target = shift;
    my @codes = ();
    my $sum = 0;
    my $answer = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);

        if ($line != $target) {
            push @codes, $line;

            while (sum(@codes) > $target) {
                shift @codes;
            }

            if (sum(@codes) == $target) {
                $answer = min(@codes) + max(@codes);
                last;
            }
        }
    }

    return $answer;
}

main();
