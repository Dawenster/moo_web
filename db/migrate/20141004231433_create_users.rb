class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uuid
      t.string :username
      t.string :platform
      t.string :model

      t.timestamps
    end
  end
end
