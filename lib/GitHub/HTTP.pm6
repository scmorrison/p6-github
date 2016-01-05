use v6;

use HTTP::Request;
use HTTP::UserAgent;
   
role GitHub::HTTP {

    has $.auth_login;
    has $.auth_password;
		has $.access_token;
		has $.fingerprint;
    has $!github_api_uri = "https://api.github.com";
    has %.credentials;

    # Require SSL
    BEGIN {
        if ::('IO::Socket::SSL') ~~ Failure {
            print("1..0 # Skip: IO::Socket::SSL not available\n");
            exit 0;
        }
    }

    multi method BUILD(:$!fingerprint) {

		}

    multi method BUILD(:$!auth_login, :$!auth_password) {
        # We need the initial username / password  or
        # client_id and access_token request authenticate
        # against the GitHub API.
    }

    method request(Str $path, Str $method='GET', :%data is copy) {

        my $auth_uri = "$!github_api_uri/$path";
				my $req;

		    $req = HTTP::Request.new(|($method  => URI.new($auth_uri)));
	  	  $req.header.field(User-Agent => %data<note>);
    		$req.header.field(Accept => 'application/vnd.github.v3+json');

				if $.auth_login.defined && $.auth_password.defined {
            $req.header.field(
                Authorization => "Basic " ~ MIME::Base64.encode-str("{$.auth_login}:{$.auth_password}")
            );
        } elsif ($.fingerprint) {
            $req.header.field(
                Authorization => "token " ~ $.fingerprint
            );
        }

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
}
