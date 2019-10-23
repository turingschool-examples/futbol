class GamesTeamsCollection
  attr_reader :games_teams

  def initialize(games_teams_path)
    @games_teams = generate_objects_from_csv(games_teams_path)
  end

  def generate_objects_from_csv(csv_file_path)
    objects = []
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row_object|
      objects << GameTeam.new(row_object)
    end
    objects
  end

  def total_home_games
    @games_teams.count do |game_team|
      game_team.hoa == 'home'
    end
  end
end
