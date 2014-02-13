class User < ActiveRecord::Base
  attr_reader :entered_password

  has_many :events
  has_many :event_attendances
  has_secure_password

  include BCrypt

    validates :email, :uniqueness => true, :format => /.+@.+\..+/ # imperfect, but okay
    validates :entered_password, :length => { :minimum => 6 }

    def password
      puts "password"
      @password ||= Password.new(password_digest)
    end

    def password=(new_password)
      puts "password = new password"
      puts new_password
      @entered_password = new_password
      @password = Password.create(new_password)
      self.password_digest = @password
      puts password_digest
      puts @password
    end

    def self.authenticate(email, password)
      user = User.find_by_email(email)
      return user if user && (user.password == password)
      nil
    end

    def created_events
      # returns list of created events
    end

    def attended_events
      # returns list of attended events
    end
end
