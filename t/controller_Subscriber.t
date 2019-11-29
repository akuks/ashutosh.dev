use strict;
use warnings;
use Test::More;


use Catalyst::Test 'webApp';
use webApp::Controller::Subscriber;

ok( request('/subscriber')->is_success, 'Request should succeed' );
done_testing();
