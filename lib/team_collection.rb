require 'csv'
require_relative '../lib/team'

class TeamCollection
  attr_reader :teams_array

  def initialize(location)
    @teams_array = []
	CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
	  @teams_array << Team.new(row)
    end
  end

  def find_best_offensive_team(best_offensive_team_id)
	@teams_array.find {|team| team.team_id == best_offensive_team_id}.team_name
  end

end