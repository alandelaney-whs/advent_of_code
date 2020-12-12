#!/usr/bin/env perl -w
# day07.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";
    my %bags = ();

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        %bags = get_bags($line, %bags);
    }

    close($fh);

    #print "Common vote count = $common_vote_sum\n";
}

sub get_bags {
    my $line = shift;
    $line =~ /^([a-z]+ [a-z]+) bags contain/;
    my $head = $1;
    $head =~ s/ /-/;

    my @tails = $line =~ /\d+ ([a-z]+ [a-z]+) bags?/g;
    #my @data = $line =~ /^(w+ \w+) bags contain/;
    #my @data = $line =~ /^(\w+ \w+) bags contain (\d+ \w+ \w+ bags?, )*(\d+ \w+ \w+) bags?.$/;
    #my @data = grep /^(\d+ \w+ \w+ bags?, )*/, $line;
    #my @data = grep /^w+ \w+ bags contain (\d+ \w+ \w+ bags?, )*\d+ \w+ \w+ bags?.$/, $line;
    #my @data = $line =~ /^(\w+ \w+) bags contain (\d+ \w+ \w+ bags?, )*\d+ (\w+ \w+) bags?.$/g;

    #print "$1\n";

    my $matches = scalar @tails;
    #my $

    if ($matches == 0) {
        print "Regexp failed for $line\n";
    }# else {
    #    print "$head: @tails\n";
    #}

    #if ($1) {
    #    print "$1 - $2 - $3 - $4 - $5\n";
    #} else {
    #    print "$line\n";
    #}

    return ();
}

main();
