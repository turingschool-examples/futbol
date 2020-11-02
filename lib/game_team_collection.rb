require "csv"
require './lib/game_team'

class GameTeamCollection
  attr_reader :game_team_path, :stat_tracker

  def initialize(game_team_path, stat_tracker)
    @game_team_path = game_team_path
    @stat_tracker   = stat_tracker
    @game_teams     = []
    create_game_teams(game_team_path)
  end

  def create_game_teams(game_team_path)
    data = CSV.parse(File.read(game_team_path), headers: true)
    @game_teams = data.map {|data| GameTeam.new(data, self)}
  end

  # Game Statistics
  def compare_hoa_to_result(hoa, result)
    @game_teams.count do |game|
      game.HoA == hoa && game.result == result
    end.to_f
  end

  def total_games
    @game_teams.count / 2
  end

  def percentage_home_wins
    (compare_hoa_to_result("home", "WIN") / total_games * 100).round(2)
  end

  def percentage_visitor_wins
    (compare_hoa_to_result("away", "WIN") / total_games * 100).round(2)
  end

  def percentage_ties
    (compare_hoa_to_result("away", "TIE") / total_games  * 100).round(2)
  end

 # Season Statistics
  def games_in_season(season)
    @game_teams.select do |game|
    @stat_tracker.game_ids_per_season[season].include?(game.game_id)
    end
  end

  def games_per_coach(season)
    coaches_and_games = {}
    games_in_season(season).each do |game|
     (coaches_and_games[game.head_coach] << game if coaches_and_games[game.head_coach]) ||
     (coaches_and_games[game.head_coach] = [game])
     end
    coaches_and_games
  end

  def count_coach_results(season)
    coaches_and_results = {}
    games_per_coach(season).each do |coach, games|
        coaches_and_results[coach] = games.count do |game|
        game.result == "WIN"
      end
    end
    coaches_and_results
  end

  def coach_percentage(season)
    coaches_and_percentages = {}
    wins ||= count_coach_results(season)
    wins.keys.map do |coach|
      coaches_and_percentages[coach] = (wins[coach].to_f / games_per_coach(season)[coach].count).round(2)
    end
    coaches_and_percentages
  end

  def winningest_coach(season)
    coach = coach_percentage(season).max_by do |coach, percentage|
      percentage
    end
    coach[0]
  end

  def worst_coach(season)
    coach = coach_percentage(season).min_by do |coach, percentage|
      percentage
    end
    coach[0]
  end

  def team_scores(season, attribute)
    scores = {}
    games_in_season(season).each do |game|
      if attribute == "shots"
        (scores[game.team_id] += game.shots.to_i if scores[game.team_id]) ||
        (scores[game.team_id] = game.shots.to_i)
      elsif attribute == "goals"
        (scores[game.team_id] += game.goals.to_i if scores[game.team_id]) ||
        (scores[game.team_id] = game.goals.to_i)
      end
    end
    scores
  end

  def team_ratios(season)
    goals = team_scores(season, "goals")
    shots = team_scores(season, "shots")
    score_ratios = {}
    ratios = count_coach_results(season)
    goals.keys.each do |team_id|
      score_ratios[team_id] = (goals[team_id].to_f / shots[team_id]).round(2)
    end
    score_ratios
  end

  def most_accurate_team(season)
    team_id = team_ratios(season).max_by do |team, ratio|
      ratio
    end
    @stat_tracker.find_team_name(team_id[0])
  end

  def least_accurate_team(season)
    team_id = team_ratios(season).min_by do |team, ratio|
      ratio
    end
    @stat_tracker.find_team_name(team_id[0])
  end

  def total_tackles(season)
    teams_tackles = {}
    games_in_season(season).each do |game|
      (teams_tackles[game.team_id] += game.tackles.to_i if teams_tackles[game.team_id]) ||
      (teams_tackles[game.team_id] = game.tackles.to_i)
    end
    teams_tackles
  end

  def most_tackles(season)
    team_id = total_tackles(season).max_by do |team, tackles|
     tackles
   end
    @stat_tracker.find_team_name(team_id[0])
  end

  def least_tackles(season)
    team_id = total_tackles(season).min_by do |team, tackles|
     tackles
    end
    @stat_tracker.find_team_name(team_id[0])
  end

  # League Statistics Methods
  def best_offense
    @stat_tracker.find_team_name(find_highest_goal_team_id)
  end

  def worst_offense
    @stat_tracker.find_team_name(find_lowest_goal_team_id)
  end

  def highest_scoring_visitor
    @stat_tracker.find_team_name(highest_average_team_id_visitor)
  end

  def highest_scoring_home_team
    @stat_tracker.find_team_name(highest_average_team_id_home)
  end

  def lowest_scoring_visitor
    @stat_tracker.find_team_name(lowest_average_team_id_visitor)
  end

  def lowest_scoring_home_team
    @stat_tracker.find_team_name(lowest_average_team_id_home)
  end

  def most_goals_scored(team_id)
    # require "pry"; binding.pry
    @game_teams.select do |game_team|
      team_id == game_team.team_id
    end.max_by {|game| game.goals}.goals.to_i
  end

  def fewest_goals_scored(team_id)
    @game_teams.select do |game_team|
      team_id == game_team.team_id
    end.min_by {|game| game.goals}.goals.to_i
  end

  # League Statistics Helper Methods
  def find_highest_goal_team_id
    @game_teams.max_by {|goal| goal.goals}.team_id
  end

  def find_lowest_goal_team_id
    @game_teams.min_by {|goal| goal.goals}.team_id
  end

  def highest_average_team_id_visitor
    highest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
    @stat_tracker.total_goals_per_team_id_away.each do |team_id, num_goals|
      @stat_tracker.total_games_per_team_id_away.each do |id, num_games|
        highest_visitor[team_id] << (num_goals / num_games).round(2) if team_id == id
      end
    end
     highest_visitor.max_by {|team_id, avg| avg}[0]
   end

   def highest_average_team_id_home
     highest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
     @stat_tracker.total_goals_per_team_id_home.each do |team_id, num_goals|
       @stat_tracker.total_games_per_team_id_home.each do |id, num_games|
         highest_home[team_id] << (num_goals / num_games).round(2) if team_id == id
       end
     end
     highest_home.max_by {|team_id, avg| avg}[0]
   end

  def lowest_average_team_id_visitor
    lowest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
    @stat_tracker.total_goals_per_team_id_away.each do |team_id, num_goals|
      @stat_tracker.total_games_per_team_id_away.each do |id, num_games|
        lowest_visitor[team_id] << (num_goals / num_games).round(2) if team_id == id
        end
    end
     lowest_visitor.min_by {|team_id, avg| avg}[0]
   end

   def lowest_average_team_id_home
    lowest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
    @stat_tracker.total_goals_per_team_id_home.each do |team_id, num_goals|
      @stat_tracker.total_games_per_team_id_home.each do |id, num_games|
       lowest_home[team_id] << (num_goals / num_games).round(2) if team_id == id
     end
    end
    lowest_home.min_by {|team_id, avg| avg}[0]
  end

  # TEAM STATS
  def average_win_percentage(team_id)
    (winning_games(team_id).count / total_games(team_id).count.to_f * 100).round(2)
  end

  # Team Stats Helper
  def winning_games(team_id)
    @game_teams.select do |game|
      team_id == game.team_id && game.result == 'WIN'
    end
  end

  def total_games(team_id)
    @game_teams.select do |game|
      team_id == game.team_id && game.result != 'TIE'
    end
  end

  def winning_games(team_id)
   @game_teams.select do |game|
     team_id == game.team_id && game.result == 'WIN'
   end
 end

 def losing_games(team_id)
   @game_teams.select do |game|
     team_id == game.team_id && game.result == 'LOSS'
   end
 end

 def lowest_win_percentage(team_id)
   highest_loser_pct = {}
   @game_teams.each do |game_team|
     winning_games(team_id).each do |game|
       if game_team.game_id == game.game_id
         lowest = lowest_opposing_team(team_id)[game_team.team_id]
         total = total_opposing_team_games(team_id)[game_team.team_id].count.to_f
         highest_loser_pct[game_team.team_id] = (lowest / total * 100).round(2) unless game_team.team_id == team_id
       end
     end
   end
   highest_loser_pct.max_by {|id, pct| pct}[0]
 end

 def lowest_opposing_team(team_id)
   highest_opp_losses = Hash.new {|hash_obj, key| hash_obj[key] = 0}
   @game_teams.each do |game_team|
     winning_games(team_id).each do |game|
       if game_team.game_id == game.game_id
         highest_opp_losses[game_team.team_id] += 1 unless game_team.team_id == team_id
       end
     end
   end
   highest_opp_losses
 end
 def total_opposing_team_games(team_id)
   total_games = Hash.new {|hash_obj, key| hash_obj[key] = []}
   @game_teams.each do |game_team|
     winning_games(team_id).each do |game|
       if game_team.game_id == game.game_id
         total_games[game_team.team_id] << game_team.team_id unless game_team.team_id == team_id
       end
     end
   end
   total_games
 end

 def highest_opposing_team(team_id)
   highest_opp_wins = Hash.new {|hash_obj, key| hash_obj[key] = 0}
   @game_teams.each do |game_team|
     losing_games(team_id).each do |game|
       if game_team.game_id == game.game_id
         highest_opp_wins[game_team.team_id] += 1 unless game_team.team_id == team_id
       end
     end
   end
   highest_opp_wins
 end

 def highest_win_percentage(team_id)
   highest = {}
   @game_teams.each do |game_team|
     winning_games(team_id).each do |game|
       if game_team.game_id == game.game_id
         high = highest_opposing_team(team_id)[game_team.team_id]
         total = total_opposing_team_games(team_id)[game_team.team_id].count.to_f
         highest[game_team.team_id] = (high / total * 100).round(2) unless game_team.team_id == team_id
       end
     end
   end
   highest.max_by {|id, pct| pct}[0]
 end
end
