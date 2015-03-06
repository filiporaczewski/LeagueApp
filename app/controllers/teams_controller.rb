class TeamsController < ApplicationController

	def home
		
	end

	def index
		@teams = Team.all 
	end

	def new
		@tean = Team.new
	end

	def create
		@team = Team.create(league_id: params[:league_id]) do |team|
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

	def edit 

	end

	def update

	end

	def destroy

	end

	def show

	end

end
