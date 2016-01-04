use v6;

use GitHub::HTTP;

class X::GitHub is Exception {
  has $.status;
  has $.reason;

  method message()
  {
    "Error: '$.status $.reason'";
  }
}

class GitHub:ver<v0.0.1>:auth<github:scmorrison> does GitHub::HTTP {

    # OAuth
    method authorizations(:$token) {
        self.request('authorizations' ~ $token, 'GET');
    }

    method get_authorization(:$token, :%data) {
        self.request('authorizations/' ~ $token, 'POST', :data(%data));
    }

    method create_authorization(:%data) {
        self.request('authorizations', 'POST', :data(%data));
    }

    method update_authorization(:%data) {
        self.request('authorizations', 'POST', :data(%data));
    }

    method delete_authorization(:$token) {
        self.request('authorizations/' ~ $token, 'DELETE');
    }

    method reset_authorization(:%data) {
        # POST /applications/:client_id/tokens/:access_token
				#my $client_id = $.auth_login;
        #my $access_token = $.auth_password;
        self.request('authorizations', 'POST', :data(%data));
        #self.request('applications/' ~ $client_id ~ '/' ~ $access_token, 'POST', :data(%data));
    }

}
