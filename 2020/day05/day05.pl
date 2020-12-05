#!/usr/bin/env perl -w
# day05.pl ---

use warnings;
use strict;
use List::Util qw( max );

sub main {
    my $file_name = "input.txt";
    my @ids = ();

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        push(@ids, seat_id($line));
    }

    close($fh);

    my @sorted_ids = sort { $a <=> $b } @ids;
    my $max_id = $sorted_ids[-1];
    my $first_id = $sorted_ids[0];
    my $index = 0;
    my $sum = $first_id + $index;

    while ($first_id + $index == $sorted_ids[$index]) {
        $index++;
    }

    my $missing_id = $sorted_ids[$index] - 1;

    print "Max seat ID = $max_id\n";
    print "Missing seat ID = $missing_id\n";
}

sub seat_id {
    my $line = shift;
    my $line_bin = $line;
    $line_bin =~ tr/FBLR/0101/;
    my $row = bin_to_dec(substr($line_bin, 0, 7));
    my $column = bin_to_dec(substr($line_bin, -3));

    return $row * 8 + $column;
}

sub bin_to_dec {
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

main();
