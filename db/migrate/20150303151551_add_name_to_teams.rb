class AddNameToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :team_name, :string
  end
end
