require "test_helper"

class OnsensControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get onsens_index_url
    assert_response :success
  end

  test "should get new" do
    get onsens_new_url
    assert_response :success
  end
end
