require 'csv'

class Team

  def self.from_csv(team_path)
    csv = CSV.read("#{team_path}", headers: true, header_converters: :symbol)

    @@all_teams = csv.map do |row|
       Team.new(row)
    end
  end

  def self.all
    @@all_teams
  end

  attr_reader :team_id, :franchise_id,
            :team_name, :abbreviation,
            :stadium, :link

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end

end
