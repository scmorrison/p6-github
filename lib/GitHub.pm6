use v6;

use GitHub::HTTP;

class X::GitHub is Exception {
  has $.reason;
  method message()
  {
    "Error : $.reason";
  }
}

class GitHub:ver<v0.0.1>:auth<github:scmorrison> does GitHub::HTTP {

    # OAuth
    method authorizations() {

    }

    method get_authorization() {

    }

    method authorization() {

    }

    method create_authorization(:%data) {
        self.request('authorizations', 'POST', :data(%data));
    }

    method update_authorization() {

    }

    method delete_authorization() {

    }
}
