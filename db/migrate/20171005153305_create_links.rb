#rake generate:migration NAME=#name
class CreateLinks < ActiveRecord::Migration[5.0]
	def change
		create_table :links do |t|
			t.string :long_link
			t.string :short_link
			t.integer :counter

			t.timestamps
		end
	end
end
