use strict;
use warnings;
package App::json2perl;
# ABSTRACT: Convert JSON data to Perl 5 code

our $VERSION = '0.01';


use JSON::MaybeXS qw<decode_json>;
use Data::Dumper  qw<Dumper>;


sub run
{
    my @args = @_;
    binmode(STDIN, ':raw');
    my $data = decode_json do { local $/; <STDIN> };

    local $Data::Dumper::Indent = 0;
    local $Data::Dumper::Purity = 0;
    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Sortkeys = 1;
    local $Data::Dumper::Quotekeys = 0;

    print Dumper($data), "\n";
}

1;
