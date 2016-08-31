class CreateShots < ActiveRecord::Migration[5.0]
  def change
    create_table :shots do |t|
      t.references :game, foreign_key: true
      t.integer :number
      t.integer :frame
      t.integer :player
      t.integer :pins

      t.timestamps
    end
  end
end
