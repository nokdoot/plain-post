package Lexer;

use feature qw/ say /;
use Data::Dumper;

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
    my ($input, $label, $pattern) = @_;
    my @tokens;
    my ($buf, $finished) = ("");
    my $split = sub { split /($pattern)/, $_[0] };
    my $maketoken = sub { [$label, $_[0] ]};
    sub {
        while (@tokens == 0 && ! $finished) {
            my $i = $input->();
            if (ref $i) {
                my ($sep, $tok) = $split->($buf);
                $tok = $maketoken->($tok) if defined $tok;
                push @tokens, grep defined && $_ ne "", $sep, $tok, $i;
                $buf = "";
            }
            else {
                $buf .= $i if defined $i;
                my @newtoks = $split->($buf);
                while (@newtoks > 2
                       || @newtoks && ! defined $i) {
                    push @tokens, shift(@newtoks);
                    push @tokens, $maketoken->(shift @newtoks) if @newtoks;
                }
                $buf = join "", @newtoks;
                $finished = 1 if ! defined $i;
                @tokens = grep $_ ne "", @tokens;
            }
        }
        return shift(@tokens);
    }
}
