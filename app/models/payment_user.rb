# TS - You can probably get rid of this model
class PaymentUser < ActiveRecord::Base
	belongs_to :payment
	belongs_to :user

end
