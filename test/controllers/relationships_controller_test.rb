require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get follower_id:integer" do
    get relationships_follower_id:integer_url
    assert_response :success
  end

  test "should get followed_id:integer" do
    get relationships_followed_id:integer_url
    assert_response :success
  end

end
