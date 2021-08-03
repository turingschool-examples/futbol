require_relative './comparable'

class TeamStatistics
  include Comparable
  attr_reader :games, :teams, :game_teams

  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def team_info(team_id)
    team_info = {}
    @teams.each do |team|
      if team.team_id == team_id
        team_info["team_id"] = team.team_id
        team_info["franchise_id"] = team.franchise_id
        team_info["team_name"] = team.team_name
        team_info["abbreviation"] = team.abbreviation
        team_info["link"] = team.link
      end
    end
    team_info
  end

  def games_won(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id && game.result == "WIN"
    end
  end

  def all_games_played(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id
    end
  end

  def average_win_percentage(team_id)
    games_won(team_id).length.fdiv(all_games_played(team_id).length).round(2)
  end

  def most_goals_scored(team_id)
    all_games_played(team_id).max_by do |game|
      game.goals
    end.goals.to_i
  end

  def fewest_goals_scored(team_id)
    all_games_played(team_id).min_by do |game|
      game.goals
    end.goals.to_i
  end

  def all_seasons
    seasons = []
    @games.each do |game|
      seasons << game.season if !seasons.include?(game.season)
    end
    seasons
  end

  def best_season(team_id)
    all_seasons.max_by do |season|
      #super weird, but gets rid of nils from season_win_percentage, evading errors from min_by/nil interaction
       [season_win_percentage(season, team_id)].compact
    end
  end

  def worst_season(team_id)
    all_seasons.min_by do |season|
      #super weird, but gets rid of nils from season_win_percentage, evading errors from min_by/nil interaction
       [season_win_percentage(season, team_id)].compact
    end
  end

  def winning_game_ids(team_id)
    games_won(team_id).map do |game|
      game.game_id
    end
  end

  def season_win_percentage(season, team_id)
    #could be made into two helper methods, but speed becomes an issue when dealing with full CSVs
    games_in_season = []
    total_games = 0
    @games.each do |game|
      #game.season == season
      if season_verification(game, season) && game.played?(team_id)
        total_games += 1
      end
      if season_verification(game, season)
        games_in_season << game.game_id
      end
    end
    winning_game_in_season_ids = winning_game_ids(team_id) & games_in_season
    #condidional changes the evil NaN into nils. Nils are produced when total_games = 0.
    winning_game_in_season_ids.length.fdiv(total_games) if total_games != 0
  end

  def all_opponents(team_id)
    @games.filter_map do |game|
      if team_id == game.home_team_id
        game.away_team_id
      elsif team_id == game.away_team_id
        game.home_team_id
      end
    end.uniq
  end

  def team_opponent_win_percentage(opponent_id, team_id)
    team_wins = 0
    total_games = 0
    @games.each do |game|
      if game.played?(team_id) && game.played?(opponent_id)
        team_wins +=1 if game.won?(team_id)
        total_games += 1
      end
    end

    # team_wins =
    # @games.count do |game|
    #   game.played?(team_id) && game.played?(opponent_id) && game.won?(team_id)
    # end
    #
    # total_games =
    # @games.count do |game|
    #   game.played?(team_id) && game.played?(opponent_id)
    # end

    team_wins.fdiv(total_games)
  end
  #needs a test
  def favorite_opponent_id(team_id)
    all_opponents(team_id).max_by do |opponent_id|
      team_opponent_win_percentage(opponent_id, team_id)
    end
  end

  def favorite_opponent(team_id)
    @teams.find do |team|
      team.team_id == favorite_opponent_id(team_id)
    end.team_name
  end
  #needs a test
  def rival_id(team_id)
    all_opponents(team_id).min_by do |opponent_id|
      team_opponent_win_percentage(opponent_id, team_id)
    end
  end

  def rival(team_id)
    @teams.find do |team|
      team.team_id == rival_id(team_id)
    end.team_name
  end
end
