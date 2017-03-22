package Net::Cisco::ISE::Mock::Controller::InternalUser;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use XML::Simple;

sub query {
    my $self = shift;
	my $id = $self->param("id");
    my $rs = $self->db->resultset('Internaluser');
    my $internaluser;
	if ($id) 
	{ my $query_rs = $rs->search({ id => $id });
      my $account = $query_rs->first;
      $internaluser =
        { id => $account->id, name => $account->name, email => $account->email, firstName => $account->firstname, lastName => $account->lastname, identityGroups  => $account->identitygroups,
          changePassword => $account->changepassword, expiryDateEnabled => $account->expirydateenabled, expiryDate => $account->expirydate,
          enablePassword => $account->enablepassword, enabled => $account->enabled, password => $account->password, passwordIDStore => $account->passwordidstore,
          description => $account->firstname." ".$account->lastname
        };
        $internaluser->{"enablePassword"} = ref($internaluser->{"enablePassword"}) ? "" : $internaluser->{"enablePassword"};
      $self->app->log->debug(Dumper \$internaluser);
    } else
    { my $query_rs = $rs->search;
      my %internalusers = ();
      while (my $account = $query_rs->next)
      { $internalusers{$account->name} =
        { id => $account->id, name => $account->name, email => $account->email, firstName => $account->firstname, lastName => $account->lastname, identityGroups  => $account->identitygroups,
          changePassword => $account->changepassword, expiryDateEnabled => $account->expirydateenabled, expiryDate => $account->expirydate,
          enablePassword => $account->enablepassword, enabled => $account->enabled, password => $account->password, passwordIDStore => $account->passwordidstore,
          description => $account->firstname." ".$account->lastname
        };
        $internalusers{$account->name}{"enablePassword"} = ref($internalusers{$account->name}{"enablePassword"}) ? "" : $internalusers{$account->name}{"enablePassword"};
      }
      $self->app->log->debug(Dumper \%internalusers);
      $self->stash("internalusers" => \%internalusers);
      $self->render(template => 'internaluser/queryall', format => 'xml', layout => 'internaluserall');
      return;
    }
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
