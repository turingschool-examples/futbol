require 'CSV'
require './lib/game.rb'
require './lib/game_factory.rb'
require './lib/team.rb'
require './lib/teams_factory.rb'
require './lib/game_team.rb'
require './lib/game_team_factory.rb'

class Stattracker
  attr_reader :game_teams_factory,
              :teams_factory,
              :game_factory,
              :all_games,
              :all_teams,
              :all_game_teams

  def initialize
      @game_teams_factory = GameTeamFactory.new
      @teams_factory = Teams_factory.new    
      @game_factory = GameFactory.new
      @all_games = []
      @all_teams = []
      @all_game_teams = []
  end

  def self.from_csv(source)
    stattracker = Stattracker.new

    source.each do |key, value|
        case key
        when :games
          stattracker.game_factory.create_games(value)
        when :teams
          stattracker.teams_factory.create_teams(value)
        when :game_teams
          stattracker.game_teams_factory.create_game_teams(value)
        end
      end

      stattracker.instance_variable_set(:@all_games, stattracker.game_factory.games)
      stattracker.instance_variable_set(:@all_teams, stattracker.teams_factory.teams)
      stattracker.instance_variable_set(:@all_game_teams, stattracker.game_teams_factory.game_teams)

    stattracker
  end

  def percentage_home_wins
    total_games = @games.length
    home_wins = @games.count { |game| game.home_goals > game.away_goals }
          
    percentage = (home_wins.to_f / total_games) * 100
    percentage.round(2)
  end

  def highest_total_score
    scores = @all_games.map do |game|
      game.home_goals + game.away_goals
    end
    scores.max
  end

  def lowest_total_score
    scores = @all_games.map do |game|
      game.home_goals + game.away_goals
    end
    scores.min
  end

  def coach_win_percentages
    coach_games = Hash.new { |hash, key| hash[key] = { wins: 0, games: 0}}
    @all_game_teams.each do |game_team|
      coach = game_team.head_coach
      coach_games[coach][:games] += 1
      coach_games[coach][:wins] += 1 if game_team.result == "WIN"
    end
      coach_games.transform_values do |stats| 
        games = stats[:games]
        games > 0 ? ((stats[:wins].to_f / games) * 100).round : 0
    end
  end

  def winningest_coach
    coach_win_percentages = coach_win_percentages()
    coach_win_percentages.max_by { |coach, win_percentage| win_percentage}.first
  end

  def worst_coach
    coach_win_percentages = coach_win_percentages()
    coach_win_percentages.min_by { |coach, win_percentage| win_percentage}.first
  end
end