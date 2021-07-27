require './lib/stat_tracker'


RSpec.describe StatTracker do
  context '#initialize' do
    it 'exists' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.new(locations)

      expect(stat_tracker).to be_a StatTracker
    end

    it 'accepts data' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.games[0].game_id).to eq(2012030221)
      expect(stat_tracker.teams[0].team_id).to eq(1)
      expect(stat_tracker.game_teams[0].game_id).to eq(2012030221)
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  context "Game stat methods" do
    it '#highest_total_score' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.highest_total_score).to eq(5)
    end

    it '#lowest_total_score' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.lowest_total_score).to eq(1)
    end

    it '#percentage_home_wins' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.percentage_home_wins).to eq(0.60)
    end

    it '#percentage_visitor_wins' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.percentage_visitor_wins).to eq(0.40)
    end

    it '#percentage_ties' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.percentage_ties).to eq(0.0)
    end

    it '#count_of_games_by_season' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.count_of_games_by_season).to eq({"20122013" => 10})
    end

    it '#average_goals_per_game' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.average_goals_per_game).to eq(3.70)
    end

    it '#average_goals_by_season' do
      game_path = './data/games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.average_goals_by_season).to eq({"20122013" => 3.70})
    end
  end
end
