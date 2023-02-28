# Futbol

## Check-in Plan
- Daily check-ins (possibly excluding Saturday) at the beginning of work time for the day
- We will establish the next day’s check-in time and “agenda” at the end of each working day
- Re-DTR (scheduled) and check-in before the weekend to plan for remaining work in advance of Monday’s due date

## Project Organization and Workflow
[GitHub Project Tracker](https://github.com/users/reidsmiller/projects/1/views/1)
- Agreed-upon Git workflow: separate branches per issue, external review and approval for each PR (process is set up in Git repo)
- We discussed wanting to blend pair / group work with individual work:
- Collaborative planning in Iteration 1
- Collaborative / paired setup for first part of Iteration 2 (Simplecov, CSV input)
- Break up work on methods to work separately in second part of Iteration 2
- We agreed that we’ll settle significant Merge Conflicts (not simple formatting, spaces, etc.)  by flagging the group via Slack for discussion + decision

## Structure Planning
- We decided to use Figma for code structure planning, and used the design tool to build out a loose structure while we discussed
- All put input in to the doc until we came to a starting agreement → visual representation of our thinking
- We chose our tools based on what we wanted to learn about and gain exposure with for future jobs, and what team members had a little familiarity with that was applicable to the scope of this project

## Code Design
[Link to Figma board](https://www.figma.com/file/ugTRoTKJl5EqZZcZ9VHiY5/F%C3%BAtbol---PD?node-id=0%3A1&t=v3GGoNcRnvwvX7y9-1) - work in progress / iterative approach

- We plan to create at least two class (Team, Game) to parse out data from the CSV files into attributes that we can call from three other classes, which we intend to hold the methods in (Game / League / Season Stats). We will call all of these methods into the StatTracker class, to utilize the Spec Helper. Our StatTracker class will only contain the specific methods named in Iteration 2.

- We also plan to put common methods that might be used across the Stats classes into a module.

[Initial DTR completed Monday Feb. 27, 2023](https://docs.google.com/document/d/1dh0IGhfFFzFICHPGQ5E1T7Iv2a_0WvBvUoctJfrnevE/edit?usp=sharing)

## Contributors
- Kailey Kaes - [LinkedIn](https://www.linkedin.com/in/kailey-kaes-336142219/), [GitHub](https://github.com/kaileykaes)
- Reid Miller - [LinkedIn](https://www.linkedin.com/in/reid-s-miller/), [GitHub](https://github.com/reidsmiller)
- Caroline Peri - [LinkedIn](https://www.linkedin.com/in/carolineperi/), [GitHub](https://github.com/cariperi)
- Logan Wilson - [LinkedIn](https://www.linkedin.com/in/logan-wilson-28422ba0/), [GitHub](https://github.com/bluedevil667)

