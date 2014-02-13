require 'faker'

User.delete_all
Event.delete_all

User.create(first_name: "Daniel", last_name: "Lu", email: "dandydanny@gmail.com", birthdate: "1982/06/22", password: "password")
User.create(first_name: "John", last_name: "Doe", email: "jdoe@dbc.com", birthdate: "1983/01/25", password: "password")

Event.create(user_id: 1, name: "Project Demo", location: "DBC Great Hall", starts_at: "Fri, 7 Mar 2014 09:20:00 -0600", ends_at: "Fri, 7 Mar 2014 11:20:01 -0600")
Event.create(user_id: 2, name: "My Party", location: "Hacker Loft", starts_at: "Sat, 7 Mar 2014 17:00:00 -0600", ends_at: "Thu, 14 Nov 2013 23:20:00 -0600")


# Create 500 users
users = 500.times.map do
  User.create!( :first_name => Faker::Name.first_name,
                :last_name  => Faker::Name.last_name,
                :email      => Faker::Internet.email,
                :birthdate  => Date.today - 15.years - rand(20000).days )
end

100.times do
  start_time = Time.now + (rand(61) - 30).days
  end_time   = start_time + (1 + rand(6)).hours

  Event.create!( :user_id    => users[rand(users.length)].id,
                 :name       => Faker::Company.name,
                 :location   => "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
                 :starts_at  => start_time,
                 :ends_at    => end_time )
end
