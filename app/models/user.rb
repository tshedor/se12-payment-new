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

	def full_name 
		"#{first_name} #{last_name}"
	end

	def owed
    dollars_owed = 0
    Payment.where(recipient_id: id, paid: false).each do |p|
      dollars_owed += p.amount
    end

    dollars_due = 0
    Payment.where(sender_id: id, paid: false).each do |p|
      dollars_due += p.amount
    end

    (dollars_owed - dollars_due)
	end

	def is_user?
		role == "user"
	end

	def is_admin?
		role =="admin"
	end

end
