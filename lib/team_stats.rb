require_relative "stats"

class TeamStats < Stats

  def initialize(file_path)
    Stats.from_csv(file_path)
  end

  def self.team_info(team_id)
  # finds a specific team via their id
   team = team_by_id(team_id)
   # returns an array of the team object's instance variables, then iterates
   # over that array, deletes the '@' from the front of the instance variable
   # and assigns that as a key, then sets the value equal to the key by again
   # removing the '@' and then passing that as a method call then returning it
   # all as a hash
    team_data = team.instance_variables.map { |key,value| ["#{key}".delete("@"), value = team.send("#{key}".delete("@").to_sym)]}.to_h
    # searches the hash for a key, value pair whose key is "stadium" then deletes it.
    team_data.delete_if {|k,v| k == "stadium"}
 end
end
