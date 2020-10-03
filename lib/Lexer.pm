package Lexer;

use strict;
use warnings;

use constant COMMAND => 'COMMAND';
use constant WORD => 'WORD';
use constant SPACE => 'SPACE';
use constant ERR => 'ERR';
use constant EOF => 'EOF';
use constant NEW_LINE => 'NEW_LINE';

sub token_stream {
    my $fh = shift;
    my $line = undef;
    return sub { 
        my $pos = pos($line);
        if (!$line or !$pos or length($line) == $pos) {
            $line = readline($fh);
        }

        return [EOF, undef] if !defined $line;
        return [NEW_LINE, undef] if $line =~ /\G (\n) /gcx;
        return [SPACE, $1] if $line =~ /\G (\s+) /gcx;
        return [COMMAND, $1] if $line =~ /\G (^=) /gcx;
        return [WORD, $1] if $line =~ /\G ([\p{L}\p{N}]+) /gcxu;
        return [ERR, $line];
    }
}

1;
