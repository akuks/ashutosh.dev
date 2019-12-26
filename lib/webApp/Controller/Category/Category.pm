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


=head2 GET /category/category
    :/category/category
        summary: To create a category
        parameters: 
            - in: url
                name: category
                type: string
                description: Category name 

=cut

sub cat_create :Path :Args(0) GET {
    my ( $self, $c ) = @_;

    # If user is not admin and login go to home page
    unless ($c->user_exists and $c->user->role->role_name eq 'admin') {
        $c->res->redirect ('/'); $c->detach();
    }

    my $params = $c->req->params;
    my ($category, $message, $error);

    eval {
        $category = $c->model('DB::Category')->update_or_create({
            name => $params->{category}
        }) if ($params->{category});
    };
    
    if ($@) {                                                                       # If any error
        $message = 'Category may exists or is blank. Please contact system administrator.';
        $error = 2;
    }
    else {
        $message = 'Category created successfully.';
        $error = 1;
    }

    $c->stash(
        template => 'category/category.tt',
        category => [
            map { { 
                id    => $_->id,
                name  => $_->name,
            } } @{$c->config->{category}}
        ],
        message => $message,
        error   => $error
    );
}

=head2 GET /category/category/get
    :/category/category
        summary: To get the list of categories
        parameters: null
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

=head2 GET /category/category/remove
    :/category/category/remove
        summary: To get the list of categories
        parameters: 
            - in: url
                name: category
                type: id
                description: Category ID to be deleted 

=cut

sub cat_remove :Chained('/') PathPart('category/category/remove') :Args(0) GET {
    my ( $self, $c ) = @_;

    # If user is not admin and login go to home page
    unless ($c->user_exists and $c->user->role->role_name eq 'admin') {
        $c->res->redirect ('/'); $c->detach();
    }

    my $params = $c->req->params;
    
    $c->res->body(encode_json ({ message => 'Category removed succesfully.'}) );
}

=head2 GET /category/category/enable
    :/category/category/enable
        summary: To get the list of categories
        parameters: 
            - in: url
                name: category
                type: id
                description: Category ID to be deleted 

=cut

sub cat_enable :Chained('/') PathPart('category/category/enable') :Args(0) GET {
    my ( $self, $c ) = @_;

    # If user is not admin and login go to home page
    unless ($c->user_exists and $c->user->role->role_name eq 'admin') {
        $c->res->redirect ('/'); $c->detach();
    }

    my $params = $c->req->params;
    
    $c->res->body(encode_json ({ message => 'Category enabled succesfully.'}) );
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
