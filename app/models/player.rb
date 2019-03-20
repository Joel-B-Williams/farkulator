class Player < ApplicationRecord
  belongs_to :game

  validates :score, :game_id, presence: true

  def bank_score
    game = self.game
    self.score += game.running_total
  end
end
