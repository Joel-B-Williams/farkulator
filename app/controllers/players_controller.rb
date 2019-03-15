class PlayersController < ApplicationController
  def update
    player = Player.find_by(id: params[:id])
    game = player.game

    player.bank_score

    game.reset_running_total
    game.rotate_active_player

    if player.save && game.save
      redirect_to game_path(game)
    else
      flash[:warning]="Something has gone horribly pear shaped in players_controller ln 10"
    end
  end
end