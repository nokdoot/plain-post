#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;

use Data::Dumper;

use lib './';

use Lexer qw/ make_charstream records tokens /;

my $str = "a = 12345679 * 6";

my $a = tokens($str);
say Dumper $a->();
say Dumper $a->();
say Dumper $a->();
say Dumper $a->();
say Dumper $a->();

__DATA__
---

