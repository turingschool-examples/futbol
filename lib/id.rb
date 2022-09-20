require 'csv'
module Id
  attr_reader :team_data
  team_path = './data/teams.csv'
  locations = {
      teams: team_path
    }
  @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
  def team_name_from_id_average(average)
    @teams_data.each do |row|
      return row[:teamname] if average[0] == row[:team_id]
    end
  end
end
