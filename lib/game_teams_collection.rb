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

 #  def home_wins
 #    @game_teams_collection_instances.count do |game_team|
 #      game_team.result == "WIN"
 #    end
 #  end
 #
 # def percentage_vistor_wins
 #   all_results = []
 #   @game_teams_collection_instances.each do |instance|
 #     all_results << instance.result
 #   end
 #   number_of_results = all_results.length
 #
 #   result_loss = []
 #   @game_teams_collection_instances.each do |instance|
 #     if instance.result.include?("LOSS")
 #       result_loss << instance.result
 #     end
 #   end
 #   number_of_losses = result_loss.length
 #   home_win_percentage = number_of_losses.to_f / number_of_results
 # end
 #
 # def percentage_ties
 #   all_results = []
 #   @game_teams_collection_instances.each do |instance|
 #     all_results << instance.result
 #   end
 #   number_of_results = all_results.length
 #
 #   result_tie = []
 #   @game_teams_collection_instances.each do |instance|
 #     if instance.result.include?("TIE")
 #       result_tie << instance.result
 #     end
 #
 #   end
 #   number_of_ties = result_tie.length
 #   home_win_percentage = number_of_ties.to_f / number_of_results
 # end
end
