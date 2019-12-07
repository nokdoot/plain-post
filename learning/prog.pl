#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;

use Data::Dumper;

use lib './';

use Lexer qw/ make_charstream records tokens /;

my %optype = (
    '+'  => ['ARITHMETIC', 3],
    '-'  => ['ARITHMETIC', 3],
    '*'  => ['ARITHMETIC', 4],
    '/'  => ['ARITHMETIC', 4],
    '**' => ['ARITHMETIC', 5],
    'x'  => ['STRING'    , 4],
    '.'  => ['STRING'    , 3],
);

my $stdin = make_charstream(\*STDIN);

my $a = tokens($stdin, \%optype, qr/\*\*|[-+*\/x.].../,
    sub { 
        my $optype = $_[1];
        [ "OPERATOR", @{$optype->{$_[0]}}, $_[0] ]
    }
);
# my $a = tokens($stdin, "WHITESPACE", qr/\s+/);
# my $a = tokens($stdin, "WHITESPACE", qr/\s+/, sub { "" } );

while ( my $output = $a->() ) {
    if ( ref $output ) {
        say Dumper @$output;
    }
    else {
        say $output;
    }
}
