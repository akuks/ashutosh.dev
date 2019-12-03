package webApp::Controller::Admin::Panel;
use Moose;
use Crypt::PBKDF2;
use Digest::SHA1 'sha1_base64';
use Data::Dumper;
use Safe::Isa;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

webApp::Controller::Admin::Panel - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub login :Chained('/') PathPart('admin/panel/login') CaptureArgs(0) {}

sub login_form :Chained('/') PathPart('admin/panel/login') Args(0) GET {
    my ($self, $c) = @_;

    # load the login template
    $c->stash(
        template => 'auth/login.tt'
    );
}

sub login_form_POST :Chained('/') PathPart('admin/panel/login') Args(0) POST {
    my ($self, $c) = @_;

    my $params   = $c->req->params;

    my $username = $params->{username};
    my $password = $params->{password};

    #$c->res->body(Dumper($params)); $c->detach();

    if ($username and $password) {
        if ( $c->authenticate( { email => $username, password => $password } ) ) {
            
            $c->res->redirect('/admin/panel/dashboard');
            
        }
        else {
            $c->forward('login_form', ['Invalid User credentials.']);
        }
    }
    else {
        $c->forward('login_form', ['Invalid User credentials.']);
    }
}

sub dashboard :Chained('/') PathPart('admin/panel/dashboard') GET {
    my ($self, $c) = @_;

    unless ($c->user_exists and $c->user->email eq 'kukreti.ashutosh@gmail.com') {
        $c->res->redirect('/');
    }

    my @blog = $c->model('DB::Blog')->search({});
    my $i = 0;

    $c->stash(
        template => 'dashboard/dashboard.tt',
        blogs    => [
            map { { 
                # User details
                user        => {  
                    user_id  => $_->user->id,
                    username => $_->user->first_name,
                },
                count       => $i++,
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
            } } @blog
        ],
    );
}

sub logout :Chained('/') PathPart('admin/panel/logout') GET {
    my ($self, $c) = @_;

    $c->logout;

    $c->res->redirect('/');
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
