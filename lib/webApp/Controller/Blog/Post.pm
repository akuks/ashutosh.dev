package webApp::Controller::Blog::Post;

use Data::Dumper;

use Moose;
use namespace::autoclean;
use POSIX qw/strftime/;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

webApp::Controller::Blog::Post - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(3) {
    my ( $self, $c ) = @_;

    my $args = $c->request->arguments;
    my ($blog, $post);

    if ( ! $args->[2]) {
        $c->detach('__invalid_blog__');
    }

    eval {
        $blog = $c->model('DB::Blog')->search( { slug => $args->[2] } );
    };
    
    # If the above query fails
    if ($@) {
        $c->detach('__error_in_db__');
    }

    # Detach if invalid slug is there
    unless ($blog->first) {
        $c->detach('__invalid_blog_slug__');
    }

    eval {
        $post = $c->model('DB::BlogDetail')->search( { blog_id => $blog->first->id } );
    };

    # If the above query fails
    if ($@) {
        $c->detach('__error_in_db__');
    }

    # Detach if invalid slug is there
    unless ($post->first) {
        $c->detach('__details_not_available_for_blog__');
    }
    
    #$post = $post->first;

    my @post_details = map { { 
        blog_id     => $_->blog_id,
        body        => $_->blog_text,
        title       => $_->blog->title,
        author      => $_->blog->user->first_name,
        create_date => $_->blog->creation_date->strftime('%B %d, %Y'),
    } } $post->first;

    $c->stash(
        template => 'blog/post.tt',
        post     => \@post_details,
        category => [
            map { { 
                id    => $_->id,
                name  => $_->name,
                count => _get_topic_count_by_category($c, $_->id)
            } } @{$c->config->{category}}
        ],
    );
}


sub post_edit :Chained('/') PathPart('blog/post/edit') :Args(0) GET {
    my ($self, $c) = @_;

    unless ( $c->user_exists ) {
        $c->res->redirect('/'); $c->detach();                # Go to home page if user is not logged in
    }

    my $params = $c->req->params;

    my $blog;

    eval {
        $blog = $c->model('DB::Blog')->search({ id => $params->{id} });
    };

    if ($@) {
        $c->res->body("Error in querying database. Please contact system administrator");
        $c->detach();
    }

    if (! $blog->first) {
        $c->res->body("Invalid blog ID."); $c->detach();
    }

    #$c->res->body(Dumper( $blog->first->blog_details->get_column('blog_text')->first )); $c->detach();

    $c->stash(
        template => 'blog/post_edit.tt',
        
        # Category
        category => [
            map { { 
                id    => $_->id,
                name  => $_->name,
            } } @{ $c->config->{category} }
        ],

        # Post Details
        post     => map { { 
            blog_id  => $blog->first->id,
            title    => $blog->first->title,
            slug     => $blog->first->slug,
            category => $blog->first->category->name,
            body     => $blog->first->blog_details->get_column('blog_text')->first,
            body_id  => $blog->first->blog_details->get_column('id')->first,
        } } $blog->first,
    );
}

sub post_edit_post :Chained('/') PathPart('blog/post/edit') :Args(0) POST {
    my ($self, $c) = @_;

    unless ( $c->user_exists ) {
        $c->res->redirect('/'); $c->detach();                # Go to home page if user is not logged in
    }

    my $params = $c->req->params;

    my ($blog, $message);

    eval {
        $blog = $c->model('DB::Blog')->search({ id => $params->{id} });
    };

    if ($@) {
        $c->res->body("Error in querying database. Please contact system administrator");
        $c->detach();
    }

    if (! $blog->first) {
        $c->res->body("Invalid blog ID."); $c->detach();
    }

    eval {
        $blog->first->update({
            category_id => $params->{category},
            title       => $params->{title},
            slug        => ($params->{slug}) ? (lc $params->{slug}) : $c->forward('_get_slug_if_not_defined', [$params->{slug}]),
            status      => ($params->{publish_post}) ? 1 : 2,
            update_date => strftime("%Y-%m-%d %H:%M:%S", localtime),
        });
    };

    if ($@) {
        $c->res->body("Error in updating database.".$@); $c->detach();
    }

    my $mod_body = $params->{body} =~ s/'/\\\'/r;

    #$c->res->body(($mod_body)); $c->detach();
    eval {
        $c->model('DB::BlogDetail')->update_or_create({ 
            id        => $params->{body_id},
            blog_id   => $params->{id},
            blog_text => $mod_body
        });
    };

    if ($@) {
        $c->res->body("Error in updating blog body.".$@); $c->detach();
    }    
    else {
        $message = "Blog updated Successfully."
    }

    #$c->res->body(Dumper( $blog->first->blog_details->get_column('blog_text')->first )); $c->detach();

    $c->stash(
        template => 'blog/post_edit.tt',
        
        # Category
        category => [
            map { { 
                id    => $_->id,
                name  => $_->name,
            } } @{ $c->config->{category} }
        ],

        # Post Details
        post     => map { { 
            blog_id  => $blog->first->id,
            title    => $blog->first->title,
            slug     => $blog->first->slug,
            category => $blog->first->category->name,
            body     => $blog->first->blog_details->get_column('blog_text')->first,
            body_id  => $blog->first->blog_details->get_column('id')->first,
        } } $blog->first,

        message      => $message
    );
}

=head2 METHOD
    

=cut

sub _get_topic_count_by_category {
    my ($c, $category_id) = @_;

    my $category = $c->model('DB::Blog')->search ({ category_id => $category_id});

    return $category->count;
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

=encoding utf8

=head1 AUTHOR

Ashutosh Kukreti

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
