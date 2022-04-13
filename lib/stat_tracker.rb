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

  def winningest_coach(season)
    season_games = games_by_season(season)
    coaches_records = {}

    season_game_teams = []
    @game_teams.each do |row|
      season_games.each do |game|
        if row[:game_id] == game[:game_id]
          season_game_teams << row
        end
      end
    end

    season_game_teams.each do |row|
      coaches_records[row[:head_coach]] = [0,0,0,0.to_f]
    end

    season_game_teams.each do |row|
      if row[:result] == "WIN"
        coaches_records[row[:head_coach]][0] += 1
      elsif row[:result] == "LOSS"
        coaches_records[row[:head_coach]][1] += 1
      elsif row[:result] == "TIE"
        coaches_records[row[:head_coach]][2] += 1
      end
    end

    coaches_records.keys.each do |key|
      total_games = coaches_records[key][0] + coaches_records[key][1] + coaches_records[key][2]
      coaches_records[key][3] = coaches_records[key][0]/total_games.to_f
    end

    winning_coach = ""
    winning_coach_percentage = 0.to_f

    coaches_records.keys.each do |key|
      if coaches_records[key][3] > winning_coach_percentage
        winning_coach_percentage = coaches_records[key][3]
        winning_coach = key
      end
    end

    require 'pry'; binding.pry

    return winning_coach
  end

end
