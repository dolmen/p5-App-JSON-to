use strict;
use warnings;

package App::JSON::to::yaml;

our $VERSION = '0.01';

use YAML::Tiny ();


sub encoding
{
    'UTF-8'
}

sub dump
{
    YAML::Tiny->new($_[1])->write_string
}

1;
