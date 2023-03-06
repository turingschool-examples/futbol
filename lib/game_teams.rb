require_relative 'stat_book'

class GameTeams < StatBook
  def initialize(locations)
    super(locations[:game_teams])
  end

  def best_offense
    goals_counter.max_by{|_, v| v[:goals].fdiv(v[:games])}[0]
  end
  
  def worst_offense
    goals_counter.min_by{|_, v| v[:goals].fdiv(v[:games])}[0]
  end

  def highest_scoring_visitor
    goals_counter.max_by{|_, v| v[:away].fdiv(v[:games])}[0]
  end

  def lowest_scoring_visitor
    goals_counter.min_by{|_, v| v[:away].fdiv(v[:games])}[0]
  end

  def highest_scoring_home_team
    goals_counter.max_by{|_, v| v[:home].fdiv(v[:games])}[0]
  end

  def lowest_scoring_home_team
    goals_counter.min_by{|_, v| v[:home].fdiv(v[:games])}[0]
  end

  def most_tackles(season)
    tackle_checker(season)[:best_team]
  end

  def least_tackles(season)
    tackle_checker(season)[:worst_team]
  end

  def best_season(team)
    win_loss_checker(team)[:best_szn]
  end

  def worst_season(team)
    win_loss_checker(team)[:worst_szn]
  end

  def average_win_percentage(team)
    wins, games = 0, 0
    win_loss_counter[team].each do |_, szn|
      wins += szn[:wins]
      games += szn[:games]
    end
    wins.fdiv(games).round(2)
  end

  def most_goals_scored(team)
    goals_checker(team)[:most_goals]
  end

  def fewest_goals_scored(team)
    goals_checker(team)[:least_goals]
  end

  def winningest_coach(season)
    coaches = super_nested_hash
    (0..@game_id.count).each do |i|
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
    coaches = super_nested_hash
    (0..@game_id.count).each do |i|
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
    teams = super_nested_hash
    (0..@game_id.count).each do |i|
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
    teams = super_nested_hash
    (0..@game_id.count).each do |i|
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

  ## Helper Methods ##

  def nested_hash
    Hash.new { |h, k| h[k] = Hash.new(0)}
  end

  def super_nested_hash
    Hash.new { |h, k| h[k] = Hash.new{ |h, k| h[k] = Hash.new(0) }}
  end

  def tackle_counter(hash)
    (0..@game_id.count).each do |i|
      hash[@team_id[i]][@game_id[i]&.slice(0..3)] += @tackles[i].to_i
    end
    hash
  end

  def tackle_checker(season)
    teams = tackle_counter(nested_hash)
    best_team, worst_team = nil, nil
    most_tackles = 0
    least_tackles = 5000
    teams.each do |team, szns|
      tackles = szns[season.slice(0..3)]
      if least_tackles > tackles && tackles > 0
        least_tackles = tackles
        worst_team = team
      elsif most_tackles < tackles
        most_tackles = tackles
        best_team = team
      end
    end
    {:best_team => best_team, :worst_team => worst_team}
  end

  def goals_counter
    goals = nested_hash
    (0..@game_id.count).each do |i|
      goals[@team_id[i]][:goals] += @goals[i].to_i
      goals[@team_id[i]][:away] += @goals[i].to_i if @hoa[i] == 'away'
      goals[@team_id[i]][:home] += @goals[i].to_i if @hoa[i] == 'home'
      goals[@team_id[i]][:games] += 1
    end
    goals.delete(nil)
    goals
  end

  def win_loss_counter
    games = super_nested_hash
    (0..@game_id.count).each do |i|
      games[@team_id[i]][@game_id[i]&.slice(0..3)][:wins] += 1 if @result[i] == 'WIN'
      games[@team_id[i]][@game_id[i]&.slice(0..3)][:losses] += 1 if @result[i] == 'LOSS'
      games[@team_id[i]][@game_id[i]&.slice(0..3)][:games] += 1
    end
    games.delete(nil)
    games
  end

  def win_loss_checker(team)
    best_szn, worst_szn = nil, nil
    best_record, worst_record = 0, 1
    win_loss_counter[team].each do |szn, results|
      winpct = results[:wins].fdiv(results[:games])
      if winpct > best_record
        best_record = winpct
        best_szn = szn
      elsif winpct < worst_record
        worst_record = winpct
        worst_szn = szn
      end
    end
    {:best_szn => "#{best_szn}#{(best_szn.to_i + 1).to_s}", 
    :worst_szn => "#{worst_szn}#{(worst_szn.to_i + 1).to_s}"}
  end

  def goals_checker(team)
    most_goals, least_goals = 0, 10
    (0..@game_id.count).each do |i|
      if @team_id[i] == team 
        goals = @goals[i].to_i
        if goals > most_goals
          most_goals = goals
        elsif goals < least_goals
          least_goals = goals
        end
      end
    end
    {:most_goals => most_goals, :least_goals => least_goals}
  end
end