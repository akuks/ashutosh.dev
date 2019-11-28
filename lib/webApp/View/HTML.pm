package webApp::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    CATALYST_VAR => 'c',
    ENCODING     => 'utf-8',
    WRAPPER      => 'common/header.tt',
    render_die => 1,
);

=head1 NAME

webApp::View::HTML - TT View for webApp

=head1 DESCRIPTION

TT View for webApp.

=head1 SEE ALSO

L<webApp>

=head1 AUTHOR

Ashutosh Kukreti

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
