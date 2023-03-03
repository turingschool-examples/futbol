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
    @shots = file[:shots]
    @tackles = file[:tackles]
  end

  def best_offense
    offenses = Hash.new { |h, k| h[k] = Hash.new(0) }
    (0..@team_id.count).each do |i|
      offenses[@team_id[i]][:goals] += @goals[i].to_i
      offenses[@team_id[i]][:games] += 1
    end
    offenses.max_by{|k, v| (v[:goals].fdiv(v[:games]))}[0]
  end
  
  def worst_offense
    offenses = Hash.new { |h, k| h[k] = Hash.new(0) }
    (0..@team_id.count).each do |i|
      offenses[@team_id[i]][:goals] += @goals[i].to_i
      offenses[@team_id[i]][:games] += 1
    end
    offenses.select{|k, v| v[:goals] > 0}.min_by{|k, v| (v[:goals].fdiv(v[:games]))}[0]
  end

  def highest_scoring_visitor
    away_teams = Hash.new { |h, k| h[k] = Hash.new(0) }
    (0..@team_id.count).each do |i|
      if @hoa[i] == 'away'
        away_teams[@team_id[i]][:goals] += @goals[i].to_i
        away_teams[@team_id[i]][:games] += 1
      end
    end
    away_teams.max_by{|k, v| (v[:goals].fdiv(v[:games]))}[0]
  end

  def lowest_scoring_visitor
    away_teams = Hash.new { |h, k| h[k] = Hash.new(0) }
    (0..@team_id.count).each do |i|
      if @hoa[i] == 'away'
        away_teams[@team_id[i]][:goals] += @goals[i].to_i
        away_teams[@team_id[i]][:games] += 1
      end
    end
    away_teams.min_by{|k, v| (v[:goals].fdiv(v[:games]))}[0]
  end

  def highest_scoring_home_team
    home_teams = Hash.new { |h, k| h[k] = Hash.new(0) }
    (0..@team_id.count).each do |i|
      if @hoa[i] == 'home'
        home_teams[@team_id[i]][:goals] += @goals[i].to_i 
        home_teams[@team_id[i]][:games] += 1 
      end
    end
    home_teams.max_by{|k, v| (v[:goals].fdiv(v[:games]))}[0]
  end

  def lowest_scoring_home_team
    home_teams = Hash.new { |h, k| h[k] = Hash.new(0) }
    (0..@team_id.count).each do |i|
      if @hoa[i] == 'home'
      home_teams[@team_id[i]][:goals] += @goals[i].to_i
      home_teams[@team_id[i]][:games] += 1
      end
    end
    home_teams.min_by{|k, v| (v[:goals].fdiv(v[:games]))}[0]
  end

  def winningest_coach(season)
    coaches = Hash.new { |h, k| h[k] = Hash.new{ |h, k|h[k] = Hash.new(0) }}
    (0..@team_id.count).each do |i|
      coaches[@head_coach[i]][@game_id[i]&.slice(0..3)][:wins] += 1 if @result[i] == 'WIN'
      coaches[@head_coach[i]][@game_id[i]&.slice(0..3)][:games] += 1
    end
    winningest_record = 0
    winningest_coach = nil
    coaches.each do |coach, szns|
      record = szns[season.slice(0..3)][:wins]&.fdiv(szns[season.slice(0..3)][:games])
      if record > winningest_record
        winningest_record = record
        winningest_coach = coach
      end
    end
    winningest_coach
  end

  def worst_coach(season)
    coaches = Hash.new { |h, k| h[k] = Hash.new{ |h, k|h[k] = Hash.new(0) }}
    (0..@team_id.count).each do |i|
      coaches[@head_coach[i]][@game_id[i]&.slice(0..3)][:wins] += 1 if @result[i] == 'WIN'
      coaches[@head_coach[i]][@game_id[i]&.slice(0..3)][:games] += 1
    end
    worst_record = 1
    worst_coach = nil
    coaches.each do |coach, szns|
      record = szns[season.slice(0..3)][:wins]&.fdiv(szns[season.slice(0..3)][:games])
      if record < worst_record
        worst_record = record
        worst_coach = coach
      end
    end
    worst_coach
  end

  def least_accurate_team(season)
    teams = Hash.new { |h, k| h[k] = Hash.new{ |h, k|h[k] = Hash.new(0) }}
    (0..@team_id.count).each do |i|
      teams[@team_id[i]][@game_id[i]&.slice(0..3)][:shots] += @shots[i].to_i
      teams[@team_id[i]][@game_id[i]&.slice(0..3)][:goals] += @goals[i].to_i
    end
    worst_ratio = 0
    worst_team = nil
    teams.each do |team, szns|
      ratio = szns[season.slice(0..3)][:shots]&.fdiv(szns[season.slice(0..3)][:goals])
      if ratio > worst_ratio
        worst_ratio = ratio
        worst_team = team
      end
    end
    worst_team
  end

  def least_accurate_team(season)
    teams = Hash.new { |h, k| h[k] = Hash.new{ |h, k|h[k] = Hash.new(0) }}
    (0..@team_id.count).each do |i|
      teams[@team_id[i]][@game_id[i]&.slice(0..3)][:shots] += @shots[i].to_i
      teams[@team_id[i]][@game_id[i]&.slice(0..3)][:goals] += @goals[i].to_i
    end
    worst_ratio = 0
    worst_team = nil
    teams.each do |team, szns|
      ratio = szns[season.slice(0..3)][:shots]&.fdiv(szns[season.slice(0..3)][:goals])
      if ratio > worst_ratio
        worst_ratio = ratio
        worst_team = team
      end
    end
    worst_team
  end

  def most_accurate_team(season)
    teams = Hash.new { |h, k| h[k] = Hash.new{ |h, k|h[k] = Hash.new(0) }}
    (0..@team_id.count).each do |i|
      teams[@team_id[i]][@game_id[i]&.slice(0..3)][:shots] += @shots[i].to_i
      teams[@team_id[i]][@game_id[i]&.slice(0..3)][:goals] += @goals[i].to_i
    end
    best_ratio = 9
    best_team = nil
    teams.each do |team, szns|
      ratio = szns[season.slice(0..3)][:shots]&.fdiv(szns[season.slice(0..3)][:goals])
      if ratio < best_ratio
        best_ratio = ratio
        best_team = team
      end
    end
    best_team
  end

  def most_tackles(season)
    teams = Hash.new { |h, k| h[k] = Hash.new(0)}
    (0..@team_id.count).each do |i|
      teams[@team_id[i]][@game_id[i]&.slice(0..3)] += @tackles[i].to_i
    end
    best_team = nil
    most_tackles = 0
    teams.each do |team, szns|
      tackles = szns[season.slice(0..3)]
      if most_tackles < tackles
        most_tackles = tackles
        best_team = team
      end
    end
    best_team
  end

  def least_tackles(season)
    teams = Hash.new { |h, k| h[k] = Hash.new(0)}
    (0..@team_id.count).each do |i|
      teams[@team_id[i]][@game_id[i]&.slice(0..3)] += @tackles[i].to_i
    end
    worst_team = nil
    least_tackles = 5000
    teams.each do |team, szns|
      tackles = szns[season.slice(0..3)]
      if least_tackles > tackles && tackles > 0
        least_tackles = tackles
        worst_team = team
      end
    end
    worst_team
  end
end