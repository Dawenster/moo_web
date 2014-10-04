class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :answer
      t.string :result
      t.integer :time
      t.integer :digits
      t.boolean :repeat

      t.timestamps
    end
  end
end
