class LeaguesController < ApplicationController

	def index
		@leagues = League.all 
	end

	def new
		@league = League.new
		League.team_numb = params[:num_team]
	end

	def create
		@league = League.new
		team_names_array = []
		teams_number = League.team_numb.to_i
		(1..teams_number).each do |i|
			code = "params[:team_name_#{i}]"
			team_names_array << eval(code)
		end

		@schedule = @league.create_league(params[:league_name], teams_number, team_names_array)

	end

	def show

	end

	# private
	# 	def league_params
	# 		params.require(:league).permit(:league_name, :number_of_teams)
	# 	end 

end

