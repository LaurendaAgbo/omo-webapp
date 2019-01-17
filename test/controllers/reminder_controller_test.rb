require 'test_helper'

class ReminderControllerTest < ActionDispatch::IntegrationTest
  test "should get new," do
    get reminder_new,_url
    assert_response :success
  end

  test "should get index," do
    get reminder_index,_url
    assert_response :success
  end

  test "should get show," do
    get reminder_show,_url
    assert_response :success
  end

  test "should get edit" do
    get reminder_edit_url
    assert_response :success
  end

end
