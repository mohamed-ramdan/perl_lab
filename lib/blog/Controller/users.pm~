package blog::Controller::users;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

blog::Controller::users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut




### Create New Starts ########################################################################################################


sub form_create : Local {
        my ($self, $c) = @_;
    
        # Set the TT template to use
        $c->stash->{template} = 'users/form_create.tt';
    }


sub form_create_do : Local {
        my ($self, $c) = @_;
    
        # Retrieve the values from the form
        my $name     = $c->request->params->{name} ;#    || 'N/A';
        my $password    = $c->request->params->{password};#    || 'N/A';
        my $email = $c->request->params->{email} ;#|| '1';
    
        # Create the user
        my $user = $c->model('DB::User')->create({
                name   => $name,
                password  => Digest::MD5::md5_hex($password),
		email  => $email,
            });
    
        # Store new model object in stash
        $c->stash->{user} = $user;
    
        # Avoid Data::Dumper issue mentioned earlier
        # You can probably omit this    
        $Data::Dumper::Useperl = 1;
    
        # Set the TT template to use
        #$c->stash->{template} = 'users/list.tt';
	$c->stash(template=>'users/useraddsucc.tt');
	
    	}

	


### Create New Ends ########################################################################################################



### Delete User starts #####################################################################################################

	## BASE ##########################################################
	sub base :Chained('/') :PathPart('users') :CaptureArgs(0) {
	my ($self, $c) = @_;
	# Store the ResultSet in stash so it's available for other methods
	$c->stash(resultset => $c->model('DB::User'));
	# Print a message to the debug log
	$c->log->debug('*** INSIDE BASE METHOD ***');
	}

	## Object base ###################################################
	sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
        # $id = primary key of user to delete
        my ($self, $c, $id) = @_;   
        # Find the user object and store it in the stash
        $c->stash(object => $c->stash->{resultset}->find($id));
        # Make sure the lookup was successful.  You would probably
        # want to do something like this in a real app:
        #   $c->detach('/error_404') if !$c->stash->{object};
        die "User $id not found!" if !$c->stash->{object};
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    	}

	## Delete Object ################################################
	sub delete :Chained('object') :PathPart('delete') :Args(0) {
        my ($self, $c) = @_;
        # Use the user object saved by 'object' and delete it along
        $c->stash->{object}->delete;
        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "User deleted.";
        # Forward to the list action/method in this controller
        $c->forward('list');
    	}

### Delete User Ends #####################################################################################################


### Edit User Starts #####################################################################################################

	sub edit :Chained('object') :PathPart('edit'){
	my ($self, $c) = @_;
	$c->stash(user=>$c->stash->{object}); 
	$c->stash(template=>'users/form_edit.tt');
	}



	sub update :Chained('object') :PathPart('update') :Args(0) {
      	my ($self, $c) = @_;
	# Retrieve the values from the form
	my $name = $c->request->params->{name} ;#|| 'N/A';
	my $email = $c->request->params->{email} ;#|| 'N/A';
	my $password= $c->request->params->{password} ;#|| 'N/A';
	# Create the user
	my $user = $c->stash->{object}->update({
	name => $name,
	email => $email,
	password => Digest::MD5::md5_hex($password)
	});
	    
		# Redirect the user back to the list page with status msg as an arg
		$c->response->redirect($c->uri_for($self->action_for('list')));
	    }


### Edit User Ends #####################################################################################################

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched blog::Controller::users in users.');
}


### List User Starts #####################################################################################################
sub list:Local{
my($self,$c)=@_;
$c->stash(users=>[$c->model('DB::User')->all]); 
$c->stash(template=>'users/list.tt');
}
### List User Ends #####################################################################################################



### Authentication Starts ##############################################################################################
sub login : Local {
    my ( $self, $c ) = @_;
 
    if ($c->authenticate( { 
                             username => $c->request->params->{'email'}, 
                             password => $c->request->params->{'password'} 
                          } )) {   
       # $c->authenticate returns a true value if authentication succeeds
       # so display the login successful page here.
	$c->response->redirect($c->uri_for($self->action_for('list')));
	
    } else {
       # or undef is authentication failed.  
       # so display the 'try again' page here.
	$c->response->redirect($c->uri_for('login'));
    }
}

sub preferences : Local {
    my ( $self, $c ) = @_;
 
    if ( $c->user_exists() ) {
 
        ## If a user is logged in - you can show them the preferences page.
        $c->response->redirect($c->uri_for($self->action_for('list')));
 
    } else {
 
        # otherwise bounce them to the login page.
        $c->response->redirect($c->uri_for('login'));
 
    }
}




sub logout : Local {
   my ( $self, $c ) = @_;
 
   $c->logout();
}

### Authentication Ends ##############################################################################################





=encoding utf8

=head1 AUTHOR

mohamedramadan,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
