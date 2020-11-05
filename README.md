# Futbol

Futbol is a [Turing School](https://turing.io/) project by [Ely Hess](https://github.com/elyhess), [Phil McCarthy](https://github.com/philmccarthy) & [Robert Hess](https://github.com/kaiheiongaku). It was completed during Mod 1—week 4 & 5—of the backend engineering program.

### Learning Goals
- Build classes with single responsibilities.
- Write organized readable code.
- Use TDD as a design strategy
- Design an Object Oriented Solution to a problem
- Practice algorithmic thinking
- Work in a group
- Use Pull Requests to collaborate among multiple partners

### Design Strategy
The Futbol project uses data from a fictional soccer league to analyze team performance for specific seasons and across seasons.

- StatTracker is the highest-level class in our architecture, and all lower-level class interaction happens through StatTracker.
- There are 3 'verticals' with which StatTracker interacts to look up information about rich Ruby objects, which are generated from 3 separate-but-related CSV data files.
  - `GameManager` and `Game` - every `Game` has information about the teams that played, and the `GameManager` is a repository that is responsible for looking up information about `Game`s.
  - `GameTeamsManager` and `GameTeams` - every `GameTeam` represents `Team` statistics from a single game. There are 2 `GameTeams` that match each `Game`. The `GameTeamManager` is a repository that is responsible for looking up information about `GameTeam`s.
  - `TeamManager` and `Team` - every `Team` has information about an individual soccer team, and the `TeamManager` is a repository that is responsible for looking up information about each `Team`.

### Testing
![100 percent test coverage screenshot](https://i.imgur.com/Dz3sQRm.png)

We're proud to have been extremely diligent in our TDD approach while working on this project. An rspec harness was provided for verification that the program functions as expected.

![testing results](https://i.imgur.com/2KBHCKG.png)
