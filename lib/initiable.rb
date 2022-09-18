require 'csv'

module Initiable

  @@all_teams
  @@all_games
  @@all_game_teams

  def initialize(csvs)
    @@all_teams = []
    @@all_games = []
    @@all_game_teams = []
    csvs[:game_csv].each {|row| @@all_games << row}
    csvs[:gameteam_csv].each {|row| @@all_game_teams << row}
    csvs[:team_csv].each {|row| @@all_teams << row}
  end
end
