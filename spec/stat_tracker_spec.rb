require_relative 'spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/fixture_game_teams.csv'

    @file_paths = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.new(@file_paths)
  end


  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@stat_tracker).to be_instance_of(StatTracker)
      expect(@stat_tracker.game_manager).to be_instance_of(GameManager)
      expect(@stat_tracker.team_manager).to be_instance_of(TeamManager)
      expect(@stat_tracker.game_team_manager).to be_instance_of(GameTeamManager)
    end
  end

  describe '.from_csv(file_paths)' do
    it 'returns instance of StatTracker' do
      stats = StatTracker.from_csv(@file_paths)
      expect(stats).to be_instance_of(StatTracker)
    end
  end

  describe '#highest_total_score' do
    it 'highest_total_score' do
      expect(@stat_tracker.highest_total_score).to eq(5)
    end
  end

  describe '#lowest_total_score' do
    it 'lowest_total_score' do
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe '#percentage_home_wins' do
    it 'percentage_home_wins' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.64)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'percentage_visitor_wins' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.33)
    end
  end

  describe '#percentage_ties' do
    it "percentage_ties" do
      expect(@stat_tracker.percentage_ties).to eq(0.03)
    end
  end

  describe '#count_of_games_by_season' do
    it "count_of_games_by_season" do
      expect(@stat_tracker.count_of_games_by_season).to eq({"20122013" => 39})
    end
  end

  describe '#average_goals_per_game' do
    it "average_goals_per_game" do
      expect(@stat_tracker.average_goals_per_game).to eq(3.87)
    end
  end

  describe '#average_goals_by_season' do
    it "average_goals_by_season" do
      expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>3.87})
    end
  end

  describe '#count_of_teams' do
    it 'counts all teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe '#best_offense' do
    it 'best_offense' do
      expect(@stat_tracker.best_offense).to eq("New York City FC")
    end
  end

  describe '#worst_offense' do
    it 'worst_offense' do
      expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
    end
  end

  describe '#highest_scoring_visitor' do
    it 'highest_scoring_visitor' do
      expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end
  end

  describe '#highest_scoring_home_team' do
    it 'highest_scoring_home_team' do
      expect(@stat_tracker.highest_scoring_home_team).to eq("New York City FC")
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'textlowest_scoring_visitor' do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'lowest_scoring_home_team' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
    end
  end

  describe '#team_info(team_id)' do
    it 'team_info by team_id' do
      expectation = {
        "team_id"=>"1",
        "franchise_id"=>"23",
        "team_name"=>"Atlanta United",
        "abbreviation"=>"ATL",
        "link"=>"/api/v1/teams/1"
      }

      expect(@stat_tracker.team_info("1")).to eq(expectation)
    end
  end

  describe '#best_season' do
    it "can return the best season from a given team" do
      expect(@stat_tracker.best_season("6")).to eq("20122013")
    end
  end

  describe '#worst_season' do
    it "can return the best season from a given team" do
      expect(@stat_tracker.worst_season("6")).to eq("20122013")
    end
  end

  describe '#average_win_percentage(team_id)' do
    it 'average_win_percentage by team_id' do
      expect(@stat_tracker.average_win_percentage("3")).to eq(0.00)
    end
  end

  describe '#most_goals_scored(team_id)' do
    it 'most_goals_scored by team_id' do
      expect(@stat_tracker.most_goals_scored("3")).to eq(2)
    end
  end

  describe '#fewest_goals_scored(team_id)' do
    it 'fewest_goals_scored by team_id' do
      expect(@stat_tracker.fewest_goals_scored("3")).to eq(1)
    end
  end

  describe '#favorite_opponent(team_id)' do
    it 'favorite_opponent(team_id)' do
      expect(@stat_tracker.favorite_opponent("3")).to eq("FC Dallas")
    end
  end

  describe '#rival(team_id)' do
    it 'rival by team_id' do
      expect(@stat_tracker.rival("3")).to eq("FC Dallas")
    end
  end

  describe '#winningest_coach(season)' do
    it "winningest_coach by season" do
      expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    end
  end

  describe '#worst_coach(season)' do
    it 'worst_coach by season' do
      expect(@stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
    end
  end

  describe '#most_accurate_team(season_id)' do
    it 'most_accurate_team by season_id' do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq("New York City FC")
    end
  end

  describe '#least_accurate_team(season_id)' do
    it 'least_accurate_team by season_id' do
      expect(@stat_tracker.least_accurate_team("20122013")).to eq("Sporting Kansas City")
    end
  end

  describe '#most_tackles(season_id)' do
    it 'most_tackles by season_id' do
      expect(@stat_tracker.most_tackles("20122013")).to eq("LA Galaxy")
    end
  end

  describe '#fewest_tackles(season_id)' do
    it 'fewest_tackles by season_id' do
      expect(@stat_tracker.fewest_tackles("20122013")).to eq("Sporting Kansas City")
    end
  end
end
