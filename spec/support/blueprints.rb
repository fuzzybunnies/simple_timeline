require 'machinist/mongoid'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

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
