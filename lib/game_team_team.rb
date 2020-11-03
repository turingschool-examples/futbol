require_relative './game_team'
require_relative './game_team_collection'
require_relative "./divisable"

class GameTeamTeam < GameTeamCollection
  include Divisable
  def average_win_percentage(team_id)
    percentage(winning_games(team_id).count, total_games(team_id).count)
  end

  def most_goals_scored(team_id)
    @game_teams.select do |game_team|
      team_id == game_team.team_id
    end.max_by {|game| game.goals}.goals.to_i
  end

  def fewest_goals_scored(team_id)
    @game_teams.select do |game_team|
      team_id == game_team.team_id
    end.min_by {|game| game.goals}.goals.to_i
  end

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
         highest_loser_pct[game_team.team_id] = percentage(lowest, total) unless game_team.team_id == team_id
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
         highest[game_team.team_id] = percentage(high, total) unless game_team.team_id == team_id
       end
     end
   end
   highest.max_by {|id, pct| pct}[0]
  end
end
