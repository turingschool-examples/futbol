class StatTracker
  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end

  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

  def count_of_teams
    Team.all.count
  end

  def best_offense
    teams = change_data_to_array(Team)
    games = change_data_to_array(Game)

    best_team = teams.max_by do |team|
      games_with_team = games.select do |game|
        game.home_team_id == team.team_id || game.away_team_id == team.team_id
      end
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.home_goals : game.away_goals
        end
        total_score / games_with_team.count
      else
        0
      end
    end
    best_team.team_name
  end

  def change_data_to_array(data_class)
    data_class.all.values
  end

end
