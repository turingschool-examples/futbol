require "./lib/stat_daddy"
require "csv"
require "pry"

class SeasonStats < StatDaddy
  def winningest_coach(season)
    coach_wins = Hash.new(0)
    coach_games = Hash.new(0)
  end

  def worst_coach(season)
  end

  def most_accurate_team(season)
    # Name of the Team with the best ratio of shots to goals for the season
  end

  def least_accurate_team(season)
    # Name of the Team with the worst ratio of shots to goals for the season
  end

  # this tackles method works if you run rspec but this now needs to have the
  # tackles team string like "5" (look at the #most_tackles spec tests) return the name of the team
  # the name of the team is in the teams.csv so we have to call in to that
  # something like comparing @team.team_id
  # and then replacing the instance of @game_teams.team_id to @team.team_name

  # either way, this method can be used for both methods below eventually, just have to
  # flesh out what that means for each season as well.
  # season is only listed in the games.csv so something like @game.season to compile
  # each seasons and then compare somehow the seasons with the game_id instances in
  # both @game and @game_teams.
  def tackles
    tackles_total = Hash.new(0)
    @game_teams.each do |data|
      team_id = data.team_id
      tackles = data.tackles.to_i
      tackles_total[team_id] += tackles
    end
    tackles_total
  end

  # Name of the Team with the most tackles in the season
  def most_tackles
    team_tackles = []
    tackles
    @team_goals.each do |team_id, tackles|
      puts "Team ID #{team_id}: Total Tackles - #{tackles}"
    end
  end

  def fewest_tackles(season)
    @games_teams_fixture_path.each do |data|
      # Name of the Team with the fewest tackles in the season
    end
  end
end
