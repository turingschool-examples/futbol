require_relative "./stat_tracker"
require "csv"

class LeagueStatistics < StatTracker

  def count_of_teams
    total_games = CSV.read(@teams, :headers=>true)
    total_games.count
  end

  def team_name(id)
    rows = CSV.read(@teams, :headers => true, :header_converters => :symbol)
    rows.find do |row|
      return row[:teamname] if row[:team_id] == id.to_s
    end
  end

  def team_scores
    scores("home_and_away")
  end

  def visitor_scores
    scores("away")
  end

  def home_team_scores
    scores("home")
  end

  def scores(side)
    scores = Hash.new { |hash, key| hash[key] = [] }
    CSV.foreach(@game_teams, :headers => true, :header_converters => :symbol) do |row|
      if side == "home_and_away"
        scores[row[:team_id]] << row[:goals].to_i
      elsif row[:hoa] == side
        scores[row[:team_id]] << row[:goals].to_i
      end
    end
    scores
  end

  def average_team_scores
    average_scores(team_scores)
  end

  def average_visitor_scores
    average_scores(visitor_scores)
  end

  def average_home_team_scores
    average_scores(home_team_scores)
  end

  def average_scores(side_scores_hash)
    average_scores = Hash.new
    side_scores_hash.each do |team, scores|
      average_scores[team] = (scores.sum.to_f / scores.count).round(2)
    end
    average_scores
  end

  def best_offense
    highest_score(average_team_scores)
  end

  def highest_scoring_visitor
    highest_score(average_visitor_scores)
  end

  def highest_scoring_home_team
    highest_score(average_home_team_scores)
  end

  def highest_score(average_side_scores)
    highest_score = average_side_scores.max_by do |team, av_score|
      av_score
    end[0]
    team_name(highest_score)
  end

  def worst_offense

    lowest_score(average_team_scores)
  end

  def lowest_scoring_visitor
    lowest_score(average_visitor_scores)
  end

  def lowest_scoring_home_team
    lowest_score(average_home_team_scores)
  end

  def lowest_score(average_side_scores)
    lowest_score = average_side_scores.min_by do |team, av_score|
      av_score
    end[0]
    team_name(lowest_score)
  end
end
