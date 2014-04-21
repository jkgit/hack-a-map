require 'test_helper'

class HackathonControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should get map" do
    get :map
    assert_response :success
    assert_not_nil assigns(:hackathons)
    assert_not_nil assigns(:filtered_hacks)
    assert_equal(assigns(:hackathons).length, assigns(:filtered_hacks).length)
  end
  
  test "should get map for country" do
    get :map, :country => 'United States of America'
    assert_response :success
    assert_not_nil assigns(:hackathons)
    assert_not_nil assigns(:filtered_hacks)
    assert_not_equal(assigns(:hackathons).length, assigns(:filtered_hacks).length)
  end
  
  test "should get map for country using nickname" do
    get :map, :country => 'US'
    assert_response :success
    assert_not_nil assigns(:hackathons)
    assert_not_nil assigns(:filtered_hacks)
    assert_not_equal(assigns(:hackathons).length, assigns(:filtered_hacks).length)
    nickname_hacks_length=assigns(:filtered_hacks).length
    get :map, :country => 'United States of America'
    assert_equal(nickname_hacks_length, assigns(:filtered_hacks).length)
  end
end
