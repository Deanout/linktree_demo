class Theme < ApplicationRecord
  # Hey Future Dean,
  # Theme types are used to determine between profile or admin dashboard themes probably.

  has_many :users
end
