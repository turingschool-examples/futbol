require_relative 'loadable'

class GameTeam
  @@accumulator = []
  extend Loadable
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in,
              :head_coach, :goals, :shots, :tackles, :pim,
              :powerplayopportunities, :powerplaygoals,
              :faceoffwinpercentage, :giveaways, :takeaways

  def initialize(data)
    @game_id = data[:game_id].to_i
    @team_id = data[:team_id].to_i
    @hoa = data[:hoa]
    @result = data[:result]
    @settled_in = data[:settled_in]
    @head_coach = data[:head_coach]
    @goals = data[:goals].to_i
    @shots  = data[:shots].to_i
    @tackles = data[:tackles].to_i
    @pim = data[:pim].to_i
    @powerplayopportunities = data[:powerplayopportunities].to_i
    @powerplaygoals = data[:powerplaygoals].to_i
    @faceoffwinpercentage = data[:faceoffwinpercentage].to_f
    @giveaways = data[:giveaways].to_i
    @takeaways = data[:takeaways].to_i
  end

 def self.from_csv(games_file_path)
   load_csv(games_file_path, self)
 end

 def self.accumulator
   @@accumulator
 end

 def percentage_ties
   ties = @@accumulator.count do |team|
     team.result == "TIE"
   end
   result = (ties.to_f / @@accumulator.count)*100
   result.round(2)
 end


end
