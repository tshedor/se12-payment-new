class Payment < ActiveRecord::Base
	has_many :payment_users
	has_many :users, through: :payment_users
	belongs_to :type
	validates_presence_of :title, :amount, :type_id
	
end
