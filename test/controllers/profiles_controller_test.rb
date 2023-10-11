# frozen_string_literal: true

require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    @user = users(:one)
    get user_path(@user.username)
    assert_response :success
  end
end
