package blog::Controller::comments;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

blog::Controller::comments - Catalyst Controller

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
        $c->stash->{template} = 'comments/form_create.tt';
    }


sub form_create_do : Local {
        my ($self, $c) = @_;
    
        # Retrieve the values from the form
        
        my $body    = $c->request->params->{body};#    || 'N/A';
        my $user_id = $c->request->params->{user_id} ;#|| '1';
	my $post_id = $c->request->params->{post_id} ;#|| '1';
    
        # Create the user
        my $comment = $c->model('DB::Comment')->create({
                body   => $body,
                user_id  => $user_id,
		post_id  => $post_id,
            });
    
        # Store new model object in stash
        $c->stash->{comment} = $comment;
    
        # Avoid Data::Dumper issue mentioned earlier
        # You can probably omit this    
        $Data::Dumper::Useperl = 1;
    
        # Set the TT template to use
        #$c->stash->{template} = 'users/list.tt';
	$c->stash(template=>'comments/commentaddsucc.tt');
	$c->stash(posts=>[$c->model('DB::Post')->all]);
	
    	}

	


### Create New Ends ########################################################################################################






### Delete Comment starts #####################################################################################################

	# Check the post controller

### Delete Comment Ends #####################################################################################################













### List Starts ########################################################################################################
sub list:Local{
my($self,$c)=@_;
$c->stash(comments=>[$c->model('DB::Comment')->all]); 
$c->stash(template=>'comments/list.tt');
}
### List  Ends ########################################################################################################




sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched blog::Controller::comments in comments.');
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
