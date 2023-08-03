require_relative 'helper_class'

class StatTracker
  attr_reader :data, 
              :team_file,
              :game_file,
              :game_team_file

  def initialize(data)
    @data = data
    @game_file ||= CSV.open(data[:games], headers: true, header_converters: :symbol).group_by { |row| row[:season] }.map {|key, value| Season.new(key, value)}
    @game_file2 ||= CSV.foreach(data[:games], headers: true, header_converters: :symbol) { |row| SeasonGameID.new(row) }
    @team_file ||= CSV.foreach(data[:teams], headers: true, header_converters: :symbol) { |row| Team.new(row) }
    @game_team_file ||= CSV.foreach(data[:game_teams], headers: true, header_converters: :symbol) { |row| GameTeam.new(row) }
    
  end

  include Teams
  include Seasons
  
  def rewind(file)
    file.rewind
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

end