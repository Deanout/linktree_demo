# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = User.find_by(slug: params[:slug])
    redirect_to root_path and return unless @user

    @links = @user.links.order(position: :asc)
  end
end
