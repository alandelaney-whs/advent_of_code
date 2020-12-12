#!/usr/bin/env perl -w
# day06.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";
    my $common_vote_sum = 0;
    my $all_vote_sum = 0;
    my %isect = ();
    my %union = ();
    my $first_line = 1;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);

        if ($line eq "") {
            $common_vote_sum += scalar keys %isect;
            $all_vote_sum += scalar keys %union;
            %isect = ();
            %union = ();
            $first_line = 1;
        } elsif ($first_line) {
            %isect = get_union($line, %isect);
            %union = get_union($line, %union);
            $first_line = 0;
        } else {
            %isect = get_intersection($line, %isect);
            %union = get_union($line, %union);
            $first_line = 0;
        }
    }

    close($fh);

    print "Common vote count = $common_vote_sum\n";
    print "Total vote count = $all_vote_sum\n";
}

sub get_intersection {
    my ($str, %current) = @_;
    my @chars = split //, $str;
    my %isect = ();

    foreach my $elem (@chars) {
        if ($current{$elem}) {
            $isect{$elem}++;
        }
    }

    return %isect;
}

sub get_union {
    my ($str, %union) = @_;
    my @chars = split //, $str;

    foreach my $elem (@chars) {
        $union{$elem}++;
    }

    return %union;
}

main();
