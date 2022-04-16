require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'


class StatTracker

attr_reader :games, :team, :game_teams

  def initialize(locations)
    @games = read_and_create_games(locations[:games])
    @teams = read_and_create_teams(locations[:teams])
    @game_teams = read_and_create_game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end


  def read_and_create_games(games_csv)
    games_array = []
    CSV.foreach(games_csv, headers: true, header_converters: :symbol) do |row|
      games_array << Game.new(row)
    end
    games_array
  end

  def read_and_create_teams(teams_csv)
    teams_array = []
    CSV.foreach(teams_csv, headers: true, header_converters: :symbol) do |row|
      teams_array << Team.new(row)
    end
    teams_array
  end

  def read_and_create_game_teams(game_teams_csv)
    game_teams_array = []
    CSV.foreach(game_teams_csv, headers: true, header_converters: :symbol) do |row|
      game_teams_array << GameTeam.new(row)
    end
    game_teams_array
  end

  ## GAME STATISTICS

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

## Find season from games

  def games_in_season(season)
    @game_teams.find_all { |game| game.game_id[0..3] == season[0..3] }
  end

## Find teams from id
  def team_name_from_id(id)
    @teams.find { |team| team.team_id == id }.team_name
  end

  ## SEASON STATISTICS : All methods return Strings

  def winningest_coach(season)
# # Name of the Coach with the best win percentage for the season
    winning_coaches = []
    win_loss_hash = games_in_season(season).group_by { |win_loss| win_loss.result[0..].to_s}
      win_loss_hash.each do |k, v|
        if k == "WIN"
          v.each do |coach|
            winning_coaches << coach.head_coach
          end
        end
      end
      coach_by_percent = Hash.new
      winners = winning_coaches.group_by { |coach| coach[0..]}.transform_values { |v| v.count}
      winners.to_a.sort_by { |number| number[1] }.last[0]
  end

  def worst_coach(season)
# Name of the Coach with the worst win percentage for the season
# Actually LEAST amount of losses
    losing_coaches = []
    win_loss_hash = games_in_season(season).group_by { |win_loss| win_loss.result[0..].to_s}
      win_loss_hash.each do |k, v|
        if k == "LOSS"
          v.each do |coach|
            losing_coaches << coach.head_coach
          end
        end
      end
      coach_by_percent = Hash.new
      losers = losing_coaches.group_by { |coach| coach[0..]}.transform_values { |v| v.count}
      losers.to_a.sort_by { |number| number[1] }.first[0]
  end

  def most_accurate_team(season)
    # Name of the Team with the best ratio of shots to goals for the season
    # Compare shots to goals
    # Use games_by_season for a set of game ; set up empty hash
    # Does teams have a team_id? if team_id =nil?
    # make a hash key of the team_id, and values goals & shots
  end

  def least_accurate_team(season)
    # Name of the Team with the worst ratio of shots to goals for the season

  end

  def most_tackles(season)
    # Name of the Team with the most tackles in the season
    team_name_from_id(teams_by_tackles(season).last[0])
  end

  def fewest_tackles(season)
    # Name of the Team with the fewest tackles in the season
    team_name_from_id(teams_by_tackles(season).first[0])
  end

# helper method to check team tackles

  def teams_by_tackles(season)
    teams = Hash.new
    games_in_season(season).each do |game|
      if teams[game.team_id].nil?
        teams[game.team_id] = game.tackles.to_i
      else
        teams[game.team_id] += game.tackles.to_i
      end
    end
    teams.sort_by { |team, number| number }
# require "pry"; binding.pry
  end

end
