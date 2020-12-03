#!/usr/bin/env perl -w
# day02.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";
    my $valid_password_1 = 0;
    my $valid_password_2 = 0;

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        $valid_password_1 += is_valid_password_1($line);
        $valid_password_2 += is_valid_password_2($line);
    }

    close($fh);
    print "Valid password count 1 = $valid_password_1\n";
    print "Valid password count 2 = $valid_password_2\n";
}

sub is_valid_password_1 {
    my $line = shift;

    $line =~ /^(\d*)-(\d*) ([a-z]): ([a-z]*)$/;
    my $min = $1;
    my $max = $2;
    my $char = $3;
    my $password = $4;
    my $count = () = $password =~ /$char/g;

    if ($count >= $min and $count <= $max) {
        return 1;
    }

    return 0;
}

sub is_valid_password_2 {
    my $line = shift;

    $line =~ /^(\d*)-(\d*) ([a-z]): ([a-z]*)$/;
    my $pos1 = $1 - 1;
    my $pos2 = $2 - 1;
    my $char = $3;
    my $password = $4;
    my $match1 = substr($password, $pos1, 1);
    my $match2 = substr($password, $pos2, 1);

    return ($match1 eq $char) + ($match2 eq $char) == 1;
}

main();
