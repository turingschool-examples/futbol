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
  def highest_total_score
    result = games.max_by do |game|
      game['away_goals'].to_i + game['home_goals'].to_i
    end
    result['away_goals'].to_i + result['home_goals'].to_i
  end
#
  def lowest_total_score
    result = games.min_by do |game|
      game['away_goals'].to_i + game['home_goals'].to_i
    end
    result['away_goals'].to_i + result['home_goals'].to_i
  end

  def home_win_percentage
    average = all_home_game_wins/all_home_games.count.to_f
    average.round(2)
  end

  def all_home_games
    game_teams.find_all do |game|
      game['HoA'] == "home"
    end
  end

  def all_home_game_wins
    all_home_games.find_all do |game|
      game['result'] == "WIN"
    end.count
  end

  def all_home_game_losses
    all_home_games.find_all do |game|
      game['result'] == "LOSS"
    end.count
  end

  def visitor_win_percentage
    average = all_away_game_wins/all_away_games.count.to_f
    average.round(2)
  end

  def all_away_games
    game_teams.find_all do |game|
      game['HoA'] == "away"
    end
  end

  def all_away_game_wins
    all_away_games.find_all do |game|
      game['result'] == "WIN"
    end.count
  end
#
#------------LeagueStatistics
  def count_of_teams
    teams = games.flat_map do |game|
      [game['away_team_id'], game['home_team_id']]
    end

    teams.uniq.count
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
