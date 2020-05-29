require_relative './game_collection'
require_relative './game'
require_relative './team_collection'
require_relative './team'
require_relative './game_team_collection'
require_relative './game_team'

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
      game.away_goals.to_i + game.home_goals.to_i
    end
    total.home_goals.to_i + total.away_goals.to_i
  end

  def lowest_total_score
    total = game_collection.all.min_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    total.home_goals.to_i + total.away_goals.to_i
  end

  def team_info(team_id)
    acc = {}
    team_collection.all.each do |team|
      if team.team_id == team_id
        acc["team_id"] = team.team_id
        acc["franchise_id"] = team.franchise_id
        acc["team_name"] = team.team_name
        acc["abbreviation"] = team.abbreviation
        acc["link"] = team.link
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
    home_games_filtered_by_team(team_id).group_by do |game|
      game.season
    end
  end

  def season_home_wins(team_id)
    wins = Hash.new(0.0)
    home_games_grouped_by_season(team_id).each do |season, game|
      game.each do |game|
        if game.outcome == :home_win
          wins[season] += 1.0
        elsif game.outcome == :away_win
          wins[season] -= 1.0
        else
          wins[season] -= 0.5
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
    wins = Hash.new(0.0)
    away_games_grouped_by_season(team_id).each do |season, game|
      game.each do |game|
        if game.outcome == :away_win
          wins[season] += 1.0
        elsif game.outcome == :home_win
          wins[season] -= 1.0
        else
          wins[season] -= 0.5
        end
      end
    end
    wins
  end

  def win_count_by_season(team_id)
    accum = {}
    season_away_wins(team_id).each do |season_away_id, away_win|
      season_home_wins(team_id).each do |season_home_id, home_win|
        if season_away_id == season_home_id
          accum[season_away_id] = away_win + home_win
        end
      end
    end
    accum
  end

  def best_season(team_id)
    win_count_by_season(team_id).max_by do |game_season, wins|
      wins
    end[0]
  end

  def season_home_losses(team_id)
    losses = Hash.new(0.0)
    home_games_grouped_by_season(team_id).each do |season, game|
      game.each do |game|
        if game.outcome == :away_win
          losses[season] += 1.0
        elsif game.outcome == :home_win
          losses[season] -= 1.0
        else
          losses[season] += 0.5
        end
      end
    end
    losses
  end

  def season_away_losses(team_id)
    losses = Hash.new(0.0)
    away_games_grouped_by_season(team_id).each do |season, game|
      game.each do |game|
        if game.outcome == :home_win
          losses[season] += 1.0
        elsif game.outcome == :away_win
          losses[season] -= 1.0
        else
          losses[season] += 0.5
        end
      end
    end
    losses
  end

  def loss_count_by_season(team_id)
    accum = {}
    season_away_losses(team_id).each do |season_away_id, away_loss|
      season_home_losses(team_id).each do |season_home_id, home_loss|
        if season_away_id == season_home_id
          accum[season_away_id] = away_loss + home_loss
        end
      end
    end
    accum
  end

  def worst_season(team_id)
    loss_count_by_season(team_id).max_by do |game_season, losses|
      losses
    end[0]
  end

end
