require 'csv'
require_relative 'game_teams'
require_relative 'stat_tracker'

class GameTeamsCollection

  def initialize(game_teams_path)
    @game_teams_path = game_teams_path
    @game_teams_collection_instances = all_game_teams
  end

  def all_game_teams
    csv = CSV.read("#{@game_teams_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
       GameTeams.new(row)
    end
  end

  def percentage_home_wins
    #require 'pry'; binding.pry
   all_results = []
   @game_teams_collection_instances.each do |instance|
     all_results << instance.result
   end
   number_of_results = all_results.length

   result_win = []
   @game_teams_collection_instances.each do |instance|
     if instance.result.include?("WIN")
       result_win << instance.result
     end
   end
   number_of_wins = result_win.length
   home_win_percentage = number_of_wins.to_f / number_of_results
 end

 def percentage_vistor_wins
   all_results = []
   @game_teams_collection_instances.each do |instance|
     all_results << instance.result
   end
   number_of_results = all_results.length

   result_loss = []
   @game_teams_collection_instances.each do |instance|
     if instance.result.include?("LOSS")
       result_loss << instance.result
     end
   end
   number_of_losses = result_loss.length
   home_win_percentage = number_of_losses.to_f / number_of_results
 end

 def percentage_ties
   all_results = []
   @game_teams_collection_instances.each do |instance|
     all_results << instance.result
   end
   number_of_results = all_results.length

   result_tie = []
   @game_teams_collection_instances.each do |instance|
     if instance.result.include?("TIE")
       result_tie << instance.result
     end

   end
   number_of_ties = result_tie.length
   home_win_percentage = number_of_ties.to_f / number_of_results
 end

 def winningest_team
   #refactor for winningest
   team_game_count = Hash.new(0)
   @game_teams_collection_instances.each do |game|
     if game.result == "WIN"
     team_game_count[game.team_id] += 1
    end
   end
  winningest = team_game_count.max_by {|key, value| value}
 end
 # def count_of_games_per_season
 #   #refactor for winningest
 #   season_game_count = Hash.new(0)
 #   @game_instances.each do |game|
 #     season_game_count[game.season]+=1
 #   end
 #   season_game_count
 # end
 # # def winningest_team
 #   team_totals = {}
 #   teams_list.map do |team|
 #     team_totals[team] = games_by_team_array(team)
 #   end
 #
 # end
 #
 # def teams_list
 #  @game_teams_collection_instances.map do |game|
 #    game[team_id]
 #  end.uniq
 # end
 #
 #  def games_by_team_array(team_id)
 #   games = []
 #   @game_teams_collection_instances.each do |game|
 #     if game.team_id == team_id
 #       games << game
 #     end
 #    games
 #    end
 #  end
end
