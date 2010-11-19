require 'machinist/mongoid'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  email { Faker::Internet.email }
  password { 'password' }
end
Timeline.blueprint do
  name { }
  events {[]}
end

Event.blueprint do
  timeline {}
  event_date {}
  title {}
  short_description {}
  detailed_description {}
end

Timeline.blueprint(:valid) do
  name { Faker::Lorem.words(4).join(' ') }
  description { Faker::Lorem.paragraph(2) }
  user_id { "#{User.make!.id}" }
end

Event.blueprint(:valid) do
  event_date { '2000/1/1' }
  title { Faker::Lorem.words(4).join(' ') }
  short_description { Faker::Lorem.sentence(1) }
  detailed_description { Faker::Lorem.paragraph(2) }
end
