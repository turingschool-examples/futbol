require 'csv'

class Team

  @@all = nil

  def self.all
    @@all
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all = csv.map do |row|
      Team.new(row)
    end
  end

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end

#Michelle start
  def find_team_names(team_id)
    match_team = @@all.find do |team|
      team.team_id == team_id
    end
    match_team.team_name
  end
#Michelle end
end
