class Team

attr_reader :id,
            :team_name,
            :games_won

  def initialize(team_data)
    @id = team_data[:team_id]
    @team_name = team_data[:teamname]
    @games_won = 0
    # parse_stats(game_team_data)
  end 

  def parse_stats(game_team_data)
    game_lines = CSV.open game_team_data, headers: true, header_converters: :symbol
    @games_won = game_lines.count do |line|
      line[:team_id] == @id && line[:result] == "WIN"
    end
  end
end