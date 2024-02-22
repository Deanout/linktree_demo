# frozen_string_literal: true

class Theme < ApplicationRecord
  # Hey Future Dean,
  # Theme types are used to determine between profile or admin dashboard themes probably.

  # def users_with_this_as_profile_theme
  #   User.where(profile_theme_id: id)
  # end

  # def users_with_this_as_admin_theme
  #   User.where(admin_theme_id: id)
  # end

  def self.default_css_value
    '--light-theme'
  end

  def self.default_theme
    find_by(css_value: default_css_value)
  end
end
