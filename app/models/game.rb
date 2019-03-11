class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  
  validates :running_total, presence: true
  validates :rollover_scoring, inclusion: { in: [ true, false ] }

  def create_players(num_players)
    num_players.times do |i| 
      self.players.create(name: "Player #{i+1}") 
    end
  end

  def set_active_player
    self.active_player = self.players.first.id
  end

  def rotate_active_player
    active_player = Player.find_by(id: self.active_player)
    players = self.players.order('id ASC')
    idx = players.index(active_player)
    next_player = idx+1

    if next_player >= players.length
      self.active_player = players[0].id
    else
      self.active_player = players[next_player].id
    end
  end
end
