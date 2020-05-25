require_relative './game'
require_relative './team'
require_relative './game_teams'
require 'csv'
require 'pry'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_teams)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_teams = game_teams_path
  end

  def highest_total_score
    sum_total_score = []
    games.by_row.each do |data|
        sum_total_score << data[6].to_i + data[7].to_i
    end
    sum_total_score.max
  end

  def lowest_total_score
    sum_total_score = []
    games.by_row.each do |data|
        sum_total_score << data[6].to_i + data[7].to_i
    end
    sum_total_score.min
  end

  #   highest_total_away_score = games.by_col![7].max_by do |number|
  #     number
  #   end
  #
  #   highest_total_score = highest_total_home_score + highest_total_away_score
  # end
  #
  # def lowest_total_score
  #   highest_total_home_score = games.by_row[6][7].sum do |number|
  #     number
  #   end
  #
  #   highest_total_away_score = games.by_col[7].max do |number|
  #     number
  #   end
  #
  #   highest_total_score = highest_total_away_score - highest_total_home_score
  # end
end
