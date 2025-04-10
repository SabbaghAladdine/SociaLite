
# SocialLite

In this app, users will be able to sign up, log in, view a home feed of posts, engage in a
real-time chat interface, and manage basic profile settings.


## Set Up

This app relies on a springboot static API that provides both a REST API and a STOMP Websocket.
remember to always start the springboot api when testing the application.
you can find the source code for the api here 
https://github.com/SabbaghAladdine/SocialLite_API.
and a Jar file of the api will be in this repository root.

remember to change the api Ip address in the apiIp.dart file in the commons directory.
## Screenshots

![API Screenshot](https://github.com/SabbaghAladdine/SociaLite/blob/main/ScreenShots/swagger.png)

the api contains two requests that you can access using swagger

Swagger Link: localhost:8080/swagger-ui/index.html

/get retrieves a static list of posts for the app feed

/group sends a Stomp message to the app chat room 

this is the message format that needs to be sent in the /group request 
{   "content": "hello world",   "sender": "user123",   "time": "2025-04-09T15:30:00.000Z" }

![Login Screenshot](https://raw.githubusercontent.com/SabbaghAladdine/SociaLite/refs/heads/main/ScreenShots/login.jpg)

![Feed Screenshot](https://raw.githubusercontent.com/SabbaghAladdine/SociaLite/refs/heads/main/ScreenShots/feed.jpg)

![Post Screenshot](https://raw.githubusercontent.com/SabbaghAladdine/SociaLite/refs/heads/main/ScreenShots/Post.jpg)

![Chat Screenshot](https://raw.githubusercontent.com/SabbaghAladdine/SociaLite/refs/heads/main/ScreenShots/chatRoom.jpg)

![Settings Screenshot](https://raw.githubusercontent.com/SabbaghAladdine/SociaLite/refs/heads/main/ScreenShots/settings.jpg)