module Globeable
  def find_team_name_by_id(id_number)
    team_name = nil
    @teams_data.each do |row|
      team_name = row[:teamname] if row[:team_id] == id_number.to_s
    end
    team_name
  end

  def seasons
    seasons_ary = @games_data.map do |row|
      row[:season]
    end
    seasons_ary.uniq
  end

  def team_names
    teams = @teams_data.map do |row|
      row[:teamname]
    end
  end
end