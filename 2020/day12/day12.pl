#!/usr/bin/env perl -w
# day12.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";
    my $x1_pos = 0;
    my $y1_pos = 0;
    my $x2_pos = 0;
    my $y2_pos = 0;
    my $x_way = 10;
    my $y_way = -1;
    my $dir = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        $line =~ /^([NSEWLFR])(\d+)$/;

        my $inst = $1;
        my $val = $2;

        if ($inst eq "N") {
            $y1_pos -= $val;
            $y_way -= $val;
        } elsif ($inst eq "E") {
            $x1_pos += $val;
            $x_way += $val;
        } elsif ($inst eq "S") {
            $y1_pos += $val;
            $y_way += $val;
        } elsif ($inst eq "W") {
            $x1_pos -= $val;
            $x_way -= $val;
        } elsif ($inst eq "L") {
            $dir = ($dir - $val) % 360;
            if ($val == 90) {
                ($x_way, $y_way) = ($y_way, -$x_way);
            } elsif ($val == 180) {
                ($x_way, $y_way) = (-$x_way, -$y_way);
            } elsif ($val == 270) {
                ($x_way, $y_way) = (-$y_way, $x_way);
            } else {
                die "Invalid inst: $inst";
            }
        } elsif ($inst eq "R") {
            $dir = ($dir + $val) % 360;
            if ($val == 90) {
                ($x_way, $y_way) = (-$y_way, $x_way);
            } elsif ($val == 180) {
                ($x_way, $y_way) = (-$x_way, -$y_way);
            } elsif ($val == 270) {
                ($x_way, $y_way) = ($y_way, -$x_way);
            } else {
                die "Invalid inst: $inst";
            }
        } elsif ($inst eq "F") {
            $x2_pos += $x_way * $val;
            $y2_pos += $y_way * $val;
            if ($dir == 0) {
                $x1_pos += $val;
            } elsif ($dir == 90) {
                $y1_pos += $val;
            } elsif ($dir == 180) {
                $x1_pos -= $val;
            } elsif ($dir == 270) {
                $y1_pos -= $val;
            } else {
                die "Invalid direction: $dir";
            }
        } else {
            die "Invalid direction: $inst\n";
        }
    }

    my $answer1 = abs($x1_pos) + abs($y1_pos);
    my $answer2 = abs($x2_pos) + abs($y2_pos);
    print "Answer to part 1: $answer1\n";
    print "Answer to part 2: $answer2\n";
}

main();
