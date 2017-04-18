use strict;
use warnings;

use Plack::Middleware::TemplateToolkit;
use Plack::Builder;

my $body = '<html><body>Hellow world - sweet</body></html>';

my $app = sub {
    my $self = shift;
    return [ 200, [ 'Content-Type' => 'text/html' ], [$body] ];
};

my $root = './htdocs/';

builder {

    # Page to show when requested file is missing
    enable 'ErrorDocument',    #
        404 => "$root/page_not_found.html";

    # These files can be served directly
    enable 'Static',
        path => qr{\.(gif|png|jpg|swf|ico|mov|mp3|pdf|js|css)$},
        root => $root;

    enable 'TemplateToolkit',
        INCLUDE_PATH => $root,    # required
        pass_through => 1;        # delegate missing templates to $app

    $app;
}

