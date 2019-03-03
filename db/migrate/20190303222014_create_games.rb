class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :running_total, default: 0
      t.boolean :rollover_scoring, default: false
      t.timestamps
    end
  end
end
