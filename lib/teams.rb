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

  attr_reader :team_id, :francise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @francise_id = team_info[:franchiseid]
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end
end
