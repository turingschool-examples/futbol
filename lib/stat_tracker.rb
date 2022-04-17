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
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    # require 'pry'; binding.pry
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins(team)
    # @game_teams.map {|game_team| (gam.}
  end


  def games_by_season(season)
    @games.select do |row|
      row.season == season
    end
  end

  def team_info(given_team_id)
    team = {}
    @teams.each do |row|
      if row.team_id == given_team_id
        team[:team_id] = row.team_id
        team[:franchise_id] = row.franchise_id
        team[:team_name] = row.team_name
        team[:abbreviation] = row.abbreviation
        team[:link] = row.link
      end
    end
    return team
  end

  def game_teams_by_season(season)
    @game_teams.select do |row|
      row.game_id.to_s[0..3] == season.to_s[0..3]
    end
  end

  def coaches_records(game_teams)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    game_teams.each do |row|
      if row.result == "WIN"
        hash[row.head_coach][0] += 1
      else
        hash[row.head_coach][1] += 1
      end
    end
    return hash
  end

  def percentage_away_wins
    game_results = Hash.new{|h,k| h[k] = [0,0,0,0,0,0.to_i] }
      @game_teams.each do |game|
        if game.hoa == "home" && game.result == "WIN"
          game_results[game.data][0] += 1
        elsif game.hoa == "home" && game.result == "LOSS"
          game_results[game.data][1] += 1
        elsif game.hoa == "away" && game.result == "WIN"
          game_results[game.data][2] += 1
        elsif game.hoa == "away" && game.result == "LOSS"
          game_results[game.data][3] += 1
        elsif game.hoa == "home" && game.result == "TIE"
          game_results[game.data][4] += 1
        elsif game.hoa == "away" && game.result == "TIE"
          game_results[game.data][4] += 1
        end
      end
      require "pry"; binding.pry
      return game_results
  end

  def percentage_home_wins
    total_home_games = game_results[key][0] + game_results[key][1]
    percentage_home_wins = game_results[key][0]/total_home_games.to_f
  end

  def percentage_away_wins
    total_away_games = game_results[key][2] + game_results[key][3]
    percentage_away_wins = game_results[key][2]/total_away_games.to_f
  end

  # def percentage_home_wins
  #   game_results = Hash.new{|h,k| h[k] = [0,0,0,0,0,0.to_f] }
  #     @game_teams.each do |row|
  #       require "pry"; binding.pry
  #       if row[:HoA] == "home" && row[:result] == "WIN"
  #         game_results[tallies][0] += 1
  #       elsif row[:HoA] == "home" && row[:result] == "LOSS"
  #         game_results[tallies][1] += 1
  #       elsif row[:HoA] == "away" && row[:result] == "WIN"
  #         game_results[tallies][2] += 1
  #       elsif row[:HoA] == "away" && row[:result] == "LOSS"
  #         game_results[tallies][3] += 1
  #       elsif row[:HoA] == "home" && row[:result] == "TIE"
  #         game_results[tallies][4] += 1
  #       elsif row[:HoA] == "away" && row[:result] == "TIE"
  #         game_results[tallies][4] += 1
  #       end
  #     end
  #     return game_results
  # end



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
      row.team_id == id
    end.team_name.to_s
  end

  # def total_amount_shots(game_teams, category)
  #   game_teams.map do |game|
  #     game.shots
  #   end.sum
  # end
  #

  def accuracy_hash(season)
    season_game_teams = game_teams_by_season(season)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    season_game_teams.each do |row|
      hash[row.team_id][0] += row.goals
      hash[row.team_id][1] += row.shots
      hash[row.team_id][2] = hash[row.team_id][0]/hash[row.team_id][1].to_f
    end
    hash
  end
  # require "pry"; binding.pry

  def most_accurate_team(season)
    accurate_team_id = accuracy_hash(season).max_by do |team|
      team[1][2]
    end[0]
    return team_name(accurate_team_id)
  end

  def least_accurate_team(season)
    accurate_team_id = accuracy_hash(season).min_by do |team|
      team[1][2]
    end[0]
    return team_name(accurate_team_id)
  end

  def tackle_hash(season)
    season_game_teams = game_teams_by_season(season)
    hash = Hash.new{|h,k| h[k] = 0 }
    season_game_teams.each do |row|
      hash[row.team_id] += row.tackles
    end
    hash
  end

  def most_tackles(season)
    most_tackles_team_id = tackle_hash(season).max_by do |team|
      team[1]
    end[0]
    return team_name(most_tackles_team_id)
  end

  def fewest_tackles(season)
    most_tackles_team_id = tackle_hash(season).min_by do |team|
      team[1]
    end[0]
    return team_name(most_tackles_team_id)
  end

  def count_of_teams
      @teams.map {|team| team.team_id}.length
      # require 'pry'; binding.pry
  end


end
