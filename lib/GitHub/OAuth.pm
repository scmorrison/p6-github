unit module GitHub::OAuth;

use HTTP::Request;
use HTTP::UserAgent;
use Config::Simple;

class X::GitHub::OAuth is Exception {
  has $.reason;
  method message()
  {
    "Error : $.reason";
  }
}
# Require SSL
BEGIN {
    if ::('IO::Socket::SSL') ~~ Failure {
        print("1..0 # Skip: IO::Socket::SSL not available\n");
        exit 0;
    }
}

class GitHub::OAuth {
    has $.auth_login;
    has $.auth_password;
    has $!github_api_uri = "https://api.github.com";
    has @!auth;

    submethod BUILD(:$!auth_login, :$!auth_password) {
        # We need the initial username / password to
        # request a token from the GitHub API
    }
    
    method request-new-token(:%data is copy) {

        my $auth_uri = "$!github_api_uri/authorizations";

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
          X::GitHub::OAuth.new(reason => $res.status-line).throw;
        }

        return from-json($res.content);

    }

    method authenticate {

    }
}

=begin pod
=head1 GitHub::Auth
C<GitHub::OAuth> is a simple GitHub API OAuth client.

=head1 Synopsis
    use GitHub::OAuth;

    my $gh = GitHub::OAuth.new(
        auth_login => 'myusername',
        auth_password => 'mypassword',
        token_cache => '%*ENV<HOME>/.ghauth' # Default ~/.ghauth
    );

    my $ghauth = $gho.create_authentication(data => {
      :scopes(['user', 'repo', 'gist']),
      :note<'test-github-oauth-client'>
    });

    say $ghauth<token>;
=end pod

