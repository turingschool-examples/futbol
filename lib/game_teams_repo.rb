class GameTeamsRepo
    def initialize(game_teams_path)
      @game_teams = make_game_teams(game_teams_path)
    end
  
    def make_game_teams(game_teams_path)
      game_teams = []
      CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
        games_teams << GameTeams.new(row)
      end
      game_teams
    end