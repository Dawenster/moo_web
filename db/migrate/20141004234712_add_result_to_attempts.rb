class AddResultToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :result, :string
  end
end
