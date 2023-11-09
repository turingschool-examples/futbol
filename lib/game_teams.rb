
class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(game_id, team_id, hoa, result, head_coach, goals, shots, tackles)
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa
    @result = result
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles
  end

  def self.create_game_teams(data_path)
    game_instance_array = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      game_id =row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      head_coach = row[:head_coach]
      goals = row[:goals].to_i
      shots = row[:shots].to_i
      tackles = row[:tackles].to_i
      game_instance = GameTeams.new(game_id, team_id, hoa, result, head_coach, goals, shots, tackles)
      game_instance_array << game_instance
    end
    game_instance_array
  end
end
