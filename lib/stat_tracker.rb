require 'csv'
require 'active_support'
require './lib/csv_to_hashable.rb'
class StatTracker 
  include CsvToHash
  attr_reader :games, :hash, :locations
  def initialize(locations)
    from_csv(locations)
    @game_table = GameTable.new(@hash[:games])
  end

  def highest_score
    self.from_csv(csv_files)
    
  end

  def team_instantiate
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv',
      #teams_test: './data/teams_test.csv'
    }
    info = from_csv(locations)
    team = TeamsTable.new(info[:teams])
  end
  # CSV.parse(File.read(csv_file[1]), headers: true, converters: :numeric).map{|line| line}
end

    # csv_files.map {
    #   |csv_file| 
    #   symbol = csv_file[0]
    #   CSV.parse(File.read(csv_file[1]),converters: :numeric).map{|item| item}
    # }
    # csv_files.each_with_index{|file, i| Hash[file[0],data[i]}
    #     csv_files.map{ |file|
    #   CSV.parse(File.read(file[1]), headers: true, converters: :numeric, header_converters: :symbol).map{
    #   |row| 
    #   headers ||= row.headers
    #   data << row.to_h
    # }}

