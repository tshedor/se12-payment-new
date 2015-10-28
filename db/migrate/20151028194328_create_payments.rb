class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :title
      t.decimal :amount
      t.integer :type_id
      t.text :note

      t.timestamps null: false
    end
  end
end
