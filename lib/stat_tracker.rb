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

  def game_collection_to_use
    game_coll = instantiate_game_collection
  end

  def instantiate_game_collection
    @instantiate_game_collection ||= game_collection.all
  end

  def game_team_collection_to_use
    instantiate_game_team_collection
  end

  def instantiate_game_team_collection
    @instantiate_game_team_collection ||= game_team_collection.all
  end

  def team_collection_to_use
    instantiate_team_collection
  end

  def instantiate_team_collection
    @instantiate_team_collection ||= team_collection.all
  end

# JUDITH START HERE
  def highest_total_score
    top_score = 0
    game_collection.all.each do |game|
      if game.away_goals.to_i + game.home_goals.to_i > top_score
        top_score = game.away_goals.to_i + game.home_goals.to_i
      end
    end
  end

  def lowest_total_score
    lowest_score = 1000000
    game_collection.all.each do |game|
      if game.away_goals.to_i + game.home_goals.to_i < lowest_score
        lowest_score = game.away_goals.to_i + game.home_goals.to_i
      end
    end
  end

  def home_games
    home_games = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa == "home"
        home_games << result
      end
    home_games.count(true)
  end

  def percentage_home_wins
    home_wins = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa == "home" && game_team.result == "WIN"
        home_wins << result
    end
    (home_wins.count(true) / home_games.to_f).round(2)
  end

  def visitor_games
    visitor_games = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa == "away"
      visitor_games << result
    end
    visitor_games.count(true)
  end

  def percentage_visitor_wins
    visitor_wins = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa == "away" && game_team.result == "WIN"
        visitor_wins << result
    end
    (visitor_wins.count(true) / visitor_games.to_f).round(2)
  end

  def all_games
    all_games = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa
      all_games << result
    end
    all_games.count
  end

  def percentage_ties
    ties = []
    game_team_collection.all.flat_map do |game_team|
      result =  game_team.result == "TIE"
        ties << result
    end
    (ties.count(true) / all_games.to_f).round(2)
  end

  def seasons
    seasons = []
    game_collection.all.flat_map do |game|
       seasons << game.season
    end
    seasons
  end

  def count_of_games_by_season
    games_per_season = Hash.new(0)
    seasons.each do |season|
       games_per_season[season] += 1
     end
     games_per_season
  end

  def sum_of_all_goals
    game_collection.all.sum do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
  end

  def average_goals_per_game
    ((sum_of_all_goals / all_games.to_f) * 2).round(2)
  end

  def sum_of_goals_per_season(season)
    individual_season = game_collection.all.find_all do |game|
      game.season == season
    end
     individual_season.sum do |game|
       game.home_goals.to_i + game.away_goals.to_i
     end
  end

  def average_goals_per_season(season)
    individual_season = game_collection.all.find_all do |game|
      game.season == season
    end
    (sum_of_goals_per_season(season) / individual_season.count.to_f).round(2)
  end

  def average_goals_by_season
    avg_goals_by_season = game_collection.all.group_by do |game|
      game.season
    end
    avg_goals_by_season.transform_values do |season|
      average_goals_per_season(season[0].season)
    end
  end

  # JUDITH END HERE

  # The below is all of Dan's code

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
  # End of Dan's code #

     #################START of SEASON STATS######################

  def team_name_based_off_of_team_id(team_id)
    team_collection_to_use.each do |team|
      return team.team_name if team_id == team.team_id
    end
  end

  def games_by_season(season_id)
   game_collection_to_use.select do |game|
     season_id == game.season
   end
  end

  def season_games_grouped_by_team_id(season_id)
    collection = games_by_season(season_id).group_by do |game|
      game.game_id
    end
  end

  def game_teams_by_season(season_id)
    game_team_collection_to_use.select do |game_team|
      season_games_grouped_by_team_id(season_id).keys.include?(game_team.game_id)
    end
  end

  def winningest_coach(season_id)
    coaches_hash = game_teams_by_season(season_id).group_by do |game_team|
      game_team.head_coach
    end
    coaches_hash.transform_values do |game_team_collection|
      game_team_collection.keep_if do |game_team|
        game_team.result == "WIN"
      end
    end
    coaches_hash.transform_values! do |game_team_collection|
      game_team_collection.count
    end
    best_coach = coaches_hash.max_by do |coach, wins|
      wins
    end
    best_coach[0]
  end

   def worst_coach(season_id)
    coaches_hash = game_teams_by_season(season_id).group_by do |game_team|
      game_team.head_coach
    end
    coaches_hash.transform_values do |game_team_collection|
      game_team_collection.keep_if do |game_team|
        game_team.result == "WIN"
      end
    end
    coaches_hash.transform_values! do |game_team_collection|
      game_team_collection.count
    end
    worst_coach = coaches_hash.min_by do |coach, wins|
      wins
    end
    worst_coach[0]
  end

  def most_accurate_team(season_id)
    goals_for_season_by_team = Hash.new(0)
    game_teams_by_season(season_id).each do |game_team|
      goals_for_season_by_team[game_team.team_id] += game_team.goals.to_i
    end
    shots_for_season_by_team = Hash.new(0)
    game_teams_by_season(season_id).each do |game_team|
      shots_for_season_by_team[game_team.team_id] += game_team.shots.to_i
    end
    ratio_of_g_to_s_for_season_by_team = Hash.new(0)
      goals_for_season_by_team.each do |g_team_id, goals|
        shots_for_season_by_team.each do |s_team_id, shots|
          if s_team_id == g_team_id
            ratio_of_g_to_s_for_season_by_team[s_team_id] = goals.to_f / shots.to_f
          end
        end
      end

    best_team = ratio_of_g_to_s_for_season_by_team.max_by do |team_id, ratio|
      ratio
    end
    team_name_based_off_of_team_id(best_team[0])
  end

  def least_accurate_team(season_id)
    goals_for_season_by_team = Hash.new(0)
    game_teams_by_season(season_id).each do |game_team|
      goals_for_season_by_team[game_team.team_id] += game_team.goals.to_i
    end
    shots_for_season_by_team = Hash.new(0)
    game_teams_by_season(season_id).each do |game_team|
      shots_for_season_by_team[game_team.team_id] += game_team.shots.to_i
    end
    ratio_of_g_to_s_for_season_by_team = Hash.new(0)
      goals_for_season_by_team.each do |g_team_id, goals|
        shots_for_season_by_team.each do |s_team_id, shots|
          if s_team_id == g_team_id
            ratio_of_g_to_s_for_season_by_team[s_team_id] = goals.to_f / shots.to_f
          end
        end
      end
    worst_team = ratio_of_g_to_s_for_season_by_team.min_by do |team_id, ratio|
      ratio
    end
    team_name_based_off_of_team_id(worst_team[0])
  end

  def total_season_tackles_grouped_by_team(season_id)
    tackles_for_season_by_team = Hash.new(0)
    game_teams_by_season(season_id).each do |game_team|
      tackles_for_season_by_team[game_team.team_id] += game_team.tackles.to_i
    end
    tackles_for_season_by_team
  end

  def most_tackles(season_id)
    best_team = total_season_tackles_grouped_by_team(season_id).max_by do |team_id, tackles|
      tackles
    end
    team_name_based_off_of_team_id(best_team[0])
  end

  def fewest_tackles(season_id)
    worst_team = total_season_tackles_grouped_by_team(season_id).min_by do |team_id, tackles|
      tackles
    end
    team_name_based_off_of_team_id(worst_team[0])
  end

  ######################END of SEASON STATS####################
  # start of sienna's league stats
  def home_game_teams
    game_team_collection.all.find_all do |game_team|
      game_team.hoa == "home"
    end
  end

  def home_game_teams_by_team
    home_game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def total_home_goals_grouped_by_team
    goals_by_team_id = Hash.new(0)
    home_game_teams_by_team.each do |team_id, game_team_coll|
      game_team_coll.each do |game_team|
        goals_by_team_id[team_id] += game_team.goals.to_i
      end
    end
    goals_by_team_id
  end

  def total_home_games_grouped_by_team
    games_by_team_id = Hash.new(0)
    home_game_teams_by_team.each do |team_id, game_team_coll|
      game_team_coll.each do |game_team|
        games_by_team_id[team_id] += 1
      end
    end
    games_by_team_id
  end

  def ratio_home_goals_to_games_grouped_by_team
    ratio_goals_to_games_by_team = Hash.new(0)
    total_home_games_grouped_by_team.each do |games_team_id, total_games|
      total_home_goals_grouped_by_team.each do |goals_team_id, total_goals|
        if games_team_id == goals_team_id
          ratio_goals_to_games_by_team[games_team_id] = (total_goals.to_f / total_games.to_f)
        end
      end
    end
    ratio_goals_to_games_by_team
  end

  def find_team_id_with_best_home_goals_to_games_ratio
    ratio_home_goals_to_games_grouped_by_team.max_by do |team_id, ratio_g_to_g|
      ratio_g_to_g
    end[0]
  end

  def find_team_id_with_worst_home_goals_to_games_ratio
    ratio_home_goals_to_games_grouped_by_team.min_by do |team_id, ratio_g_to_g|
      ratio_g_to_g
    end[0]
  end

  def highest_scoring_home_team
    team_name_based_off_of_team_id(find_team_id_with_best_home_goals_to_games_ratio)
  end

  def lowest_scoring_home_team
    team_name_based_off_of_team_id(find_team_id_with_worst_home_goals_to_games_ratio)
  end
end
