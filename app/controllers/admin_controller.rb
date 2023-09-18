class AdminController < ApplicationController
  before_action :authenticate_user!
  def index; end

  def appearance; end

  def analytics; end

  def settings; end
end
