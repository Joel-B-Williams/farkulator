require 'rails_helper'

RSpec.describe Player, type: :model do

  context "validations & defaults" do
    it "is valid with attributes" do
      game = Game.create
      player = Player.new(game_id: game.id)
      expect(player).to be_valid
    end

    it "is not valid without score" do
      player = Player.new(score: nil)
      expect(player).to_not be_valid
    end
    
    it "is not valid without game id" do
      player = Player.new(game_id: nil)
      expect(player).to_not be_valid
    end

    it "defaults to score 0" do
      expect(Player.new.score).to be 0
    end
  end

  context "gameplay" do
    it "banks score" do
      game = Game.create(running_total: 1000)
      player = Player.create(game_id: game.id)

      player.bank_score
      
      expect(player.score).to be 1000
    end
  end
end
