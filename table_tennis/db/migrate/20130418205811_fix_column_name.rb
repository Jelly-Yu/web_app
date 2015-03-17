class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :matches, :status, :state
  end

  def down
  end
end
