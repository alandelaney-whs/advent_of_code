#!/usr/bin/env perl -w
# day02.pl ---

use warnings;
use strict;
use List::Util qw( min max sum );

sub main {
    my $file_name = "input.txt";
    my $paper = 0;
    my $ribbon = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        my @next_values = get_dimensions($line);
        $paper += $next_values[0];
        $ribbon += $next_values[1];
    }

    close($fh);

    print "Paper = $paper\n";
    print "Ribbon = $ribbon\n";
}

sub get_dimensions {
    my $line = shift;
    $line =~ /^(\d+)x(\d+)x(\d+)$/;
    my $length = $1 + 0;
    my $width = $2 + 0;
    my $height = $3 + 0;
    my @areas = ($length * $width, $length * $height, $width * $height);
    my @perimeters = (
        ($length + $width) * 2,
        ($length + $height) * 2,
        ($width + $height) * 2);

    my $min_area = min @areas;
    my $min_perimeter = min @perimeters;

    return (
        sum(@areas) * 2 + $min_area,
        $min_perimeter + $length * $width * $height);
}

main();
