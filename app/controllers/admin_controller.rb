# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    @links = current_user.links.order(position: :asc)
  end

  def appearance; end

  def analytics
    @daily_profile_views = current_user.get_daily_profile_views
    @daily_link_clicks = current_user.get_daily_link_clicks
    @daily_device_views = current_user.get_daily_views_by_device_type

    @daily_device_views_by_type = @daily_device_views.map do |device, count|
      { name: "#{device}", data: count }
    end
  end

  def settings; end

  def update
    current_user.update(user_params)
    redirect_to admin_appearance_path
  end

  def update_theme
    profile_theme_id = params[:user][:profile_theme_id]
    @theme = Theme.find(profile_theme_id)
    current_user.profile_theme = @theme
    current_user.save
    redirect_to admin_appearance_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :avatar, :bio, :profile_theme_id)
  end
end
