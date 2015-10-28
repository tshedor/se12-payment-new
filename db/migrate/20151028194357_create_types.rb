class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
    	t.string :name
    end

   	if Type.all.empty?
   		Type.create(name: "credit")
   		Type.create(name: "debt")
   	end

  end
end
