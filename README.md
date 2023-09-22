# Futbol

[Turing School](https://turing.io/) Futbol project.

## Check-in Plan

- Check-ins will occur daily
- Planning for the next iteration will occur after previous iteration completion

## Project Plan

- Iteration Planning will occur as a team
  - Iteration features will be clearly known and agreed upon prior to iteration kickoff
  - features will be broken down into reasonable sub-functionalities
  - sub-functionality features will be available for anyone on the team to own and will be obtained from a kahnban board
- Iteration milestone and deliverables will be tracked in [Linear](https://linear.app)

![fut_v4](https://github.com/trpubz/futbol/assets/25095319/b29da731-dc6e-441b-a965-6d9568457d2a)
[stattracker_v1](https://github.com/trpubz/futbol/assets/25095319/d2e34cc1-273a-4510-aa1a-463cd9963a7a)


## Plan of Attack Considerations

- Studying the interaction pattern provides overview of functionality
- Studying the spec_harness should help drive spec dev

## Code Design

- StatTracker class will house retrieval logic; most query logic is worked out in Stat (superclass)
  - Game stats
  - League stats
  - Season stats
  - Team stats
    - slightly different implementation with data loaded into referential hash with keys related to queries 
- Stat (superclass) will house data and shared logic for query implementation

  
### ERD for Data
![erd_v1](https://github.com/trpubz/futbol/assets/25095319/9071d533-9f56-4e2a-ba61-359107162d1a)


## DTR

- [v1](https://docs.google.com/document/d/1xlq3COkAis2Ka8S6jJ9tsDimgus19CnItrIJYnmH5xM/edit)
  
### Recommended behavior

  - when you checkout a new feature branch; immediately open a draft PR
    - this automatically moves the feature branch in Linear into 'In Progress'
    - this allows commits to be periodically reviewed && commented as it realates to the new functionality
    - when the PR is modified to 'Ready for Review' it automticlaly updates the issue to 'In Review'  
  - pause your work when a branch is ready to be merged
  - after PR merge, pull upstream branch into yours
  - comment your code

## Retro

[miro retro board](https://miro.com/app/board/uXjVMjam68c=/?share_link_id=784845189724)
![Quick Retrospective](https://github.com/trpubz/futbol/assets/25095319/b4294a2c-4d69-4d65-a3d0-2d0fbf71288d)

### Went Well

- async
- kanban board
- pairing before unproductive struggle

### Do Diff

- group code blocks when doing async
- providing contextual comments on shared code
- celebrating successes more often

### Considerations

- continue, stop, invent, act
- working, not working, start doing, stop doing
- path of least resistance
- effectiveness high because more technical version of mid-DTR
  - conduct mid-DTR after retro

## Contributors

- Blaine Kennedy [![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=plastic&logo=github&logoColor=white)](https://github.com/bkchilidawg) [![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=plastic&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/blaine-kennedy-3462a7140/)
- Kam Kennedy [![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=plastic&logo=github&logoColor=white)](https://github.com/kameronk92) [![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=plastic&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/kameron-kennedy-pe-98019469/)
- Taylor Pubins [![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=plastic&logo=github&logoColor=white)](https://github.com/trpubz) [![LinkedIn](https://img.shields.io/badge/linkedin-%230077B5.svg?style=plastic&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/trpubins/)
