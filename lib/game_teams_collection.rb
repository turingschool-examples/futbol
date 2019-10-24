require 'csv'
require_relative 'game_teams'
require_relative 'stat_tracker'

class GameTeamsCollection
  attr_reader :game_teams_instances

  def initialize(game_teams_path)
    @game_teams_path = game_teams_path
    @game_teams_instances = all_stats
  end

  def all_stats
    game_teams_objects = []
    csv = CSV.read("#{@game_teams_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      game_teams_objects <<  GameTeams.new(row)
    end
    game_teams_objects
  end

  def percentage_home_wins
    all_results = []
    @game_teams_instances.each do |instance|
      all_results << instance.result
    end
    number_of_results = all_results.length

    result_win = []
    @game_teams_instances.each do |instance|
      if instance.result.include?("WIN")
        result_win << instance.result
      end
    end
    number_of_wins = result_win.length
    home_win_percentage = number_of_wins.to_f / number_of_results
  end

  def percentage_vistor_wins
    all_results = []
    @game_teams_instances.each do |instance|
      all_results << instance.result
    end
    number_of_results = all_results.length

    result_loss = []
    @game_teams_instances.each do |instance|
      if instance.result.include?("LOSS")
        result_loss << instance.result
      end
    end
    number_of_losses = result_loss.length
    home_win_percentage = number_of_losses.to_f / number_of_results
  end

  def percentage_ties
    all_results = []
    @game_teams_instances.each do |instance|
      all_results << instance.result
    end
    number_of_results = all_results.length

    result_tie = []
    @game_teams_instances.each do |instance|
      if instance.result.include?("TIE")
        result_tie << instance.result
      end

    end
    number_of_ties = result_tie.length
    home_win_percentage = number_of_ties.to_f / number_of_results
  end
end
