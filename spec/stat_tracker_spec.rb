require "./lib/stat_tracker"
require "./lib/game"

RSpec.describe StatTracker do
  before do
    game_file = "./data/games.csv"
    team_file = "./data/teams.csv"
    game_teams_file = "./data/teams.csv"
    game_lines = CSV.open game_file, headers: true, header_converters: :symbol
    team_lines = CSV.open game_file, headers: true, header_converters: :symbol
    game_teams_lines = CSV.open game_file, headers: true, header_converters: :symbol
    games = []
    teams = []
    game_teams = []
    game_lines.each do |line|
      games << Game.new(line)
    end
    team_lines.each do |line|
      teams << Team.new(line)
    end
    game_team_lines.each do |line|
      game_teams << GameTeam.new(line)
    end
    @game_1 = games[0]
    @game_2 = games[2] 
    @game_3 = games[11] 
    @game_4 = games[5] 
    @game_5 = games[12]
    @game_6 = games[9]
  end
end