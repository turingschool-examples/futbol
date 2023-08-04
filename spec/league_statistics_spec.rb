require "spec_helper"

RSpec.describe LeagueStatistics do 
 before(:each) do
      @game_path = './fixture/games_fixture.csv'
      @team_path = './data/teams.csv'
      @game_teams_path = './fixture/game_teams_fixture.csv'
  @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    
    @league =LeagueStatistics.new(@locations)
  end

  it "can show total number of teams" do 
   
    expect(@league.count_of_teams).to eq(32)
  end

  it "can show the name of the team with the highest average number of goals scored per game across all seasons " do 

    expect(@league.best_offense).to eq("FC Dallas")
  end

  it " can show name of the team with the lowest average number of goals scored per game across all seasons." do

     expect(@league.worst_offense_team).to eq("Sporting Kansas City")
  end 
end  
 