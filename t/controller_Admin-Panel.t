use strict;
use warnings;
use Test::More;


use Catalyst::Test 'webApp';
use webApp::Controller::Admin::Panel;

ok( request('/admin/panel')->is_success, 'Request should succeed' );
done_testing();
