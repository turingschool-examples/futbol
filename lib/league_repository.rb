require_relative './csv_helper_file'
require_relative './repository'

class LeagueRepository < Repository

  def count_of_teams
    @team_collection.count
  end

  def best_offense
    average_team_goals = Hash.new
    total_games = Hash.new
    @game_team_collection.each do |game|
      if total_games[game.team_id] == nil
        total_games[game.team_id] = 0
        total_games[game.team_id] += 1
      else
        total_games[game.team_id] += 1
      end
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

  def find_team_id(id)
    found_team = @team_collection.find do |team|
      team.team_id == id
    end
    named_team = found_team.teamname
    named_team
    # require "pry"; binding.pry
  end

  def worst_offense
    average_team_goals = Hash.new
    total_games = Hash.new
    @game_team_collection.each do |game|
      if total_games[game.team_id] == nil
        total_games[game.team_id] = 0
        total_games[game.team_id] += 1
      else
        total_games[game.team_id] += 1
      end
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

    answer_hash = answer_hash.key(answer_hash.values.min)
    find_team_id(answer_hash)
  end

  def highest_scoring_visitor
    total_away_games = Hash.new
    average_score_away = Hash.new
    @game_collection.each do |game|
      if total_away_games[game.away_team_id] == nil
        total_away_games[game.away_team_id] = 0
        total_away_games[game.away_team_id] += 1
      else
        total_away_games[game.away_team_id] += 1
      end
    end
    @game_collection.each do |game|
      if average_score_away[game.away_team_id] == nil
        average_score_away[game.away_team_id] = 0
        average_score_away[game.away_team_id] += game.away_goals
      else
        average_score_away[game.away_team_id] += game.away_goals
      end
    end
      average_score_away = average_score_away.map do |key, value|
        {key => (average_score_away[key].to_f / total_away_games[key].to_f).round(2)}
      end

      answer_hash = average_score_away.reduce Hash.new, :merge

      answer = answer_hash.key(answer_hash.values.max)
      find_team_id(answer)
  end

  def highest_scoring_home_team
    total_home_games = Hash.new
    average_score_home = Hash.new
    @game_collection.each do |game|
      if total_home_games[game.home_team_id] == nil
        total_home_games[game.home_team_id] = 0
        total_home_games[game.home_team_id] += 1
      else
        total_home_games[game.home_team_id] += 1
      end
    end
    @game_collection.each do |game|
      if average_score_home[game.home_team_id] == nil
        average_score_home[game.home_team_id] = 0
        average_score_home[game.home_team_id] += game.home_goals
      else
        average_score_home[game.home_team_id] += game.home_goals
      end
    end
      average_score_home = average_score_home.map do |key, value|
        {key => (average_score_home[key].to_f / total_home_games[key].to_f).round(2)}
      end

      answer_hash = average_score_home.reduce Hash.new, :merge
      answer = answer_hash.key(answer_hash.values.max)
      find_team_id(answer)
  end

  def lowest_scoring_visitor
    total_away_games = Hash.new
    average_score_away = Hash.new
    @game_collection.each do |game|
      if total_away_games[game.away_team_id] == nil
        total_away_games[game.away_team_id] = 0
        total_away_games[game.away_team_id] += 1
      else
        total_away_games[game.away_team_id] += 1
      end
    end
    @game_collection.each do |game|
      if average_score_away[game.away_team_id] == nil
        average_score_away[game.away_team_id] = 0
        average_score_away[game.away_team_id] += game.away_goals
      else
        average_score_away[game.away_team_id] += game.away_goals
      end
    end
      average_score_away = average_score_away.map do |key, value|
        {key => (average_score_away[key].to_f / total_away_games[key].to_f).round(2)}
      end

      answer_hash = average_score_away.reduce Hash.new, :merge

      answer = answer_hash.key(answer_hash.values.min)
      find_team_id(answer)
  end

  def lowest_scoring_home_team
    total_home_games = Hash.new
    average_score_home = Hash.new
    @game_collection.each do |game|
      if total_home_games[game.home_team_id] == nil
        total_home_games[game.home_team_id] = 0
        total_home_games[game.home_team_id] += 1
      else
        total_home_games[game.home_team_id] += 1
      end
    end
    @game_collection.each do |game|
      if average_score_home[game.home_team_id] == nil
        average_score_home[game.home_team_id] = 0
        average_score_home[game.home_team_id] += game.home_goals
      else
        average_score_home[game.home_team_id] += game.home_goals
      end
    end
      average_score_home = average_score_home.map do |key, value|
        {key => (average_score_home[key].to_f / total_home_games[key].to_f).round(2)}
      end

      answer_hash = average_score_home.reduce Hash.new, :merge
      answer = answer_hash.key(answer_hash.values.min)
      find_team_id(answer)
  end

end
