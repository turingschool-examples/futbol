require 'csv'
require 'spec_helper.rb'

RSpec.describe TeamStats do
  let(:game_path) { './data/games_fixture.csv' }
  let(:team_path) { './data/teams_fixture.csv' }
  let(:game_teams_path) { './data/game_teams_fixture.csv' }
  let(:locations) do 
    {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  let(:teamstats) {TeamStats.new(locations)}
#   describe "Team Statistics" do
#     it "#team_info" do
#       expect(teamstats.team_info("6")).to eq({
#         "team_id"=> "6", 
#         "franchise_id"=> "6", 
#         "team_name"=> "FC Dallas", 
#         "abbreviation"=> "DAL", 
#         "link"=> "/api/v1/teams/6"
#       })
#     end

#   it "#best_season" do 
#     game_path = './data/games.csv'
#     team_path = './data/teams_fixture.csv'
#     game_teams_path = './data/game_teams_fixture.csv' 
#     locations = 
#       {
#       games: game_path,
#       teams: team_path,
#       game_teams: game_teams_path
#       }
    
#     stat_tracker = StatTracker.from_csv(locations) 
#     teamstats = TeamStats.new(locations)
#     expect(teamstats.best_season("6")).to eq("20122013")
#     expect(teamstats.best_season("3")).to eq("20142014").or(eq("20162017"))
#   end

#   it "#worst_season" do 
#     game_path = './data/games.csv'
#     team_path = './data/teams_fixture.csv'
#     game_teams_path = './data/game_teams_fixture.csv' 
#     locations = 
#       {
#       games: game_path,
#       teams: team_path,
#       game_teams: game_teams_path
#       }

#     stat_tracker = StatTracker.from_csv(locations) 
#     teamstats = TeamStats.new(locations)
#     expect(teamstats.worst_season("6")).to eq("20132014")
#     expect(teamstats.worst_season("3")).to eq("20122013").or(eq("20172018")).or(eq("20152016"))
#   end

#   it "#average_win_percentage" do
#   game_path = './data/games.csv'
#   team_path = './data/teams_fixture.csv'
#   game_teams_path = './data/game_teams_fixture.csv' 
#   locations = 
#     {
#     games: game_path,
#     teams: team_path,
#     game_teams: game_teams_path
#     }
  
#     stat_tracker = StatTracker.from_csv(locations) 
#     teamstats = TeamStats.new(locations)
#   expect(teamstats.average_win_percentage("3")).to eq(0.39)
#   expect(teamstats.average_win_percentage("6")).to eq(0.67)
# end

#   it "#most_goals_scored" do
#     expect(teamstats.most_goals_scored("3")).to eq(5)
#     expect(teamstats.most_goals_scored("6")).to eq(4)
#   end

#   it "#fewest_goals_scored" do
#     expect(teamstats.fewest_goals_scored("3")).to eq(0)
#     expect(teamstats.fewest_goals_scored("6")).to eq(1)
#   end

  it "#favorite_opponent" do
    game_path = './data/games.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv' 
    locations = 
      {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    
    stat_tracker = StatTracker.from_csv(locations) 
    teamstats = TeamStats.new(locations)
    expect(teamstats.favorite_opponent("3")).to eq("DC United").or(eq("Real Salt Lake"))
    expect(teamstats.favorite_opponent("6")).to eq("Houston Dynamo").or(eq("DC United")).or(eq("New York City FC"))
  end

  # it "#rival" do
  #   game_path = './data/games.csv'
  #   team_path = './data/teams_fixture.csv'
  #   game_teams_path = './data/game_teams_fixture.csv' 
  #   locations = 
  #     {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #     }
    
  #   stat_tracker = StatTracker.from_csv(locations) 
  #   teamstats = TeamStats.new(locations)
    

  #   expect(teamstats.rival("3")).to eq("FC Dallas").or(eq("Orlando Pride")).or(eq("Los Angeles FC")).or(eq("Seattle Sounders FC"))
  #   expect(teamstats.rival("6")).to eq("Sporting Kansas City").or(eq("Philadelphia Union")).or(eq("Utah Royals FC"))
  # end


  it "finds all the game teams for that team_id" do 
    gameteam1 = double("Game 1")
    gameteam2 = double("Game2")
    gameteam3 = double("Game3")

    allow(gameteam1).to receive(:team_id).and_return("8")
    allow(gameteam2).to receive(:team_id).and_return("12")
    allow(gameteam3).to receive(:team_id).and_return("8")
    
    allow(teamstats).to receive(:game_teams).and_return([gameteam1, gameteam2, gameteam3])
    
    expect(teamstats.find_relevant_game_teams_by_teamid("8")).to eq([gameteam1, gameteam3])

    end 

  xit "finds all the games that are associated with that gameteam" do 

    gameteam1 = double("GameTeam1")
    gameteam3 = double("GameTeam3")
    game1 = double("Game1")
    game3 = double("Game3")

    allow(game1).to receive(:game_id).and_return(2334)
    allow(game3).to receive(:game_id).and_return(1111)

    allow(gameteam3).to receive(:game_id).and_return(1898)
    allow(gameteam1).to receive(:game_id).and_return(2334)
    
    relevant_game_teams = [gameteam1, gameteam3]

    allow(teamstats).to receive(:games).and_return([game1, game3])

    expect(teamstats.find_corresponding_games_by_gameteam(relevant_game_teams)).to eq([game1])
  
  end 

    it "creates an array of the number of goals scored in each game" do 

      game1 = double("Game1")
      game2 = double("Game2")

      allow(game1).to receive(:goals).and_return(3)
      allow(game2).to receive(:goals).and_return(0)

      relevant_games = [game1, game2]

      expect(teamstats.create_goals_array(relevant_games)).to match_array([3, 0])
    end

    it "takes a hash with seasons as keys and win/losses listed in an array as value and returns an array with win percentages as the 1st element and the season as the second element" do 
      hash1 = {"2012" => ["WIN", "LOSS", "WIN"], "2013" => ["LOSS"]}
  
      hash_seasons = hash1

      expect(teamstats.order_list(hash_seasons)).to eq(
        [[0.6667, "2012"], [0.0, "2013"]]
      )
    end

    it "determines the average win percentage based on the amount of victories divided by total games" do 

      game1 = double("game1")
      game2 = double("game2")
      game3 = double("game3")
      game4 = double("game4")

      allow(game1).to receive(:result).and_return("WIN")
      allow(game2).to receive(:result).and_return("LOSS")
      allow(game3).to receive(:result).and_return("LOSS")
      allow(game4).to receive(:result).and_return("WIN")


      allow(teamstats).to receive(:find_relevant_game_teams_by_teamid).and_return([game1, game2, game3, game4])

      expect(teamstats.average_win_percentage("6")).to eq(0.50)
    end

    it "when provided with a list of game teams, this method will return the corresponding games with the same game_id" do 

      game1 = double("game1")
      game2 = double("game2")
      game3 = double("game3")

      gameteam1 = double("gameteam1")
      gameteam2 = double("gameteam2")
      gameteam3 = double("gameteam3")

      allow(game1).to receive(:game_id).and_return(25)
      allow(game2).to receive(:game_id).and_return(26)
      allow(game3).to receive(:game_id).and_return(27)

      allow(gameteam1).to receive(:game_id).and_return(30)
      allow(gameteam2).to receive(:game_id).and_return(45)
      allow(gameteam3).to receive(:game_id).and_return(26)

      allow(teamstats).to receive(:games).and_return([game1, game2, game3])

      relevant_game_teams = [gameteam1, gameteam2, gameteam3]

      expect(teamstats.find_relevant_games_based_on_game_teams(relevant_game_teams)).to eq([game2])
  end 

  it "when input with a game and the list of various game_teams that have been filtered by team_id so as to prevent duplicates, it returns the result of the game_team (what happened in the game)" do 

    gamearg = double("game")
    allow(gamearg).to receive(:game_id).and_return(25)

    gameteam1 = double("gameteam1")
    gameteam2 = double("gameteam2")
    gameteam3 = double("gameteam3")

    allow(gameteam1).to receive(:game_id).and_return(30)
    allow(gameteam2).to receive(:game_id).and_return(45)
    allow(gameteam3).to receive(:game_id).and_return(25)

    allow(gameteam1).to receive(:result).and_return("LOSS")
    allow(gameteam2).to receive(:result).and_return("LOSS")
    allow(gameteam3).to receive(:result).and_return("WIN")
    
    game = gamearg
    relevant_game_teams = [gameteam1, gameteam2, gameteam3]

    expect(teamstats.determine_game_outcome(game, relevant_game_teams)).to eq("WIN")

  end



  # end 
end 