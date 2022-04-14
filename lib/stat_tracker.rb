require 'csv'

# game_data = CSV.open"./data/games.csv", headers: true, header_converters: :symbol

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = CSV.read "#{locations[:games]}", headers: true, header_converters: :symbol
    @teams = CSV.read "#{locations[:teams]}", headers: true, header_converters: :symbol
    @game_teams = CSV.read "#{locations[:game_teams]}", headers: true, header_converters: :symbol
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @games.map {|game| game[:away_goals].to_i + game[:home_goals].to_i}.max
  end

  def games_by_season(season)
    @games.select do |row|
      row[:season] == season.to_s
    end
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
    accurate_team_id = hash.min_by do |team|
      team[1][2]
    end[0]
    return team_name(accurate_team_id)
  end

  def count_of_teams
      @teams.map {|team| team[:team_id]}.length
  end


end
