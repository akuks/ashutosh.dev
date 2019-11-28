use utf8;
package webApp::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

webApp::Schema::Result::User

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::EncodedColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 blogs

Type: has_many

Related object: L<webApp::Schema::Result::Blog>

=cut

__PACKAGE__->has_many(
  "blogs",
  "webApp::Schema::Result::Blog",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-11-01 14:45:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:t4bjP7eYAvnPcsgYTWKdwQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;