class User < ActiveRecord::Base
	has_many :payment_users
	has_many :payments, through: :payment_users
	validates_presence_of :first_name, :last_name
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :password, presence: true, length: { minimum: 6 }
	validates_uniqueness_of :email
	has_secure_password

	def self.authenticate(email, password)
	  @user = User.find_by_email(email)

	  if !@user.nil?
	  	if @user.authenticate(password)
	  		return @user
	  	end
	  end
	  
	  return nil
	end

end
