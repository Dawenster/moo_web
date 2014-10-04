class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.string :guess

      t.timestamps
    end
  end
end
