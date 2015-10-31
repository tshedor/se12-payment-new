class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :title
      t.integer :recipient_id
      t.integer :sender_id
      t.decimal :amount, :precision=>2
      t.integer :type_id
      t.text :note

      t.timestamps null: false
    end
  end
end
