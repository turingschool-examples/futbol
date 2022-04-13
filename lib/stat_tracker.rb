require 'csv'
require './lib/game_team'
require './lib/team'
require './lib/game'
class StatTracker

	attr_reader :games, :teams, :game_teams

	def initialize(games_hash, teams_hash, game_teams_hash)
		@games = create_games(games_hash)
		@teams = create_teams(teams_hash)
		@game_teams = create_game_teams(game_teams_hash)
	end

	def self.from_csv(locations)
	 games_hash = CSV.open(locations[:games], headers: true, header_converters: :symbol)
	 teams_hash = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
	 game_teams_hash = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)
	 stat_tracker1 = self.new(games_hash, teams_hash, game_teams_hash)
	end

	def create_teams(teams)
		team_arr = Array.new
		teams.each do |row|
			team_id = row[:team_id]
			franchise_id = row[:franchise_id]
			team_name = row[:team_name]
			abbreviation = row[:abbreviation]
			stadium = row[:stadium] # do symbols always return all lowercase or the same case as we assign it???
			link = row[:link]
			team_arr << Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
		end
		return team_arr
	end

  def create_game_teams(game_teams)
    game_team_array = []
    game_teams.each do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals]
      shots = row[:shots]
      tackles = row[:tackles]
      pim = row[:pim]
      power_play_opportunities = row[:power_play_opportunities]
      power_play_goals = row[:power_play_goals]
      face_off_win_percentage = row[:face_off_win_percentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      # binding.pry
      game_team_array << GameTeam.new(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,power_play_opportunities,power_play_goals,face_off_win_percentage,giveaways,takeaways)
    end
    return game_team_array
  end

  def create_games(games)
    game_arr = []
    games.each do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      game_arr << Game.new(game_id, season, type, date_time, away_team_id, home_team_id,
        away_goals, home_goals, venue, venue_link)
    end
  return game_arr
  end

	def highest_total_score
		highest_score_arr = []
		@games.each do |game|
			highest_score_arr << game.away_goals.to_i + game.home_goals.to_i
		end
		highest_score_arr.max
	end
end
