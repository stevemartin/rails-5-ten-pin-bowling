# README

## Models

Game
players:integer:max-4(3 zero indexed)
frames:integer:max-10(9 zero indexed)

current_frame:integer

Frame ( game and player related )
game_id:integer
player_number:integer
frame_number:integer
total:integer

  > this could just be game logic rather than state
  > attempt_1
  > attempt_2
  > attempt_3
  > attempt_4

Frame ( just linked to game )
game_id:integer
number:integer
player_1_chance_a_score:integer
player_1_chance_b_score:integer
player_1_total:integer
player_2_chance_a_score:integer
player_2_chance_b_score:integer
player_2_total:integer

Game
  has_many :frames
