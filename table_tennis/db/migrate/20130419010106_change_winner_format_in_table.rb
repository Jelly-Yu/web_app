class ChangeWinnerFormatInTable < ActiveRecord::Migration
  def up
  change_column :matches, :winner, :integer
  end

  def down
  end
end
