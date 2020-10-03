#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use feature qw/ say /;

sub next_paragraph {
    local $/ = '\n';
    my $a = <DATA>;
    say $a;
}

next_paragraph();

__DATA__
한줄a

두줄
두줄

세줄
세줄
세줄

다시 한줄

다시 두줄
다시 두줄
