require 'CSV'
require_relative 'team'
require_relative 'teams'
require_relative 'game'
require_relative 'games_methods'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    team_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = Games.new(game_path)
    @teams = Teams.new(team_path)
    @game_teams = GameTeams.new(game_teams_path)
  end



  # def initialize(game_path, game_teams_path, teams_path)
  #   @game_teams_collection = GameTeamsCollection.new(game_teams_path)
  #   @game_collection = GameCollection.new(game_path)
  #   @game_teams = GameTeamsStats.new(@game_teams_collection)
  #   @game_stats = GameStats.new(@game_collection)
  #   @team_collection = TeamCollection.new(teams_path)
  #   @season_stats = SeasonStats.new(@game_stats, @game_teams_collection, @team_collection)
  # end
  # def games
  #   Games.new(@game_path)
  # end
  #
  # def teams
  #   Teams.new(@team_path)
  # end
  #
  # def game_teams
  #   GameTeams.new(@game_teams_path)
  # end

  def best_offense
    # team with highest average goals per game
    # team_average = total_goals / all_games

    average_goals_per_team = @teams.map do |team|
      # get the total number of goals
      total_goals = total_goals_per_team(team.id)
      # total_goals = team.total_goals_in_season
      total_games = total_games_per_team(team.id)
      # get the total number of games
      if total_games != 0
        {
          team.name => total_goals / total_games
        }
      else
        {
          team.name => 0
        }
      end
    end

    average_goals_per_team.max do |statistic|
      statistic.values.first
    end.keys.first
  end

  def total_goals_per_team(team_id)
    @games.sum do |game|
      is_home_team = game.home_team_id == team_id
      is_away_team = game.away_team_id == team_id
      if is_home_team
        game.home_goals
      elsif is_away_team
        game.away_goals
      else
        0
      end
    end
  end
end
#   def initialize
#     @teams = []
#     @games = []
#   end
#
# # team_id,franchiseId,teamName,abbreviation,Stadium,link
#
#   def load_from_csv(root_path = "./data")
#     CSV.foreach("#{root_path}/teams.csv", headers: true, header_converters: :symbol) do |row|
#       data = {team_id: row[:team_id],
#               franchiseid: row[:franchiseid],
#               teamname: row[:teamname],
#               abbreviation: row[:abbreviation],
#               stadium: row[:stadium],
#               link: row[:link]
#             }
#       @teams << Team.new(data)
#     end
#
#     CSV.foreach("#{root_path}/games.csv", headers: true, header_converters: :symbol) do |row|
#       data = {game_id: row[:game_id],
#               season: row[:season],
#               type: row[:type],
#               date_time: row[:date_time],
#               away_team_id: row[:away_team_id],
#               home_team_id: row[:home_team_id],
#               away_goals: row[:away_goals],
#               home_goals: row[:home_goals],
#               venue: row[:venue],
#               venue_link: row[:venue_link]
#             }
#       @games << Game.new(data)
#     end
#   end
#
#   def count_of_teams
#     @teams.size
#   end
#
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
