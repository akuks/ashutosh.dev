use strict;
use warnings;
use Test::More;


use Catalyst::Test 'webApp';
use webApp::Controller::Blog;

ok( request('/blog')->is_success, 'Request should succeed' );
done_testing();
