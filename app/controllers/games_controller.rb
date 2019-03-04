class GamesController < ApplicationController
  def index
  end
  
  def show
    @game = Game.find_by(id: params[:id])
    @players = @game.players
  end

  def new
    @game = Game.new
  end

  def create
    rollover = params[:game][:rollover_scoring]
    players = params[:game][:players].to_i

    game = Game.create(rollover_scoring: rollover)

    if game.save
      players.times do |i| 
        game.players.create(name: "Player #{i+1}") 
      end
      redirect_to game_path(game)
    else
      flash[:warning]="Oops!"
      render new
    end
  end

  def edit
  end
  def update
  end
  def destroy
  end

  private
    def game_params
      params.require(:game).permit(:players, :rollover_scoring)
    end
end