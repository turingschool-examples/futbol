require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers:true)
    teams = CSV.read(locations[:teams], headers:true)
    game_teams = CSV.read(locations[:game_teams], headers:true)

    new(games, teams, game_teams)
  end

#
# #------------GameStatistics
#
#   def highest_total_score
#     result = games.max_by do |game|
#       game.away_goals.to_i + game.home_goals.to_i
#     end
#     result.away_goals.to_i + result.home_goals.to_i
#   end
#
#   def lowest_total_score
#     result = games.min_by do |game|
#       game.away_goals.to_i + game.home_goals.to_i
#     end
#     result.away_goals.to_i + result.home_goals.to_i
#   end
#
#------------LeagueStatistics
  def count_of_teams
    teams = games.flat_map do |game|
      [game['away_team_id'], game['home_team_id']]
    end

    teams.uniq.count
  end

# #------------SeasonStatistics

  def winningest_coach(season)
    game_team_results_by_season(season)
    coaches_records_start

    # coaches_record_per_season(season)

    # coach_record_hash = {}
    # games_in_season(season).each do |game|

    # end
  end

#   def winningest_coach
#     winner = coach_list_wins_losses.max_by do |key, w_l|
#       wins = w_l.count("WIN")
#       losses = w_l.count("LOSS").to_f
#       (wins) / (wins + losses)
#     end
#     winner[0]
#   end
#
#   def worst_coach
#     loser = coach_list_wins_losses.min_by do |key, w_l|
#       wins = w_l.count("WIN")
#       losses = w_l.count("LOSS").to_f
#       (wins) / (wins + losses)
#     end
#     loser[0]
#   end
#


#------------TeamStatistics

  def team_info
    result = { }
    teams.each do |team|
      (result[:team_id] ||= []) << team['team_id']
      (result[:franchiseId] ||= []) << team['franchiseId']
      (result[:teamName] ||= []) << team['teamName']
      (result[:abbreviation] ||= []) << team['abbreviation']
      (result[:link] ||= []) << team['link']
    end
    result
  end

#---------------------------
  # private

def game_team_results_by_season(season)
    games_of_season = games.find_all do |game|
      game['season'] == season
    end
    game_ids_in_season = games_of_season.map do |game|
      game['game_id']
    end
    @games_results_per_season = game_teams.find_all do |gt|
      game_ids_in_season.include? gt['game_id']
    end
  end

  def coaches_records_start
    coach_record_hash = {}
    @games_results_per_season.each do |gr|
      coach_record_hash[gr['head_coach']] = {wins: 0, losses: 0}
    end
    coach_record_hash
  end

  def add_wins_losses
    @games_results_per_season.each do |gr|
      if gr['result'] == "WIN"
        coach_record_hash[gr['head_coach']][:wins] += 1
      end
    end
  end
end
