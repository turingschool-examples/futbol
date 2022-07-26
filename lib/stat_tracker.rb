class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    #two ways to create a stat tracker: data that I give it
  end


  def self.from_csv(locations)
    games = CSV.parse(File.read(locations[:games]), headers: true, header_converters: :symbol).map(&:to_h)
    #reads each csv row as a hash with the header as the key and the data as the value, all inside an array
    teams = CSV.parse(File.read(locations[:teams]), headers: true, header_converters: :symbol).map(&:to_h)
    game_teams = CSV.parse(File.read(locations[:game_teams]), headers: true, header_converters: :symbol).map(&:to_h)
    StatTracker.new(games, teams, game_teams)
    #data from CSV file
  end
end

