class SetDefault < ActiveRecord::Migration
  def up
  	change_column :users, :points, :integer, :default => 100
  end

  def down
  end
end
