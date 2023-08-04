# FUTBOL PROJECT

## SCHEDULE/CHECKINS/RETRO (MST)
**Retro:** 4th August 2023, Friday, 2:00 PM - 4:00 PM 

**Checkins:** Standup prior to Work Session, check-ins if blockers are persistent, check-in at conclusion

**Regular work sessions:** Weekdays 7:00 PM - 11:00 PM, flexible weekends

**Defined break times:** 4:00 PM - 6:00 PM 

## Project Management

**Project Management Tool:** [Trello Board](https://trello.com/b/nZVs6Do1/futbol)
1. Adopt an Agile approach, utilizing Trello to manage daily standups, tickets, and any potential backlogs.
2. GitHub is utilized for version control and code collaboration/documentation to ensure seamless integration with the development workflow.
3. Weekly retro to assess project progress and reevaluate design and architecture structure.

**Git Workflow:** 
1. Commit/Push/Pull often.
2. Clear commit messages with prefixes (feat:, test:, doc:, fix:, refactor:).
3. Pull Requests never merged by the creator - will request review via slack each time it's submitted.
4. Pull requests will have the following: 
   - Outline of all methods developed or iterated categorized by class.
   - Potential additional work to complete and suggestions for future refactors.
5. Inline comments on commits for PR requests from reviewers.
6. All team members will be set as reviewers - both reviewers will leave comments, only required to merge.

**General Task Assignment:**
1. Initial sessions will take place together to develop method structures.
2. After grouped/paired sessions, we will divvy up methods based on return values and the level of comfort.
3. For more complex methods, we may choose to work together or split apart and come back with individual solutions.
4. Individual contributors will be responsible for pushing their tasks along the Trello task board.

## Code Design

**Summary:** We will begin by building out all objects and parsing files through the stat tracker. We will then build relevant methods in classes. Eventually, we will move methods into modules for each class and leave the classes to only have instance variables. We will perhaps also have a module for standard calculations such as percentage calculations, etc. 

**Classes:**  
- GameStat
- LeagueStat 
- SeasonStat 
- StatTracker 

**Modules:**  
- GameStatable
- LeagueStatable
- SeasonStatable

**External Files:**  
- Data files
- Sample data files
- Runner
- Spec Harness

**Additional Documents:**  
[Futbol Architecture](https://miro.com/app/board/uXjVMxAWfME=/#tpicker-content)  
[Google Doc Brainstorm](https://docs.google.com/document/d/1gS0AAn056CZI1Cn7MSnpMDbgAODSe6wiQGfNmsCnGRE/edit)  
[DTR Document](https://docs.google.com/document/d/1ge9dOOicZM7uRql86bdureXG470FcPbfWdJxfzakB2k/edit)  

## Contributors:
- Charles Ren - [GitHub](https://github.com/chuckrenny), [LinkedIn](https://www.linkedin.com/in/charles-ren-42673816b/)
- Antoine Aube - [GitHub](https://github.com/Antoine-Aube), [LinkedIn](https://www.linkedin.com/in/antoine-aube-4b40a11b3/)
- Jimmy Trulock - [GitHub](https://github.com/JimmyTrulock), [LinkedIn](https://www.linkedin.com/in/thomas-trulock-253976281/)


## Tools used for retro
[Retro outline](https://docs.google.com/document/d/17RAxiIajq-_j0huVj-npaqTOPzxJOJFkNgLIVpdR9ZI/edit) 
[Trello Board](https://trello.com/b/nZVs6Do1/futbol)

## Top 3 things that went well during your project
Time Management - clear expectations on work times and meetings times and sticking to them. We were always on time for calls and for deliverables. 

Async work - We were able to divide and conquer once we got warmed up and did some pseudo coding together. This was reflective of an actual work environment where developers review each other’s PR, leave comments, and adjust their code accordingly before merging into main. 

Collaboration on roadblocks and synchronizing code format - With our Async work, we each developed some unique solutions to solving assigned deliverables. When we came back together and there was overlap, we were able to fuse solutions together. When one solution was clearly more efficient than the other, we utilized it, but also made sure that this was a group consensus. Any code that was not your own was explained, so that each team member clearly understood the methods. 

## Top 3 things your team would do differently next time
Perhaps some shorter evening sessions in the future - Due to some weekend scheduling constraints, we had to pack in a bit more work during the evenings. With regards to a real work environment, we could communicate our inability to take on certain tasks within a 40 hour work-week. Given that this is school and we had more time available, we made it work!

Assigning the work by relevant and potentially overlapping helper methods - Each do one section from iteration 2, that way we could have developed the whole suite of methods and not needed to combine methods. This however was conducive to learning as we got to see each other solve similar problems in different ways. 

Splitting up talking points from the beginning - at the beginning during check ins and group discussion, not all team members contributed as much as we did as we are doing now. As part of the DTR, we could focus on that aspect to ensure that we divide up communication more evenly. For example, before the 2nd check-in, we divided up talking points based on Code, workflow, and project organization to be able to present more equally. 
