class AddTeamNumberToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :number_of_teams, :integer
  end
end
