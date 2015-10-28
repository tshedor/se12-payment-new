class AddReferencesToPaymentUsers < ActiveRecord::Migration
  def change
    add_reference :payment_users, :payment, index: true, foreign_key: true
    add_reference :payment_users, :user, index: true, foreign_key: true
  end
end
