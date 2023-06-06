require "csv"

class StatTracker
  
  def from_csv(csv)
    team_id = csv[0].index("team_id")
    franchiseId = csv[0].index("franchiseId")
    teamName = csv[0].index("teamName")
    abbreviation = csv[0].index("abbreviation")
    stadium = csv[0].index("Stadium")
    link = csv[0].index("link")
      new_arr = csv.map do |team|
      {:team_id => team[team_id], 
      :franciseId => team[franchiseId],
      :abbreviation => team[abbreviation],
      :stadium => team[stadium], 
      :link => team[link]}
      end
      new_arr.drop(1)
  end



end