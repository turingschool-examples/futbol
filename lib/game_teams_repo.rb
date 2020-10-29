require 'CSV'
require './lib/game_teams'
class GameTeamsRepo
  attr_reader :parent, 
              :game_teams 
  
  def initialize(path, parent)
    @parent = parent
    @game_teams = create_game_teams(path)
  end

  def create_game_teams(path) 
    rows = CSV.readlines('./data/game_teams.csv', headers: :true , header_converters: :symbol)

    rows.map do |row|
      GameTeams.new(row, self)
    end
  end
end
#add percentage games stats methods 
