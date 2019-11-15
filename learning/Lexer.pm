package Lexer;

use base "Exporter";
@EXPORT_OK = qw/ 
    make_charstream 
    blocks
    records
    tokens
    iterator_to_stream
    make_lexer
    allinput
/;

%EXPORT_TAGS = ('all' => \@EXPORT_OK);

sub make_charstream {
    my $fh = shift;
    return sub { return getc($fh) };
}

sub records {
    my $input = shift;
    my $terminator = @_ ? shift : quotemeta($/);
    my @records;
    my @newrecs = split /($terminator)/, $input;

    while ( @newrecs > 2 ) {
        push @records, shift(@newrecs).shift(@newrecs);
    }
    push @records, @newrecs;
    return sub {
        return shift @records;
    }
}

sub tokens {
    my $target = shift;
    return sub {
        TOKEN: {
            return ['integer', $1] if $target =~ /\G (\d+)/gcx;
            return ['print'] if $target =~ /\G print \b/gcx;
            return ['identifier', $1] if $target =~ /\G ([A-Za-z_]\w*)/gcx;
            return ['operator', $1] if $target =~ /\G (\*\*)/gcx;
            return ['operator', $1] if $target =~ /\G ([-+*\/=()])/gcx;
            return ['terminator', $1] if $target =~ /\G (; \n* | \n+)/gcx;
            redo TOKEN if $target =~ /\G \s+/gcx;
            return ['unknown', $1] if $target =~ /\G (.)/gcx;
            return;
        }
    }
}
