require 'CSV'

class StatTracker
  def self.from_csv(object, path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      object.add(object.new(row))
    end
  end

  def self.remove_all
   Team.remove_all
   GameTeams.remove_all
  end

 def self.count_of_teams
   Team.all.size
 end

 def self.best_offense
  GameTeams.teams_sort_by_average_goal.last.teamname
 end
end
