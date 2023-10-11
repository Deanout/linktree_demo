# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: %i[update destroy update_position toggle_active]

  def create
    @link = current_user.links.build(link_params)

    if @link.save
      redirect_to admin_index_path, notice: 'Link was successfully created.'
    else
      redirect_to admin_index_path, notice: 'Link was not created.'
    end
  end

  def update
    if @link.update(link_params)
      redirect_to admin_index_path, notice: 'Link was successfully updated.'
    else
      redirect_to admin_index_path, notice: 'Link was not updated.'
    end
  end

  def destroy
    @link.destroy
    redirect_to admin_index_path, notice: 'Link was successfully destroyed.'
  end

  def update_position
    position = params.dig(:link, :position).to_i
    @link.insert_at(position)
  end

  def toggle_active
    active_value = params.dig(:link, :active)
    @link.update(active: active_value)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:name, :url, :active, :position)
  end
end
