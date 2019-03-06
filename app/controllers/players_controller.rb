class PlayersController < ApplicationController
  def update
    player = Player.find_by(id: params[:id])
    game = player.game
    player.score += game.running_total
    game.running_total = 0
    if player.save && game.save
      redirect_to game_path(game)
    else
      flash[:warning]="Something has gone horribly pear shaped in players_controller ln 10"
    end
  end
end