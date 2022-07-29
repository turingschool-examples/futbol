require './lib/game'
require './lib/season'
require './lib/league'
require './lib/team'

class LeagueGenerator
  attr_reader :league
  def initialize(all_data_hash)
    @teams_data = all_data_hash[:teams]
    @games_data = all_data_hash[:games]
    @game_teams_data = all_data_hash[:game_teams]

    games_by_season_hash = @games_data.group_by do |game|
      game[:season]
    end

    league = League.new

    games_by_season_hash.each do |season, games_by_season|
      league.seasons << Season.new(games_by_season)
    end
    
    games_by_team = @game_teams_data.group_by do |game|
      game[:team_id]
    end

    @teams_data.each do |team|
      league.teams << Team.new(team, games_by_team[team[:team_id]])
    end

    @games_data.each do |game|
      league.games << Game.new(game)
    end
  end
end