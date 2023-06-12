# Futbol
## Contributors
Chris C: [GitHub](https://github.com/topher-nullset) | [LinkedIn](https://www.linkedin.com/in/chris-cullinane-3200b9276/) <br />
Paul B: [GitHub](https://github.com/pcbennett108) | [LinkedIn](https://www.linkedin.com/in/paul-bennett-388540279) <br />
Wil F: [GitHub](https://github.com/fadwil) | [LinkedIn](https://www.linkedin.com/in/wil-fady-920b33275) <br />
Weston S: [GitHub](https://github.com/westonio) | [LinkedIn](https://www.linkedin.com/in/westonschutt)<br />
## Check-in Process
Morning check-in at 8:30 am MST <br />
Informal check-in during worktime <br />
Hitting barriers? Unsure of what's next? That's what the check-in is for!
## Project Organization
Tasks and organization belongs in [GitHub projects](https://github.com/users/westonio/projects/3) <br />
General questions and things like scheduling belong in Slack<br />
Project storyboard on [Miro](https://miro.com/app/board/uXjVMB55lMQ=/) <br />
Pull Request Template:
```
    Describe your changes
    Issue ticket number and link
    Checklist before requesting a review
  - [ ] I have performed a self-review of my code
  - [ ] If it is a core feature, I have added thorough tests.
  - [ ] I AM MERGING WITH WESTONIO
  ```
## Unique Approaches
Start with 2 classes StatTracker and Parser
>The focus should be on writing clean parsers in Parser. 
>Game, league, and season methods in StatTracker would call on parser data.
>StatTracker instance methods would also call on code blocks to reduce rewriting code. 
>Code blocks could then be split into seperate classes to clean up StatTracker.
>(fewer classes in the beginning, more classes later) <br />

Start with 4 classes ST, game_parser, teams_parser, game_teams_parser
>Parsers and logic are built into the classes based on the nature of the csv file they come from.
>(This breaks out the work very nicely for four people but could become confusing) <br />

Start with 5 classes ST, Parsers, Games, Leagues, and Season.
>Parsers would live in Parsers for StatTracker to call
>Games, League, and Season will contain all logic for ST methods besides slicing the csv_data.
>(More complex at the start but maybe the least major refactoring, who knows?) <br />

The runner file will deliver the CSV's to Stat tracker with .read_csv
>This creates a StatTracker object with all of the csv data
>The instance methods in StatTracker will deliver the csv slices to classes with .from_csv <br />

We decided to start on what felt like the simplest approach and understand that we will have to pivot as we progress through the project.
## DTR Link
original: https://docs.google.com/document/d/1zckxrDKgt_dMJLzHltimGCktWElfJmO8VVLp9EDuGns/edit?usp=sharing

## Retrospective
### Tools: 
- [Miro board](https://miro.com/app/board/uXjVMB55lMQ=/)
- We considered using easyretro.io or miro board but we stuck with the miro board as we already were working with it.

### Top 3 things that went well during your project:
- Communication 
- Collective contribution to planning ahead of time set us up for success
- Willingness to try different ideas and open to change

### Top 5 things your team would do differently next time:
- Be willing to jump in and start spiking ideas in the beginning
- When blocked initially, we could have put options into writing to have a visual aid for our discussion in seeing the whole picture
- Working with the data more ahead of time before jumping into writing methods
- As we are all students, caring less about getting the code to work and more about understanding what we wanted to do with the data
- Worked async more often in order to potentially have some merge conflicts and learn how to resolve them
