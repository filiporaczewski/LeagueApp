class AddLeagueIdToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :league_id, :integer
  end
end
