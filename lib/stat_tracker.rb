require 'csv' 
require './lib/team'


class StatTracker
  def self.from_csv(locations)
    teams = CSV.open locations[:teams], headers: true, header_converters: :symbol
    teams.each do |team| 
      new_team = Team.new(team)
      require 'pry'; binding.pry
    end
  end
end