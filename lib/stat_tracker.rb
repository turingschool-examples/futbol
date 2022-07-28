require 'csv'


class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = read_data(games)
    @teams = read_data(teams)
    @game_teams = read_data(game_teams)
  end

  def self.from_csv(locations)
    games = CSV.open(locations[:games], { headers: true, header_converters: :symbol })
    teams = CSV.open(locations[:teams], { headers: true, header_converters: :symbol })
    game_teams = CSV.open(locations[:game_teams], {headers: true, header_converters: :symbol })
    StatTracker.new(games, teams, game_teams)
  end

  def read_data(data)
    list_of_data = []
    data.each do |row|
      list_of_data << row
    end
    list_of_data
  end

# Game Statistics Methods
  def highest_total_score
    max = @games.max_by { |game| game[:away_goals].to_i + game[:home_goals].to_i }
    max[:away_goals].to_i + max[:home_goals].to_i
  end

  def lowest_total_score
    min = @games.min_by { |game| game[:away_goals].to_i + game[:home_goals].to_i }
    min[:away_goals].to_i + min[:home_goals].to_i
  end

  def percentage_home_wins
    wins = @games.count { |game| game[:home_goals].to_i > game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def percentage_visitor_wins
    wins = @games.count { |game| game[:home_goals].to_i < game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def percentage_ties
    wins = @games.count { |game| game[:home_goals].to_i == game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def count_of_games_by_season(team_id = false)
    @games.reduce(Hash.new(0)) do |hash, game|
      hash[game[:season]] += 1 if team_id == false || (team_id == game[:home_team_id || :away_team_id])
      hash
    end
  end

  def average_goals_per_game
    (@games.sum { |game| game[:away_goals].to_f + game[:home_goals].to_f } / @games.count).round(2)
  end

  def average_goals_by_season
    seasons = count_of_games_by_season
    avg_arr = []
    seasons.each do |season, count|
      games_in_season = @games.find_all { |game| game[:season] == season }
      avg_arr << ((games_in_season.sum { |game| game[:away_goals].to_i + game[:home_goals].to_i }) / count.to_f).round(2)
    end
    Hash[seasons.keys.zip(avg_arr)]
  end


# League Statistics Methods

  def count_of_teams
    @teams.count
  end

  def best_offense
    teams = ((@games.map { |game| game[:home_team_id] }) + (@games.map { |game| game[:away_team_id] })).uniq.sort_by(&:to_i)
    avgs = []
    teams.each do |team|
      home_goal = (@games.find_all { |game| team == game[:home_team_id] }.map { |game| game[:home_goals].to_i }).sum
      away_goal = (@games.find_all { |game| team == game[:away_team_id] }.map { |game| game[:away_goals].to_i }).sum
      avgs << ((home_goal + away_goal).to_f / (@games.count { |game| (game[:home_team_id || :away_team_id]) == team })).round(3)
    end
    @teams.find { |team| team[:team_id] == (Hash[teams.zip(avgs)].max_by { |_k, v| v })[0] }[:team_name]
  end

# Team Statistics Methods
  def team_info(team_id)
    headers = @teams[0].headers.map!(&:to_s)
    Hash[headers.zip((@teams.find { |team| team[:team_id] == team_id }).field(0..-1))].reject { |k| k == 'stadium' }
  end

  def best_season(team_id)
    seasonal_winrates(team_id).max_by { |_k, v| v }[0]
  end

  def worst_season(team_id)
    seasonal_winrates(team_id).min_by { |_k, v| v }[0]
  end

  def average_win_percentage(team_id)
    (seasonal_winrates(team_id).values.reduce(:+) / count_of_games_by_season(team_id).count.to_f).round(2)
  end

  # Team helper method - returns hash of a given team's seasons & win rates
  def seasonal_winrates(team_id)
    win_ids = @game_teams.find_all { |game| game[:team_id] == team_id && game[:result] == "WIN" }.map { |game| game[:game_id] } 
    season_info = count_of_games_by_season(team_id)
    ordered_win_rate = []
    season_info.each do |season|
      ordered_win_rate << ((@games.count { |game| game[:season] == season[0] && win_ids.include?(game[:game_id]) }) / (2 * season[1].to_f))
    end
    Hash[season_info.keys.zip(ordered_win_rate)]
  end

  def most_goals_scored(team_id)
    @game_teams.find_all { |game| game[:team_id] == team_id }.max_by { |game| game[:goals] }[:goals].to_i
  end

  def fewest_goals_scored(team_id)
    @game_teams.find_all { |game| game[:team_id] == team_id }.min_by { |game| game[:goals] }[:goals].to_i
  end

  def favorite_opponent(team_id)
    @teams.find { |team| team[:team_id] == win_hash(team_id).max_by { |_k, v| v }[0] }[:team_name]
  end

  def rival(team_id)
    @teams.find { |team| team[:team_id] == win_hash(team_id).min_by { |_k, v| v }[0] }[:team_name]
  end

  def win_hash(team_id)
    home_games = @games.find_all { |game| game[:home_team_id] == team_id}
    away_games = @games.find_all { |game| game[:away_team_id] == team_id}
    opponents = (home_games.map { |game| game[:away_team_id]} + away_games.map { |game| game[:home_team_id]}).uniq.sort_by { |num| num.to_i}
    ordered_win_rate = []
    opponents.each do |opponent, win_counter = 0|
      win_counter += home_games.count { |game| game[:away_team_id] == opponent && game[:home_goals] > game[:away_goals]}
      win_counter += away_games.count { |game| game[:home_team_id] == opponent && game[:home_goals] < game[:away_goals]}
      ordered_win_rate << (win_counter.to_f / versus_games_counter(team_id, opponent))
    end
    Hash[opponents.zip(ordered_win_rate)]
  end

  def versus_games_counter(team_id, opponent)
    counter = @games.count { |game| (game[:away_team_id] == opponent && game[:home_team_id] == team_id) }
    counter += @games.count { |game| (game[:away_team_id] == team_id && game[:home_team_id] == opponent) }
    counter
  end

  def worst_offense
    teams = ((@games.map { |game| game[:home_team_id] }) + (@games.map { |game| game[:away_team_id] })).uniq.sort_by { |num| num.to_i }
    avgs = []
    teams.each do |team|
      home_goal = (@games.find_all { |game| team == game[:home_team_id]}.map { |game| game[:home_goals].to_i}).sum
      away_goal = (@games.find_all { |game| team == game[:away_team_id]}.map { |game| game[:away_goals].to_i}).sum
      avgs << ((home_goal + away_goal).to_f / (@games.find_all { |game| game[:home_team_id] == team || game[:away_team_id] == team}).count).round(3)
    end
    worst_o_id = (Hash[teams.zip(avgs)].min_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == worst_o_id }[:teamname]
  end

  def highest_scoring_visitor
    teams = (@games.map { |game| game[:away_team_id] }).uniq.sort_by { |num| num.to_i }
    avgs = []
     teams.each do |team|
      away_goal = (@games.find_all { |game| team == game[:away_team_id]}.map { |game| game[:away_goals].to_i}).sum
      avgs << ((away_goal).to_f / (@games.find_all { |game| game[:away_team_id] == team}).count).round(3)
    end
      highest_visitor = (Hash[teams.zip(avgs)].max_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == highest_visitor }[:teamname]
  end

  def highest_scoring_home_team
    teams = (@games.map { |game| game[:home_team_id] }).uniq.sort_by { |num| num.to_i }
    avgs = []
     teams.each do |team|
      home_goal = (@games.find_all { |game| team == game[:home_team_id]}.map { |game| game[:home_goals].to_i}).sum
      avgs << ((home_goal).to_f / (@games.find_all { |game| game[:home_team_id] == team}).count).round(3)
    end
      highest_home_team = (Hash[teams.zip(avgs)].max_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == highest_home_team }[:teamname]
  end

  def lowest_scoring_visitor
    teams = (@games.map { |game| game[:away_team_id] }).uniq.sort_by { |num| num.to_i }
    avgs = []
    teams.each do |team|
      away_goal = (@games.find_all { |game| team == game[:away_team_id]}.map { |game| game[:away_goals].to_i}).sum
      avgs << ((away_goal).to_f / (@games.find_all { |game| game[:away_team_id] == team}).count).round(3)
    end
    lowest_visitor = (Hash[teams.zip(avgs)].min_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == lowest_visitor }[:teamname]
  end

  def lowest_scoring_home_team
    teams = (@games.map { |game| game[:home_team_id] }).uniq.sort_by { |num| num.to_i }
    avgs = []
    teams.each do |team|
      home_goal = (@games.find_all { |game| team == game[:home_team_id]}.map { |game| game[:home_goals].to_i}).sum
      avgs << ((home_goal).to_f / (@games.find_all { |game| game[:home_team_id] == team}).count).round(3)
    end
    lowest_home_team = (Hash[teams.zip(avgs)].min_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == lowest_home_team }[:teamname]
  end

  def list_game_ids_by_season(season_desired) #every game_id associated with a season
    season_dsrd = @games.select {|game| game[:season] == season_desired}
    gretzy = []
    season_dsrd.each do |game|
      gretzy << game[:game_id]
    end
    gretzy

  end

  def coach_win_percentages_by_season(season_desired) #{coaches => win percentage}
    games_won = Hash.new(0)
    games_played = Hash.new(0)
    percent_won = {}

    list_game_ids_by_season(season_desired).each do |num|
      stanley = @game_teams.select { |thing| thing[:game_id] == num }
      stanley.each do |half|
        if half[:result] == "WIN"
          games_won[half[:head_coach]] += 1
          games_played[half[:head_coach]] += 1
        else
          games_won[half[:head_coach]] += 0
          games_played[half[:head_coach]] += 1
        end
      end
    end
    games_won.keys.each do |key|
      percent_won[key] = (games_won[key].to_f / games_played[key].to_f)
    end
    percent_won
  end

  def winningest_coach(season_desired)
    coach_win_percentages_by_season(season_desired).max_by {|a, b| b }[0]
  end

  def worst_coach(season_desired)
    wasd = coach_win_percentages_by_season(season_desired).min_by {|a, b| b }[0]
  end

  def team_accuracy(season_desired)
    @team_shots_1 = Hash.new(0)
    @team_goals_1 = Hash.new(0)
    @team_shot_percentage_1 = Hash.new
    list_game_ids_by_season(season_desired).each do |num|

      wayne = @game_teams.select { |thing| thing[:game_id] == num }
      wayne.each do |period|
        @team_shots_1[period[:team_id]] += period[:shots].to_i
        @team_goals_1[period[:team_id]] += period[:goals].to_i
      end
    end
    @team_shots_1.each do |thornton|
      @team_shot_percentage_1[thornton[0]] = @team_goals_1[thornton[0]].to_f / @team_shots_1[thornton[0]]
    end
    @team_shot_percentage_1
  end

  def most_accurate_team(season_desired)
    wasd = team_accuracy(season_desired).max_by { |a, b| b }
    (@teams.find { |this_team| this_team[:team_id] == wasd[0]})[:teamname]
  end

  def least_accurate_team(season_desired)
    johnny = team_accuracy(season_desired).min_by { |a, b| b }
    (@teams.find { |this_team_1| this_team_1[:team_id] == johnny[0]})[:teamname]
  end

  def most_tackles(season_desired)
    team_tackles_2 = Hash.new(0)
    list_game_ids_by_season(season_desired).each do |num|
      orr = @game_teams.select { |thing| thing[:game_id] == num }
      orr.each do |period|
        team_tackles_2[period[:team_id]] += period[:tackles].to_i
      end
    end
    bobby = team_tackles_2.max_by { |a, b| b }
    (@teams.find { |this_team_2| this_team_2[:team_id] == bobby[0]})[:teamname]

  end

  def fewest_tackles(season_desired)
    team_tackles_3 = Hash.new(0)
    list_game_ids_by_season(season_desired).each do |num|
      orr = @game_teams.select { |thing| thing[:game_id] == num }
      orr.each do |period|
        team_tackles_3[period[:team_id]] += period[:tackles].to_i
      end
    end
    bobby = team_tackles_3.min_by { |a, b| b }
    (@teams.find { |this_team_3| this_team_3[:team_id] == bobby[0]})[:teamname]

  end

end
