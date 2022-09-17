# require 'rspec'
require './lib/stat_tracker'

RSpec.describe TeamStatistics do
  before(:all) do
    game_path = './data/dummy_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#team_info' do
    it 'returns a hash of the team info' do
      expect(@stat_tracker.team_info('18')).to eq({
        "team_id" => "18",
        "franchise_id" => "34",
        "team_name" => "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
      })
    end
  end

  describe '#total_wins_per_season' do
    it 'returns total wins a specific team had during a season' do
      expect(@stat_tracker.total_wins_per_season('6')).to eq({"20122013"=>2})
    end
  end

  describe '#total_games_played_per_season' do
    it 'returns total games a specific team played during a season' do
        expect(@stat_tracker.total_games_played_per_season('6')).to eq({"20122013"=>4})
    end
  end

  describe '#calculate_percentages' do
    it 'returns a hash of the winning percentages for each team against a specific team' do
      expect(@stat_tracker.calculate_percentages('6')).to eq({"20122013"=>0.5})
    end
  end

  describe '#best_season' do
    it 'returns the season with the highest win percentage for a team' do
      expect(@stat_tracker.best_season('6')).to eq("20122013")
    end
  end

  describe '#worst_season' do
    it 'returns the season with the lowest win percentage for a team' do
      expect(@stat_tracker.worst_season('6')).to eq("20122013")
    end
  end

  describe '#average_win_percentage' do
    it 'returns the average win percentage of all games for a team' do
      expect(@stat_tracker.average_win_percentage('6')).to eq(0.5)
    end
  end

  describe '#most_goals_scored' do
    it 'returns the highest number of goals a particular team has scored in a single game' do
      expect(@stat_tracker.most_goals_scored('8')).to eq(3)
    end
  end

  describe '#fewest_goals_scored' do
    it "returns the lowest number of goals a particular team has scored in a single game" do
      expect(@stat_tracker.fewest_goals_scored('16')).to eq(0)
    end
  end

  describe '#total_times_won_against' do
    it 'returns a hash with the total times each team won against a specific team' do
      expect(@stat_tracker.total_times_won_against('6')).to eq({3=>2})
    end
  end

  describe '#total_times_played_against' do
    it 'returns a hash with the total times each time played against a specific team' do
      expect(@stat_tracker.total_times_played_against('6')).to eq({3=>4})
    end
  end

  describe '#favorite_opponent' do
    it 'returns the name of the opponenet that has the lowest win percentage against the given team' do
      expect(@stat_tracker.favorite_opponent('6')).to eq("Houston Dynamo")
    end
  end

  describe '#rival' do
    it 'returns the name of the opponent that has the highest win percentage against the given team' do
      expect(@stat_tracker.rival('6')).to eq('Houston Dynamo')
    end
  end
end
