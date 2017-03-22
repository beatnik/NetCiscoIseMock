use Net::Cisco::ISE;
use Data::Dumper;
my $ise = Net::Cisco::ISE->new(hostname => 'localhost', username => 'admin', password => 'testPassword', port=>'3000', ssl => 0);
$ise->identitygroups;
