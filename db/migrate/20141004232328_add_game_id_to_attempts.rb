class AddGameIdToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :game_id, :integer
  end
end
