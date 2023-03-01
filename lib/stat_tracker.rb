require 'csv' 
require_relative './lib/teams'
require_relative './lib/games'
require_relative './lib/game_teams'


class StatTracker
  def self.from_csv(files)
    teams = CSV.open (files[:teams], headers: true, header_converters: :symbol).map {|row| row}
    games = CSV.open (files[:games], headers: true, header_converters: :symbol).map {|row| }
    game_teams = CSV.open (files[:games], headers: true, header_converters: :symbol).map {|row| }
  end
  
end