use strict;
use warnings;

use Plack::Builder;

my $body = '<html><body>Hellow world - sweet</body></html>';

my $app = sub {
    my $self = shift;
    return [ 200, [ 'Content-Type' => 'text/html' ], [$body] ];
};

builder {
    enable "Plack::Middleware::Static",
        path => qr{^/(images|js|css)/},
        root => './htdocs/';
    $app;
};
