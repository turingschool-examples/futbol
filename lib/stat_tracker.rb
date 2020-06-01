
require_relative "./helper"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @games.all
  end

  def teams
    @teams.all
  end

  def game_teams
    @game_teams.all
  end

  def count_of_teams
    teams.count
  end

  def find_team_by_id(id)
    teams.find do |team|
      team.team_id.to_i == id.to_i
    end
  end

  def scores_by_team
    game_teams.reduce({}) do |team_scores, game|
      if team_scores[game.team_id].nil?
        team_scores[game.team_id] = [game.goals.to_i]
      else
        team_scores[game.team_id] << game.goals.to_i
      end
      team_scores
    end
  end

  def average_scores_by_team
    average_scores_by_team = {}
    scores_by_team.each do |team, scores|
      average_scores_by_team[team] = (scores.sum / scores.count.to_f)
    end
    average_scores_by_team
  end

  def best_offense
    highest_average_score = average_scores_by_team.max_by do |team, average_score|
      average_score
    end
    find_team_by_id(highest_average_score.first).team_name
  end

  def worst_offense
    lowest_average_score = average_scores_by_team.min_by do |team, average_score|
      average_score
    end
    find_team_by_id(lowest_average_score.first).team_name
  end

  def scores_by_away_team
    games.reduce({}) do |team_scores, game|
      if team_scores[game.away_team_id].nil?
        team_scores[game.away_team_id] = [game.away_goals.to_i]
      else
        team_scores[game.away_team_id] << game.away_goals.to_i
      end
      team_scores
    end
  end

  def average_scores_by_away_team
    average_scores_by_away_team = {}
    scores_by_away_team.each do |team, scores|
      average_scores_by_away_team[team] = (scores.sum / scores.count.to_f)
    end
    average_scores_by_away_team
  end

  def highest_scoring_visitor
    highest_average_score = average_scores_by_away_team.max_by do |team, average_score|
      average_score
    end
    find_team_by_id(highest_average_score.first).team_name
  end

  def lowest_scoring_visitor
    lowest_average_score = average_scores_by_away_team.min_by do |team, average_score|
      average_score
    end
    find_team_by_id(lowest_average_score.first).team_name
  end

  def scores_by_home_team
    games.reduce({}) do |team_scores, game|
      if team_scores[game.home_team_id].nil?
        team_scores[game.home_team_id] = [game.home_goals.to_i]
      else
        team_scores[game.home_team_id] << game.home_goals.to_i
      end
      team_scores
    end
  end

  def average_scores_by_home_team
    average_scores_by_home_team = {}
    scores_by_home_team.each do |team, scores|
      average_scores_by_home_team[team] = (scores.sum / scores.count.to_f)
    end
    average_scores_by_home_team
  end

  def highest_scoring_home_team
    highest_average_score = average_scores_by_home_team.max_by do |team, average_score|
      average_score
    end
    find_team_by_id(highest_average_score.first).team_name
  end

  def lowest_scoring_home_team
    lowest_average_score = average_scores_by_home_team.min_by do |team, average_score|
      average_score
    end
    find_team_by_id(lowest_average_score.first).team_name
  end

end
