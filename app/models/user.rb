class User < ActiveRecord::Base
  # TS - see payment.rb, but the inverse will be `has_many :payments`
  # TS - so get rid of payment_users and the through: relation
	has_many :payment_users
	has_many :payments, through: :payment_users
	validates_presence_of :first_name, :last_name
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :password, presence: true, length: { minimum: 6 }
	validates_uniqueness_of :email
	has_secure_password

	def self.authenticate(email, password)
    # TS - generally, you don't need instance variables in models. And since you're in the User.self scope, this method is available without the prefix
    # TS - `user = find_by_email(email)`
	  @user = User.find_by_email(email)

    # TS - avoid double negation - `if user.present?` - and move the second if to the same line.
	  if !@user.nil?
	  	if @user.authenticate(password)
	  		return @user
	  	end
	  end

    # TS - last line of method in ruby always returns, remove explicit `return` here
	  return nil
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def owed
    dollars_owed = 0
    # TS - activesupport's sum is more effective here
    # TS - dollars_owed = Payment.where(recipient_id: id, paid: false).sum(&:amount)
    # TS - however, since this deals more with Payments than Users, I would make this as a Payment method. i.e. def self.owed(user); where(recipient: user, paid: false).sum(&:amount); end. Then access both of those methods here.
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
