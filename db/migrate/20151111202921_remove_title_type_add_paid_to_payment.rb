class RemoveTitleTypeAddPaidToPayment < ActiveRecord::Migration
  def change
  	remove_column(:payments, :title)
  	remove_column(:payments, :type_id)

  	add_column(:payments, :paid, :boolean, default: false)

  end
end
