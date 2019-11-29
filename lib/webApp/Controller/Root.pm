package webApp::Controller::Root;
use Moose;
use Data::Dumper;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

webApp::Controller::Root - Root Controller for webApp

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 auto

=cut

sub auto :Private {
    my ($self, $c) = @_;

    my @category = $c->model('DB::Category')->search({});

    $c->config->{category} = \@category;

    return ($c->config->{category});
}
    

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my $params = $c->req->params;

    my @blog;

    # If category or search topic is passed in parameters
    my @blog = ( $params->{category} || $params->{search} ) ? 
        _get_blog_list($c, $params) : $c->model('DB::Blog')->search({}) ;

    @blog = map { { 
        # User details
        user        => {  
            user_id  => $_->user->id,
            username => $_->user->first_name,
        },
        blog_id     => $_->id,
        title       => $_->title,
        slug        => $_->slug,
        status      => $_->status,
        
        # Category belongs to
        category    => {
            id   => $_->category->id,
            name => $_->category->name
        },

        # Dates
        year        => $_->creation_date->strftime('%Y'),
        month       => $_->creation_date->strftime('%m'),
        create_date => $_->creation_date->strftime('%B %d, %Y'),
        update_date => $_->update_date->date,
    } } @blog;

    my @category = $c->model('DB::Category')->search({});

    # Hello World
    $c->stash(
        template => 'home.tt',
        title    => 'Ashutosh Personal Web Blog',
        blogs    => \@blog,
        category => [
            map { { 
                id    => $_->id,
                name  => $_->name,
                count => _get_topic_count_by_category($c, $_->id)
            } } @category
        ],
    );
}

=head2 METHOD
    

=cut

sub _get_blog_list {
    my ($c, $params) = @_;

    if ( $params->{category} ) {
        return $c->model('DB::Blog')->search({ category_id => $params->{category} });
    }
    elsif ( $params->{search}) {
        return (
            $c->model('DB::Blog')->search({ title => { -like => '%'.$params->{search}.'%' } })
        );
    }
}

=head2 METHOD
    

=cut

sub _get_topic_count_by_category {
    my ($c, $category_id) = @_;

    my $category = $c->model('DB::Blog')->search ({ category_id => $category_id});

    return $category->count;
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Ashutosh Kukreti

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
