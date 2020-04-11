require './lib/stat_tracker'
require 'pry';

class Statistics
  def initialize(stats)
    @stat_tracker = stats
    @csv_games = CSV.read(stat_tracker.games, headers: true, header_converters: :symbol)
    @csv_teams = CSV.read(stat_tracker.teams, headers: true, header_converters: :symbol)
    @csv_game_teams = CSV.read(stat_tracker.game_teams, headers: true, header_converters: :symbol)
  end

  def create_games
  @csv_games.map { |row| Game.new(row) }
  end

  def create_game_teams
    @csv_game_teams.map { |row| GameTeam.new(row) }
  end

  def create_teams
    @csv_teams.map { |row| Team.new(row) }
  end
end

 def teams_hash
   teams = Hash.new(0)
   @teams_collection.each do |team|
     teams[team.id] = 0
   end
   teams
 end

 def current_season_games(season)
   @games_collection.find_all do |game|
    if game.season == season
      game.id
    end
  end
 end

 def most_tackles(season)
   teams = teams_hash
   games_of_season = current_season_games.each do |game|
     @game_teams_collection.find_all {|game_team| game_team.game_id == game.game_id}




    teams[game_team.team_id] +=
