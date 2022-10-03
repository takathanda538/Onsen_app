require "test_helper"

class OnsenCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get onsen_comments_index_url
    assert_response :success
  end

  test "should get show" do
    get onsen_comments_show_url
    assert_response :success
  end
end
