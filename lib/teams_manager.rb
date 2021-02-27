require_relative './team'
require 'CSV'

class TeamsManager
  attr_reader :teams

  def initialize(data_path)
    @teams = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << Team.new(row)
    end
    list_of_data
  end

  def count_of_teams #ask intructors if they want this
    teams.uniq.count
  end

  def get_names_hash
    team_names_hash = {}
    @teams.each do |team|
      team_names_hash[team.team_id] = team.team_name
    end
    team_names_hash
  end

  def get_team_name(team_id)
    name_hash = get_names_hash
    name_hash[team_id]
  #alternate replacement without hashing.
  #get_name(id)
    # team = @teams.find do |team|
    #   team.team_id == id
    # end
    # team.name
  #end
  end
end
