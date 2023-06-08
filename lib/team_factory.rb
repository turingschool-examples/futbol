class TeamFactory
  attr_reader :teams

  def initialize
    @teams = []
  end


  def create_teams(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      team_details = {
        :team_id => row[:team_id], 
        :franchise_id => row[:franchiseid],
        :team_name => row[:teamname],
        :abbreviation => row[:abbreviation], 
        :stadium => row[:stadium], 
        :link => row[:link]
      }
      @teams.push(team_details)
    end
  end
end