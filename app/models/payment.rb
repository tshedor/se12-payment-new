class Payment < ActiveRecord::Base
  # TS - instead of this table, you should do this more intuitively
  # TS - i.e. a `has_one :recipient, class_name: 'User'` and `has_one :sender, class_name: 'User'`
	has_many :payment_users
	has_many :users, through: :payment_users
	belongs_to :type
	validates_presence_of :sender_id, :recipient_id, :note
	validates :amount, :presence=>true,
						:numericality => true
  validates_format_of :amount, :with => /\A\d+(?:\.\d{0,2})?\z/

end
