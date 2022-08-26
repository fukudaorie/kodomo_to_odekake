require "test_helper"

class Admin::SpotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_spots_index_url
    assert_response :success
  end
end
