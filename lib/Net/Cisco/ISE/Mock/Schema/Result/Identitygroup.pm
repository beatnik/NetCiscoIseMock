use utf8;
package Net::Cisco::ISE::Mock::Schema::Result::Identitygroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Net::Cisco::ISE::Mock::Schema::Result::Identitygroup

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

=head1 TABLE: C<identitygroups>

=cut

__PACKAGE__->table("identitygroups");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-14 23:05:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YDte8lUhU/UVhU7NljE0wA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
