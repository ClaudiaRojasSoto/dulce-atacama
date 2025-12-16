require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get complete_profile" do
    get profiles_complete_profile_url
    assert_response :success
  end
end
