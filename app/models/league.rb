class League < ActiveRecord::Base
	has_many :teams

	class << self
		attr_accessor :team_numb
	end

	def create_league(league_name, number_of_teams, team_names)
		@league = League.create(league_name: league_name, number_of_teams: number_of_teams)
		(1..number_of_teams).each do |i|
			code = "teams_played_with_team_#{i}=[]"
			eval(code)
			Team.create(league_id: @league.id) do |team|
				team.games_played = 0
				team.wins = 0
				team.draws = 0
				team.defeats = 0
				team.goals_scored = 0
				team.goals_lost = 0
				team.goals_difference = 0
				team.points = 0
			end 
		end

		@league.teams.each_with_index do |team, index|
			team.team_name = team_names[index]
			team.save
		end

	end
	
end
