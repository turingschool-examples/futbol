require_relative 'helper_class'

class StatTracker
  attr_reader :data, 
              :team_file,
              :game_file,
              :game_team_file

  def initialize(data)
    @data = data
    @game_file = CSV.open data[:games], headers: true, header_converters: :symbol
    @team_file = CSV.open data[:teams], headers: true, header_converters: :symbol
    @game_team_file = CSV.open data[:game_teams], headers: true, header_converters: :symbol
    @teams = []
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def create_teams
    @team_file.each do |team|
      @teams << Teams.new(team)
    end
  end

  def count_of_teams
    @teams.count
  end
end
