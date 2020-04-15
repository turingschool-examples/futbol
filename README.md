## Modules
Plan is to make two separate modules, these will hold two separate functionalities. To make common calculations and to load the CSV files.
### Calculable
1. This module will hold the functionalities for our commonly used calculations.
### Loadable
2. This module will hold the functionalities for both reading and loading from the CSV files which hold our information.
## Inheritance
3.  Plan here is to make a 'Stats' super class which will pass common attributes and behaviors to four subclasses called game_stats, team_stats, league_stats, and season_stats classes.

## Additional Classes
4. We considered putting in additional classes to separate out season data, but found it to be more efficient to pass the functionality down to the child classes of Stats.
