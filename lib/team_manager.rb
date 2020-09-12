class TeamManager
  attr_reader :team_data,
              :tracker

  def initialize(location, tracker)
    @team_data = team_stats(location)
    @tracker = tracker
  end

  def teams_stats
    teams_data = CSV.read(@teams, { encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all })
    hashed_teams_data = teams_data.map { |row| row.to_hash }
    hashed_teams_data.each do |row|
      row.delete(:staduim)
    end
  end
end
