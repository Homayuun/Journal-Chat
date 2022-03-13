# Journal
Is a fullstack app featuring a local host and ios app communicating with each other through HTTP-Methods which gets data from defined REST-API endpoints in node app. <br/>
this app does not feature a decent UI and is focused on the technical aspects like: HTTP Requests (PUT,POST,GET,DELETE) & User Authentication. <br/>
further developments on this project can lead to a social media or chat app.<br/>

# Screenshots
<img src= "https://user-images.githubusercontent.com/30705391/158051318-89f77d51-38b7-4c87-9a65-eba3a875f20d.PNG" width="200" height="355.55">,
<img src= "https://user-images.githubusercontent.com/30705391/158051538-33a45c3e-0f43-4dc0-9b82-b06bcff3694d.PNG" width="200" height="355.55">,
<img src= "https://user-images.githubusercontent.com/30705391/158051552-a5e5f107-8bd0-4eee-bc89-744f373e8cd8.PNG" width="200" height="355.55">,
<img src= "https://user-images.githubusercontent.com/30705391/158052042-656598c6-fd1f-436a-839b-c0438424fd41.jpeg" width="200" height="355.55">,
<img src= "https://user-images.githubusercontent.com/30705391/158051557-c8bd5108-3cbc-4f6c-b48e-5d094187228d.PNG" width="200" height="355.55">,



# Installation
# (first step): Node app
1. Open myJournal-webapp folder in Atom [ if you've got required packages ] or Visual Studio <br/>
2. Open console/terminal run this command 'sudo npm install sails -g ' & after that 'npm install' <br/>
3. Optional (run this command to get informed whenever you hit an endpoint : 'sudo npm i -S sails-hook-morgan') <br/>
4. Optional (run this command to automatically restart node app whenever you modify a file: 'sudo npm i -g nodemon')<br/>
5. run node app.js<br/>
6. open your browser go to http://localhost:1337/home or http://*yourIP*:1337/home & you'll be asked to sign up <br/>
7. you'll be redirected to homepage and see the posts <br/>

# (second step): iOS
1. Download the project<br/>
2. Open Journal.xcodeproj<br/>
3. Go to "Service" from navigator<br/>
4. change baseUrl (line 13) from what it is to your own IP Address , also change :1440 to :1337 {<br/>
   if you don't know your IP address:
   - open terminal <br/>
   - type "ifconfig en0"<br/>
   - inet is your IP Address<br/>
}<br/>
5. After you've signed up with a new email address through node app {<br/>
   - go to line 72 (let params = ....) <br/>
   - change emailAddress & password<br/>
}<br/>
6. locate Journal in navigator tab / targets / Journal / Signing & Capabilities / All / Change "Team"<br/>
7. Run Journal<br/>
8. Tap login button at upper - right corner to login if you've successfully logined you get a prompt & you get posts fetched to table cell
9. Tap add post button at upeer - Left corner to create a post by entering body & title
10. Swipe to the left to delete a post 
