class ChangePointsForInteger < ActiveRecord::Migration
  def up
   change_column :users, :points, :integer
  end

  def down
  end
end
