require './lib/stat_tracker.rb'

class Teams
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def self.create_multiple_teams(locations)
    # require "pry"
    # binding.pry
    teams = CSV.parse(File.read(locations), headers: true, header_converters: :symbol).map(&:to_h)
    teams_as_objects = teams.map { |row| Teams.new(row) }
    require "pry"
    binding.pry
  end

  def initialize(team_info)
  @team_id = team_info[:team_id]
  @franchise_id = team_info[:franchiseid]
  @team_name = team_info[:teamname]
  @abbreviation = team_info[:abbreviation]
  @stadium = team_info[:Stadium]
  @link = team_info[:link]
  end


end
