use Net::Cisco::ISE;
use Data::Dumper;
my $ise = Net::Cisco::ISE->new(hostname => 'localhost', username => 'admin', password => 'testPassword', port=>'3001', ssl => 0, debug => 0);
my %internalusers = %{ $ise->internalusers };
for my $internaluser (keys %internalusers)
{ print Dumper $ise->internalusers("id",$internalusers{$internaluser}->id); }
