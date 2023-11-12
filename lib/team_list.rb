require 'CSV'
require_relative './team'

class TeamList
  attr_reader :teams, :stat_tracker

  def initialize(path, stat_tracker)
    @teams = create_teams(path)
    @stat_tracker = stat_tracker
  end
  
  def create_teams(path)
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    data.map do |datum|
      Team.new(datum, self)
    end
  end

  

end