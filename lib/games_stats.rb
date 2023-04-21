class GamesStats
  attr_reader :games,
              :game_teams

  def initialize(locations)
    @games = (CSV.open locations[:games], headers: true, header_converters: :symbol).map { |line| Game.new(line) } 
    # @teams = (CSV.open locations[:teams], headers: true, header_converters: :symbol).map { |team| Team.new(team) } 
    @game_teams = (CSV.open locations[:game_teams], headers: true, header_converters: :symbol).map { |game_team| GameTeam.new(game_team) }
  end

  def merge_game_game_teams
    @games.map! do |game|
      @game_teams.each do |game_team|
        if game_team.game_id == game.game_id 
          if game_team.home_away == "home"
            game.home_team_goals = game_team.goals
            game.home_result = game_team.result
            game.home_shots = game_team.shots
            game.home_head_coach = game_team.head_coach
            game.home_tackles = game_team.tackles
          elsif game_team.home_away == "away"
            game.away_team_goals = game_team.goals
            game.away_result = game_team.result
            game.away_shots = game_team.shots
            game.away_head_coach = game_team.head_coach
            game.away_tackles = game_team.tackles
          end
        end
      end
      game
    end
  end

  # highest sum of winning and losing teams score
  def highest_total_score
    # i want to find the game with the highest points scored and add the home score and away score.
    require 'pry'; binding.pry
  end
end