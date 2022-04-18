  require 'csv'

  require_relative 'game'
  require_relative 'team'
  require_relative 'game_team'

  class CSVReader
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
  end
