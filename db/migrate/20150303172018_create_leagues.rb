class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|

      t.string :league_name
      t.timestamps null: false
    end
  end
end
