require 'test_helper'

class AttendeesControllerTest < ActionController::TestCase
  setup do
    @attendee = attendees(:one)
    @event = events(:one)
    @attendee.event_id = @event.id
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendee" do
    assert_difference('Attendee.count') do
      post :create, :attendee => @attendee.attributes
    end
    assert_redirected_to event_path(@attendee)
  end

  test "should get edit" do
    get :edit, :id => @attendee.to_param
    assert_response :success
  end

  test "should update attendee" do
    put :update, :id => @attendee.to_param, :attendee => @attendee.attributes
    assert_redirected_to event_path(@attendee)
  end

  test "should destroy attendee" do
    assert_difference('Attendee.count', -1) do
      delete :destroy, :id => @attendee.to_param
    end

    assert_redirected_to attendees_path
  end
end
