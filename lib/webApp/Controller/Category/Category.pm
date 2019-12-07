package webApp::Controller::Category::Category;
use Moose;
use namespace::autoclean;
use JSON;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

webApp::Controller::Category::Category - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub cat_create :Path :Args(0) GET {
    my ( $self, $c ) = @_;

    # If user is not admin and login go to home page
    unless ($c->user_exists and $c->user->role->role_name eq 'admin') {
        $c->res->redirect ('/'); $c->detach();
    }

    $c->stash(
        template => 'category/category.tt',
        category => [
            map { { 
                id    => $_->id,
                name  => $_->name,
            } } @{$c->config->{category}}
        ],
    );
}

=head2 index

=cut

sub cat_get :Chained('/') PathPart('category/category/get') :Args(0) GET {
    my ( $self, $c ) = @_;

    # If user is not admin and login go to home page
    unless ($c->user_exists and $c->user->role->role_name eq 'admin') {
        $c->res->redirect ('/'); $c->detach();
    }

    my $count = 1;

    my @category =  map { { 
        id    => $_->id,
        count => $count++,
        name  => $_->name,
    } } @{$c->config->{category}} ;
    
    $c->res->body(encode_json ({ category => \@category}) );
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
