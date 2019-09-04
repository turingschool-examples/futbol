class StatTracker
  attr_reader :all_teams, :all_games, :all_game_teams

  def initialize(team_array, game_array, game_teams_array)
    @all_teams = team_array[1..-1]
    @all_games = game_array[1..-1]
    @all_game_teams = game_teams_array[1..-1]
  end

  def self.from_csv(file_paths)
    all_teams = Array.new
    all_games = Array.new
    all_game_teams = Array.new
    self.generate_data(file_paths[:teams], Team, all_teams)
    self.generate_data(file_paths[:games], Game, all_games)
    self.generate_data(file_paths[:game_teams], GameTeam, all_game_teams)
    self.new(all_teams, all_games, all_game_teams)
  end


  def self.generate_data(location ,obj_type, array)
    CSV.foreach(location) do |row|
      array << obj_type.new(row)
    end
  end
end
