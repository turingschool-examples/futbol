require './lib/teams.rb'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams,
              :game_path,
              :team_path,
              :game_teams_path,
              :locations

  def initialize(games, teams, game_teams)
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    @games = games
    @teams = Teams.create_multiple_teams(@locations[:teams])
    @game_teams = game_teams
    #two ways to create a stat tracker: data that I give it
  end


  def self.from_csv(locations)
    games = CSV.parse(File.read(locations[:games]), headers: true, header_converters: :symbol).map(&:to_h)
    #reads each csv row as a hash with the header as the key and the data as the value, all inside an
    @teams
    # teams = CSV.parse(File.read(locations[:teams]), headers: true, header_converters: :symbol).map(&:to_h)
    game_teams = CSV.parse(File.read(locations[:game_teams]), headers: true, header_converters: :symbol).map(&:to_h)
    StatTracker.new(games, @teams, game_teams)
    #data from CSV file
  end
end
