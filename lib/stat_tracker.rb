require 'CSV'

class StatTracker

  def initialize
    @games = nil
    @game_teams = nil
    @teams = nil
  end

  def self.from_csv(locations_hash)
    require 'pry'; binding.pry
    CSV.foreach(locations_hash, headers: true, header_converters: :symbol) do |row|
      require 'pry'; binding.pry
      team_id = row[:team_id]
      franchise_id = row[:franchiseid]
      team_name = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]

    end
  end

  def break_down_locations(locations_hash)
    locations_hash.each do |file_location|
      CSV.foreach(file_location, headers: true, header_converters: :symbol) do |row|
        require 'pry'; binding.pry
        team_id = row[:team_id]
        franchise_id = row[:franchiseid]
        team_name = row[:teamname]
        abbreviation = row[:abbreviation]
        stadium = row[:stadium]
        link = row[:link]

      end
    end
  end

end

  # def create_teams_data
  #   CSV.foreach('./data/teams.csv', headers: true, header_converters: :symbol) do |row|
  #     require 'pry'; binding.pry
  #     team_id = row[:team_id]
  #     franchise_id = row[:franchiseid]
  #     team_name = row[:teamname]
  #     abbreviation = row[:abbreviation]
  #     stadium = row[:stadium]
  #     link = row[:link]

  #     teams_data = TeamData.new(team_id, franchise_id, team_name, abbreviation, stadium, link)

  #   end
  # end
