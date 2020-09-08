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

  def best_offense
    best_offense = team_stats.max_by do |team, stats|
      stats[:total_goals] / stats[:total_games].to_f
    end

    teams.find do |team|
      team['team_id'] == best_offense[0]
    end['teamName']
  end

  def worst_offense
    worst_offense = team_stats.min_by do |team, stats|
      stats[:total_goals] / stats[:total_games].to_f
    end

    teams.find do |team|
      team['team_id'] == worst_offense[0]
    end['teamName']
  end

  def highest_scoring_visitor
    highest_scoring_visitor = team_stats.max_by do |team, stats|
      stats[:away_goals] / stats[:away_games].to_f
    end

    teams.find do |team|
      team['team_id'] == highest_scoring_visitor[0]
    end['teamName']
  end

  def highest_scoring_home_team
    highest_scoring_home_team = team_stats.max_by do |team, stats|
      stats[:home_goals] / stats[:home_games].to_f
    end

    teams.find do |team|
      team['team_id'] == highest_scoring_home_team[0]
    end['teamName']
  end
  
  # LeagueStatistics Help Methods
  def create_team_stats_hash
    team_stats_hash = {}

    teams.each do |team|
      team_stats_hash[team['team_id']] = { total_games: 0, total_goals: 0,
                                           away_games: 0, home_games: 0,
                                           away_goals: 0, home_goals: 0 }
    end

    team_stats_hash
  end

  def team_stats
    create_team_stats_hash.each do |team_id, games_goals|
      games.each do |game|
        if team_id == game['away_team_id'] || team_id == game['home_team_id']
          games_goals[:away_games] += 1 if team_id == game['away_team_id']
          games_goals[:home_games] += 1 if team_id == game['home_team_id']
          games_goals[:away_goals] += game['away_goals'].to_i if team_id == game['away_team_id']
          games_goals[:home_goals] += game['home_goals'].to_i if team_id == game['home_team_id']
        end
      end
      games_goals[:total_games] = games_goals[:away_games] + games_goals[:home_games]
      games_goals[:total_goals] = games_goals[:away_goals] + games_goals[:home_goals]
    end
  end


# #------------SeasonStatistics
#
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
  private

  def coach_list_wins_losses
    coach_hash = Hash.new
    game_teams.each do |gt|
      (coach_hash[gt.head_coach] ||= []) << gt.result
    end
    coach_hash
  end  
end
