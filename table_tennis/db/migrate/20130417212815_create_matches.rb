class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player1
      t.integer :player2
      t.date :mDate
      t.string :status
      t.string :winner

      t.timestamps
    end
  end
end
