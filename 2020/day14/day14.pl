#!/usr/bin/env perl -w
# day14.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";
    my %cells = ();
    my $mask = "";

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);

        if ($line =~ /^mask = ([01X]{36})$/) {
            $mask = $1;
        } elsif ($line =~ /^mem\[(\d+)\] = (\d+)$/) {
            $cells{$1} = apply_mask($2, $mask);
        } else {
            die "Unknown line\n";
        }
    }

    my @addresses = keys %cells;
    my $sum = 0;

    foreach my $cell(@addresses) {
        $sum += $cells{$cell};
    }

    print "Sum of values = $sum\n";
}

sub apply_mask {
    my $val = shift;
    my $mask = shift;

    my $zeroes = $mask;
    $zeroes =~ tr/X/1/;
    {
        no warnings;
        $zeroes = oct("0b".$zeroes);
    }
    my $zeroes_applied = $val & $zeroes;

    my $ones = $mask;
    $ones =~ tr/X/0/;
    {
        no warnings;
        $ones = oct("0b".$ones);
    }
    my $answer = $zeroes_applied | $ones;
    return $answer;
}

sub print_bin {
    my $val = shift;
    my $val_bin = sprintf("%b", $val);
    print "$val_bin\n";
}

main();
