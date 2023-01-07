require_relative 'spec_helper'

RSpec.describe StatTracker do
  let(:game_path) {'./spec/fixtures/games.csv'}
  let(:team_path) {'./spec/fixtures/teams.csv'}
  let(:game_teams_path) {'./spec/fixtures/game_teams.csv'}
  let(:locations) do
      {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    end

  let(:stat_tracker) { StatTracker.from_csv(locations) }
    
  it 'exists' do
      expect(StatTracker.from_csv(locations)).to be_an_instance_of(StatTracker)
  end

  describe '#highest_total_score' do
    it 'can get highest total score' do
      expect(stat_tracker.highest_total_score).to eq(7)
    end
  end

  describe '#lowest_total_score' do
    it 'can get lowest total score' do
      expect(stat_tracker.lowest_total_score).to eq(2)
    end
  end

  describe '#games_total_scores_array' do
    it 'returns array of total scores' do
      expect(stat_tracker.games_total_scores_array.first).to be_a(Integer)
      expect(stat_tracker.games_total_scores_array).to be_a(Array)
    end
  end

    it "#percentage_home_wins" do
    expect(stat_tracker.percentage_home_wins).to eq 0.40
    end

    it "#percentage_visitor_wins" do
        expect(stat_tracker.percentage_visitor_wins).to eq 0.50
    end

    it "#percentage_ties" do
        expect(stat_tracker.percentage_ties).to eq 0.10
    end

  describe '#average_goals_per_game or season' do
    it 'can find average goals per game' do
      expect(stat_tracker.average_goals_per_game).to eq(3.7)
    end

    it 'can find average goals by season' do
      expected_hash = 
      {
        "20132014" => 4.0,
        "20122013" => 3.33,
        "20162017" => 3.0,
        "20152016" => 4.0
      }

      expect(stat_tracker.average_goals_by_season).to eq(expected_hash)
    end
  end

  describe '#count_of_teams' do
    it 'returns total number of teams in data' do
      expect(stat_tracker.count_of_teams).to eq(12)
    end
  end

  describe '#count_of_games_by_season' do
    it '#count_of_games_by_season' do
      expected = {
        "20132014"=>3,
        "20122013"=>3,
        "20162017"=>1,
        "20152016"=>3,
      }
      expect(stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end

  describe '#highest_ and lowest_scoring_visitor' do
    it 'can find highest scoring visitor' do
      expect(stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end

    it 'can find lowest scoring visitor' do
      expect(stat_tracker.lowest_scoring_visitor).to eq("LA Galaxy").or(eq("FC Cincinnati"))
    end
  end

  describe '#highest_ and lowest_scoring_home_team' do
    it 'can find highest scoring home team' do
      expect(stat_tracker.highest_scoring_home_team).to eq("North Carolina Courage")
    end

    it 'can find the lowest scoring home team' do
      expect(stat_tracker.lowest_scoring_home_team).to eq("FC Dallas").or(eq("Minnesota United FC")).or(eq("Montreal Impact"))
    end
  end

  describe '#most_tackles and #fewest_tackles' do
    it 'can find most_tackles' do

    expect(stat_tracker.most_tackles("20132014")).to eq("North Carolina Courage")
    end

    it 'can find fewest_tackles' do
      expect(stat_tracker.fewest_tackles("20132014")).to eq("FC Cincinnati")
    end
  end

  describe '#average_win_percentage' do
    it 'can find average_win_percentage for a team' do
      expect(stat_tracker.average_win_percentage("6")).to eq(0.33)
    end
  end

  describe 'best and worst offense' do
    it 'can find best_offense' do
      expect(stat_tracker.best_offense).to eq("North Carolina Courage")
    end

    it 'can find the worst_offense' do
      expect(stat_tracker.worst_offense).to eq("FC Cincinnati")
    end
  end

  describe '#winningest_coach' do
    it 'can return the coach with the best win percentage for a season' do
      expect(stat_tracker.winningest_coach("20152016")).to eq("Michel Therrien")
    end
  end

  describe '#worst_coach' do
    it 'can return the coach with the worst win percentage for a season' do
      expect(stat_tracker.worst_coach("20152016")).to eq("Jeff Blashill")
    end
  end

  describe '#best_season' do
    it 'can return the best season for a team' do
      expect(stat_tracker.best_season("6")).to eq("20122013")
    end
  end

  describe '#worst_season' do
    it 'can return the worst season for a team' do
      expect(stat_tracker.worst_season("6")).to eq("20152016")
    end
  end

  describe '#team_info' do
    it "can return team info" do
      expected = {
        "team_id" => "26",
        "franchise_id" => "14",
        "team_name" => "FC Cincinnati",
        "abbreviation" => "CIN",
        "link" => "/api/v1/teams/26"
      }

      expect(stat_tracker.team_info("26")).to eq(expected)
    end
  end


  it "#most_accurate_team" do
    expect(stat_tracker.most_accurate_team("20162017")).to eq ("Real Salt Lake")
    expect(stat_tracker.most_accurate_team("20122013")).to eq ("FC Dallas")
  end

  it "#least_accurate_team" do
    expect(stat_tracker.least_accurate_team("20162017")).to eq ("Montreal Impact")
    expect(stat_tracker.least_accurate_team("20122013")).to eq ("Seattle Sounders FC")
  end

  it "#most_goals_scored" do
    expect(stat_tracker.most_goals_scored("6")).to eq 4
  end

  it "#fewest_goals_scored" do
    expect(stat_tracker.fewest_goals_scored("6")).to eq 1
  end

  it "#favorite_opponent" do
    expect(stat_tracker.favorite_opponent("6")).to eq ("Sporting Kansas City")
  end

  it "#rival" do
    expect(stat_tracker.rival("6")).to eq("New York Red Bulls")
  end
end