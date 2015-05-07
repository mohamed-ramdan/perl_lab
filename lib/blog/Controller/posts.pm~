package blog::Controller::posts;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

blog::Controller::posts - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut





#sub userObject :Chained('base') :PathPart('id') :CaptureArgs(1) {

#    my ($self, $c, $id) = @_;

#    $c->stash(resultset => $c->model('DB::User'));
#    $c->stash(object => $c->stash->{resultset}->find($id));
 
#    die "User $id not found!" if !$c->stash->{object};
 
#    $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
#}

#sub post_create :Chained('userObject') :PathPart('post_create') :Args(0) {
#    my ($self, $c) = @_;
 
    # Set the TT template to use
#    $c->stash(user=>$c->stash->{object},template => 'posts/post_create.tt');
    
#}





### Create New Starts ########################################################################################################

sub form_create : Local {
        my ($self, $c) = @_;
    
        # Set the TT template to use
        $c->stash->{template} = 'posts/form_create.tt';
    }


sub form_create_do : Local {
        my ($self, $c) = @_;
    
        # Retrieve the values from the form
        my $title     = $c->request->params->{title} ;#    || 'N/A';
        my $body    = $c->request->params->{body};#    || 'N/A';
        my $user_id = $c->request->params->{user_id} ;#|| '1';
    
        # Create the user
        my $post = $c->model('DB::Post')->create({
                title   => $title,
                body  => $body,
		user_id  => $user_id,
            });
    
        # Store new model object in stash
        $c->stash->{post} = $post;
    
        # Avoid Data::Dumper issue mentioned earlier
        # You can probably omit this    
        $Data::Dumper::Useperl = 1;
    
        # Set the TT template to use
        #$c->stash->{template} = 'users/list.tt';
	$c->stash(template=>'posts/postaddsucc.tt');

	$c->stash(comments=>[$c->model('DB::User')->all]);
    	}

	


### Create New Ends ########################################################################################################




### Delete Post starts #####################################################################################################

	## BASE ##########################################################
	sub base :Chained('/') :PathPart('posts') :CaptureArgs(0) {
	my ($self, $c) = @_;
	# Store the ResultSet in stash so it's available for other methods
	$c->stash(resultset => $c->model('DB::Post'));
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
        die "Post $id not found!" if !$c->stash->{object};
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    	}

	## Delete Object ################################################
	sub delete :Chained('object') :PathPart('delete') :Args(0) {
        my ($self, $c) = @_;
        # Use the user object saved by 'object' and delete it along
        $c->stash->{object}->delete;
        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Post deleted.";
        # Forward to the list action/method in this controller
        $c->forward('list');
    	}

### Delete Post Ends #####################################################################################################



### Edit Post Starts #####################################################################################################

	sub edit :Chained('object') :PathPart('edit'){
	my ($self, $c) = @_;
	$c->stash(post=>$c->stash->{object}); 
	$c->stash(template=>'posts/form_edit.tt');
	}



	sub update :Chained('object') :PathPart('update') :Args(0) {
      	my ($self, $c) = @_;
	# Retrieve the values from the form
	my $title = $c->request->params->{title} ;#|| 'N/A';
	my $body = $c->request->params->{body} ;#|| 'N/A';
	my $user_id= $c->request->params->{user_id} ;#|| 'N/A';
	# Create the user
	my $post = $c->stash->{object}->update({
	title => $title,
	body => $body,
	user_id => $user_id,
	
	});
	    
		# Redirect the user back to the list page with status msg as an arg
		$c->response->redirect($c->uri_for($self->action_for('list')));
	    }


### Edit Post Ends #####################################################################################################










### show post Starts #####################################################################################################
sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
        # $id = primary key of book to delete
        my ($self, $c, $id) = @_;
    
        # Find the book object and store it in the stash
        $c->stash(object => $c->stash->{resultset}->find($id));
    
        # Make sure the lookup was successful.  You would probably
        # want to do something like this in a real app:
        #   $c->detach('/error_404') if !$c->stash->{object};
        die "Post $id not found!" if !$c->stash->{object};
    
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    }




sub show :Chained('object') :PathPart('show'){
my ($self, $c) = @_;
$c->stash(post=>$c->stash->{object});
$c->stash(comments=>[$c->model('DB::Comment')->all]);  
$c->stash(template=>'posts/show.tt');
}



### show post Ends #####################################################################################################




### List post Starts #####################################################################################################
sub list:Local{
my($self,$c)=@_;
$c->stash(posts=>[$c->model('DB::Post')->all]); 
$c->stash(template=>'posts/list.tt');
$c->stash(comments=>[$c->model('DB::Comment')->all]);
}

### List post Ends #####################################################################################################







### Delete Comment starts #####################################################################################################

	## BASE ##########################################################
	sub base_c :Chained('/') :PathPart('comments') :CaptureArgs(0) {
	my ($self, $c) = @_;
	# Store the ResultSet in stash so it's available for other methods
	$c->stash(resultset => $c->model('DB::Comment'));
	# Print a message to the debug log
	$c->log->debug('*** INSIDE BASE METHOD ***');
	}

	## Object base ###################################################
	sub object_c :Chained('base_c') :PathPart('id') :CaptureArgs(1) {
        # $id = primary key of user to delete
        my ($self, $c, $id) = @_;   
        # Find the user object and store it in the stash
        $c->stash(object => $c->stash->{resultset}->find($id));
        # Make sure the lookup was successful.  You would probably
        # want to do something like this in a real app:
        #   $c->detach('/error_404') if !$c->stash->{object};
        die "Comment $id not found!" if !$c->stash->{object};
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    	}

	## Delete Object ################################################
	sub delete_c :Chained('object_c') :PathPart('delete_c') :Args(0) {
        my ($self, $c) = @_;
        # Use the user object saved by 'object' and delete it along
        $c->stash->{object}->delete;
        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Comment deleted.";
        # Forward to the list action/method in this controller
        $c->forward('list');
    	}

### Delete Comment Ends #####################################################################################################



### Create New Starts ########################################################################################################


sub show :Chained('object') :PathPart('show'){
	my ($self, $c) = @_;
	my $id = $c->stash->{object}->id ;
	$c->stash(post=>$c->stash->{object});
	$c->stash(comments=> [$c->model('DB::Comment')->search({post_id => $id})]);
	$c->stash(template => 'posts/show.tt');
}


sub comment :Chained('object') :PathPart('comment') :Args(0) {
	my ($self, $c) = @_;
	my $id = $c->stash->{object}->id;
	my $body     = $c->request->params->{body}     || 'N/A';
	my $comment = $c->model('DB::Comment')->create({
		body   => $body,
		post_id  => $c->stash->{object}->id,
		user_id  => $c->session->{__user}{id},
		}); 
	$c->response->redirect($c->uri_for($self->action_for('show'),[$id]));
}





### Create New Ends ##########################################################################################################





sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched blog::Controller::posts in posts.');
}










=encoding utf8

=head1 AUTHOR

mohamedramadan,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
