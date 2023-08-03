require_relative 'helper_class'

class StatTracker
  attr_reader :data, 
              :team_file,
              :game_file,
              :game_team_file,
              :test_game_file

  def initialize(data)
    @data = data
    @game_file ||= CSV.open(data[:games], headers: true, header_converters: :symbol).group_by { |row| row[:season] }.map {|key, value| Season.new(key, value)}
    @game_file ||= CSV.open(data[:games], headers: true, header_converters: :symbol).group_by { |row| row[:season] }.map {|key, value| Season.new(key, value)}
    @team_file ||= CSV.foreach(data[:teams], headers: true, header_converters: :symbol) { |row| Team.new(row) }
    # @test_game_file ||= CSV.foreach(data[:games], headers: true, header_converters: :symbol).take(20).map { |row| TeamPerformance.new(row) }
    @game_team_file ||= CSV.foreach(data[:game_teams], headers: true, header_converters: :symbol) { |row| GameTeam.new(row) }
    @teams_lookup = {}
    CSV.foreach(data[:teams], headers: true, header_converters: :symbol) do |row|
      team = Team.new(row)
      @teams_lookup[team.team_id] = team.teamname
    end
    @test_game_file ||= CSV.foreach(data[:games], headers: true, header_converters: :symbol).map do |row|
      team_performance_data = row.to_h
      team_performance_data[:home_team_name] = @teams_lookup[team_performance_data[:home_team_id]]
      team_performance_data[:away_team_name] = @teams_lookup[team_performance_data[:away_team_id]]
      TeamPerformance.new(team_performance_data)
    end
    # require 'pry'; binding.pry
  end

  include Teams
  include Games
  include Seasons
  
  def rewind(file)
    file.rewind
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

end