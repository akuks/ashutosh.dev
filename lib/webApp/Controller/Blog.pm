package webApp::Controller::Blog;
use Moose;
use namespace::autoclean;

use strict;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

webApp::Controller::Blog - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    
    $c->stash(
        template => 'blog/post.tt',
        blog     => 'hello'
    );
}



=encoding utf8

=head1 AUTHOR

Ashutosh Kukreti

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
