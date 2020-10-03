#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;
use lib 'lib';
use open ':std' => ':encoding(UTF-8)';;

use Lexer;

my $next_token = Lexer::token_stream(*STDIN);

sub print_token {
    my $token = shift;
    if ($token->[0] eq 'NEW_LINE') {
        return say "NEW_LINE";
    }
    if ($token->[0] eq 'EOF') {
        return say "EOF";
    }
    else {
        return say "[$token->[0], $token->[1]]";
    }
}

while (my $token = $next_token->()) {
    print_token($token);
    last if $token->[0] eq 'EOF';
    if ($token->[0] eq 'ERR') {
        say $token->[1];
        last;
    }
}
