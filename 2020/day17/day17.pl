#!/usr/bin/env perl -w
# day17.pl ---

use warnings;
use strict;
use List::Util qw/sum/;

sub main {
    my $x = 100;
    my $y = 100;
    my $z = 100;
    my $size = 0;

    my %cycle0 = ();
    my %cycle1 = ();
    my %cycle2 = ();
    my %cycle3 = ();
    my %cycle4 = ();
    my %cycle5 = ();
    my %cycle6 = ();

    my $file_name = "input.txt";

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);

        for (my $idx = 0; $idx < length($line); $idx++) {
            my $char = substr $line, $idx, 1;
            #print "$char";
            if ($char eq "#") {
                $x = 100 + $idx;
                my $key = "$x-$y-$z";
                #print "Setting key $key\n";
                $cycle0{$key} = 1;
            }
        }

        $y++
    }

    $size = hash_size(%cycle0);
    #print "size = $size\n\n";

    #$x = 99;
    #$y = 99;
    #$z = 99;

    for (my $x = 99; $x < 109; $x++) {
        for (my $y = 99; $y < 109; $y++) {
            for (my $z = 99; $z < 102; $z++) {
                my $key = "$x-$y-$z";
                my $neighbours = count_neighbours($x, $y, $z, %cycle0);
                if ($neighbours == 3) {
                    #print "Setting key $key\n";
                    $cycle1{$key} = 1;
                } elsif ($neighbours == 2) {
                    if (exists($cycle0{$key})) {
                        #print "Setting key $key\n";
                        $cycle1{$key} = 1;
                    }
                }
            }
        }
    }

    $size = hash_size(%cycle1);
    #print "size = $size\n";

    for (my $x = 98; $x < 110; $x++) {
        for (my $y = 98; $y < 110; $y++) {
            for (my $z = 98; $z < 103; $z++) {
                my $key = "$x-$y-$z";
                my $neighbours = count_neighbours($x, $y, $z, %cycle1);
                if ($neighbours == 3) {
                    $cycle2{$key} = 1;
                } elsif ($neighbours == 2) {
                    if (exists($cycle1{$key})) {
                        $cycle2{$key} = 1;
                    }
                }
            }
        }
    }

    $size = hash_size(%cycle2);
    #print "size = $size\n";

    for (my $x = 97; $x < 111; $x++) {
        for (my $y = 97; $y < 111; $y++) {
            for (my $z = 97; $z < 104; $z++) {
                my $key = "$x-$y-$z";
                my $neighbours = count_neighbours($x, $y, $z, %cycle2);
                if ($neighbours == 3) {
                    $cycle3{$key} = 1;
                } elsif ($neighbours == 2) {
                    if (exists($cycle2{$key})) {
                        $cycle3{$key} = 1;
                    }
                }
            }
        }
    }

    $size = hash_size(%cycle3);
    #print "size = $size\n";

    for (my $x = 96; $x < 112; $x++) {
        for (my $y = 96; $y < 112; $y++) {
            for (my $z = 96; $z < 105; $z++) {
                my $key = "$x-$y-$z";
                my $neighbours = count_neighbours($x, $y, $z, %cycle3);
                if ($neighbours == 3) {
                    $cycle4{$key} = 1;
                } elsif ($neighbours == 2) {
                    if (exists($cycle3{$key})) {
                        $cycle4{$key} = 1;
                    }
                }
            }
        }
    }

    $size = hash_size(%cycle4);
    #print "size = $size\n";

    for (my $x = 95; $x < 113; $x++) {
        for (my $y = 95; $y < 113; $y++) {
            for (my $z = 95; $z < 106; $z++) {
                my $key = "$x-$y-$z";
                my $neighbours = count_neighbours($x, $y, $z, %cycle4);
                if ($neighbours == 3) {
                    $cycle5{$key} = 1;
                } elsif ($neighbours == 2) {
                    if (exists($cycle4{$key})) {
                        $cycle5{$key} = 1;
                    }
                }
            }
        }
    }

    $size = hash_size(%cycle5);
    #print "size = $size\n";

    for (my $x = 94; $x < 114; $x++) {
        for (my $y = 94; $y < 114; $y++) {
            for (my $z = 94; $z < 107; $z++) {
                my $key = "$x-$y-$z";
                my $neighbours = count_neighbours($x, $y, $z, %cycle5);
                if ($neighbours == 3) {
                    $cycle6{$key} = 1;
                } elsif ($neighbours == 2) {
                    if (exists($cycle5{$key})) {
                        $cycle6{$key} = 1;
                    }
                }
            }
        }
    }

    $size = hash_size(%cycle6);
    print "size = $size\n";
}

sub count_neighbours {
    my $x = shift;
    my $y = shift;
    my $z = shift;
    my %grid = @_;

    my $answer = 0;

    for (my $i = $x - 1; $i < $x + 2; $i++) {
        for (my $j = $y - 1; $j < $y + 2; $j++) {
            for (my $k = $z - 1; $k < $z + 2; $k++) {
                my $key = "$i-$j-$k";
                $answer += exists($grid{$key});
            }
        }
    }

    $answer -= exists($grid{"$x-$y-$z"});
}

sub hash_size {
    return (scalar @_ / 2);
}

main();
