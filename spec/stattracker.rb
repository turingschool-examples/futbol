require './lib/stattracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'
games_fixture_path = './data/games_fixture.csv'
games_teams_fixture_path = './data/games_teams_fixture.csv'


locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path,
  games_fixture_path: games_fixture_path,
  games_teams_fixture_path: games_teams_fixture_path

}

stat_tracker = StatTracker.from_csv(locations)
RSpec.describe StatTracker do
  describe "#highest_total_score" do
    it "" do

    end
  end

  describe "#lowest_total_score" do
    it "" do
      
    end
  end

  describe "#percentage_home_wins" do
    it "" do
      
    end
  end

  describe "#percentage_visitor_wins" do
    it "" do
      
    end
  end

  describe "#percentage_ties" do
    it "" do
      
    end
  end

  describe "#count_of_games_by_season" do
    it "" do
      
    end
  end

  describe "#average_goals_per_game" do
    it "" do
      
    end
  end

  describe "#average_goals_by_season" do
    it "" do
      
    end
  end

  describe "#count_of_teams" do
    it "" do
      
    end
  end

  describe "#best_offense" do
    it "" do
      
    end
  end

  describe "#worst_offense" do
    it "" do
      
    end
  end

  describe "#highest_scoring_visitor" do
    it "" do
      
    end
  end

  describe "#highest_scoring_home_team" do
    it "" do
      
    end
  end

  describe "#lowest_scoring_visitor" do
    it "" do
      
    end
  end

  describe "#lowest_scoring_home_team" do
    it "" do
      
    end
  end

  describe "#winningest_coach" do
    it "" do
      
    end
  end

  describe "#worst_coach" do
    it "" do
      
    end
  end

  describe "#most_accurate_team" do
    it "" do
      
    end
  end

  describe "#least_accurate_team" do
    it "" do
      
    end
  end

  describe "#most_tackles" do
    it "" do
      
    end
  end

  describe "#fewest_tackles" do
    it "" do
      
    end
  end
end