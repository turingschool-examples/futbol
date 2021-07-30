require 'spec_helper'

RSpec.describe GameTeamsManager do
  context 'game_teams_manager' do

    game_teams_manager = GameTeamsManager.new('./data/mini_game_teams.csv')

    it "has attributes" do
      expect(game_teams_manager.game_teams).not_to be_empty
    end

    it 'makes games' do
      expect(game_teams_manager).to respond_to(:make_game_teams)
    end

    it 'has winningest coach' do
      expect(game_teams_manager.winningest_coach("20142015")).to eq('Alain Vigneault')
    end

    it 'has worst coach' do
      expect(game_teams_manager.worst_coach("20142015")).to eq("Mike Johnston")
    end

    it 'coach win percentage per coach' do
      expected = {
        "Mike Johnston"=>0.0,
        "Alain Vigneault"=>0.7272727272727273,
        "Jon Cooper"=>0.6
      }
      expect(game_teams_manager.coach_win_pct("20142015")).to eq(expected)
    end

    it 'counts coach wins by season' do
      expected = {
        "Mike Johnston"=>{:wins=>0, :total=>5},
        "Alain Vigneault"=>{:wins=>8, :total=>11},
        "Jon Cooper"=>{:wins=>3, :total=>5}
      }
      expect(game_teams_manager.coach_wins("20142015")).to eq(expected)
    end

    it 'gets accuracy data' do
      expected = {
        "5"=>{:goals=>6, :shots=>31},
        "3"=>{:goals=>26, :shots=>79},
        "14"=>{:goals=>12, :shots=>36}
      }
      expect(game_teams_manager.get_accuracy_data("20142015")).to eq(expected)
    end

    it 'gets accuracy average' do
      expected = {
        "5"=>0.1935483870967742,
        "3"=>0.3291139240506329,
        "14"=>0.3333333333333333
      }
      expect(game_teams_manager.get_accuracy_average("20142015")).to eq(expected)
    end

    it "has most accurate and least accurate teams" do
      expect(game_teams_manager.most_accurate_team("20132014")).to eq("16")
      expect(game_teams_manager.least_accurate_team("20132014")).to eq("19")
    end

    it 'names the team with the most and fewest tackles' do
      expect(game_teams_manager.team_tackles("20142015")).to eq({"14"=>146, "3"=>349, "5"=>152})
      expect(game_teams_manager.most_tackles("20142015")).to eq("3")
      expect(game_teams_manager.fewest_tackles("20142015")).to eq("14")
    end

    it 'highest scoring vistor and home team' do
      expect(game_teams_manager.highest_scoring_visitor).to eq("28")
      # expect(stat_tracker.highest_scoring_home_team).to eq("Real Salt Lake")
    end

    it 'lowest scoring vistor and home team' do
      expect(game_teams_manager.lowest_scoring_visitor).to eq("4")
      # expect(stat_tracker.lowest_scoring_home_team).to eq("Houston Dash")
    end
  end
end
