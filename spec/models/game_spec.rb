require 'rails_helper'

RSpec.describe Game, type: :model do
  context "validations & defaults" do
    it "is valid with attributes" do
      expect(Game.new).to be_valid
    end

    it "is not valid without running total" do
      game = Game.new(running_total: nil)
      expect(game).to_not be_valid
    end
    
    it "is not valid without rollover scoring" do
      game = Game.new(rollover_scoring: nil)
      expect(game).to_not be_valid
    end

    it "defaults to rollover scoring false" do
      expect(Game.new.rollover_scoring).to be false
    end
    
    it "defaults to running total 0" do
      expect(Game.new.running_total).to be 0
    end
    
    it ".rollover?" do
      rollover_game = Game.create(rollover_scoring: true)
      no_rollover_game = Game.create(rollover_scoring: false)
      default_game = Game.create
      expect(rollover_game.rollover?).to be true
      expect(no_rollover_game.rollover?).to be false
      expect(default_game.rollover?).to be false
    end
  end

  context "interacts with players" do
    it "creates players" do
      game = Game.create
      game.create_players(3)
      expect(game.players.count).to be 3
    end

    it "can't have a negative number of players" do
      game = Game.create
      game.create_players(-2)
      expect(game.players.count).to be 0
    end

    it "sets the first player to active" do
      game = Game.create
      game.create_players(3)
      first_player_id = game.players.first.id
      game.set_active_player
      expect(game.active_player).to eq first_player_id
    end
    
    it "rotates active player" do
      game = Game.create
      game.create_players(3)

      first_player_id = game.players.first.id
      third_player_id = game.players.last.id

      game.set_active_player
      game.rotate_active_player
      game.rotate_active_player
      
      expect(game.active_player).to eq third_player_id
      
      game.rotate_active_player
      expect(game.active_player).to eq first_player_id
    end
  end
end
