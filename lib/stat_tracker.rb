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
    game_score = []
    @games.each do |row|
      game_score << row[:away_goals].to_i + row[:home_goals].to_i
    end
    game_score.max
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
    coaches_records = win_percentage_by_coach(coaches_records(season_game_teams))
    winning_coach = coaches_records.max_by do |coach|
      coach[1][2]
    end[0]
  end

end
