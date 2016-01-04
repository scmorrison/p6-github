use v6;

use HTTP::Request;
use HTTP::UserAgent;
   
role GitHub::HTTP {

    has $.auth_login;
    has $.auth_password;
		has $.auth_token;
    has $!github_api_uri = "https://api.github.com";
    has @!auth;

    # Require SSL
    BEGIN {
        if ::('IO::Socket::SSL') ~~ Failure {
            print("1..0 # Skip: IO::Socket::SSL not available\n");
            exit 0;
        }
    }

    submethod BUILD(:$!auth_login, :$!auth_password) {
        # We need the initial username / password  or
        # client_id and access_token request authenticate
        # against the GitHub API.
    }

    method request(Str $path, $method='GET', :%data is copy) {

        my $auth_uri = "$!github_api_uri/$path";

        # POST
        my $req = HTTP::Request.new(POST => URI.new($auth_uri));
        $req.header.field(User-Agent => %data<note>);
        $req.header.field(Accept => 'application/vnd.github.v3+json');
        $req.header.field(
          Authorization => "Basic " ~ MIME::Base64.encode-str("{$.auth_login}:{$.auth_password}")
        );

        $req.content = to-json(%data).encode;
        $req.header.field(Content-Length => $req.content.bytes.Str);
        my $ua = HTTP::UserAgent.new;
        $ua.timeout = 10;

        my $res = $ua.request($req);

        if (!$res.is-success) {
          X::GitHub.new(reason => $res.status-line).throw;
        }

        return from-json($res.content);

    }

#    method request(Str $path, $method='GET', :%data is copy) {
#
#        my $auth_uri = "$!github_api_uri/$path";
#
#
#        # POST
#			  my $req = HTTP::Request.new('POST' => URI.new($auth_uri));
#  			$req.header.field(User-Agent => %data<note>);
#	 			$req.header.field(Accept => 'application/vnd.github.v3+json');
#	  		$req.header.field(
#					Authorization => "Basic " ~ MIME::Base64.encode-str("{$.auth_login}:{$.auth_password}")
#				);
#
#        $req.content = to-json(%data).encode;
#        $req.header.field(Content-Length => $req.content.bytes.Str);
#        my $ua = HTTP::UserAgent.new;
#        $ua.timeout = 10;
#
#        my $res = $ua.request($req);
#
#        if (!$res.is-success) {
#          X::GitHub.new(reason => $res.status-line).throw;
#        }
#
#        return from-json($res.content);
#
#    }



}
