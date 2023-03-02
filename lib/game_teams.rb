class GameTeam
  def initialize(locations)
    file = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    @game_id = file[:game_id]
    @team_id = file[:team_id]
    @hoa = file[:hoa]
    @result = file[:result]
    @settled_in = file[:settled_in]
    @head_coach = file[:head_coach]
    @goals = file[:goals]
  end

  def best_offense
    offenses = Hash.new(0)
    (0..@team_id.count).each do |i|
      offenses[@team_id[i]] += @goals[i].to_i
    end
    offenses.max_by{|k, v| v}[0]
  end
  
  def worst_offense
    offenses = Hash.new(0)
    (0..@team_id.count).each do |i|
      offenses[@team_id[i]] += @goals[i].to_i
    end
    offenses.select{|k, v| v > 0}.min_by{|k, v| v}[0]
  end

  def highest_scoring_visitor
    away_teams = Hash.new(0)
    (0..@team_id.count).each do |i|
      away_teams[@team_id[i]] += @goals[i].to_i if @hoa[i] == 'away'
    end
    team_id = away_teams.max_by{|k, v| v}[0]
  end

  def lowest_scoring_visitor
    away_teams = Hash.new(0)
    (0..@team_id.count).each do |i|
      away_teams[@team_id[i]] += @goals[i].to_i if @hoa[i] == 'away'
    end
    team_id = away_teams.min_by{|k, v| v}[0]
  end

  def highest_scoring_home_team
    home_teams = Hash.new(0)
    (0..@team_id.count).each do |i|
      home_teams[@team_id[i]] += @goals[i].to_i if @hoa[i] == 'home'
    end
    team_id = home_teams.max_by{|k, v| v}[0]
  end

  def lowest_scoring_home_team
    home_teams = Hash.new(0)
    (0..@team_id.count).each do |i|
      home_teams[@team_id[i]] += @goals[i].to_i if @hoa[i] == 'home'
    end
    home_teams.min_by{|k, v| v}[0]
  end
end