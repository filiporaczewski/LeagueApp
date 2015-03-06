class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :match_name
      t.integer :first_team_score
      t.integer :second_team_score
      t.integer :league_id

      t.timestamps null: false
    end
  end
end
