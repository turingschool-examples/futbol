

class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :powerplayopportunities,
              :powerplaygoals,
              :faceoffwinpercentage,
              :giveaways,
              :takeaways
              # :game_teams_rows
  def initialize(data)
    @game_id = data[:game_id]
    @team_id = data[:team_id]
    @hoa = data[:hoa]
    @result = data[:result]
    @settled_in = data[:settled_in]
    @head_coach = data[:head_coach]
    @goals = data[:goals]
    @shots = data[:shots]
    @tackles = data[:tackles]
    @pim = data[:pim]
    @powerplayopportunities = data[:powerplayopportunities]
    @powerplaygoals = data[:powerplaygoals]
    @faceoffwinpercentage = data[:faceoffwinpercentage]
    @giveaways = data[:giveaways]
    @takeaways = data[:takeaways]

    @game_teams_rows = Hash.new

    data.by_row!.each do |row|
      team_hash = row.to_h
      @game_teams_rows[team_hash[:team_id].to_i] = team_hash
    end

  end

  def gt_by_id(id)
    @game_teams_rows[id]
    # binding.pry
  end

  def goals_array(team_id)
    max_goals = Hash.new
    goals_by_id = Array.new
    data.by_row!.each do |row|
      team_hash = row.to_h
      max_goals[team_hash[:team_id]] = goals_by_id
      if team_hash[:team_id] == team_id
        goals_by_id << team_hash[:goals]
      end
    end
  end


end
