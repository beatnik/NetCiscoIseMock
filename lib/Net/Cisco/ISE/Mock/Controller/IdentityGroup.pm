package Net::Cisco::ACS::Mock::Controller::IdentityGroup;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use XML::Simple;

sub query {
    my $self = shift;
	my $name = $self->param("name");
	my $id = $self->param("id");
    my $rs = $self->db->resultset('Identitygroup');
    my $identitygroup;
	if ($name) 
	{ my $query_rs = $rs->search({ name => $name });
      $identitygroup = $query_rs->first;
    }
	if ($id) 
	{ my $query_rs = $rs->search({ id => $id });
      $identitygroup = $query_rs->first;
    }
    if (!$id && !$name)
    { my $query_rs = $rs->search;
      my %identitygroups = ();
      while (my $group = $query_rs->next)
      { $identitygroups{$group->name} =
        { id => $group->id, name => $group->name, description => $group->description
        };
      }
      my $log = Mojo::Log->new(path => '/home/hendrik/NetCiscoAcsMock/log/development.log');
      $log->debug(Dumper \%identitygroups);
      $self->stash("identitygroups" => \%identitygroups);
      $self->render(template => 'identitygroup/queryall', format => 'xml', layout => 'identitygroupall');
      return;
    }
    
    $self->stash("identitygroup" => $identitygroup);
	$self->render(template => 'identitygroup/query', format => 'xml', layout => 'identitygroup');
}

sub update {
    my $self = shift;
    my $rs = $self->db->resultset('Identitygroup');
    my $data = $self->req->body;
    my $xmlsimple = XML::Simple->new();
    my $xmlout = $xmlsimple->XMLin($data);
    my $query_rs = $rs->search({ name => $xmlout->{"name"} });
    my $group = $query_rs->first;

    $group->update({ description => $xmlout->{"description"},
          id => $xmlout->{"id"},
          });
	$self->render(template => 'identitygroup/identitygroupresult', format => 'xml', layout => 'identitygroupresult', status => 200);	
}

sub create {
    my $self = shift;
    my $data = $self->req->body;
    my $xmlsimple = XML::Simple->new();
    my $xmlout = $xmlsimple->XMLin($data);
    my $rsmax = $self->db->resultset('Identitygroup')->get_column('Id');
    my $maxid = $rsmax->max;
    $maxid++;
    $self->db->resultset('Identitygroup')->create({
          name => $xmlout->{"name"},
          description => $xmlout->{"description"},
          id => $maxid,
          });
	$self->render(template => 'identitygroup/identitygroupresult', format => 'xml', layout => 'identitygroupresult', status => 200);	
}

sub delete {
    my $self = shift;
    my $rs = $self->db->resultset('Identitygroup');
	my $name = $self->param("name");
	my $id = $self->param("id");
    my $identitygroup;
	if ($name) 
	{ my $query_rs = $rs->search({ name => $name });
      $identitygroup = $query_rs->first;
    }
	if ($id) 
	{ my $query_rs = $rs->search({ id => $id });
      $identitygroup = $query_rs->first;
    }
    $identitygroup->delete if $identitygroup;
	$self->render(template => 'identitygroup/identitygroupresult', format => 'xml', layout => 'identitygroupresult', status => 200);	
}

1;
