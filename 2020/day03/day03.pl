#!/usr/bin/env perl -w
# day03.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";

    my $slope1_pos = 0;
    my $slope2_pos = 0;
    my $slope3_pos = 0;
    my $slope4_pos = 0;
    my $slope5_pos = 0;

    my $tree1_count = 0;
    my $tree2_count = 0;
    my $tree3_count = 0;
    my $tree4_count = 0;
    my $tree5_count = 0;
    my $line_count = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    my $first_line = <$fh>;
    chomp($first_line);
    my $item1 = substr($first_line, 0, 1);
    my $line_width = length($first_line);
    my $item2 = $item1;
    my $item3 = $item1;
    my $item4 = $item1;
    my $item5 = $item1;

    if ($item1 eq "#") {
        $tree1_count++;
    }

    if ($item2 eq "#") {
        $tree2_count++;
    }

    if ($item3 eq "#") {
        $tree3_count++;
    }

    if ($item4 eq "#") {
        $tree4_count++;
    }

    if ($item5 eq "#") {
        $tree5_count++;
    }

    #print("Current width = $line_width");

    foreach my $line (<$fh>) {
        chomp($line);

        $line_count++;

        $slope1_pos = ($slope1_pos + 1) % $line_width;
        $slope2_pos = ($slope2_pos + 3) % $line_width;
        $slope3_pos = ($slope3_pos + 5) % $line_width;
        $slope4_pos = ($slope4_pos + 7) % $line_width;

        $item1 = substr($line, $slope1_pos, 1);
        $item2 = substr($line, $slope2_pos, 1);
        $item3 = substr($line, $slope3_pos, 1);
        $item4 = substr($line, $slope4_pos, 1);

        if ($item1 eq "#") {
            $tree1_count++;
        }

        if ($item2 eq "#") {
            $tree2_count++;
        }

        if ($item3 eq "#") {
            $tree3_count++;
        }

        if ($item4 eq "#") {
            $tree4_count++;
        }

        if ($line_count % 2 == 0) {
            $slope5_pos = ($slope5_pos + 1) % $line_width;
            $item5 = substr($line, $slope5_pos, 1);

            if ($item5 eq "#") {
                $tree5_count++;
            }
        }
    }

    close($fh);

    print ("Part 1: $tree2_count\n");
    my $product = $tree1_count * $tree2_count * $tree3_count * $tree4_count * $tree5_count;
    print("Part 2: $product\n");
}

main();
