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

    it 'has winningest and worst coach' do
      expect(game_teams_manager.coach_results("20142015")[:max].call).to eq('Alain Vigneault')
      expect(game_teams_manager.coach_results("20142015")[:min].call).to eq("Mike Johnston")
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
      expect(game_teams_manager.accuracy_data("20142015")).to eq(expected)
    end

    it 'gets accuracy average' do
      input = {
        "5"=>{:goals=>6, :shots=>31},
        "3"=>{:goals=>26, :shots=>79},
        "14"=>{:goals=>12, :shots=>36}
      }
      expected = {
        "5"=>0.1935483870967742,
        "3"=>0.3291139240506329,
        "14"=>0.3333333333333333
      }
      expect(game_teams_manager.get_accuracy_avg(input)).to eq(expected)
    end

    it "has most accurate and least accurate teams" do
      expect(game_teams_manager.accuracy_results("20132014")[:max].call).to eq("16")
      expect(game_teams_manager.accuracy_results("20132014")[:min].call).to eq("19")
    end

    it 'names the team with the most and fewest tackles' do
      expect(game_teams_manager.team_tackles("20142015")).to eq({"14"=>146, "3"=>349, "5"=>152})
      expect(game_teams_manager.tackle_results("20142015")[:max].call).to eq("3")
      expect(game_teams_manager.tackle_results("20142015")[:min].call).to eq("14")
    end

    it 'has best and worst seasons' do
      expect(game_teams_manager.season_results("3")[:max].call).to eq("20142015")
      expect(game_teams_manager.season_results("15")[:min].call).to eq("20152016")
    end

    it 'has an average win percentage' do
      expect(game_teams_manager.average_win_percentage("15")).to eq(0.67)
    end

    it "can process a game" do
      game1 = double('game win')
      game2 = double('game loss')

      allow(game1).to receive(:won?).and_return(true)
      allow(game2).to receive(:won?).and_return(false)
      data1 = {wins: 0, total: 0}
      data2 = {wins: 0, total: 0}
      expected1 = {wins: 1, total: 1}
      expected2 = {wins: 0, total: 1}
      game_teams_manager.process_game(data1, game1)
      game_teams_manager.process_game(data2, game2)
      expect(data1).to eq(expected1)
      expect(data2).to eq(expected2)
    end

    it "gets seasons averages" do
      input = {
        "20142015" => {wins: 8, total: 11}
      }
      expect(game_teams_manager.season_avgs(input)).to eq([["20142015", 0.727272727272727273]])
    end

    it "gets seasons win count" do
      expect(game_teams_manager.seasons_win_count("3")).to eq({"20142015" => {wins: 8, total: 11}})
    end

    it "can get most and fewest number of goals" do
      expect(game_teams_manager.goal_results("3")[:max].call).to eq(5)
      expect(game_teams_manager.goal_results("3")[:min].call).to eq(0)
    end

    it "can get team goals" do
      expected = [2, 3, 2, 2, 2, 2, 2, 3, 3, 0, 5]

      expect(game_teams_manager.goals_per_team_game("3")).to eq(expected)
    end

    it 'has best and worse offense' do
      expect(game_teams_manager.offense_results[:max].call).to eq("28")
      expect(game_teams_manager.offense_results[:min].call).to eq("4")
    end

    it 'gets offense averages' do
      input = {
        "26"=>{:goals=>7, :total=>3},
        "28"=>{:goals=>8, :total=>3},
        "16"=>{:goals=>16, :total=>6},
        "19"=>{:goals=>10, :total=>6},
        "4"=>{:goals=>6, :total=>6},
        "15"=>{:goals=>10, :total=>6},
        "5"=>{:goals=>6, :total=>5},
        "3"=>{:goals=>26, :total=>11},
        "14"=>{:goals=>12, :total=>5}
       }
      expected = {
        "26" => 2.33,
        "28" => 2.67,
        "16" => 2.67,
        "19" => 1.67,
        "4" => 1.0,
        "15" => 1.67,
        "5" => 1.2,
        "3" => 2.36,
        "14" => 2.4
      }
      expect(game_teams_manager.get_offense_avgs(input)).to eq(expected)
    end

    it "percentage of home wins, away wins, and ties" do
      expect(game_teams_manager.percentage_hoa_wins(:home)).to eq(0.43)
      expect(game_teams_manager.percentage_hoa_wins(:away)).to eq(0.59)
    end

    it "has percentage ties" do
      expect(game_teams_manager.percentage_ties).to eq(0.0)
    end
  end
end
