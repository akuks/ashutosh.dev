use strict;
use warnings;
use Test::More;


use Catalyst::Test 'webApp';
use webApp::Controller::Blog::Post;

ok( request('/blog/post')->is_success, 'Request should succeed' );
done_testing();
