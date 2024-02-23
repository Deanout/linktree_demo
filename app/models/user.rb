# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_one_attached :avatar
  has_many :visits, class_name: 'Ahoy::Visit'
  has_many :links, dependent: :destroy

  normalizes :email, with: ->(email) { email.strip.downcase }

  # Only allow letters and numbers in username, because we use it in URLs
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9]+\z/ },
            length: { minimum: 3, maximum: 20 }
  validate :username_not_reserved
  validate :email_not_reserved

  attr_writer :login

  # Maybe the user should be the owner of the theme?
  # belongs_to :profile_theme, class_name: 'Theme', optional: true
  belongs_to :profile_theme, class_name: 'Theme', foreign_key: 'profile_theme_id', optional: true
  belongs_to :admin_theme, class_name: 'Theme', foreign_key: 'admin_theme_id', optional: true

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  # Want the range to be 30 days?

  def daily_profile_views
    Ahoy::Event.where(name: 'Viewed Dashboard', user_id: id).group_by_day(:time).count
  end

  def daily_link_clicks
    Ahoy::Event.where(name: 'Clicked Link', user_id: id).group_by_day(:time).count
  end

  def daily_views_by_device_type
    # Filter by last 7 days
    # daily_views_by_device_type = Ahoy::Event.joins(:visit).where(name: 'Viewed Dashboard', user_id: id)
    #                                         # .where('time > ? AND time < ?', 7.days.ago, Time.now)
    #                                         .group('visits.device_type').count
    visits.group(:device_type).count
  end

  def profile_css_value
    profile_theme&.css_value || Theme.default_css_value
  end

  private

  RESERVED_WORDS = %w[
    admin analytics appearance settings up users health rails
  ].freeze

  def username_not_reserved
    return unless RESERVED_WORDS.include?(username)

    errors.add(:username, 'is reserved and cannot be used')
  end

  def email_not_reserved
    return unless RESERVED_WORDS.any? { |word| email.include?(word) }

    errors.add(:email, 'contains a reserved word')
  end
end
