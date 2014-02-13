require 'faker'

User.delete_all
Event.delete_all

User.create(first_name: "Daniel", last_name: "Lu", email: "dan@dbc.com", birthdate: "1982/06/22", password: "password", password_confirmation: "password")
User.create(first_name: "Shiba", last_name: "Inu", email: "shiba@dbc.com", birthdate: "1983/01/25", password: "password", password_confirmation: "password")

Event.create(user_id: 1, name: "Project Demo", location: "DBC Great Hall", starts_at: "Fri, 7 Mar 2014 09:20:00 -0600", ends_at: "Fri, 7 Mar 2014 11:20:01 -0600")
Event.create(user_id: 1, name: "My Party", location: "Hacker Loft", starts_at: "Sat, 7 Mar 2014 17:00:00 -0600", ends_at: "Sat, 7 Mar 2014 23:20:00 -0600")


# Create 500 users
users = 5.times.map do
  User.create!( :first_name             => Faker::Name.first_name,
                :last_name              => Faker::Name.last_name,
                :email                  => Faker::Internet.email,
                :birthdate              => Date.today - 15.years - rand(20000).days,
                :password               => "password",
                :password_confirmation  => "password")
end

10.times do
  start_time = Time.now + (rand(61) - 30).days
  end_time   = start_time + (1 + rand(6)).hours

  Event.create!( :user_id    => users[rand(users.length)].id,
                 :name       => Faker::Company.name,
                 :location   => "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
                 :starts_at  => start_time,
                 :ends_at    => end_time )
end
