class User < ActiveRecord::Base
  has_many :events
  has_many :event_attendances
  #has_secure_password

  # Added stuff for bcrypt
  include BCrypt
    
    def created_events
     # returns list of created events
    end

    def attended_events
     # returns list of attended events
    end

    validates :email, uniqueness: true, on: :create
    validates :email, presence: true

    def password
      puts "password"
      @password ||= Password.new(password_digest)
    end

    def password=(new_password)
      puts "password = new password"
      puts new_password
      @password = Password.create(new_password)
      self.password_digest = @password
      puts @password_
      puts @password
    end

    def self.authenticate(email, password)
      user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil

    end
end
