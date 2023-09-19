# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    @links = current_user.links.order(position: :asc)
  end

  def appearance; end

  def analytics; end

  def settings; end
end
