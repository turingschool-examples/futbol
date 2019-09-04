class StatTracker

  def self.from_csv(file_paths)
    @all_teams = Array.new
    @all_games = Array.new
    @all_game_teams = Array.new
    self.generate_data(file_paths[:teams], Team, @all_teams)
    self.generate_data(file_paths[:games], Game, @all_games)
    self.generate_data(file_paths[:teams], GameTeam, @all_game_teams)
    data = {
      teams: @all_teams[1..-1],
      games: @all_games[1..-1],
      game_teams: @all_game_teams[1..-1]
    }
  end

  def self.generate_data(location ,obj_type, array)
    CSV.foreach(location) do |row|
      array << obj_type.new(row)
    end
  end
end
