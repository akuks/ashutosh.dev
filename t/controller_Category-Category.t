use strict;
use warnings;
use Test::More;


use Catalyst::Test 'webApp';
use webApp::Controller::Category::Category;

ok( request('/category/category')->is_success, 'Request should succeed' );
done_testing();
