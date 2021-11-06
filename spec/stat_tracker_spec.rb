require 'simplecov'

SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require './lib/tg_stat'
require './lib/creator'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'

RSpec.describe StatTracker do
  let!(:game_path)       {'./spec/fixtures/spec_games.csv'}
  let!(:team_path)       {'./spec/fixtures/spec_teams.csv'}
  let!(:game_teams_path) {'./spec/fixtures/spec_game_teams.csv'}
  let!(:locations)       { {
                            games: game_path,
                            teams: team_path,
                            game_teams: game_teams_path
                            } }
  let!(:stattracker)     { StatTracker.from_csv(locations) }

  it "attributes" do
    expect(stattracker.game_data).to eq(CSV.read(locations[:games], headers: true, header_converters: :symbol))
    expect(stattracker.team_data).to eq(CSV.read(locations[:teams], headers: true, header_converters: :symbol))
    expect(stattracker.game_team_data).to eq(CSV.read(locations[:game_teams], headers: true, header_converters: :symbol))
  end

  it "self from csv and initialize" do
    expect(stattracker).to be_a(StatTracker)
  end

  # these will be in the league stat class spec
  describe "League Stats" do
    it "league count_of_teams" do
      expect(stattracker.count_of_teams).to eq(32)
    end

    it "best offense" do
      expect(stattracker.best_offense).to eq("FC Dallas")
    end
  end


  describe 'TeamStats' do
    describe '#team_info' do
      it "returns the info for each team" do
        expected = {
          "team_id" => "18",
          "franchise_id" => "34",
          "team_name" => "Minnesota United FC",
          "abbreviation" => "MIN",
          "link" => "/api/v1/teams/18"
        }
        expect(stattracker.team_info("18")).to eq expected
      end
    end
    describe '#best_season' do
      it "returns the best season for the team id given" do
        expect(stattracker.best_season("6")).to eq "20122013"
      end
    end

    describe '#worst_season' do
      it "returns the worst season for the team id given" do
        expect(stattracker.worst_season("3")).to eq "20122013"
      end
    end

    describe '#average_win_percentage' do
      it "returns the average win/loss percentage for the team id given" do
        expect(stattracker.average_win_percentage("6")).to eq 100.0
      end
    end

    describe '#least_goals_scored' do
      it "returns the least goals scored for the team id given" do
        expect(stattracker.fewest_goals_scored("6")).to eq 1
      end
    end

    describe '#favorite_opponent' do
      it "returns the team name that has the most losses against the team id given" do
        expect(stattracker.favorite_opponent("6")).to eq "Houston Dynamo"
      end
    end

    describe '#rival' do
      it "returns the team name that has the most wins against the team id given" do
        expect(stattracker.rival("5")).to eq "FC Dallas"
      end
    end
  end
end
