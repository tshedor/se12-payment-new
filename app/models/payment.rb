class Payment < ActiveRecord::Base
	has_many :payment_users
	has_many :users, through: :payment_users
	belongs_to :type
	validates_presence_of :sender_id, :recipient_id, :note
	validates :amount, :presence=>true,
						:numericality => true
  validates_format_of :amount, :with => /\A\d+(?:\.\d{0,2})?\z/
	
end
