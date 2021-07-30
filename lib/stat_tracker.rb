require_relative './teams_processor'
require_relative './games_processor'
require_relative './game_teams_processor'

class StatTracker
  include TeamsProcessor
  include GamesProcessor
  include GameTeamsProcessor

  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = parse_games_file(locations[:games])
    @teams = parse_teams_file(locations[:teams])
    @game_teams = parse_game_teams_file(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
##########move elsewhere
  # Interface
  def favorite_opponent(team_id)
    win_loss = calculate_win_percents(team_id)
    fav_team = win_loss.max_by do |team, result|
      result
    end.first

    team_info(fav_team)["team_name"]
  end

  # Interface
  def rival(team_id)
    win_loss = calculate_win_percents(team_id)
    rival_team = win_loss.min_by do |team, result|
      result
    end.first

    team_info(rival_team).team_name
  end

  # Helper
  def calculate_win_percents(team_id)
    win_loss = opponent_win_count(team_id)
    win_loss.map do |team, results|
      avg = results[:wins].fdiv(results[:total])
      [team, avg]
    end.to_h
  end

  # GameManager Method
  # We send team_id, they return hash with opp_id & results against
  def opponent_win_count(team_id)
    win_loss = {}
    @games.each do |game|
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        data = get_home_or_away(team_id, game)

        win_loss[data[:opp_id]] ||= {wins: 0, total: 0}
        if data[:team_goals] > data[:opp_goals]
          win_loss[data[:opp_id]][:wins] += 1
        end
        win_loss[data[:opp_id]][:total] += 1
      end
    end
    win_loss
  end

  # GameManager Method
  # Full send
  def get_home_or_away(team_id, game)
    teams = [game[:home_team_id], game[:away_team_id]]
    goals = [game[:home_goals], game[:away_goals]]
    team_index = teams.index(team_id)
    opp_index = team_index - 1
    {
      team_goals: goals[team_index],
      opp_id: teams[opp_index],
      opp_goals: goals[opp_index]
    }
  end


  ####

  # Interface
  def average_win_percentage(team_id)
    wins = 0
    games = 0
    seasons_win_count(team_id, @games).each do |season, stats|
      wins += stats[:wins]
      games += stats[:total]
    end
    (wins.fdiv(games)).round(2)
  end

  # Interface
  def best_offense
    team_id = get_offense_averages.max_by do |team, data|
      data
    end.first

    team_info(team_id)["team_name"]
  end

  # Interface
  def worst_offense
    team_id = get_offense_averages.min_by do |team, data|
      data
    end.first

    team_info(team_id)["team_name"]
  end

  # Helper
  def get_offense_averages
     get_goals_per_team.map do |team, data|
      [team, data[:goals].fdiv(data[:total])]
    end.to_h
  end

  # GameManager
  # Full send
  def get_goals_per_team
    team_goals = {}
    @games.each do |game|
      team_goals[game[:home_team_id]] ||= {goals: 0, total: 0}
      team_goals[game[:away_team_id]] ||= {goals: 0, total: 0}

      team_goals[game[:home_team_id]][:goals] += game[:home_goals].to_i
      team_goals[game[:home_team_id]][:total] += 1

      team_goals[game[:away_team_id]][:goals] += game[:away_goals].to_i
      team_goals[game[:away_team_id]][:total] += 1
    end
    team_goals
  end
  def best_season(team_id)
    get_season_averages(team_id).max_by do |season, average|
      average
    end.first
  end

  def worst_season(team_id)
    get_season_averages(team_id).min_by do |season, average|
      average
    end.first
  end

  def get_season_averages(team_id)
    season_average = seasons_win_count(team_id)
    season_average.map do |season, stats|
      [season, stats[:wins].fdiv(stats[:total])]
    end.to_h
  end

  def seasons_win_count(team_id, games)
    season_average = {}
    games.each do |game|
      season = game[:season]
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        data = get_home_or_away(team_id, game)

        season_average[season] ||= {wins: 0, total: 0}
        if data[:team_goals] > data[:opp_goals]
          season_average[season][:wins] += 1
        end
        season_average[season][:total] += 1
      end
    end
    season_average
  end

  def rival(team_id)
    win_loss = calculate_win_percents(team_id)
    rival_team = win_loss.min_by do |team, result|
      result
    end.first

    team_info(rival_team)["team_name"]
  end


  def percentage_home_wins
    home_game_wins = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] > game[:away_goals]
        home_game_wins += 1
      end
    end
    (home_game_wins.fdiv(total_games)).round(2)
  end

  def percentage_visitor_wins
    visitor_game_wins = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] < game[:away_goals]
        visitor_game_wins += 1
      end
    end
    (visitor_game_wins.fdiv(total_games)).round(2)
  end

  def percentage_ties
    ties = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] == game[:away_goals]
        ties += 1
      end
    end
    (ties.fdiv(total_games)).round(2)
  end









  def get_home_team_goals
    home_avg = {}
    @games.each do |game|
      home_avg[game[:home_team_id]] ||= { goals: 0, total: 0 }
      home_avg[game[:home_team_id]][:goals] += game[:home_goals].to_i
      home_avg[game[:home_team_id]][:total] += 1
    end
    home_avg
  end

  def highest_scoring_home_team
    home_info = get_home_team_goals
    team_id = home_info.each.max_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end

  def lowest_scoring_home_team
    home_info = get_home_team_goals
    team_id = home_info.each.min_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end
  def most_goals_scored(team_id)
    goals = goals_per_team_game(team_id)
    goals.max_by do |goal|
      goal.to_i
    end.to_i
  end

  def goals_per_team_game(team_id)
    goals = []
    @game_teams.each do |game|
      goals << game[:goals] if game[:team_id] == team_id
    end
    goals
  end

  def fewest_goals_scored(team_id)
    goals = goals_per_team_game(team_id)
    goals.min_by do |goal|
      goal.to_i
    end.to_i
  end
