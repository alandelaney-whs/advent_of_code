#!/usr/bin/env perl -w
# day08.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";
    my @instructions = ();
    my $index = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        my $next_inst = get_inst($line);
        push @instructions, $next_inst;
    }

    close($fh);

    my ($completed, $accum) = run_instructions(@instructions);

    if ($completed) {
        print "Instructions completed.  Accum = $accum\n";
    } else {
        print "Loop detected.  Accum = $accum\n";
    }

    while (not $completed) {
        foreach my $elem (@instructions) {
            $elem->{visited} = 0;
        }

        my $inst = $instructions[$index]{inst};
        my $pos = $instructions[$index]{pos};
        my $value = $instructions[$index]{value};
        my $visited = $instructions[$index]{visited};

        if ($inst eq "jmp") {
            $instructions[$index]{inst} = "nop";
            ($completed, $accum) = run_instructions(@instructions);
            $instructions[$index]{inst} = "jmp";
        } elsif ($inst eq "nop") {
            $instructions[$index]{inst} = "jmp";
            ($completed, $accum) = run_instructions(@instructions);
            $instructions[$index]{inst} = "nop";
        }

        $index++;
    }

    print "Instructions completed.  Accum = $accum\n";
}

sub get_inst {
    my $line = shift;
    my $answer = {};

    $line =~ /^(acc|jmp|nop) (\+|\-)(\d+)$/;

    $answer->{inst} = $1;
    $answer->{pos} = $2 eq "+" ? 1 : 0;
    $answer->{value} = $3;
    $answer->{visited} = 0;

    return $answer;
}

sub run_instructions {
    my @instructions = @_;
    my $len = scalar @instructions;
    my $index = 0;
    my $accum = 0;

    while (1) {
        if ($index == $len) {
            return 1, $accum;
        }

        my $inst = $instructions[$index]{inst};
        my $pos = $instructions[$index]{pos};
        my $value = $instructions[$index]{value};
        my $visited = $instructions[$index]{visited};

        if ($visited) {
            return 0, $accum;
        }

        $instructions[$index]{visited} = 1;

        if ($inst eq "nop") {
            $index++;
        } elsif ($inst eq "acc") {
            if ($pos) {
                $accum += $value
            } else {
                $accum -= $value;
            }
            $index++;
        } elsif ($inst eq "jmp") {
            if ($instructions[$index]{pos}) {
                $index += $value;
            } else {
                $index -= $value;
            }
        } else {
            print "Error - inst = $inst\n";
        }
    }
}

main();
