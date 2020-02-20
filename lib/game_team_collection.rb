class GameTeamCollection

  attr_reader :games_by_teams, :csv_file_path
  def initialize(csv_file_path)
    @games_by_teams = []
    @csv_file_path = csv_file_path
  end
end
