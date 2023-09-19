class Link < ApplicationRecord
  belongs_to :user
  acts_as_list
end
