class LeaguesController < ApplicationController

	before_action :set_league, only: [:play_match, :destroy, :show]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :owner?, only: [:play_match, :destroy]

	def index
		@leagues = League.all 
	end

	def new
		@league = League.new
		League.team_numb = params[:num_team]
	end

	def play_match	
		@league.p_match(params[:match], params[:f_team_score].to_i, params[:s_team_score].to_i)

		redirect_to :league
	end

	def create
		@league = League.new
		team_names_array = []
		teams_number = League.team_numb.to_i
		(1..teams_number).each do |i|
			code = "params[:team_name_#{i}]"
			team_names_array << eval(code)
		end

		@league = @league.create_league(current_user, params[:league_name], teams_number, team_names_array)
		@schedule = @league.calendar.schedule

		redirect_to @league
	end

	def show
		League.get_team_names_from_schedule_string(@league, @league.calendar.schedule)
	end

	def destroy
		@league.destroy

		redirect_to :root
	end

	private
		def set_league
			@league = League.find(params[:id])
		end

		def owner?
			set_league
			unless current_user.leagues.include?(@league) or current_user.admin == true 
				redirect_to :back
				flash.alert = "You are not the owner of this league."
			end
		end

end

