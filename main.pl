#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;
use lib 'lib';

use Lexer;

my $next_line = Lexer::next_token(\*STDIN);
say $next_line->();
