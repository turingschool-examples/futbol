class Team

  attr_reader :team_id,
              :team_name

  def initialize(info)
    @team_id = info[:team_id]
    @team_name = info[:team_name]
  end
end