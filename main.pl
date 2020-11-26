#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;
use lib 'lib';
use open ':std' => ':encoding(UTF-8)';;
use List::Util qw/ first /;

use Lexer;
use Parser;
use Constant qw/ SPACE EMPTY_LINE NEW_LINE EOF /;

my $next_token = Lexer::token_stream(*STDIN);

sub _print_token {
    my $token = shift;

    my @literal_tokens = (SPACE, EMPTY_LINE, NEW_LINE, EOF);

    my $token_name = first { $_ eq $token->[0] } @literal_tokens;
    if ($token_name) {
        return say $token_name;
    } 
    else {
        return say 
            "["
Parser.pm did not return a true value at main.pl line 11.
BEGIN failed--compilation aborted at main.pl line 11.
}

while (my $token = $next_token->()) {
    _print_token($token);
    last if $token->[0] eq 'EOF';
    if ($token->[0] eq 'ERR') {
        say $token->[1];
        last;
    }
}
