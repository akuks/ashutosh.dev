package webApp::Controller::Blog;
use Moose;
use namespace::autoclean;

use strict;
use Data::Dumper;
use POSIX;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

webApp::Controller::Blog - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 GET /blog/new
    :GET /blog/new
        summary: Create a new blog in Database
=cut

sub index :Chained('/') PathPart('blog/new') :Args(0) GET {
    my ( $self, $c ) = @_;

    unless ($c->user_exists and $c->user->email eq 'kukreti.ashutosh@gmail.com') {
        $c->res->redirect('/');
    }
    
    $c->stash(
        template => 'blog/create_post.tt',
        category => [
            map { { 
                id    => $_->id,
                name  => $_->name,
            } } @{ $c->config->{category} }
        ],
    );
}

=head2 POST /blog/new
    
    :POST /blog/new
        summary: Create a new blog in Database
        parameters:
            - in: body
                name: title
                type: string
                description: Title of the blog (must be unique)

            - in: body
                name: body
                type: string
                description: Body of the blog

            - in: body
                name: category
                type: integer
                description: Category ID
            
            - in: body
                name: slug
                type: string
                description: URL slug
            
            - in: body
                name: status
                type: integer
                description: Status of the blog (Draft or Publish)

=cut

sub blog_post :Chained('/') PathPart('blog/new') :Args(0) POST {
    my ( $self, $c ) = @_;

    unless ($c->user_exists and $c->user->email eq 'kukreti.ashutosh@gmail.com') {
        $c->res->redirect('/');
    }

    my $params = $c->req->params;
    
    my $status;

    my $is_title_unique = $c->forward('_is_title_unique', [$params]);
    
    if (! $is_title_unique ) {
        $status = $c->forward('_create_blog', [$params]);
        
        if ($status) {
            my $body_status = $c->forward('_update_or_create_blog_body', [$params->{body}, $status]);

            if ($body_status) {
                $c->res->body("Post created succesfully. <a href='/admin/panel/dashboard'> Go to Admin Dashboard </a>");
                $c->detach();
            }
            else {
                $c->res->body("Can't Update blog body. Please check the DB logs or <a href='/admin/panel/dashboard'> Go to Admin Dashboard </a>");
                $c->detach();
            }
        }
    }
    $c->res->body("Post created succesfully. <a href='/admin/panel/dashboard'> Go to Admin Dashboard </a>");
}

=head1 METHOD
    NAME: _is_title_unique
    DESC: Check if the title is unique
    
    Parameters:
        --> name: title
            type: string
            description: Title of the blog
        
        --> name: slug
            type: string
            description: slug of the blog
=cut

sub _is_title_unique : Private {
    my ($self, $c, $params) = @_;

    my $blog = $c->model('DB::Blog')->search({
        -or => [
            title => $params->{title},
            slug  => $params->{slug},
        ]
    });

    # If found
    if ($blog->first) {
        my $ret = ( $blog->first->title eq $params->{title} ) ? 1 : 2;
        
        return $ret;
    }
    else {
        return 0;
    }
}

=head1 METHOD
    NAME: _create_blog
    DESC: Enter the blog in the database

    Parameters:
        --> name: title
            type: string
            description: Title of the blog
        
        --> name: slug
            type: string
            description: slug of the blog

        --> name: status
            type: integer
            description: Status of the blog (Draft or Publish)
        
        --> name: category_id
            type: integer
            description: Category ID
=cut

sub _create_blog :Private {
    my ($self, $c, $params) = @_;
    
    my $res;

    eval {
        $res = $c->model('DB::Blog')->update_or_create({
            user_id     => 1,
            category_id => $params->{category},
            title       => $params->{title},
            slug        => ($params->{slug}) ? (lc $params->{slug}) : $c->forward('_get_slug_if_not_defined', [$params->{slug}]),
            status      => ($params->{publish_post}) ? 1 : 2,
            update_date => strftime("%Y-%m-%d %H:%M:%S", localtime),
        });
    };

    ($@) ? return 0 : return $res; # If Query fails return 0 else return 1
}

=head1 METHOD
    NAME: _get_slug_if_not_defined
    DESC: Get the slug for the URL if not received from the frontend
=cut

sub _get_slug_if_not_defined  :Private {
    my ($self, $c, $slug) = @_;

    my $new_slug = $slug =~ s/ +/-/r;

    return ( lc  $new_slug );
}

=head1 METHOD
    NAME: _update_or_create_blog_body
    DESC: update or create blog body
=cut
sub _update_or_create_blog_body :Private {
    my ($self, $c, $body, $res) = @_;

    eval {
        $c->model('DB::BlogDetail')->update_or_create( {
            blog_id => $res->id,
            blog_text => $body,
        });
    };
    
    ($@) ? return 0 : return 1;
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
