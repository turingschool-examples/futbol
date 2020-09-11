class GameTeamsManager
  attr_reader :game_teams, :tracker #do we need attr_reader?
  def initialize(path, tracker)
    @game_teams = []
    @tracker = tracker
    create_game_teams(path)
  end

  def create_game_teams(path)
    game_teams_data = CSV.read(path, headers:true) #may need to change .read to .load
    @game_teams = game_teams_data.map do |data|
      GameTeams.new(data, self)
    end
  end
end
