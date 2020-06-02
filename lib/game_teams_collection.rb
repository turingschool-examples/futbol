require_relative './game'
require_relative './team'
require_relative './game_teams'
require 'csv'
require 'pry'

class GameTeamsCollection
  attr_reader :game_teams_collection

  def initialize(game_teams_collection)
    @game_teams_collection = game_teams_collection
  end

  def all
    all_game_teams = []
    CSV.read('./data/game_teams_fixture.csv', headers: true, header_converters: :symbol).each do |game_team|
      game_teams_hash = {game_id: game_team[:game_id], team_id: game_team[:team_id], hoa: game_team[:hoa], result: game_team[:result], settled_in: game_team[:settled_in], head_coach: game_team[:head_coach], goals: game_team[:goals], shots: game_team[:shots], tackles: game_team[:tackles], pim: game_team[:pim], powerplayopportunities: game_team[:powerplayopportunities], powerplaygoals: game_team[:powerplaygoals], faceoffwinpercentage: game_team[:faceoffwinpercentage], giveaways: game_team[:giveaways], takeaways: game_team[:takeaways]
        }
      all_game_teams << GameTeams.new(game_teams_hash)
    end
    all_game_teams
  end

  # def total_games_per_team(id)
  #   @games.all.each do |game|
  #       binding.pry
  #     is_home_team = game.home_team_id == id
  #     is_away_team = game.away_team_id == id
  #    if is_home_team || is_away_team
  #      1
  #    else
  #      0
  #    end
  #  end
  # end
end


# def favorite_opponent(team_id)
#  game_lost_ids = []
#  game_teams.all.each do |game_team|
#     game_lost_ids << game_team.game_id if game_team.result == "LOSS"
#   end
#   game_lost_ids
#
#   opponent_wins = game_teams.all.find_all do |game_team|
#     game_lost_ids.include?(game_team.game_id) && game_team.team_id != team_id
#   end
#
#   opposite_wins_by_team = opponent_wins.group_by do |game_team|
#     game_team.team_id
#   end
#
#   opposite_team_win_count = opposite_wins_by_team.reduce({}) do |acc, (team, game_teams)|
#     total_games = total_games(team_id)
#     acc[team] = game_teams.count.fdiv(total_games)
#     acc
#   end
#
#   fav_opponent = opposite_team_win_count.min_by do |team, average_win_percentage|
#     average_win_percentage
#   end
#   binding.pry
#
#   teams.all.select do |team|
#     team.id == fav_opponent[0].to_s
#     return team.name
#   end
# end
