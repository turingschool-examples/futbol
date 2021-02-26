class Game

  attr_reader :data

  def initialize(data, manager)
    @manager = manager
    @data = data
    # @away_team_id = data[:away_team_id]
  end
end




# class Game
#   def initialize(data, manager)
#     @manager = manager
#     @name = data[:name]
#     @away_team_id = data[:away_team_id]
#   end
#
#   def away_team
#     @manager.find_team_by_id(@away_team_id)
#   end
# end
