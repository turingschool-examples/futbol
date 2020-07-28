require "csv"
class FutbolData

  def initialize(passed)
    @passed = passed
    @data_location = nil
    @teams = []
    @games = []
    @game_teams = []
    create_objects
  end

  def games
    @games
  end

  def teams
    @teams
  end

  def game_teams
    @game_teams
  end

  def create_objects
    chosen_data_set
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
  end

  def case_is_team
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |x|
      @teams << x
    end
  end

  def case_is_game
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |x|
      @games << x
    end
  end

  def case_is_game_teams
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |x|
      @game_teams << x
    end
  end

end
