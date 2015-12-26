use v6;

use GitHub::HTTP;

class OAuth does GitHub::HTTP {

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
