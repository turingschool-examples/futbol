require 'csv'

class StatTracker
  attr_reader :teams, :game_teams, :games
  @@teams = nil
  @@game_teams = nil
  @@games = nil

  def self.from_csv(files)
    # CSV.foreach(files[:teams]) do |row|
    #   require 'pry'; binding.pry
    # end
     @@teams = CSV.parse(File.read(files[:teams]), headers: true)
     @@game_teams = CSV.parse(File.read(files[:game_teams]), headers: true)
     @@games = CSV.parse(File.read(files[:games]), headers: true)
  end
end
