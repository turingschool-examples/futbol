class TeamStats
  attr_reader :game_data,
              :game_teams_data,
              :teams_data

  def initialize(data)
    @game_data = data.game_data
    @game_teams_data = data.game_teams_data
    @teams_data = data.teams_data
  end
  # 
  # def group_teams_data
  #   @teams_data.group_by do |row|
  #     require "pry"; binding.pry
  #     row[:team_id]
  #   end
  # end
  #
  # def team_info(team_id)
  #   group_teams_data.each do |key, data|
  #     if key == team_id
  #       data
  #     end
  #   end
  # end
end
