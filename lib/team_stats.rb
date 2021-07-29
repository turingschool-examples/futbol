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
        team_info[:team_id] = team.team_id
        team_info[:franchise_id] = team.franchise_id
        team_info[:team_name] = team.team_name
        team_info[:abbreviation] = team.abbreviation
        team_info[:link] = team.link
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

  def season_win_percentage(season, team_id)

    winning_game_ids = games_won(team_id).map do |game|
      require "pry"; binding.pry
      game.game_id
    end


    count = 0
    @games.each do |game|
      # require "pry"; binding.pry
      if game.season == season &&  (game.away_team_id == team_id || game.home_team_id)
        count += 1
      end
      # game_ids.each do |game_id|
      #   # require "pry"; binding.pry
      #   # if game.season == season
      #   #   require "pry"; binding.pry
      #   #   if game.game_id != game_id
      #   #     game_ids.delete(game_id)
      #   #     require "pry"; binding.pry
      #   #   end
      #   # end
      # end
    end
    game_ids = []
    @games.each do |game|
      if game.season == season
        game_ids << game.game_id
      end
    end
    season_winning_game_ids = winning_game_ids & game_ids
    season_winning_game_ids.length / count

    #num of winning games in season fdiv(num of games in season)
  end

  # def favorite_opponent(team_id)
  #
  # end

end
