require 'csv'
require './lib/teams'
require 'pry'


class StatTracker

  attr_reader :games, :teams, :game_teams


  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @league_stats = LeagueStats.new(games, teams, game_teams)
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  )
  end


  def team_info(search_team_id)
    team_search_info = @teams.find do |team|
      team[0] == search_team_id
    end

    {
      "team_id" => team_search_info[0],
      "franchise_id" => team_search_info[1],
      "team_name" => team_search_info[2],
      "abbreviation" => team_search_info[3],
      "link" => team_search_info[5]
    }
  end

  def best_season(search_team_id)
    game_info = @game_teams.find do |game_team|
      game_team = search_team_id
    end

    all_win_info = []
      @game_teams.each do |game_team|
        if game_team[3] == "WIN" && game_team[1] == search_team_id
          all_win_info << game_team[0]
        end
      end
    all_win_info

    season_won = []
    @games.each do |game|
      all_win_info.each do |per_game|
      if per_game == game[0]
        season_won << game[1]
        end
      end
    end
    best_season_percentage = (season_won.tally.values.sort.last.to_f / @games.count) * 100
    best_season_percentage.round(2).to_s
  end

  def worst_season(search_team_id)
    game_info = @game_teams.find do |game_team|
      game_team[1] = search_team_id
    end

    all_win_info = []
      @game_teams.each do |game_team|
        if game_team[3] == "WIN" && game_team[1] == search_team_id
          all_win_info << game_team[0]
        end
      end
    all_win_info

    season_won = []
    @games.each do |game|
      all_win_info.each do |per_game|
      if per_game == game[0]
        season_won << game[1]
        end
      end
    end
    best_season_percentage = (season_won.tally.values.sort.first.to_f / @games.count) * 100
    best_season_percentage.round(2).to_s
  end

  def average_win_percentage(search_team_id)
    game_info = @game_teams.find do |game_team|
      game_team = search_team_id
    end

    all_win_info = []
      @game_teams.each do |game_team|
        if game_team[3] == "WIN" && game_team[1] == search_team_id
          all_win_info << game_team[0]
        end
      end
    all_win_info = (all_win_info.count.to_f / game_teams.count.to_f).round(2)
  end

  def most_goals_scored(search_team_id)
    game_info = @game_teams.find do |game_team|
      game_team = search_team_id
    end

    highest_goals_scored = []
      @game_teams.each do |game_team|
      if game_team[1] == search_team_id
        highest_goals_scored << game_team[:goals]
        end
      end
      highest_goals_scored.sort.last.to_i
  end

  def fewest_goals_scored(search_team_id)
    game_info = @game_teams.find do |game_team|
      game_team = search_team_id
    end

    fewest_goals_scored = []
      @game_teams.each do |game_team|
      if game_team[1] == search_team_id
        fewest_goals_scored << game_team[:goals]
        end
      end
      fewest_goals_scored.sort.first.to_i
  end

  def favorite_opponent(search_team_id)
    game_info = @game_teams.find do |game_team|
      game_team = search_team_id
    end

    all_games_won = []
    @game_teams.each do |game_team|
      if game_team[3] == "WIN" && game_team[1] == search_team_id
        all_games_won << game_team[0]
      end
    end
    all_games_won

    losing_teams = []
    @game_teams.each do |each_team|
      all_games_won.each do |game_won|
        if game_won == each_team[0] && each_team[3] == "LOSS"
          losing_teams << each_team[1]
      end
    end
  end
    sorted_losing_teams = losing_teams.tally.sort_by do |key, value|
    value
  end
    loser_team_id = sorted_losing_teams.last.first

    losing_team_name = ""
    @teams.each do |team|
      if team[0] == loser_team_id
        losing_team_name << team[2]
      end
    end
    losing_team_name
  end

  def rival(search_team_id)
    game_info = @game_teams.find do |game_team|
      game_team = search_team_id
    end

    all_games_won = []
    @game_teams.each do |game_team|
      if game_team[3] == "WIN" && game_team[1] == search_team_id
        all_games_won << game_team[0]
      end
    end
    all_games_won

    losing_teams = []
    @game_teams.each do |each_team|
      all_games_won.each do |game_won|
        if game_won == each_team[0] && each_team[3] == "LOSS"
          losing_teams << each_team[1]
      end
    end
  end
    sorted_losing_teams = losing_teams.tally.sort_by do |key, value|
    value
  end
    loser_team_id = sorted_losing_teams.first.first

    losing_team_name = ""
    @teams.each do |team|
      if team[0] == loser_team_id
        losing_team_name << team[2]
      end
    end
    losing_team_name
  end


  def winningest_coach(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end

    coaches_and_results= game_teams.map do |game|
                            [game[:result], game[:head_coach]]
                          end

    wins = Hash.new(0)
    all_games = Hash.new(0)

    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      all_games[coach] += 1
    end

    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / all_games[coach]
    end

    win_percentage.max_by{|coach, percentage| percentage}.first
  end

  def worst_coach(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    coaches_and_results= game_teams.map do |game|
                            [game[:result], game[:head_coach]]
                          end

    wins = Hash.new(0)
    all_games = Hash.new(0)

    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      all_games[coach] += 1
      wins[coach] += 0
    end

    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / all_games[coach]
    end

    win_percentage.max_by{|coach, percentage| -percentage}.first
  end

  def most_accurate_team(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    goals = Hash.new(0)
    shots = Hash.new(0)
    game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    team_id_accuracy = Hash.new
    goals.each do |team, goals|
      team_id_accuracy[team] = goals / shots[team]
    end

    team_id_highest_accuracy = team_id_accuracy.max_by{|team, acc| acc}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_highest_accuracy]

  end

  def least_accurate_team(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    goals = Hash.new(0)
    shots = Hash.new(0)
    game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    team_id_accuracy = Hash.new
    goals.each do |team, goals|
      team_id_accuracy[team] = goals / shots[team]
    end

    team_id_lowest_accuracy = team_id_accuracy.max_by{|team, acc| -acc}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_lowest_accuracy]
  end

  def most_tackles(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end
    id_tackles = Hash.new(0)
    game_teams.each do |game|
      id_tackles[game[:team_id]] += game[:tackles].to_i
    end

    most_tackles = id_tackles.max_by{|id, tackles| tackles}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[most_tackles]
  end

  def fewest_tackles(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end
    id_tackles = Hash.new(0)
    game_teams.each do |game|
      id_tackles[game[:team_id]] += game[:tackles].to_i
    end

    fewest_tackles = id_tackles.max_by{|id, tackles| -tackles}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[fewest_tackles]
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end
  
  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end
  
  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end
 
end
