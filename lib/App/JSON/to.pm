use strict;
use warnings;

package App::JSON::to;
# ABSTRACT: Convert JSON data to various formats

our $VERSION = '0.01';

use JSON::MaybeXS qw<decode_json>;

sub run
{
    my ($to, @args) = @_;
    $to = lc $to;

    die "missing target format\n" unless defined $to;
    die "invalid target format '$to'\n"
	unless $to =~ /\A[a-z]+\z/ && eval { require "App/JSON/to/$to.pm"; 1 };
    my $class = __PACKAGE__ . '::' . $to;
    my $obj = $class->can('new') ? $class->new : $class;

    # TODO parse options
    # GetOptions($obj->options);

    binmode(STDIN, ':raw');
    my $data = decode_json do { local $/; <STDIN> };

    if (my $enc_meth = $obj->can('encoding')) {
	binmode(STDOUT, ':encoding('.$obj->$enc_meth().')');
    }

    print $obj->dump($data);
}

1;
