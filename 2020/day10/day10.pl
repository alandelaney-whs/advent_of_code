#!/usr/bin/env perl -w
# day10.pl ---

use warnings;
use strict;
use List::Util qw(min max sum);

sub main {
    my $file_name = "input.txt";
    my @adapters = (0);
    my $one_step = 0;
    my $three_step = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        push @adapters, $line;
    }

    my @sorted_adapters = sort {$a <=> $b} @adapters;
    push @sorted_adapters, $sorted_adapters[-1] + 3;
    my $len = scalar @sorted_adapters;

    for (my $i = 0; $i < $len - 1; $i++) {
        my $diff = $sorted_adapters[$i + 1] - $sorted_adapters[$i];
        if ($diff == 1) {$one_step++;}
        elsif ($diff == 3) {$three_step++;}
        else {print "diff = $diff\n";}
    }

    my $answer = $one_step * $three_step;
    print "$answer\n";
}

main();
