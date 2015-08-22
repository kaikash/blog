require 'test_helper'

class Web::SessionControllerTest < ActionController::TestCase
  test "should get web/registration" do
    get :web/registration
    assert_response :success
  end

end
