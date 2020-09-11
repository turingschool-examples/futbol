class TeamStats
  attr_reader :game_data,
              :game_teams_data,
              :teams_data

  def initialize(data)
    @game_data = data.game_data
    @game_teams_data = data.game_teams_data
    @teams_data = data.teams_data
  end

  def group_teams_data
    @teams_data.group_by do |row|
      row[:team_id]
    end
  end

  def team_info(team_id)
    v = []
    group_teams_data.each do |key, data|
      data.each do |row|
        if team_id == key
          v << row
        end
      end
    end
    key_transform = v[0].transform_keys {|k| k.to_s}
    value_transform = key_transform.transform_values {|v| v.to_s}
  end
end
