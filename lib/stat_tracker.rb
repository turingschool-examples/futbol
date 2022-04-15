require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
#
# game_data = CSV.open"./data/games.csv", headers: true, header_converters: :symbol

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = read_games(locations[:games])
    @teams = read_teams(locations[:teams])
    @game_teams = read_game_teams(locations[:game_teams])
    # require 'pry'; binding.pry
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def read_games(csv)
  games_arr = []
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    games_arr << Game.new(row)
  end
  games_arr
end

def read_teams(csv)
  teams_arr = []
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    teams_arr << Team.new(row)
  end
  teams_arr
end

def read_game_teams(csv)
  game_teams_arr = []
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    game_teams_arr << GameTeam.new(row)
  end
  game_teams_arr
end

  # def highest_total_score
  #   @games.map {|game| game[:away_goals].to_i + game[:home_goals].to_i}.max
  # end

  def highest_total_score
    # require 'pry'; binding.pry
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    # require 'pry'; binding.pry
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  # def percentage_home_wins(team)
  #   require 'pry'; binding.pry
  #   @game_teams.map {|game_team| (game_team.}
  # end


  def games_by_season(season)
    @games.select do |row|
      row[:season] == season.to_s
    end
  end


  def team_info(team_id)
    # require "pry"; binding.pry
    team = Hash.new

    @teams.each do |row|
      if row[:team_id] == team_id.to_s
        team[:team_id] = row[:team_id]
        team[:franchise_id] = row[:franchiseid]
        team[:team_name] = row[:teamname]
        team[:abbreviation] = row[:abbreviation]
        team[:link] = row[:link]
      end
    end
    return team
  end

  def game_teams_by_season(season)
    @game_teams.select do |row|
      row[:game_id][0..3] == season.to_s[0..3]
    end
  end

  def coaches_records(game_teams)
    hash = {}
    game_teams.each do |row|
      hash[row[:head_coach]] = [0,0,0.to_f]
    end
    game_teams.each do |row|
      if row[:result] == "WIN"
        hash[row[:head_coach]][0] += 1
      else
        hash[row[:head_coach]][1] += 1
      end
    end
    return hash
  end

  def win_percentage_by_coach(coaching_hash)
    coaching_hash.keys.map do |key|
      total_games = coaching_hash[key][0] + coaching_hash[key][1]
      coaching_hash[key][2] = coaching_hash[key][0]/total_games.to_f
    end
    return coaching_hash
  end


  def winningest_coach(season)
    season_game_teams = game_teams_by_season(season)
    coaches_hash = win_percentage_by_coach(coaches_records(season_game_teams))
    winning_coach = coaches_hash.max_by do |coach|
      coach[1][2]
    end[0]
  end

  def worst_coach(season)
    season_game_teams = game_teams_by_season(season)
    coaches_records = win_percentage_by_coach(coaches_records(season_game_teams))
    winning_coach = coaches_records.min_by do |coach|
      coach[1][2]
    end[0]
  end

  def team_name(id)
    @teams.find do |row|
      row[:team_id] == id.to_s
    end[:teamname].to_s
  end

  def total_amount(game_teams, category)
    total_amount = 0
    game_teams.each do |game|
      total_amount += game[category].to_i
    end
    total_amount
  end

  def most_accurate_team(season)
    season_game_teams = game_teams_by_season(season)
    hash = {}
    season_game_teams.each do |row|
      hash[row[:team_id]] = [0,0,0.to_f]
    end
    season_game_teams.each do |row|
      hash[row[:team_id]][0] += row[:goals].to_i
      hash[row[:team_id]][1] += row[:shots].to_i
      hash[row[:team_id]][2] = hash[row[:team_id]][0]/hash[row[:team_id]][1].to_f
    end
    accurate_team_id = hash.max_by do |team|
      team[1][2]
    end[0]
    return team_name(accurate_team_id)
  end

  def least_accurate_team(season)
    season_game_teams = game_teams_by_season(season)
    hash = {}
    season_game_teams.each do |row|
      hash[row[:team_id]] = [0,0,0.to_f]
    end
    season_game_teams.each do |row|
      hash[row[:team_id]][0] += row[:goals].to_i
      hash[row[:team_id]][1] += row[:shots].to_i
      hash[row[:team_id]][2] = hash[row[:team_id]][0]/hash[row[:team_id]][1].to_f
    end
    inaccurate_team_id = hash.min_by do |team|
      team[1][2]
    end[0]
    return team_name(inaccurate_team_id)
  end

  def most_tackles(season)
    season_game_teams = game_teams_by_season(season)
    hash = {}
    season_game_teams.each do |row|
      hash[row[:team_id]] = [0]
    end
    season_game_teams.each do |row|
      hash[row[:team_id]][0] += row[:tackles].to_i
    end
    most_tackles_team_id = hash.max_by do |team|
      team[1]
    end[0]
    return team_name(most_tackles_team_id)
  end

  def fewest_tackles(season)
    season_game_teams = game_teams_by_season(season)
    hash = {}
    season_game_teams.each do |row|
      hash[row[:team_id]] = [0]
    end
    season_game_teams.each do |row|
      hash[row[:team_id]][0] += row[:tackles].to_i
    end
    fewest_tackles_team_id = hash.min_by do |team|
      team[1]
    end[0]
    return team_name(fewest_tackles_team_id)
  end

  def count_of_teams
      @teams.map {|team| team[:team_id]}.length
  end


end
