require "csv"
class FutbolData

  attr_accessor :games, :teams, :game_teams

  def initialize(passed)
    @passed = passed
    @data_location = nil
    create_objects
  end

  def create_objects
    chosen_data_set # returns correct @data_location
    if @passed == 'teams'
      case_is_team
    elsif @passed == 'games'
      case_is_game
    elsif @passed == 'game_teams'
      case_is_game_teams
    end
  end

  def chosen_data_set
    case @passed
      when "teams"
        @data_location = './data/teams.csv'
      when "games"
        @data_location = './data/games.csv'
      when "game_teams"
        @data_location = './data/game_teams.csv'
    end
    @data_location
  end

  def case_is_team
    @teams = []
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |specific_data|
      @teams << specific_data
    end
    @teams
  end

  def case_is_game
    @games = []
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |specific_data|
      @games << specific_data
    end
    @games
  end

  def case_is_game_teams
    @game_teams = []
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |specific_data|
      @game_teams << specific_data
    end
    @game_teams
  end

end
