class GamesTeamsCollection
  attr_reader :games_teams

  def initialize(games_teams_path)
    @games_teams = generate_objects_from_csv(games_teams_path)
  end

  def generate_objects_from_csv(csv_file_path)
    objects = []
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row_object|
      objects << GameTeam.new(row_object)
    end
    objects
  end

  def total_home_games
    @games_teams.count do |game_team|
      game_team.hoa == 'home'
    end
  end

  def total_home_wins
    @games_teams.count do |game_team|
      game_team.hoa == 'home' && game_team.result == 'WIN'
    end
  end

  def percentage_home_wins
    ((total_home_wins / total_home_games.to_f) * 100).round(2)
  end

  def total_away_games
    @games_teams.count do |game_team|
      game_team.hoa == 'away'
    end
  end

  def total_away_wins
    @games_teams.count do |game_team|
      game_team.hoa == 'away' && game_team.result == 'WIN'
    end
  end

  def percentage_visitor_wins
    ((total_away_wins / total_away_games.to_f) * 100).round(2)
  end

  def total_ties
    @games_teams.count do |game_team|
      game_team.result == 'TIE'
    end
  end

  def percentage_ties
    ((total_ties.to_f / @games_teams.count) * 100).round(2)
  end

  def max_goals
    @games_teams.map {|game_team| game_team.goals.to_i}.max
  end

  def min_goals
    @games_teams.map {|game_team| game_team.goals.to_i}.min
  end

  def biggest_blowout
    max_goals - min_goals
  end

  def find_by(element, attribute)
    @games_teams.find_all do |game_team|
      game_team.send(attribute) == element
    end
  end

  def total_found_in(element, attribute)
    find_by(element, attribute).length
  end

  def total_wins_of_team(team_id)
    
  end

  def team_win_percentage(team_id)

  end
end
