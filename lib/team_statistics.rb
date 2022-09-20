class TeamStatTracker < StatTracker
  attr_reader :team_id,
              :team_games

  def initialize
    @team_games = {}
    super()
  end

  def team_games_import(team_id)
    @games.each do |game_id, game_data|
      if game_data.away_team[:team_id] == team_id || game_data.home_team[:team_id] == team_id
        @team_games[game_id] = game_data
      end
    end
  end

  #right now there is only 1 return value being given though for our
  #test there are 2 seasons that should be returned. Consider refactoring

  def best_season(team_id)
    season_wins = Hash.new(0)
    @team_games.each do |game_id, game_data|
        if (game_data.away_team[:team_id] == team_id && game_data.away_team[:result] == "WIN") || (game_data.home_team[:team_id] == team_id && game_data.home_team[:result] == "WIN")
          season_wins[game_data.season] += 1
        end
    end
    season_wins.update(season_wins) do |season, win_count|
      win_count.to_f / @team_games.values.length
    end
    season_wins.key(season_wins.values.max)
  end

  def worst_season(team_id)
    season_wins = Hash.new(0)
    @team_games.each do |game_id, game_data|
      season_wins[game_data.season] = 0
      break
    end
    @team_games.each do |game_id, game_data|
      if (game_data.away_team[:team_id] == team_id && game_data.away_team[:result] == "WIN") || (game_data.home_team[:team_id] == team_id && game_data.home_team[:result] == "WIN")
        season_wins[game_data.season] += 1
      end
    end
    season_wins.update(season_wins) do |season, win_count|
      win_count.to_f / @team_games.values.length
    end
    season_wins.key(season_wins.values.min)
  end

  def average_win_percentage(team_id)
    count = 0
    @team_games.each do |game_id, game_data|
      if (game_data.away_team[:team_id] == team_id && game_data.away_team[:result] == "WIN") || (game_data.home_team[:team_id] == team_id && game_data.home_team[:result] == "WIN") 
        count += 1
      end
    end
    (count.to_f/@team_games.values.length).round(2)
  end

  def most_goals_scored(team_id)
    unique_total_goals = []
    @team_games.each do |game_id, game_data|
      if game_data.away_team[:team_id] == team_id
        unique_total_goals << game_data.away_goals
      else
        unique_total_goals << game_data.home_goals
      end
    end
    unique_total_goals.max
  end

  def fewest_goals_scored(team_id)
    unique_total_goals = []
    @team_games.each do |game_id, game_data|
      if game_data.away_team[:team_id] == team_id
        unique_total_goals << game_data.away_goals
      else
        unique_total_goals << game_data.home_goals
      end
    end
    unique_total_goals.min
  end

  def games_by_team_by_result(team_id, game_result)
    result_by_team = Hash.new(0)
    @team_games.each do |game_id, game_data|
      if game_data.away_team[:team_id] == team_id && game_data.away_team[:result] == game_result
        result_by_team[game_data.home_team[:team_id]] += 1
      elsif game_data.home_team[:team_id] == team_id && game_data.home_team[:result] == game_result
        result_by_team[game_data.away_team[:team_id]] += 1
      end
    end
    result_by_team
  end

  def total_games_by_opponent(team_id)
    list_of_totals = Hash.new(0)
    @team_games.each do |game_id, game_data|
      if game_data.away_team[:team_id] == team_id 
        list_of_totals[game_data.home_team[:team_id]] += 1
      else
        list_of_totals[game_data.away_team[:team_id]] += 1
      end
    end
    list_of_totals
  end

  def favorite_opponent(team_id)
    percentage_of_wins = Hash.new(0.0)
    total_games_by_opponent(team_id).each do |opponent, total_games|
      percentage_of_wins[opponent] = (games_by_team_by_result(team_id, "WIN")[opponent]).to_f/(@team_games.length)
    end
    team_finder(percentage_of_wins.key(percentage_of_wins.values.max))
  end

  def team_finder(team_id)
    @teams[team_id.to_sym].team_name
  end

  def rival(team_id)
    percentage_of_wins = Hash.new(0.0)
    total_games_by_opponent(team_id).each do |opponent, total_games|
      percentage_of_wins[opponent] = (games_by_team_by_result(team_id, "WIN")[opponent]).to_f/(@team_games.length)
    end
    team_finder(percentage_of_wins.key(percentage_of_wins.values.min))
  end

  def team_info(team_id)
    @teams[team_id.to_sym].team_labels
  end
end