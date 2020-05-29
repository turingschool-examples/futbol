class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]
  end

  def self.from_csv(data_files)
    StatTracker.new(data_files)
  end

  def game_collection
    GameCollection.new(@games)
  end

  def team_collection
    TeamCollection.new(@teams)
  end

  def game_team_collection
    GameTeamCollection.new(@game_teams)
  end

  def highest_total_score
    total = game_collection.all.max_by do |game|
      game.away_goals + game.home_goals
    end
    total.home_goals + total.away_goals
  end

  def lowest_total_score
    total = game_collection.all.min_by do |game|
      game.away_goals + game.home_goals
    end
    total.home_goals + total.away_goals
  end

  def team_info(team_id)
    acc = {}
    team_collection.all.each do |team|
      if team.team_id == team_id
        acc[:team_id] = team.team_id
        acc[:franchiseid] = team.franchiseid
        acc[:teamname] = team.teamname
        acc[:abbreviation] = team.abbreviation
        acc[:link] = team.link
      end
    end
    acc
  end

  def home_games_filtered_by_team(team_id)
    game_collection.all.find_all do |game|
      game.home_team_id == team_id
    end
  end

  def home_games_grouped_by_season(team_id)
    winz = home_games_filtered_by_team(team_id).group_by do |game|
      game.season
    end
  end

  def season_home_wins(team_id)
    wins = Hash.new(0)
    home_games_grouped_by_season(team_id).each do |season, game|
      game.each do |game|
        if game.outcome == :home_win
          wins[season] += 1
        elsif game.outcome == :away_win
          wins[season] -= 1
        end
      end
    end
    wins
  end

  def away_games_filtered_by_team(team_id)
    game_collection.all.find_all do |game|
      game.away_team_id == team_id
    end
  end

  def away_games_grouped_by_season(team_id)
    away_games_filtered_by_team(team_id).group_by do |game|
      game.season
    end
  end

  def season_away_wins(team_id)
    wins = Hash.new(0)
    away_games_grouped_by_season(team_id).each do |season, game|
      game.each do |game|
        if game.outcome == :away_win
          wins[season] += 1
        elsif game.outcome == :home_win
          wins[season] -= 1
        end
      end
    end
    wins
  end

  def best_season(team_id)
    season = season_away_wins(team_id).merge(season_home_wins(team_id)).max_by do |season, wins|
      wins
    end[0]
  end

  def season_home_losses(team_id)
    losses = Hash.new(0)
    home_games_grouped_by_season(team_id).each do |season, game|
      game.each do |game|
        if game.outcome == :away_win
          losses[season] += 1
        elsif game.outcome == :home_win
          losses[season] -= 1
        end
      end
    end
    losses
  end

  def season_away_losses(team_id)
    losses = Hash.new(0)
    home_games_grouped_by_season(team_id).each do |season, game|
      game.each do |game|
        if game.outcome == :home_win
          losses[season] += 1
        elsif game.outcome == :away_win
          losses[season] -= 1
        end
      end
    end
    losses
  end

  def worst_season(team_id)
    season = season_away_losses(team_id).merge(season_home_losses(team_id)).max_by do |season, losses|
      losses
    end[0]
  end

end
