use utf8;
package Net::Cisco::ISE::Mock::Schema::Result::Internaluser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Net::Cisco::ISE::Mock::Schema::Result::Internaluser

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<internalusers>

=cut

__PACKAGE__->table("internalusers");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 email

  data_type: 'text'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 firstname

  data_type: 'text'
  is_nullable: 1

=head2 lastname

  data_type: 'text'
  is_nullable: 1

=head2 identitygroups

  data_type: 'text'
  is_nullable: 1

=head2 changepassword

  data_type: 'integer'
  is_nullable: 1

=head2 expirydateenabled

  data_type: 'integer'
  is_nullable: 1

=head2 expirydate

  data_type: 'text'
  is_nullable: 1

=head2 enablepassword

  data_type: 'text'
  is_nullable: 1

=head2 enabled

  data_type: 'integer'
  is_nullable: 1

=head2 password

  data_type: 'text'
  is_nullable: 1

=head2 passwordidstore

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 1 },
  "email",
  { data_type => "text", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "firstname",
  { data_type => "text", is_nullable => 1 },
  "lastname",
  { data_type => "text", is_nullable => 1 },
  "identitygroups",
  { data_type => "text", is_nullable => 1 },
  "changepassword",
  { data_type => "integer", is_nullable => 1 },
  "expirydateenabled",
  { data_type => "integer", is_nullable => 1 },
  "expirydate",
  { data_type => "text", is_nullable => 1 },
  "enablepassword",
  { data_type => "text", is_nullable => 1 },
  "enabled",
  { data_type => "integer", is_nullable => 1 },
  "password",
  { data_type => "text", is_nullable => 1 },
  "passwordidstore",
  { data_type => "text", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-03-22 16:48:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q2dp7HojLUdECKkIirWeFQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
