require "CSV"

class StatTracker

  def initilize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
  end

  def self.from_csv(locations)
    data = []
    headers = nil

    locations.each do |name, path|
      CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
        headers ||= row.headers
        data << row
      end
    end
    data
  end
end
