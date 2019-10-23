require 'csv'

class Game
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals,
      :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals,
      :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_info)
    @game_id = game_info[:game_id].to_i
    @team_id = game_info[:team_id]
    @hoa = game_info[:description]
    @result = game_info[:unit_price]
    @settled_in = game_info[:settled_in]
    @head_coach = game_info[:head_coach]
    @goals = game_info[:goals]
    @shots = game_info[:shots]
    @tackles = game_info[:tackles]
    @pim = game_info[:pim]
    @powerPlayOpportunities = game_info[:powerPlayOpportunities]
    @powerPlayGoals = game_info[:powerPlayGoals]
    @faceOffWinPercentage = game_info[:faceOffWinPercentage]
    @giveaways = game_info[:giveaways]
    @takeaways = game_info[:takeaways]
  end

  # def self.all_stats
  #   csv = CSV.read "./data/games.csv", headers: true, header_converters: :symbols
  #
  #   csv.map do |row|
  #     Game.new(row)
  #   end
  # end
end
