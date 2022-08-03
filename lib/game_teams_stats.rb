require "csv"
require_relative "./game_teams"
require_relative "./isolatable"
require_relative "./helpable"

class GameTeamsStats
  include Helpable
  include Isolatable

  attr_reader :game_teams

  def initialize(game_teams)
    @game_teams = game_teams
  end

  def self.from_csv(location)
    game_teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    game_teams_as_objects = game_teams.map { |row| GameTeams.new(row) }
    GameTeamsStats.new(game_teams_as_objects)
  end

  def most_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      goals_by_game << game.goals.to_i if team_id == game.team_id
    end
    goals_by_game.max
  end

  def fewest_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      goals_by_game << game.goals.to_i if team_id == game.team_id
    end
    goals_by_game.min
  end

  def best_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }

    team_scores_average =
      team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #create an average out of the scores
      end
  end

  def worst_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }
    team_scores_average =
      team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #creat an average out of the scores
      end
  end

  def number_of_tackles(team_id, game_id)
    tackles = 0
    @game_teams.each do |game_team|
      if team_id == game_team.team_id && game_id == game_team.game_id
        tackles += game_team.tackles.to_i
      end
    end
    tackles
  end

  def coach_percentage_loss(coaches, game_id_list)
    coaches = isolate_coach_loss(game_id_list)
    coach_percentage_lost =
      coaches.map do |coach_name, game_loss|
        percentage_lost = (game_loss.to_f / game_id_list.length) * 100
        [coach_name, percentage_lost]
      end.to_h
  end

  def coach_percentage_won(coaches, game_id_list)
    coaches = isolate_coach_wins(game_id_list)
    coach_percentage_won =
      coaches.map do |coach_name, game_won|
        percentage_won = (game_won.to_f / game_id_list.length) * 100
        [coach_name, percentage_won]
      end.to_h
  end
end
