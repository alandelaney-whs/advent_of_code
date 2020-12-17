#!/usr/bin/env perl -w
# day16.pl ---

use warnings;
use strict;
use List::Util qw/sum/;

sub main {
    my $file_name = "input.txt";
    my $sum_invalid = 0;
    my $valid_lines = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);

        my @vals = split /,/, $line;
        my @invalid = grep {$_ < 25 or $_ > 974} @vals;

        if (scalar @invalid) {
            $sum_invalid += sum(@invalid);
        } else {
            $valid_lines++;
        }
    }

    print "Sum of values = $sum_invalid\n";
    print "Valid lines = $valid_lines\n";
}

main();
