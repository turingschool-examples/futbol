require 'rspec'
require 'pry'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  context "Initialize" do
    describe "#initialize" do
      it "exists" do
        tracker = StatTracker.new('file input 1', 'file input 2', 'file input 3')
        expect(tracker).to be_a(StatTracker)
      end

      it "has readable attributes" do
        tracker = StatTracker.new('file input 1', 'file input 2', 'file input 3')

        expect(tracker.games).to eq('file input 1')
        expect(tracker.teams).to eq('file input 2')
        expect(tracker.game_teams).to eq('file input 3')
      end
    end
  end

  context "Game Statistics" do
    it "#highest_total_score" do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    it "#lowest_total_score" do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end

    it "#helper total_games" do
      expect(@stat_tracker.total_games).to eq 7441
    end

    it "#percentage_home_wins" do
      expect(@stat_tracker.percentage_home_wins).to eq 0.44
    end

    it "#percentage_visitor_wins" do
      expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
    end

    it "#percentage_ties" do
      expect(@stat_tracker.percentage_ties).to eq 0.20
    end

    it "#count_of_games_by_season" do
    expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end

    it "#average_goals_per_game" do
      expect(@stat_tracker.average_goals_per_game).to eq 4.22
    end

    it "#helper total_goals_per_season" do
      expected = {
        "20122013"=>3322.0,
        "20162017"=>5565.0,
        "20142015"=>5461.0,
        "20152016"=>5499.0,
        "20132014"=>5547.0,
        "20172018"=>6019.0
      }
      expect(@stat_tracker.total_goals_per_season).to eq(expected)
    end

    it "#average_goals_by_season" do
      expected = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      }
      expect(@stat_tracker.average_goals_by_season).to eq expected
    end
  end

  context "League Statistics" do
    it "#helper avg_goals_per_game" do
      expect(@stat_tracker.avg_goals_per_game).to be_a(Array)
    end

    it "#helper away_games_by_team_id" do
      expect(@stat_tracker.away_games_by_team_id.length).to eq(@stat_tracker.teams.length)
      expect(@stat_tracker.away_games_by_team_id).to be_a(Hash)
    end

    it "#helper home_games_by_team_id" do
      expect(@stat_tracker.home_games_by_team_id.length).to eq(@stat_tracker.teams.length)
      expect(@stat_tracker.home_games_by_team_id).to be_a(Hash)
    end

    it "#helper average_scores_for_all_visitors" do
      expect(@stat_tracker.average_scores_for_all_visitors.length).to eq(@stat_tracker.teams.length)
      expect(@stat_tracker.average_scores_for_all_visitors).to be_a(Hash)
    end

    it "#helper average_scores_for_all_home_teams" do
      expect(@stat_tracker.average_scores_for_all_home_teams.length).to eq(@stat_tracker.teams.length)
      expect(@stat_tracker.average_scores_for_all_home_teams).to be_a(Hash)
    end
  end

  context "Season Statistics" do
    it "#helper season_game_teams" do
      expect(@stat_tracker.season_game_teams("20132014")).to be_a(Array)
      expect(@stat_tracker.season_game_teams("20132014")[0]).to be_a(CSV::Row)
    end

    it "#helper game_wins_by_season" do
      expect(@stat_tracker.game_wins_by_season("20132014")).to be_a(Array)
    end

    it "#helper total_games_by_coaches_by_season" do
      expect(@stat_tracker.total_games_by_coaches_by_season("20132014")[0]).to be_a(CSV::Row)
    end

    it "#helper coach_stats_by_season" do
      expect(@stat_tracker.coach_stats_by_season("20132014")).to be_a(Hash)
    end

    it "#winningest_coach" do
      allow(@stat_tracker).to receive(:games_by_season).and_return(:games_by_season_save)
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    it "#worst_coach" do
      allow(@stat_tracker).to receive(:games_by_season).and_return(:games_by_season_save)
      expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end

    it "#helper season_shots_to_goals" do
      expect(@stat_tracker.season_shots_to_goals("20132014")).to be_a(Hash)
    end

    it "#most_accurate_team" do
      expect(@stat_tracker.most_accurate_team("20132014")).to eq("Real Salt Lake")
      expect(@stat_tracker.most_accurate_team("20142015")).to eq("Toronto FC")
    end

    it "#least_accurate_team" do
      expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
      expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end

    it "#helper games_by_season" do
      expect(@stat_tracker.games_by_season.keys).to eq(@stat_tracker.games[:season].uniq)
    end

    it "#helper tackles_by_team" do
      # Team_id 53 & 54 not in this season.
      expect(@stat_tracker.tackles_by_team("20122013").keys.length).to eq(30)
    end

    it "#most_tackles" do
      allow(@stat_tracker).to receive(:games_by_season).and_return(:games_by_season_save)
      expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it "#fewest_tackles" do
      allow(@stat_tracker).to receive(:games_by_season).and_return(:games_by_season_save)
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end

  context "Team Statistics" do
    it "#helper games_by_team_by_season" do
      expect(@stat_tracker.games_by_team_by_season("6").keys.length).to eq(6)
    end

    it "#helper games_by_team" do
      expect(@stat_tracker.games_by_team.keys.length).to eq(@stat_tracker.teams[:team_id].length)
    end

    it "#helper team_games_opponents" do
      expect(@stat_tracker.team_games_opponents("18")).to be_a(Hash)
    end

    it "#helper opponent_win_loss" do
      expect(@stat_tracker.opponent_win_loss("18").size).to eq(31)
      expect(@stat_tracker.opponent_win_loss("18")["14"]).to eq([0, 8])
    end
  end
end
