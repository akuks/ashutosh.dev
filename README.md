## Ashutosh.dev

    ashutosh.dev is a blog written in Perl catalyst. It is in very early stages of development. 
    I am still developing feature for this blog just for fun. Stay tuned for more updates.

**Prerequisites to install this Project**

Programming Language:
- Perl 5.26 (Works well for 5.20 +)

If you are using Ubuntu or any other Unix based Utility, please install the 'pkg-config' if not installed already.

* Ubuntu 18.0.4 +
 - sudo apt install pkg-config 

 Once the pkg-config installed, install the ExtUtils::PkgConfig using:
- cpanm ExtUtils::PkgConfig

* Next is to install the 'gdlib', if not installed already
- sudo apt install libgd-dev

**Required Perl Modules:**

- Catalyst ('5.90118')
- Catalyst::Plugin::ConfigLoader
- Catalyst::Plugin::Static::Simple
- Catalyst::Action::RenderView
- Catalyst::Plugin::Static::Simple
- Catalyst::Plugin::Session::Store::File
- Catalyst::Plugin::Static::Simple
- Catalyst::Plugin::Session::State::Cookie
- requires 'Catalyst::Plugin::Captcha';
- requires 'GD';
- requires 'GD::SecurityImage';
- Moose
- Crypt::PBKDF2
- MooseX::NonMoose
- DBIx::Class::EncodedColumn
- DBIx::Class::EncodedColumn::Crypt::PBKDF2
- JSON
- namespace::autoclean


Run script/webapp_server.pl to test the application.
