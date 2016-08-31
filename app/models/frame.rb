class Frame < ApplicationRecord
  belongs_to :game
  validates_presence_of :game_id, :player_number, :frame_number, :total
end
