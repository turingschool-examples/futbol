require_relative './csv_helper_file'


class LeagueRepository

  def initialize(game_path, game_team_path, team_path)
    @game_collection = CsvHelper.generate_game_array(game_path)
    @game_team_collection = CsvHelper.generate_game_teams_array(game_team_path)
    @team_collection = CsvHelper.generate_team_array(team_path)
  end

  def count_of_teams
    @team_collection.count
  end

  def best_offense
    team_goal_totals = {}
    @game_team_collection.each do |game|
      if team_goal_totals[game.team_id] == nil
        team_goal_totals[game.team_id] = 0
      else
        team_goal_totals[game.team_id] += game.goals
      end
    end
    max_total = team_goal_totals.max_by do |keys, values|
        team_goal_totals[keys]
      end
      highest_team_id = max_total.first
      # require "pry"; binding.pry
      find_team_id(highest_team_id)

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
    team_goal_totals = {}
    @game_team_collection.each do |game|
      if team_goal_totals[game.team_id] == nil
        team_goal_totals[game.team_id] = 0
      else
        team_goal_totals[game.team_id] += game.goals
      end
    end
    min_total = team_goal_totals.min_by do |keys, values|
        team_goal_totals[keys]
      end
      lowest_team_id = min_total.first
      find_team_id(lowest_team_id)
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
