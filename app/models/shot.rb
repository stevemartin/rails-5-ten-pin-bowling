class Shot < ApplicationRecord
  belongs_to :game
  validates :number, :frame, :player, :pins, numericality: true
end
