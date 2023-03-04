require 'spec_helper'

RSpec.describe StatTracker do
  subject(:stat_tracker) { StatTracker.new(:futbol, DATA) }

  describe '#initialize' do
    it 'exists' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '::from_csv' do
    it 'instantiates the class' do
      expect(StatTracker.from_csv(LOCATIONS)).to be_a(StatTracker)
    end
  end

  describe '#league' do
    it 'has a league' do
      expect(stat_tracker.league).to be_a(League)
    end
  end

  describe '#team_tackles' do
    it 'returns a hash of the teams as keys and the amount of tackles in the season as the value' do
      expect(stat_tracker.team_tackles("20132014")).to be_a(Hash)
    end
  end

  describe '#most_tackles' do
    it 'can check the most tackles of a season' do
      expect(stat_tracker.most_tackles("20132014")).to eq("LA Galaxy")
      expect(stat_tracker.most_tackles("20122013")).to eq("Houston Dynamo")
    end
  end

  describe '#fewest_tackles' do
    it 'can check the fewest tackles of a season' do
      expect(stat_tracker.fewest_tackles("20132014")).to eq("Atlanta United")
      expect(stat_tracker.fewest_tackles("20122013")).to eq("Toronto FC")
    end
  end

  describe '#total_goals_per_game' do
    it 'can return an array of the total score for all games' do
      expect(stat_tracker.total_goals_per_game).to eq([5, 5, 3, 5, 4, 3, 5, 5, 6, 4, 3, 5, 5, 6, 4, 3, 6, 4, 3, 5, 6, 3, 4, 5, 1, 5, 6, 2, 5, 3, 4, 5, 4, 4, 4, 5, 3, 3])
    end
  end

  describe '#highest_total_score' do
    it 'can find the score of the highest scoring game' do
      expect(stat_tracker.highest_total_score).to eq(6)
    end
  end

  describe '#lowest_total_score' do
    it 'can find the total score of the lowest scoring game' do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe '#percentage_home_wins' do
    it 'can find the percentage of home wins' do
      expect(stat_tracker.percentage_home_wins).to eq(0.45)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'can find the percentage of visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.37)
    end
  end

  describe '#percentage_ties' do
    it 'can find the percentage of ties' do
      expect(stat_tracker.percentage_ties).to eq(0.18)
    end
  end

  describe '#wins_losses_by_coach' do
    it 'can return an array with all coaches total wins and losses' do
      expect(stat_tracker.wins_losses_by_coach("20132014")).to eq([{"John Tortorella"=>1, "Bruce Boudreau"=>1, "Adam Oates"=>1, "Claude Julien"=>1, "Dan Bylsma"=>1, "Todd McLellan"=>2, "Todd Richards"=>1, "Mike Babcock"=>1, "Peter Horachek"=>1, "Bob Hartley"=>1},
        {"Ken Hitchcock"=>1,
         "Craig Berube"=>1,
         "Todd Richards"=>1,
         "Mike Babcock"=>2,
         "Bruce Boudreau"=>1,
         "Barry Trotz"=>2,
         "Bob Hartley"=>2,
         "Jack Capuano"=>1,
         "Dallas Eakins"=>1,
         "Randy Carlyle"=>2,
         "Peter DeBoer"=>1}])

      expect(stat_tracker.wins_losses_by_coach("20122013")).to eq([{"Claude Julien"=>7, "Bruce Boudreau"=>1, "Peter DeBoer"=>2, "Dave Tippett"=>1, "Mike Babcock"=>1, "Randy Carlyle"=>1, "Lindy Ruff"=>1, "Dan Bylsma"=>1, "Alain Vigneault"=>1},
        {"John Tortorella"=>6,
         "Todd Richards"=>1,
         "Kirk Muller"=>1,
         "Jack Capuano"=>2,
         "Darryl Sutter"=>2,
         "Mike Yeo"=>1,
         "Ron Rolston"=>1,
         "Adam Oates"=>1,
         "Bob Hartley"=>1,
         "Joel Quenneville"=>2,
         "Kevin Dineen"=>2,
         "Barry Trotz"=>1,
         "Paul MacLean"=>1,
         "Peter Laviolette"=>1,
         "Claude Noel"=>1,
         "Jon Cooper"=>1,
         "Randy Carlyle"=>1}])
      
    end
  end

  describe '#games_coach' do
    it 'can return an arrary of hashes indicating how many total games each coach has coached in the indicated season' do
      expect(stat_tracker.games_coached("20132014")).to eq({"John Tortorella"=>1,
        "Ken Hitchcock"=>1,
        "Craig Berube"=>1,
        "Bruce Boudreau"=>2,
        "Todd Richards"=>2,
        "Mike Babcock"=>3,
        "Adam Oates"=>1,
        "Barry Trotz"=>2,
        "Bob Hartley"=>3,
        "Claude Julien"=>1,
        "Jack Capuano"=>1,
        "Dan Bylsma"=>1,
        "Dallas Eakins"=>1,
        "Todd McLellan"=>2,
        "Randy Carlyle"=>2,
        "Peter Horachek"=>1,
        "Peter DeBoer"=>1})

      expect(stat_tracker.games_coached("20122013")).to eq({"Claude Julien"=>7,
        "John Tortorella"=>6,
        "Bruce Boudreau"=>1,
        "Todd Richards"=>1,
        "Kirk Muller"=>1,
        "Jack Capuano"=>2,
        "Peter DeBoer"=>2,
        "Dave Tippett"=>1,
        "Darryl Sutter"=>2,
        "Mike Yeo"=>1,
        "Ron Rolston"=>1,
        "Adam Oates"=>1,
        "Bob Hartley"=>1,
        "Joel Quenneville"=>2,
        "Kevin Dineen"=>2,
        "Barry Trotz"=>1,
        "Mike Babcock"=>1,
        "Paul MacLean"=>1,
        "Randy Carlyle"=>2,
        "Lindy Ruff"=>1,
        "Peter Laviolette"=>1,
        "Claude Noel"=>1,
        "Jon Cooper"=>1,
        "Dan Bylsma"=>1,
        "Alain Vigneault"=>1})
    end
  end

  describe '#winningest_coach' do
    it 'can find the winningest coach based on season' do
      expect(stat_tracker.winningest_coach("20132014")).to eq("John Tortorella")
      expect(stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    end
  end

  describe '#worst_coach' do
    it 'can find the worst coach base on season' do
      expect(stat_tracker.worst_coach("20132014")).to eq("Ken Hitchcock")
      expect(stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
    end
  end

  describe '#count_of_teams' do
    it 'returns the number of teams' do
      expect(stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe '#team_goals' do
    it 'returns a hash of the teams as keys and the amount of goals in all season as the value' do
      expect(stat_tracker.team_goals).to be_a(Hash)
    end
  end
  
  describe '#team_games' do
    it 'returns a hash of the teams as keys and the amount of games in all season as the value' do
      expect(stat_tracker.team_games).to be_a(Hash)
    end
  end

  describe '#avg_goals' do
    it 'returns a hash with the keys as team names and the values as the avg of goals of all the seasons' do
      expect(stat_tracker.avg_goals).to be_a(Hash)
    end
  end

  describe '#best_offense' do
    it 'returns the name of the team with the highest average of goals per game across all seasons' do
      expect(stat_tracker.best_offense).to eq("Sporting Kansas City")
    end
  end
  
  describe '#worst_offense' do
    it 'returns the name of the team with the highest average of goals per game across all seasons' do
      expect(stat_tracker.worst_offense).to eq("DC United")
    end
  end
end
