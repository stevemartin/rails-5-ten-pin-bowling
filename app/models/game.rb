class Game < ApplicationRecord
  has_many  :frames
  has_many  :shots
  validates :players, numericality: { greater_than: 0, less_than: 5 }
  accepts_nested_attributes_for :shots
end
