require 'csv'
class Game

  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link
  def initialize(info)
    @game_id = info[:game_id]
    @season = info[:season]
    @type = info[:type]
    @date_time = info[:date_time]
    @away_team_id = info[:away_team_id]
    @home_team_id = info[:home_team_id]
    @away_goals = info[:away_goals]
    @home_goals = info[:home_goals]
    @venue = info[:venue]
    @venue_link = info[:venue_link]
  end

end
# 
# game_path = './data/games.csv'
#  team_path = './data/teams.csv'
#  game_teams_path = './data/game_teams.csv'
#
#  locations = {
#    games: game_path,
#    teams: team_path,
#    game_teams: game_teams_path
#  }
#
# games_hash = {}
#
# CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
#   games_hash[row[:game_id]] = Game.new(row)
# end
# require "pry"; binding.pry
