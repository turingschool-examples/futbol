class Season 
  attr_reader :season_data
  
  def initialize(data)
    @season_data = data
  end

  def team_accuracy
    team_goal_accuracy = Hash.new
    @season_data.each do |game|
      accuracy = game[:goals].to_i / game[:shots].to_i.to_f
      team_id = game[:team_id]
      team_goal_accuracy[team_id] = accuracy
    end
    team_goal_accuracy
  end
  
  def most_accurate_team
    teams = CSV.read('./data_dummy/teams_dummy.csv', headers: true, header_converters: :symbol)
    teams.each do |team|
      if team[:team_id] == team_accuracy.key(team_accuracy.values.max)
        return name = team[:teamname]
      end
    end
  end
  
  def least_accurate_team
    teams = CSV.read('./data_dummy/teams_dummy.csv', headers: true, header_converters: :symbol)
    teams.each do |team|
      if team[:team_id] == team_accuracy.key(team_accuracy.values.min)
        return name = team[:teamname]
      end
    end
  end
end