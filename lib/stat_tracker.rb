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

  def combine_all_games_played(team_id)
    home_games_filtered_by_team(team_id).push(away_games_filtered_by_team(team_id)).flatten
  end

  def find_total_wins_or_ties(team_id)
    wins_and_ties = 0.0
    total_games = combine_all_games_played(team_id).each do |game|
      if team_id == game.home_team_id && game.outcome == :home_win
        wins_and_ties += 1.0
      elsif team_id == game.away_team_id && game.outcome == :away_win
        wins_and_ties += 1.0
      end
    end
    (wins_and_ties / total_games.count).round(2)
  end

  def average_win_percentage(team_id)
    find_total_wins_or_ties(team_id)
  end

  def most_home_goals_scored(team_id)
    home_games_filtered_by_team(team_id).max_by do |game|
      game.home_goals
    end.home_goals.to_i
  end

  def most_away_goals_scored(team_id)
    away_games_filtered_by_team(team_id).max_by do |game|
      game.away_goals
    end.away_goals.to_i
  end

  def most_goals_scored(team_id)
    if most_home_goals_scored(team_id) > most_away_goals_scored(team_id)
      most_home_goals_scored(team_id)
    else
      most_away_goals_scored(team_id)
    end
  end

  def fewest_home_goals_scored(team_id)
    home_games_filtered_by_team(team_id).min_by do |game|
      game.home_goals
    end.away_goals.to_i
  end

  def fewest_away_goals_scored(team_id)
    away_games_filtered_by_team(team_id).min_by do |game|
      game.away_goals
    end.away_goals.to_i
  end

  def fewest_goals_scored(team_id)
    if fewest_home_goals_scored(team_id) < fewest_away_goals_scored(team_id)
      fewest_home_goals_scored(team_id)
    else
      fewest_away_goals_scored(team_id)
    end
  end

  def all_games_played_by_team(team_id)
    game_collection.all.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
  end

  def opponents(team_id)
    # We want:
                # {
                #   "some_opponent_id" =>
                #     {
                #       "won" => times_some_opponent_won_against_my_team,
                #       "lost" => times_some_opponent_lost_against_my_team,
                #       "tied" => times_some_opoonent_tied_against_my_team
                #     }
                # }
    acc = Hash.new
    all_games_played_by_team(team_id).each do |game|
      if game.away_team_id == team_id
        opponent_id = game.home_team_id
      else
        opponent_id = game.away_team_id
      end

      # if the block has been iterated through before, then set old_value won/lost/tied to that previous value, and if it has not been iterated through then set old value won/lost/tied to 0

      if acc[opponent_id].nil?
        old_value_won = 0.0
        old_value_lost = 0.0
        old_value_tied = 0.0
      else
        old_value_won = acc[opponent_id][:won]
        old_value_lost = acc[opponent_id][:lost]
        old_value_tied = acc[opponent_id][:tied]
      end

      if opponent_id == game.winning_team_id
        old_value_won += 1.0
      elsif opponent_id == game.losing_team_id
        old_value_lost += 1.0
      else
        old_value_tied += 1.0
      end

      acc[opponent_id] = {:won => old_value_won, :lost => old_value_lost, :tied => old_value_tied}
    end
    acc
  end

  def opponent_win_percentages(team_id)
    # We want: {"opponent_id" => win_percentage, "another_opponent_id" => their_win_percentage}
    acc = {}
    result = opponents(team_id).each do |opponent, data|
      acc[opponent] = data[:won]/data.values.sum.to_f
    end
    acc
  end

  def most_won_against_opponent(team_id)
    opponent_win_percentages(team_id).min_by do |opponent_id, win_rate|
      win_rate
    end.first
  end

  def favorite_opponent(team_id)
    team_collection.all.find do |team|
      most_won_against_opponent(team_id) == team.team_id
    end.team_name
  end

  def most_lost_against_opponent(team_id)
    opponent_win_percentages(team_id).max_by do |opponent_id, win_rate|
      win_rate
    end.first
  end

  def rival(team_id)
    acc = team_collection.all.find do |team|
      most_lost_against_opponent(team_id) == team.team_id
    end.team_name
  end

end
