class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link

  def initialize(info)
    @team_id = info[:team_id]
    @franchise_id = info[:franchise_id]
    @team_name = info[:team_name]
    @abbreviation = info[:abbreviation]
    @link = info[:link]
  end

  def team_info
    info = {
      team_id: @team_id,
      franchise_id: @franchise_id,
      team_name: @team_name,
      abbreviation: @abbreviation,
      link: @link
    }
  end

  def self.read_file(location)
    team_rows = CSV.read(location, headers: true, header_converters: :symbol)
    team_rows.map do |team_row|
      new(team_row)
    end
  end
end
