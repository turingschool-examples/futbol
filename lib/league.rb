


def count_of_teams
  @teams.count
end

def best_offense
  team_id = averaging_hash.key(averaging_hash.values.max)
  team_name_from_id(team_id)
end
