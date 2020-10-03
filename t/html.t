#!/usr/bin/env perl

use strict;
use warnings;

use local::lib './local';
use lib 'lib';

use feature qw/ say /;

use Mojo::DOM;

my $dom = Mojo::DOM->new;

$dom->parse('<div><h1>Test</h1></div>')
  ->at('h1')->append('<h2>123</h2>')->root;

say $dom;
