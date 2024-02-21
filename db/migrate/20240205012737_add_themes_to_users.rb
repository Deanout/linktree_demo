# frozen_string_literal: true

class AddThemesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :profile_theme_id, :integer
    add_column :users, :admin_theme_id, :integer
  end
end
