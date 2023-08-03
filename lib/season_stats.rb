#./lib/season.rb
require 'csv'
require 'spec_helper'
require_relative 'game_teams_factory'
require_relative 'games_factory'
require_relative 'teams_factory'
require_relative 'games'

class Season
  

  # season, game_id      'games_fixtures'
  # game_id, team_id, tackles   'games_teams_fixtures'
  # team_id, franchiseId 'teams.csv'
attr_reader :year, :teams, :games, :game_teams, :searched_season
  def initialize(year)
    @year = year
    @teams = TeamsFactory.new
    @games = GamesFactory.new
    @games.create_games('./fixture/games_fixtures.csv')
    @game_teams = GameTeamsFactory.new
    @game_teams.create_game_teams('./fixture/game_teams_fixtures.csv')
    @game_teams
    @searched_season = []
    within_searched_season
  end

  def within_searched_season
    @games.games.select do |game| 
      if game.season == @year
      @searched_season << game
      end
    end
  end

  def winningest_coach
  end

  def worst_coach
  end

  #Best ratio of shots to goals
  def most_accurate_team

  end

  def least_accurate_team
  end
#most tackles in a season
  def most_tackles

  @team_tackles = Hash.new(0)
  @find_game_ids = []
  @searched_season.each do |game|
    @find_game_ids << game.game_id
  end
  
  @all_games = @game_teams.game_teams.select do |game_team|
    @find_game_ids.each do |game|
      game_team.team_id == game
    end
  end

  @all_games.each do |game|
    @team_tackles[@all_games.team_id] += @all_games.tackles
  end
  puts team_tackles
  end

 
    






  # end

  def fewest_tackles
  end

  



end
