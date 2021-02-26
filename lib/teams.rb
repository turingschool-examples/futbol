class Teams

  attr_reader :data

  def initialize(data, manager)
    @manager = manager
    @data = data
    # @away_team_id = data[:away_team_id]
  end
end
