require_relative './csv_helper_file'
require_relative './repository'
require_relative './findable'

class LeagueRepository < Repository
  include Findable

  def count_of_teams
    @team_collection.count
  end

  def best_offense
    average_team_goals = Hash.new(0)
    total_games = Hash.new(0)
    @game_team_collection.each do |game|
        total_games[game.team_id] += 1
    end
    @game_team_collection.each do |game|
      if average_team_goals[game.team_id] == nil
        average_team_goals[game.team_id] = 0
      else
        average_team_goals[game.team_id] += game.goals
      end
    end
    average_team_goals = average_team_goals.map do |key, value|
      {key => (average_team_goals[key].to_f / total_games[key].to_f).round(3)}
    end

    answer_hash = average_team_goals.reduce Hash.new, :merge

    answer_hash = answer_hash.key(answer_hash.values.max)
    find_team_id(answer_hash)
  end

  def worst_offense
    average_team_goals = Hash.new(0)
    total_games = Hash.new(0)
    @game_team_collection.each do |game|
        total_games[game.team_id] += 1
    end
    @game_team_collection.each do |game|
        average_team_goals[game.team_id] += game.goals
    end
    average_team_goals = average_team_goals.map do |key, value|
      {key => (average_team_goals[key].to_f / total_games[key].to_f).round(3)}
    end

    answer_hash = average_team_goals.reduce Hash.new, :merge

    answer_hash = answer_hash.key(answer_hash.values.min)
    find_team_id(answer_hash)
  end

  def highest_scoring_visitor
    total_away_games = Hash.new(0)
    score_away = Hash.new(0)
    @game_collection.each do |game|
        total_away_games[game.away_team_id] += 1
    end
    @game_collection.each do |game|
        score_away[game.away_team_id] += game.away_goals
    end
      score_away = score_away.map do |key, value|
        {key => (score_away[key].to_f / total_away_games[key].to_f).round(2)}
      end

      answer_hash = score_away.reduce Hash.new, :merge

      answer = answer_hash.key(answer_hash.values.max)
      find_team_id(answer)
  end

  def highest_scoring_home_team
    total_home_games = Hash.new(0)
    score_away = Hash.new(0)
    @game_collection.each do |game|
        total_home_games[game.home_team_id] += 1
    end
    @game_collection.each do |game|
        score_away[game.home_team_id] += game.home_goals
    end
      score_away = score_away.map do |key, value|
        {key => (score_away[key].to_f / total_home_games[key].to_f).round(2)}
      end

      answer_hash = score_away.reduce Hash.new, :merge
      answer = answer_hash.key(answer_hash.values.max)
      find_team_id(answer)
  end

  def lowest_scoring_visitor
    away_games = Hash.new(0)
    average_score_away = Hash.new(0)
    @game_collection.each do |game|
      away_games[game.away_team_id] += 1
    end
    @game_collection.each do |game|
        average_score_away[game.away_team_id] += game.away_goals
    end
    average_score_away = average_score_away.map do |key, value|
      {key => (average_score_away[key].to_f / away_games[key].to_f).round(2)}
    end

    answer_hash = average_score_away.reduce Hash.new, :merge

    answer = answer_hash.key(answer_hash.values.min)
    find_team_id(answer)
  end

  def lowest_scoring_home_team
    total_home_games = Hash.new(0)
    average_score = Hash.new(0)
    @game_collection.each do |game|
        total_home_games[game.home_team_id] += 1
    end
    @game_collection.each do |game|
        average_score[game.home_team_id] += game.home_goals
    end
    average_score = average_score.map do |key, value|
      {key => (average_score[key].to_f / total_home_games[key].to_f).round(2)}
    end

    answer_hash = average_score.reduce Hash.new, :merge
    answer = answer_hash.key(answer_hash.values.min)
    find_team_id(answer)
  end

end
