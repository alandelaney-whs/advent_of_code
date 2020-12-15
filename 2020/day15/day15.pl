#!/usr/bin/env perl -w
# day15.pl ---

use warnings;
use strict;

use constant {
    FALSE => 0,
    TRUE => 1,
};

sub main {
    my $answer1 = get_score(2020, 14,1,17,0,3,20);
    my $answer2 = get_score(30000000, 14,1,17,0,3,20);
    print "Answer to part 1 = $answer1\n";
    print "Answer to part 2 = $answer2\n";
}

sub get_score {
    my $iters = shift;
    my @input = @_;
    my $idx = 1;
    my %values = ();

    foreach my $elem (@input) {
        $values{$elem} = $idx;
        $idx++;
    }

    my $next_val = 0;

    while ($idx < $iters) {
        my $curr_val = $next_val;

        if (exists($values{$curr_val})) {
            $next_val = $idx - $values{$curr_val};
        } else {
            $next_val = 0;
        }

        $values{$curr_val} = $idx;
        $idx++;
    }

    return $next_val;
}

sub show_hash {
    my %hash = @_;
    my @vals = sort(keys %hash);

    foreach my $key (@vals) {
        my $val = $hash{$key};
        print "$key = $val, ";
    }

    print "\n";
}

main();
