

class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    team_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
  end

  def games
    Games.new(@game_path)
  end

  def teams
    Teams.new(@team_path)
  end

  def game_teams
    GameTeams.new(@game_teams_path)
  end
end

#
#   def count_of_teams
#     @teams.size
#   end
#
#   def best_offense
#     # team with highest average goals per game
#     # team_average = total_goals / all_games
#
#     average_goals_per_team = @teams.map do |team|
#       # get the total number of goals
#       total_goals = total_goals_per_team(team.id)
#       # total_goals = team.total_goals_in_season
#       total_games = total_games_per_team(team.id)
#       # get the total number of games
#       if total_games != 0
#         {
#           team.name => total_goals / total_games
#         }
#       else
#         {
#           team.name => 0
#         }
#       end
#     end
#
#     average_goals_per_team.max do |statistic|
#       statistic.values.first
#     end.keys.first
#   end
#
#   def total_goals_per_team(team_id)
#     @games.sum do |game|
#       is_home_team = game.home_team_id == team_id
#       is_away_team = game.away_team_id == team_id
#       if is_home_team
#         game.home_goals
#       elsif is_away_team
#         game.away_goals
#       else
#         0
#       end
#     end
#   end
#
#   def total_games_per_team(team_id)
#     @games.sum do |game|
#       is_home_team = game.home_team_id == team_id
#       is_away_team = game.away_team_id == team_id
#       if is_home_team || is_away_team
#         1
#       else
#         0
#       end
#     end
#   end
