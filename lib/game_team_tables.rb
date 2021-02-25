class GameTeamTable < StatTracker
  attr_reader :game_team_data
  def initialize(stat_tracker)
    @game_team_data = stat_tracker
  end

  def random_task(data)
    super
  end
  def send_team_data(teams)
    super
  end
  
end