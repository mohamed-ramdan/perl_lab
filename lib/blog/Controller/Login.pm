package blog::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

blog::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub index :Path :Args(0) {
    my ($self, $c) = @_;
 
    # Get the username and password from form
    my $email = $c->request->params->{email};
    my $password = $c->request->params->{password};
 
    # If the username and password values were found in form
    if ($email && $password) {
        # Attempt to log the user in
        if ($c->authenticate({ email => $email,
                               password => Digest::MD5::md5_hex($password)  } )) {
            # If successful, then let them use the application
            $c->response->redirect($c->uri_for(
                $c->controller('Users')->action_for('list')));
            return;
        } else {
            # Set an error message
            $c->stash(error_msg => "Bad email address or password.");
        }
    } else {
        # Set an error message
        $c->stash(error_msg => "Empty emial address or password.")
            unless ($c->user_exists);
    }
 
    # If either of above don't work out, send to the login page
    $c->stash(template => 'login.tt2');



	# object user
	$c->stash(users=>[$c->model('DB::User')->all]);
}




#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#
#    $c->response->body('Matched blog::Controller::Login in Login.');
#}



=encoding utf8

=head1 AUTHOR

mohamedramadan,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
