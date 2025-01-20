class TeamFactory 
  def self.create_teams(filepath)
    teams = []
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row[:team_id], row[:franchiseid], row[:teamname], row[:abbreviation], row[:stadium], row[:link])
    end
    return teams
  end
end