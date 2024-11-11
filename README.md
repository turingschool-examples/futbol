# Goal Oriented Coders: Turing Fubol Project

## Summary

The **Futbol Project** is a collaborative software development initiative designed to analyze and process soccer-related data using Ruby. The project employs test-driven development (TDD) to ensure functionality, adaptability, and code quality. Our goal is to create dynamic, reusable methods that calculate and present key statistics based on input data while maintaining alignment with industry-standard principles like the Single Responsibility Principle (SRP) and DRY (Don’t Repeat Yourself).

---

## Organization and Workflow

- **GitHub Repository:** All code is pushed to a shared GitHub repository with protected branches to ensure code quality and avoid accidental changes to main.
- **Branching Strategy:** We adopted a feature-branch workflow. Each team member creates a branch for their assigned methods and submits pull requests for peer review.
- **Code Reviews:** Pull requests must be reviewed and approved by at least one other team member before merging into the main branch.
- **Task Assignments:** Tasks are divided by features or methods. Each member is responsible for implementing, testing, and documenting their assigned tasks. 
- **Project Management Tool:** (https://turingschool.slack.com/lists/T029P2S9M/F07UWA2U2J0?view_id=View07V6F99XL1)

---

## Communication Plan 

Our team has established the following check-in structure to maintain consistent communication and collaboration throughout the project:
- **Daily Check-Ins:** During designated work blocks (3-4 hours) in class, team members will discuss progress, address blockers, and assign tasks for the day.
- **Slack Updates:** Team members will post updates in the Slack channel if they are unable to attend a daily check-in or complete assigned tasks outside of work blocks.
- **Ad-Hoc Huddles:** For urgent issues, we will organize short huddles to address them promptly and keep the project on track.(Based on everyones availability)

## Organization Approaches

**Initial Approaches:** We explored several options for collaboration, including working on the same branch collaboratively and dividing tasks by features or files.

**Collaboration Approaches:** We collectively decided on the following collaboration approaches:
  - Mob Programming
  - Synchronous Work Sessions
  - Independent Task Ownership
  - Asynchronous Collaboration
  - Voting System
  - Feature-Based Assignment
  - Collaborative Debugging

**Final Decision:** After team discussion, we agreed on a feature-branch workflow to enable parallel development and reduce merge conflicts.

---

## Code Design

The project is structured using a feature-branch workflow to enable parallel development and reduce merge conflicts. By combining clear task assignments, robust testing practices, and regular team check-ins, this project aims to deliver a high-quality application that meets the outlined requirements while fostering collaboration and professional growth among contributors.

**Key Design Structure**

#### 1.	**Stat Tracker (Main Interface)**

The Stat Tracker class acts as the main interface for interacting with all project data and methods. It serves as the entry point to the application, coordinating data loading and calculations by interacting with the Stat Calculator and data loader classes.

#### 2.	**Stat Calculator (Central Calculation Hub)**

The Stat Calculator class is the core of the project, responsible for processing all statistical methods. It performs calculations by leveraging data from the loader classes, including:
- **Win Percentages** (e.g., percentage_home_wins, percentage_visitor_wins, percentage_ties).
- **Scoring Metrics** (e.g., highest_total_score, lowest_total_score, highest_scoring_visitor).
- **Coaching Performance** (e.g., winningest_coach, worst_coach).
- **Team Performance** (e.g., best_offense, average_goals_per_game)

#### 3.	**Data Loader Classes**
These classes are responsible for loading and organizing data from CSV files, ensuring clean and accessible inputs for the Stat Calculator:


  - **Games:** Responsible for loading and organizing game data.
  - **Teams:** Responsible for handling team-related data.
  - **GameTeams:** Manages data that links games and teams.

#### 4. **Test Driven Development:**

  - **Fixtures:** Serves as predefined data sets 
  - **Isolation Testing:** Stubs & Mocks

#### 5.	**Team Collaboration**

Contributors worked collaboratively to implement methods within the **Stat Calculator**, while ensuring that the **Stat Tracker** properly coordinated all class interactions. The data loader classes were designed to b**e static and provide clean inputs for calculations.

---

## DTR Document

The **Define the Relationship (DTR)** document serves as the foundation for team collaboration on the Futbol Project. It outlines team expectations, strengths, communication styles, and workflows to ensure alignment and productive teamwork throughout the project.

**Initial DTR**
- **Date:** November 4, 2024
- **Summary:** The initial DTR established our team’s objectives, individual roles, and collaboration guidelines. We agreed on the use of tools like Slack for communication, GitHub for version control, and regular check-ins to maintain alignment on tasks and deadlines. We also identified each team member’s strengths and areas for growth to better delegate tasks and foster an environment of mutual support.
- **Document Link**: [**Initial DTR**](https://docs.google.com/document/d/e/2P*ACX-1vQp5qjABh1RMFwup5VM6o5N6oWucY9cuxxBww0Rr872fZNl_V9oUMqusqXMMzJQeacJDmoItGh7_D3-/pub)

**Updated DTRs**
- **Date:** 09 Novemeber 2024
- **Summary:** As the project progressed, we updated our DTR to reflect changes in workflows, address challenges encountered, and refine our collaboration strategies. This update included adjustments to our check-in schedule, a streamlined feedback process, and clarified expectations for pull request reviews to avoid delays.
- **Document Link**: [**Updated DTR**](https://docs.google.com/document/d/e/2PACX-1vQp5qjABh1RMFwup5VM6o5N6oWucY9cuxxBww0Rr872fZNl_V9oUMqusqXMMzJQeacJDmoItGh7_D3-/pub)

---

## Retro 

We utilize Easy Retro for our team Retro.

**Went Well**

While there were some communication hiccups, frustration with technical approaches, and resulting conflict, the team was able to come together with transparency and humility to resolve the issues, clear the air, and plan a productive path forward.
- The team adopted a feature-branch workflow, allowing parallel development and reducing merge conflicts.
- Clear division of tasks allowed everyone to focus on their strengths.
-  Daily check-ins and Slack updates ensured consistent progress, with all major features tracked and assigned

**Action Items**
- In the future, we should:
  - Be more proactive in offering help when needed.
  - Provide assistance quickly and consistently when we notice someone is struggling.
  - Moving forward, we should set aside time to connect as individuals, separate from project discussions. 
  - This will foster stronger communication and allow us to decompress as a team.
  - We should revisit the DTR (Define the Relationship) document more frequently, especially when conflicts arise or if there’s a misunderstanding about any part of the project.

[**Link to Retro**](https://easyretro.io/publicboard/v3618buCXPXeBF9ctzcPhj9mUJn2/cda275ed-c500-4098-a969-cf4ebb63d830)

---

## Contributors

| Name         | LinkedIn                      | GitHub                     |
|--------------|-------------------------------|----------------------------|
| Kevin Newland    | [LinkedIn Profile](https://www.linkedin.com/in/kevin-newland-95b719179/)         | [GitHub Profile](https://github.com/kevin-newland)        |
| Kristin Weiland   | [LinkedIn Profile](https://www.linkedin.com/in/kristin-weiland-7787159/)         | [GitHub Profile](https://github.com/KMPWeiland)        |
| Qory Dozier   | [LinkedIn Profile](http://www.linkedin.com/in/sequoyahdozier)         | [GitHub Profile](https://github.com/qoryhanisagal)        |
| Dustin Peukert   | Not Applicable         | [GitHub Profile](https://github.com/DustinPeukert)        |

