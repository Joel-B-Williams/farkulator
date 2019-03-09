class AddActivePlayerToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :active_player, :integer
  end
end
