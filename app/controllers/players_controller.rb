class PlayersController < ApplicationController
  def update
    player = Player.find_by(id: params[:game_id])
    game = player.game
    player.score += game.running_total
    game.running_total = 0
    if player.save && game.save
      redirect_to game_path(game)
    else
      p "*" * 20
      p "whoop"
    end
  end
end