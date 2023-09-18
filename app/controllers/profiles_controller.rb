# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = User.find_by(slug: params[:slug])
  end
end
