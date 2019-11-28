use strict;
use warnings;

use webApp;

my $app = webApp->apply_default_middlewares(webApp->psgi_app);
$app;

