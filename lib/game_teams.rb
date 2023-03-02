class GameTeam
  def initialize(locations)
    file = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    @game_id = file[:game_id]
    @team_id = file[:team_id]
    @hoa = file[:HoA]
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
    offenses.key(offenses.values.max)
    offenses.max_by{|k, v| v}[0]
  end

  def worst_offense
    offenses = Hash.new(0)
    (0..@team_id.count).each do |i|
      offenses[@team_id[i]] += @goals[i].to_i
    end
    offenses.find_all{|k, v| v > 0}.min_by{|k, v| v}[0]
  end
end