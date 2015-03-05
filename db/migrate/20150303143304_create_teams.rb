class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|

      t.integer :games_played
      t.integer :wins
      t.integer :draws
      t.integer :defeats
      t.integer :goals_scored
      t.integer :goals_lost
      t.integer :goals_difference
      t.integer :points

      t.timestamps null: false
    end
  end
end
