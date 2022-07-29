require 'csv'
require './lib/teams'

class StatTracker
 attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
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

end
