#!/usr/bin/env perl -w
# day04.pl ---

use warnings;
use strict;

sub main {
    my $file_name = "input.txt";
    my $valid_creds = 0;
    my $full_valid_creds = 0;
    my $next_creds = "";

    open(my $fh, "<", $file_name) or die("Could not open file");

    foreach my $line (<$fh>) {
        chomp($line);
        if ($line eq "") {
            $valid_creds += is_valid_creds($next_creds);
            $full_valid_creds += is_full_valid_creds($next_creds);
            $next_creds = "";
        } else {
            $next_creds .= " $line ";
        }
    }

    close($fh);

    $valid_creds += is_valid_creds($next_creds);
    $full_valid_creds += is_full_valid_creds($next_creds);
    print "Valid credential count = $valid_creds\n";
    print "Valid full credential count = $full_valid_creds\n";
}

sub is_valid_creds {
    my $creds = shift;

    if ($creds =~ /( byr:)/
            and $creds =~ /( iyr:)/
            and $creds =~ /( eyr:)/
            and $creds =~ /( hgt:)/
            and $creds =~ /( hcl:)/
            and $creds =~ /( ecl:)/
            and $creds =~ /( pid:)/
        ) {
        return 1;
    }

    return 0;
}

sub is_full_valid_creds {
    my $creds = shift;

    if ($creds =~ /( byr:(19[2-9][0-9]|200[0-2]) )/
            and $creds =~ /( iyr:20(1[0-9]|20) )/
            and $creds =~ /( eyr:20(2[0-9]|30) )/
            and $creds =~ /( hgt:(1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in) )/
            and $creds =~ /( hcl:#[0-9a-f]{6} )/
            and $creds =~ /( ecl:(amb|blu|brn|gry|grn|hzl|oth) )/
            and $creds =~ /( pid:\d{9} )/
        ) {
        return 1;
    }

    return 0;
}

main();
