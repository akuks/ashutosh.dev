package webApp::Controller::Blog::Post;

use Data::Dumper;

use Moose;
use namespace::autoclean;

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

=head2 METHOD
    

=cut

sub _get_topic_count_by_category {
    my ($c, $category_id) = @_;

    my $category = $c->model('DB::Blog')->search ({ category_id => $category_id});

    return $category->count;
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
