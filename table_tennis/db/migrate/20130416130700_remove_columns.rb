class RemoveColumns < ActiveRecord::Migration
  def up
  remove_column :users, :int
  end

  def down
  end
end
