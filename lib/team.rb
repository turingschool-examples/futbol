class Team
  attr_reader :name,
              :wins,
              :losses,
              :head_coach

  def initialize(team_data)
    @name = team_data[:name]
    @wins = team_data[:wins].to_i
    @losses = team_data[:losses].to_i
    @head_coach = team_data[:head_coach]
  end
end