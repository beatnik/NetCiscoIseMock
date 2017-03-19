package Net::Cisco::ISE::Mock::Controller::InternalUser;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use XML::Simple;

sub query {
    my $self = shift;
	my $name = $self->param("name");
	my $id = $self->param("id");
=pod
    my $rs = $self->db->resultset('User');
    my $user;
	if ($name) 
	{ my $query_rs = $rs->search({ name => $name });
      $user = $query_rs->first;
    }
	if ($id) 
	{ my $query_rs = $rs->search({ id => $id });
      $user = $query_rs->first;
    }
=cut
    if (!$id && !$name)
    {
=pod
my $query_rs = $rs->search;
      my %users = ();
      while (my $account = $query_rs->next)
      { $users{$account->name} =
        { id => $account->id, name => $account->name, description => $account->description,
          identitygroupname => $account->identitygroupname, changepassword => $account->changepassword,
          enablepassword => $account->enablepassword, enabled => $account->enabled, password => $account->password,
          passwordneverexpires => $account->passwordneverexpires, passwordtype => $account->passwordtype,
          dateexceeds => $account->dateexceeds, dateexceedsenabled =>$account->dateexceedsenabled,
          created => $account->created, lastmodified => $account->lastmodified
        };
        $users{$account->name}{"dateExceedsEnabled"} = $users{$account->name}{"dateExceedsEnabled"} && $users{$account->name}{"dateExceedsEnabled"} eq "true" ? 1 : 0;
        $users{$account->name}{"enabled"} = $users{$account->name}{"enabled"} && $users{$account->name}{"enabled"} eq "true" ? 1 : 0;
        $users{$account->name}{"passwordNeverExpires"} = $users{$account->name}{"passwordNeverExpires"} && $users{$account->name}{"passwordNeverExpires"} eq "true" ? 1 : 0;
        $users{$account->name}{"created"} = $users{$account->name}{"created"} && $users{$account->name}{"created"}  ? $users{$account->name}{"created"} : "";
        $users{$account->name}{"lastModified"} = $users{$account->name}{"lastModified"} && $users{$account->name}{"lastModified"}  ? $users{$account->name}{"lastModified"} : "";        
        $users{$account->name}{"dateExceeds"} = ref($users{$account->name}{"dateExceeds"}) ? "" : $users{$account->name}{"dateExceeds"};
      }
=cut
      my %internalusers = ("John" => { "description" => "The Smart One", "name" => "John Lennon", "id" => "john"},
                           "Paul" => { "description" => "The Cute One", "name" => "Paul McCartney", "id" => "paul"},
                           "George" => { "description" => "The Quiet One", "name" => "George Harrison", "id" => "george"},
                           "Ringo" => { "description" => "The Funny One", "name" => "Ringo Starr", "id" => "ringo"},
                           );
      $self->stash("internalusers" => \%internalusers);
      $self->render(template => 'internaluser/queryall', format => 'xml', layout => 'internaluserall');
      return;
    }
    my $internaluser = "";
    $self->stash("internaluser" => $internaluser);
	$self->render(template => 'internaluser/query', format => 'xml', layout => 'internaluser');
}
=pod
sub update {
    my $self = shift;
    my $rs = $self->db->resultset('User');
    my $data = $self->req->body;
    my $xmlsimple = XML::Simple->new();
    my $xmlout = $xmlsimple->XMLin($data);
    my $query_rs = $rs->search({ name => $xmlout->{"name"} });
    my $account = $query_rs->first;

    $xmlout->{"dateExceedsEnabled"} = $xmlout->{"dateExceedsEnabled"} eq "true" ? 1 : 0;
    $xmlout->{"enabled"} = $xmlout->{"enabled"} eq "true" ? 1 : 0;
    $xmlout->{"enablePassword"} = ref($xmlout->{"enablePassword"}) eq "HASH" ? "" : $xmlout->{"enablePassword"};
    $xmlout->{"passwordNeverExpires"} = $xmlout->{"passwordNeverExpires"} eq "true" ? 1 : 0;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year += 1900;
    my @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
    $account->update({ description => $xmlout->{"description"},
          identitygroupname => $xmlout->{"identityGroupName"},
          changepassword => $xmlout->{"changePassword"},
          enablepassword => $xmlout->{"enablePassword"},
          enabled => $xmlout->{"enabled"},
          password => $xmlout->{"password"},
          passwordneverexpires => $xmlout->{"passwordNeverExpires"},
          passwordtype => $xmlout->{"passwordType"},
          dateexceeds => $xmlout->{"dateExceeds"},
          dateexceedsenabled => $xmlout->{"dateExceedsEnabled"},
          id => $xmlout->{"id"},
          lastmodified => "$months[$mon] $mday $year $hour:$min:$sec",
          });
	$self->render(template => 'user/userresult', format => 'xml', layout => 'userresult', status => 200);	
}

sub create {
    my $self = shift;
    my $data = $self->req->body;
    my $xmlsimple = XML::Simple->new();
    my $xmlout = $xmlsimple->XMLin($data);
    $xmlout->{"dateExceedsEnabled"} = $xmlout->{"dateExceedsEnabled"} eq "true" ? 1 : 0;
    $xmlout->{"enabled"} = $xmlout->{"enabled"} eq "true" ? 1 : 0;
    $xmlout->{"passwordNeverExpires"} = $xmlout->{"passwordNeverExpires"} eq "true" ? 1 : 0;
    $xmlout->{"dateExceeds"} = ref($xmlout->{"dateExceeds"}) ? "" : $xmlout->{"dateExceeds"};
    my $rsmax = $self->db->resultset('User')->get_column('Id');
    my $maxid = $rsmax->max;
    $maxid++;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year += 1900;
    my @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
    $self->db->resultset('User')->create({
          name => $xmlout->{"name"},
          description => $xmlout->{"description"},
          identitygroupname => $xmlout->{"identityGroupName"},
          changepassword => $xmlout->{"changePassword"},
          enablepassword => $xmlout->{"enablePassword"}, # HASH ?!?
          enabled => $xmlout->{"enabled"},
          password => $xmlout->{"password"},
          passwordneverexpires => $xmlout->{"passwordNeverExpires"},
          passwordtype => $xmlout->{"passwordType"},
          dateexceeds => $xmlout->{"dateExceeds"}, # HASH?!?
          dateexceedsenabled =>$xmlout->{"dateExceedsEnabled"},
          id => $maxid,
          lastmodified => "$months[$mon] $mday $year $hour:$min:$sec",
          created =>  "$months[$mon] $mday $year $hour:$min:$sec",
          });
	$self->render(template => 'user/userresult', format => 'xml', layout => 'userresult', status => 200);	
}

sub delete {
    my $self = shift;
    my $rs = $self->db->resultset('User');
	my $name = $self->param("name");
	my $id = $self->param("id");
    my $user;
	if ($name) 
	{ my $query_rs = $rs->search({ name => $name });
      $user = $query_rs->first;
    }
	if ($id) 
	{ my $query_rs = $rs->search({ id => $id });
      $user = $query_rs->first;
    }
    $user->delete if $user;    
	$self->render(template => 'user/userresult', format => 'xml', layout => 'userresult', status => 200);	
}
=cut
1;
