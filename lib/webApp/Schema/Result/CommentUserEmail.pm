use utf8;
package webApp::Schema::Result::CommentUserEmail;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

webApp::Schema::Result::CommentUserEmail

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

=head1 TABLE: C<comment_user_email>

=cut

__PACKAGE__->table("comment_user_email");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 guest_email

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 nick_name

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 creation_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=head2 update_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "guest_email",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "nick_name",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "creation_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
  "update_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<guest_email>

=over 4

=item * L</guest_email>

=back

=cut

__PACKAGE__->add_unique_constraint("guest_email", ["guest_email"]);

=head2 C<nick_name>

=over 4

=item * L</nick_name>

=back

=cut

__PACKAGE__->add_unique_constraint("nick_name", ["nick_name"]);

=head1 RELATIONS

=head2 comments

Type: has_many

Related object: L<webApp::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "webApp::Schema::Result::Comment",
  { "foreign.guest_user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-11-01 14:45:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2ilnRvKZvpf9KrbiIdHQpA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
