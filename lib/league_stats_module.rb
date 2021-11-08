module LeagueEnumerables

  def average(numerator, denominator)
    (numerator.sum.to_f / denominator).round(2)
  end

  def convert_team_id_to_name(team_id_integer)
    name_array = []
    @team_data.each do |row|
      if row['team_id'].to_i == team_id_integer
        name_array << row['teamName']
      end
    end
    name_array[0]
  end

  def find_max(hash_name)
    hash_name.key(hash_name.values.max)
  end

  def find_min(hash_name)
    hash_name.key(hash_name.values.min)
  end

  def all_teams_away_ids(data)
    team_id = []
    data.each do |row|
      team_id << row['away_team_id'].to_i
    end
    team_id.uniq
  end

  def all_teams_home_ids(data)
    team_id = []
    data.each do |row|
      team_id << row['home_team_id'].to_i
    end
    team_id.uniq
  end

  def all_teams_ids(data)
    team_id = []
    data.each do |row|
      team_id << row['team_id'].to_i
    end
    team_id.uniq
  end
end
