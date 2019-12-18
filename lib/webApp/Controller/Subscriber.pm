package webApp::Controller::Subscriber;
use Moose;
use JSON;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

webApp::Controller::Subscriber - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) GET {
    my ( $self, $c ) = @_;

    my $params = $c->req->params;

    my $subs = $c->model('DB::Subscriber')->search({ user_email => $params->{email} });
   
   # Validate Captcha
   if ( ! $c->validate_captcha ($params->{captcha}) ) {
       $c->res->body(encode_json({message => 'Invalid Captcha.' }));
       $c->detach();
   }

    if ($subs->count > 0) {
        $c->res->body(encode_json({message => 'User already subscribed.' }));
    }
    else {
        eval {
            $subs = $c->model('DB::Subscriber')->create( { user_email => $params->{email} });
        };
        
        # Handling DB errors
        if ($@) {
            $c->res->body(encode_json({message => 'Error in updating.' }));
        }
        else {
            $c->res->body(encode_json({message => 'User subscribed successfully.' }));
        }
    }
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
