require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_manager'
require_relative './game_team_manager'
require_relative './season_manager'
require_relative './team_manager'
require 'csv'
require 'pry'


class StatTracker
  attr_reader :game_manager, :team_manager, :game_team_manager, :season_manager

  def initialize(locations)
    @game_manager = GameManager.new(locations)
    @team_manager = TeamManager.new(locations)
    @game_team_manager = GameTeamManager.new(locations)
    @season_manager = SeasonManager.new(@game_manager.games_by_season)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @game_manager.highest_total_score
  end

  def lowest_total_score
    @game_manager.lowest_total_score
  end

  def highest_total_score
    @game_manager.highest_total_score
  end

  def percentage_home_wins
    @game_manager.percentage_home_wins
  end

  def winningest_coach(season)
    season_games = @season_manager.game_id_by_season(season) #returns array of game ids
    win_coaches = @game_team_manager.winning_coaches(season_games) # win_coaches equals array of winning coaches for season
    win_coaches.max_by do |coach|
      win_coaches.count(coach) / season_games.count.to_f * 100
    end
  end
end














# LEAGUES METHODS
  # def count_of_teams
  #   @teams.count
  # end
  #
  # def team_average_goals_per_game
  #   students_by_group = {}
  #     @courses.each do |course|
  #       course.students.each do |student|
  #         if students_by_group[student.group].nil?
  #           students_by_group[student.group] = [student]
  #         else
  #           # elsif !students_by_group[student.group].include?(student) <= to avoid using uniq! below
  #
  #           students_by_group[student.group] << student
  #         end
  #         students_by_group[student.group].uniq!
  #       end
  #     end
  #     students_by_group

    #   scores_by_team = {}
    #     @game_teams.each do |gt|
    #       gt.teams.each do |team|
    #         if scores_by_team[team.]
    #
    # average_scores = {}
    # @teams.each do
#   end
#
#   def best_offense
#   end
# end

#
# locations.each do |class_type, path|
#   rows = CSV.read(path, headers: true, header_converters: :symbol)
#   class_name = class_type.capitalize
#   binding.pry
#   rows.map do |row|
#
# @games = from_csv(games_path, Game) # Maybe ||= could prevent edge cases by assigning
# @teams = from_csv(teams_path, Team) # from the .csv if @games does not yet exist
# @game_teams = from_csv(game_teams_path, GameTeam)
#
#
#   def self.from_csv(stat_tracker_params)
#     StatTracker.new(stat_tracker_params)
#
# my examples
# stat_tracker = StatTracker.get_csv(locations)
# # require "pry"; binding.pry
# # p stat_tracker.find_team_by_id('3')
# # p stat_tracker.games_by_season
# p stat_tracker.total_game_score_array
#
#   def find_team_by_id(id) # test method - feel free to delete
#     @teams.find do |team|
#       team.team_id == id
#     end
#   end
#
#   def games_by_season # test method - feel free to delete
#     @games.group_by { |game| game.season }
#   end
#
#   def total_game_score_array # test method - I'm not even sure this one's in the method list
#   total_game_scores = []
#   @games.each do |game|
#     total_game_scores << game.total_game_score #using a method from game class
#   end
#   total_game_scores
#   end
# end
#
# maybe put all the stuff below in another file? module? idk
