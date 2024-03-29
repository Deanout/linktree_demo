# frozen_string_literal: true

class ProfilesController < ApplicationController
  layout 'profile', only: [:show]

  def show
    @user = User.find_by(slug: params[:slug].downcase)
    redirect_to root_path and return unless @user

    @links = @user.links.where(active: true).order(position: :asc)
    ahoy.track 'Viewed Dashboard', user: @user
  end
end
