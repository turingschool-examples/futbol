require 'csv'
class Team

  def self.from_csv(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    @@all = csv.map { |row| Team.new(row) }
  end


  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(details)
    @team_id = details[:team_id].to_i
    @franchise_id = details[:franchiseid].to_i
    @team_name = details[:teamname]
    @abbreviation = details[:abbreviation]
    @stadium = details[:stadium]
    @link = details[:link]
  end


end
