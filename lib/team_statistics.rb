class TeamStatistics
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
    games_won(team_id).length.fdiv(all_games_played(team_id).length)
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
       [season_win_percentage(season, team_id)].compact
    end
  end

  def season_win_percentage(season, team_id)
    #could be made into a helper method
    winning_game_ids = games_won(team_id).map do |game|
      game.game_id
    end

    #could be made into two helper methods, but speed becomes an issue when dealing with full CSVs
    games_in_season = []
    total_games = 0
    @games.each do |game|
                                  #run on boolean, should be shortened
      if game.season == season && (game.away_team_id == team_id || game.home_team_id == team_id)
        total_games += 1
      end
      if game.season == season
        games_in_season << game.game_id
      end
    end

    winning_game_in_season_ids = winning_game_ids & games_in_season
    #condidional changes the evil NaN into nils. Nils are produced when total_games = 0.
    if total_games != 0
      winning_game_in_season_ids.length.fdiv(total_games)
    end
  end

  def worst_season(team_id)
    all_seasons.min_by do |season|
      #super messsy, but gets rid of nils from season_win_percentage, evading errors from min_by/nil interaction
       [season_win_percentage(season, team_id)].compact
    end
  end

  #do we need this? We could just iterate over the entire teams and have an exception when team_id == team_id
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
      #lots of functionality may be moved to games_class
      if game.away_team_id == team_id && game.home_team_id == opponent_id
        team_wins +=1 if game.away_goals > game.home_goals
        total_games += 1
      elsif game.home_team_id == team_id && game.away_team_id == opponent_id
        team_wins += 1 if game.away_goals < game.home_goals
        total_games += 1
      end
    end
    team_wins.fdiv(total_games)
    # require "pry"; binding.pry
  end

  def favorite_opponent(team_id)
    favorite_opponent_name = nil

    favorite_opponent_id = all_opponents(team_id).max_by do |opponent_id|
      team_opponent_win_percentage(opponent_id, team_id)
    end

    @teams.each do |team|
      if team.team_id == favorite_opponent_id
        favorite_opponent_name = team.team_name
      end
    end

    favorite_opponent_name
  end

  #needs a robust test
  def rival(team_id)
    rival = nil

    rival_id = all_opponents(team_id).min_by do |opponent_id|
      team_opponent_win_percentage(opponent_id, team_id)
    end

    @teams.each do |team|
      if team.team_id == rival_id
        rival = team.team_name
      end
    end

    rival
  end

end
