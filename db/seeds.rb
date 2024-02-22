# frozen_string_literal: true

require 'open-uri'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# request_faker.rb

def gravatar_url_for(email, **options)
  hash = Digest::MD5.hexdigest(email&.downcase || '')
  options.reverse_merge!(default: :mp, rating: :pg, size: 48)
  "https://secure.gravatar.com/avatar/#{hash}.png?#{options.to_param}"
end

Theme.create(name: 'Space', theme_type: 'dark', css_value: '--space-theme')
Theme.create(name: 'Light', theme_type: 'light', css_value: '--light-theme')

default_theme_id = Theme.default_theme&.id
theme_params = { admin_theme_id: default_theme_id,
                 profile_theme_id: default_theme_id }.compact_blank

user = User.new(username: 'dean',
                email: 'dehartdean@gmail.com',
                password: 'password',
                **theme_params)

user.avatar.attach(io: URI.open(gravatar_url_for(user.email)), filename: 'avatar.png', content_type: 'image/png')
user.save!

Ahoy::Event.destroy_all && Ahoy::Visit.destroy_all
class RequestFaker
  attr_reader :params, :content_length, :body, :remote_ip, :original_url, :user_agent, :cookies, :referer, :headers,
              :cookie_jar

  def initialize(**options)
    @params = options[:params] || {}
    @headers = options[:headers] || {}
    @content_length = options[:content_length] || 10
    @body = options[:body] || StringIO.new('fake')
    @remote_ip = options[:remote_ip] || '1.1.1.1'
    @original_url = options[:original_url] || '/'
    @user_agent = options[:user_agent] || 'Agent/Fake'
    @cookies = options[:cookies] || {}
    @cookie_jar = options[:cookie_jar] || {}
    @referer = options[:referer] || 'example.com'

    @options = options
  end
end

Ahoy.geocode = false
Ahoy::Tracker.new(request: RequestFaker.new)

user = User.first
3.times do
  # post = Post.create(
  #   title: Faker::Lorem.sentence(word_count: 3),
  #   body: Faker::Lorem.paragraph(sentence_count: 2)
  # )
  rand(15..25).times do
    puts 'Tracking'

    #   properties:
    #  {"user"=>
    #    {"id"=>1,
    #     "bio"=>"Software Developer 123",
    #     "name"=>"Dean DeHart",
    #     "slug"=>"dean",
    #     "email"=>"dean@example.com",
    #     "username"=>"Dean",
    #     "created_at"=>"2023-09-18T23:19:42.831Z",
    #     "updated_at"=>"2024-02-21T03:32:59.046Z",
    #     "admin_theme_id"=>nil,
    #     "profile_theme_id"=>1}}

    # Devices are desktop, tablet, or phone.
    # Randomly choose a device type for each visit.

    visit = Ahoy::Visit.create!(visit_token: Faker::Alphanumeric.alpha(number: 10),
                                device_type: %w[desktop tablet phone].sample,
                                user_id: user.id)

    rand(1..5).times do
      Ahoy::Event.create!(name: 'Viewed Dashboard',
                          user_id: user.id,
                          properties: {
                            id: user.id
                          },
                          visit:,
                          time: Faker::Time.between(from: 24.hours.ago, to: Time.now))
    end
    Ahoy::Event.create!(name: 'Clicked Link',
                        user_id: user.id,
                        properties: {
                          id: user.id
                        },
                        visit:,
                        time: Faker::Time.between(from: 24.hours.ago, to: Time.now))
  end
end
