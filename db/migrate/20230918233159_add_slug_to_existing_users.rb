# frozen_string_literal: true

class AddSlugToExistingUsers < ActiveRecord::Migration[7.1]
  def change
    # Add slug to existing users
    User.find_each(&:save)
  end
end
