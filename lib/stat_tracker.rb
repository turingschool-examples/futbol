require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = read_from_file(locations[:games])
    teams = read_from_file(locations[:teams])
    game_teams = read_from_file(locations[:game_teams])
    stat_tracker = self.new(games, teams, game_teams)
  end

  def self.read_from_file(file)
    file_open = CSV.open(file)

    file_open.read
  end

  def match_data_with_header(file)
    self.instance_variable_get(file).transpose
  end

  def match_data_by_spec(file, column)
    self.instance_variable_get(file).shift
    self.instance_variable_get(file).map do |line|
       line.unshift(line[column])
    end
  end

  def group_by(data)
    hash = {}
    data.each do |thing|
      hash[thing.shift] = thing.flatten
    end
    hash
  end

  def count_of_teams
    group_by(match_data_with_header(:@teams))["teamName"].count
  end

end
