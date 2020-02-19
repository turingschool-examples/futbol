class GameTeams

  attr_reader :game_id,
              :team_id,
              :hoa,
              :results,
              :settled_in,
              :head_couch,
              :goals,
              :shots,
              :tackles

  def initialize(attributes)
    @game_id = attributes[:game_id]
    @team_id = attributes[:team_id]
    @hoa = attributes[:HoA]
    @results = attributes[:results]
    @settled_in = attributes[:settled_in]
    @head_couch = attributes[:head_couch]
    @goals = attributes[:goals]
    @shots = attributes[:shots]
    @tackles = attributes[:tackles]
  end
end
