class CreatePaymentUsers < ActiveRecord::Migration
  def change
    create_table :payment_users do |t|

      t.timestamps null: false
    end
  end
end
