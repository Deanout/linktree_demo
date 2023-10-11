# frozen_string_literal: true

module ProfilesHelper
  def profile_url(user)
    # Need to return the complete URL for the user's profile.
    # Example: http://localhost:3000/username
    Rails.application.routes.url_helpers.user_url(user.username, host: 'localhost:3000')
  end
end
