#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;

use Data::Dumper;

use lib './';

use Lexer qw/ make_charstream records tokens /;

my $stdin = make_charstream(\*STDIN);

my $a = tokens($stdin, "numeral", qr/\d+/);

while ( my $output = $a->() ) {
    if ( ref $output ) {
#         say "@$output";
    }
    else {
#         say $output;
    }
}
