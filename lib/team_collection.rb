require_relative 'team'
require 'csv'

class TeamCollection
  attr_reader :csv_file_path, :teams

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @teams = []
  end

  def instantiate_team(info)
    Team.new(info)
  end

  def collect_team(team)
    @teams << team
  end

  def create_team_collection
    CSV.foreach(@csv_file_path, headers: true, header_converters: :symbol) do |row|
      collect_team(instantiate_team(row))
    end
  end

  def all
    @teams
  end

  def array_by_key(key)
    @teams.map{ |team| team.send "#{key}" }.uniq  ## can probably put this in a module passing class, collection, and key as arguments
  end

  def where_id(id)
    @teams.find{|team| team.team_id == id}.team_name
  end

end
