# **Design Strategy**

### Basic Structure
- Created a class called stat-tracker which serves as an access point to run statistics on the data

- Created four repositories to house the statistics

- Created a class for each data type that creates team, game, and game-team objects

- Created a repository super class to store and house the different collections of game, team, and game-team objects

- Created a super class helper class to reader and translate the csv files into objects

- Created modules for repository methods containing similar functionality

### Design Structure Reasoning
We chose this structure to better encapsulate different pieces of functionality in different classes. The repositories sole responsibility is to run stats for their given type. So the team repository is only responsible for running team stats. The purpose of the game, team, and game-team classes is only to make objects, since a game, team, or game-team would have no knowledge about collections of games, teams, or game-teams nor stats run on those collections. If there was stats that involved single games or teams we would put them in those classes. The repository superclass is responsible for initializing all the repositories with games, teams, and game-teams collections. The for repositories are its children, and inherit the individual collections that the super class houses. We created helper method in several cases for increased readable and to attempt to make complex methods have a single function. We also used modules when we found classes that shared similar behaviors. 
