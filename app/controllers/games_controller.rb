class GamesController < ApplicationController
  def index
  end
  
  def show
    @game = Game.find_by(id: params[:id])
    @players = @game.players.order('id ASC')
  end

  def new
    @game = Game.new
  end

  def create
    rollover = params[:game][:rollover_scoring]
    players = params[:game][:players].to_i

    game = Game.create(rollover_scoring: rollover)
    game.create_players(players)
    game.set_active_player
    if game.save
      redirect_to game_path(game)
    else
      flash[:warning]="Oops!"
      render new
    end
  end

  def edit
  end

  def update
    game = Game.find_by(id: params[:id])
    
    if params[:points] == "farkle"
      game.reset_running_total
      game.rotate_active_player
    else
      points = params[:points].to_i
      game.running_total += points
    end

    
    if game.save
      redirect_to game_path(game)
    else
      flash[:warning]="Points not added!"
      render show
    end
  end

  def destroy
  end

  private
    def game_params
      params.require(:game).permit(:players, :rollover_scoring)
    end
end