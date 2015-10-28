class User < ActiveRecord::Base
	has_many :payment_users
	has_many :payments, through: :payment_users
	validates_presence_of :first_name, :last_name, :email, :password
	validates_uniqueness_of :email

def self.authenticate(email, password)
  User.find_by_email(email) if User.exists?(:email => email, :password => password)
end

end
