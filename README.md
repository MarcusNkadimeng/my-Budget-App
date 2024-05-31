# my-Budget-App

# Table of Contents
1. Description
2. Gitflow
3. Architecture
4. Tests
5. Design
6. API

## Description
The myBudget app is a simple application designed to help users manage their finances by tracking income, expenses, and overall spending. They can categorize transactions, and view reports to gain insights into their financial habits.
1.
<img width="323" alt="Screenshot 2024-05-08 at 09 22 15" src="https://github.com/MarcusNkadimeng/my-Budget-App/assets/164848888/2114fd18-1891-49a5-821b-e20d148c3779">
2.
<img width="258" alt="Screenshot 2024-05-08 at 09 25 40" src="https://github.com/MarcusNkadimeng/my-Budget-App/assets/164848888/16dd8b5b-e718-4fea-b941-7cd5d0f866d4">
3.
<img width="297" alt="Screenshot 2024-05-08 at 09 34 25" src="https://github.com/MarcusNkadimeng/my-Budget-App/assets/164848888/f28a0160-40b5-4889-810a-0396d3e2d5be">


## Gitflow
![gitflow](https://github.com/MarcusNkadimeng/my-Budget-App/assets/164848888/da8142b0-11da-4bdf-b244-9012c60c2422)

## Architecture
myBudget is a native iOS application built using the MVVM architecture
The Model comprises of data models used by the application 
The application uses repositories for business logic that is used by the application
The View is responsible for the interface in which the user interacts with
The View model transforms information from the model and update the View

## Tests
The unit tests for the application use Apple's XCTest framework.

## Design
The application was designed using Figma.

The wireframe designs and flow can be found <a href="https://www.figma.com/file/sq610lWu5wEOtZ43bqmf9z/Budgeting-mobile-app-design-(Community)?type=design&node-id=0-1&mode=design&t=p2RrkzMYfWjaYXX1-0">here</a>: 
## API
The application uses YNAB (You Need A Budget) API.
Its endpoints can be found <a href="https://api.ynab.com/v1#">here</a>:
