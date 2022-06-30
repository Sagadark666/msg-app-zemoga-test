# Zemoga Test - PostDashboard App

This project contains the source code for a fully functional Post Board in compliance with requirements set out by the hiring team and with the purpose of delivering an reliable app to showcase my development level.

The base language for this project, as per usual nowadays for iOS development, was Swift5. I did not rely on thirdparty libraries, since for the current scope, and with the latelest version os Swift, I had at my disposal every tool that I need it. 

There were some hicups along the way, as with any development project, specially because is the first time that I worked with the Codable/Decodable classes, and other other languages handle async transactions differently. But at the end, I believe that accomplished the goal of delivering a top of the line product.

Install Instructions
 
 Since I did not used thirdparty libraries the installation process is fairly simple.
    
    - This project relies on Swift 5, hence it is only compatible with Xcode10.2 or later.
    - The git repository is public, a "git clone https://github.com/Sagadark666/msg-app-zemoga-test.git" will suffice.
    - The Core Data package is already included.
    - There is no additional setup to be done, the project is ready to be build and deployed.

Desing Concept

- Architecture: In accordance with the desgin guidelines proposed by apple, the pattern use was MVC. 
- I tried to be guided as much as posible by SOLID
- Fully self-contained. As stated above the app does not relies on third party libraries. Although there are powerful tools out there, I believe that as long as is possible and as long it does not come as a detriment of the app, not using third party, reduces contingency and implies less time suppporting and updating them, specially since Apple heavily relies and Swfit and any time a change will happen, there would be a large effort for legacy support that would not be transfered to the developer.

Features

- Is capable of executing all of the task requested (Load all post, load single post with user and comment information, marking as favorite and deleting single posts, and deleting them all at once, reloading post while keeping current information).
- The app is able to resize dynammicaly to screen size.
- As per the proposed Web transaction handler does not seem be performance issues.


App Structure

- Networking: The Api folder contains a class that handles URL tasks. And the Controller itself takes care of deploying functions need it, and therefore pass the argument neccesaries to call different parts of the endpoint.
- Model: The are four classes, Post, PostDetails, User and Comments. All four of them use deserialization, or as is invoked in Swfit Codable. The only data model with Coding Keys is Post, which allow it to contain isFavorite property.
- View: The screen adaptability was achieve trhough Constrains. The dynamic lists are built upon CollectionViews.
- Controller: There are only two controllers, each for the Views available. There are also two interfaces that take care of the information sent back and forth along with a delegate to handle the navigation functions (Delete and Fav Post).  

Credits

Thanks to all of the wonderfull developers that are so eager to help out. Stackoverflow, GitHub and Reddit comunnites as well. 
