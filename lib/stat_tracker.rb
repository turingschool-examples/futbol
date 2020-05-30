require_relative './game'
require_relative './game_collection'
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


  def team_name_based_off_of_team_id(team_id)
    team_collection.all.each do |team|
      return team.team_name if team_id == team.team_id
    end
  end

  def filter_by_season(season_id)
    games_grouped_by_season[season_id]
  end

  def games_grouped_by_season
    @games_grouped_by_season ||= game_collection.all.group_by do |game|
      game.season
    end
  end

  def find_games_by_season_in_game_teams(season_id)
    games_by_season = filter_by_season(season_id)

    game_team_season_collection = []

    games_by_season.each do |season_game|
      game_team_collection.all.each do |game_team|
        if game_team.game_id == season_game.game_id
          game_team_season_collection << game_team
        end
      end
    end
    game_team_season_collection
  end

  # def group_by_head_coach(season_id)
  #   hash = find_games_by_season_in_game_teams(season_id).group_by do |game_team|
  #     game_team.head_coach
  #   end
  # end

  def winningest_coach(season_id)
    coaches_wins = Hash.new(0)
    find_games_by_season_in_game_teams(season_id).each do |game_team|
      if game_team.result == "WIN"
        coaches_wins[game_team.head_coach] += 1.0
      elsif game_team.result == "LOSS"
        coaches_wins[game_team.head_coach] += 0.0
      elsif game_team.result == "TIE"
        coaches_wins[game_team.head_coach] += 0.5
      end
    end

    coaches_total_games = Hash.new(0)
    find_games_by_season_in_game_teams(season_id).each do |game_team|
      coaches_total_games[game_team.head_coach] += 1.0
    end

    ratio_of_wins_to_games = Hash.new(0)
    coaches_total_games.each do |total_games_coach, total_games|
      coaches_wins.each do |wins_coach, total_wins|
        if total_games_coach == wins_coach
          ratio_of_wins_to_games[wins_coach] = total_wins / total_games.to_f
        end
      end
    end

    best_coach = ratio_of_wins_to_games.max_by do |coach, ratio|
      ratio
    end
    best_coach[0]
  end

  # def worst_coach(season_id)
  #   coaches_wins = Hash.new(0)
  #   game_team_collection.all.each do |game_team|
  #     if season_id.include?(game_team.game_id.split(//).join[0..3])
  #       if game_team.result == "WIN"
  #         coaches_wins[game_team.head_coach] += 1.0
  #       elsif game_team.result == "LOSS"
  #         coaches_wins[game_team.head_coach] += 0.0
  #       elsif game_team.result == "TIE"
  #         coaches_wins[game_team.head_coach] += 0.5
  #       end
  #     end
  #   end
  #
  #   coaches_total_games = Hash.new(0)
  #   game_team_collection.all.each do |game_team|
  #     if season_id.include?(game_team.game_id.split(//).join[0..3])
  #       coaches_total_games[game_team.head_coach] += 1
  #     end
  #   end
  #
  #   ratio_of_wins_to_games = Hash.new(0)
  #   coaches_total_games.each do |total_games_coach, total_games|
  #     coaches_wins.each do |wins_coach, total_wins|
  #       if total_games_coach == wins_coach
  #         ratio_of_wins_to_games[wins_coach] = total_wins / total_games.to_f
  #       end
  #     end
  #   end
  #
  #   worst_coach = ratio_of_wins_to_games.min_by do |coach, ratio|
  #     ratio
  #   end
  #   worst_coach[0]
  #
  #   # coaches_stats = Hash.new(0)
  #   #
  #   # game_team_collection.all.each do |game_team|
  #   #   if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
  #   #     if game_team.result == "LOSS"
  #   #       coaches_stats[game_team.head_coach] -= 1
  #   #     elsif game_team.result == "WIN"
  #   #       coaches_stats[game_team.head_coach] += 1
  #   #     elsif game_team.result == "TIE"
  #   #       next
  #   #     end
  #   #   end
  #   # end
  #   # worst_coach = coaches_stats.min_by do |coach, wins|
  #   #   wins
  #   # end
  #   # worst_coach[0]
  # end
  #
  # def most_accurate_team(season_id)
  #   goals_for_season_by_team = Hash.new(0)
  #   game_team_collection.all.each do |game_team|
  #     if season_id.include?(game_team.game_id.split(//).join[0..3])
  #       goals_for_season_by_team[game_team.team_id] += game_team.goals.to_i
  #     end
  #   end
  #
  #   shots_for_season_by_team = Hash.new(0)
  #   game_team_collection.all.each do |game_team|
  #     if season_id.include?(game_team.game_id.split(//).join[0..3])
  #       shots_for_season_by_team[game_team.team_id] += game_team.shots.to_i
  #     end
  #   end
  #
  #   ratio_of_g_to_s_for_season_by_team = Hash.new(0)
  #   goals_for_season_by_team.each do |g_team_id, goals|
  #     shots_for_season_by_team.each do |s_team_id, shots|
  #       if s_team_id == g_team_id
  #         ratio_of_g_to_s_for_season_by_team[s_team_id] = goals.to_f / shots.to_f
  #       end
  #     end
  #   end
  #
  #   best_team = ratio_of_g_to_s_for_season_by_team.max_by do |team_id, ratio|
  #     ratio
  #   end
  #
  #   team_name_based_off_of_team_id(best_team[0])
  # end
  #
  # def least_accurate_team(season_id)
  #   goals_for_season_by_team = Hash.new(0)
  #   game_team_collection.all.each do |game_team|
  #     if season_id.include?(game_team.game_id.split(//).join[0..3])
  #       goals_for_season_by_team[game_team.team_id] += game_team.goals.to_i
  #     end
  #   end
  #
  #   shots_for_season_by_team = Hash.new(0)
  #   game_team_collection.all.each do |game_team|
  #     if season_id.include?(game_team.game_id.split(//).join[0..3])
  #       shots_for_season_by_team[game_team.team_id] += game_team.shots.to_i
  #     end
  #   end
  #
  #   ratio_of_g_to_s_for_season_by_team = Hash.new(0)
  #   goals_for_season_by_team.each do |g_team_id, goals|
  #     shots_for_season_by_team.each do |s_team_id, shots|
  #       if s_team_id == g_team_id
  #         ratio_of_g_to_s_for_season_by_team[s_team_id] = goals.to_f / shots.to_f
  #       end
  #     end
  #   end
  #
  #   worst_team = ratio_of_g_to_s_for_season_by_team.min_by do |team_id, ratio|
  #     ratio
  #   end
  #
  #   team_name_based_off_of_team_id(worst_team[0])
  # end
  #
  # def most_tackles(season_id)
  #   tackles_for_season_by_team = Hash.new(0)
  #   find_games_by_season_in_game_teams(season_id).each do |game_team|
  #     tackles_for_season_by_team[game_team.team_id] += game_team.tackles.to_i
  #   end
  #
  #   best_team = tackles_for_season_by_team.max_by do |team_id, tackles|
  #     tackles
  #   end
  #
  #   team_name_based_off_of_team_id(best_team[0])
  # end
  #
  # def fewest_tackles(season_id)
  #   tackles_for_season_by_team = Hash.new(0)
  #   find_games_by_season_in_game_teams(season_id).each do |game_team|
  #     tackles_for_season_by_team[game_team.team_id] += game_team.tackles.to_i
  #   end
  #
  #   worst_team = tackles_for_season_by_team.min_by do |team_id, tackles|
  #     tackles
  #   end
  #
  #   team_name_based_off_of_team_id(worst_team[0])
  # end
end
