class League < ActiveRecord::Base
	require 'rubin'
	has_many :teams, dependent: :destroy
	has_one :calendar, dependent: :destroy
	has_many :matches, dependent: :destroy

	class << self
		attr_accessor :team_numb

		def get_team_names_from_schedule_string(league, schedule_string)
			new_string = schedule_string.gsub("Round 1", "").gsub(/Round [2-99]/, "\n")
			team_array = new_string.split("\n")
			team_array.each do |element|
				team_array.delete(element) if element == ""
			end
			team_array.each do |element|
				unless league.matches.find_by(match_name: element)
					league.matches.create(match_name: element)
				end
			end
		end

		def add_goals(team, gs, gl)
			team.goals_scored += gs
			team.goals_lost += gl 
			team.goals_difference = team.goals_scored - team.goals_lost
			team.save
		end

		def remove_goals(team, gs, gl)
			team.goals_scored -= gs
			team.goals_lost -= gl 
			team.goals_difference = team.goals_scored - team.goals_lost
			team.save
		end
	end

	def create_league(league_name, number_of_teams, team_names)
		@league = League.create(league_name: league_name, number_of_teams: number_of_teams)
		(1..number_of_teams).each do |i|
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

		team_names_shuffle = team_names.shuffle
		league_schedule = Rubin.new(team_names_shuffle)
		
		Calendar.create(schedule:league_schedule.output, league_id:@league.id)
		@league

	end

	def p_match(match_string, first_team_score, second_team_score)
		teams = match_string.split(/ v /)
		first_team = self.teams.find_by(team_name: teams[0])
		second_team = self.teams.find_by(team_name: teams[1])

		this_match = self.matches.find_by(match_name: match_string)
		unless this_match.first_team_score == nil 
			delete_exsisting_match(this_match, first_team, second_team)
			League.remove_goals(first_team, this_match.first_team_score, this_match.second_team_score)
			League.remove_goals(second_team, this_match.second_team_score, this_match.first_team_score) 
		end

		League.add_goals(first_team, first_team_score, second_team_score)
		League.add_goals(second_team, second_team_score, first_team_score)
		first_team.games_played += 1
		second_team.games_played += 1

		if first_team_score > second_team_score
			first_team.wins += 1
			second_team.defeats += 1
			first_team.points += 3
		elsif first_team_score < second_team_score
			first_team.defeats += 1
			second_team.wins += 1
			second_team.points += 3
		else
			first_team.draws += 1
			second_team.draws += 1
			first_team.points += 1
			second_team.points += 1
		end

		first_team.save
		second_team.save

		this_match.first_team_score = first_team_score
		this_match.second_team_score = second_team_score
		this_match.save
		
	end

	def delete_exsisting_match(match, team_one, team_two)
		team_one.games_played -= 1
		team_two.games_played -= 1

		if match.first_team_score > match.second_team_score
			team_one.wins -= 1
			team_two.defeats -= 1
			team_one.points -= 3
		elsif match.first_team_score < match.second_team_score
			team_one.defeats -= 1
			team_two.wins -= 1
			team_two.points -= 3
		else
			team_one.draws -= 1
			team_two.draws -= 1
			team_one.points -= 1
			team_two.points -= 1
		end

		team_one.save
		team_two.save

	end
	
end
