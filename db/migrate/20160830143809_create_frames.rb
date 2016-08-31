class CreateFrames < ActiveRecord::Migration[5.0]
  def change
    create_table :frames do |t|
      t.references :game, foreign_key: true
      t.integer :player_number
      t.integer :frame_number
      t.integer :total

      t.timestamps
    end
  end
end
