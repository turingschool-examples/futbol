require 'CSV'

class Team
  @@all = []
  attr_reader :team_id, :franchise_id, :team_name,
              :abbreviation, :stadium, :link

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol )
    @@all = csv.map{|row| Team.new(row)}
  end

  def self.all
    @@all
  end

  def self.find_name(id)
    team_name = @@all.find do |team|
      team.team_id == id
    end
    team_name.team_name
  end
  
  def initialize(team_details)
    @team_id = team_details[:team_id].to_i
    @franchise_id = team_details[:franchiseid].to_i
    @team_name = team_details[:teamname]
    @abbreviation = team_details[:abbreviation]
    @stadium = team_details[:stadium]
    @link = team_details[:link]
  end

end
