const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
var os = require('os');

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello World its ya boy");
// });

// comment this tomorrow
// exports.updateStatus = functions.database.ref('Users/{pushid}').onWrite(event => {
//     const eventSnapshot = event.data;
//     var isClicked = eventSnapshot.child('isClicked')
//     // only create a new value if the value of isClicked changed
//     if (isClicked.changed()) {
//         console.log("Inside the IF, this is good news!")
//         // write a new field to the eventSnapshot
//         // eventSnapshot.child('status').set("nanner");
//         // print the uid for now
//         // console.log("uid" + "=" + eventSnapshot.key);
//         // possibly another way to set data?
//         admin.database().ref('Users').once('value').then(db => {
//             //console.log("Name: " + db.child('6gEV1Gh7DnU7qn1M6BIeXRCDEav1').value());
//             db.child('6gEV1Gh7DnU7qn1M6BIeXRCDEav1').child('BoiItsMe').set("SuckIt");
//             return db.ref.set(db.val());
//         });
//         // return event.data.ref.child('status').set("SuckIt");
//     } else {
//         console.log("Inside the ELSE case");
//     }
//     // try out our count method
//     // console.log("Child Count" + count())
//     // write and save changes, return the promise
//     //return event.data.ref.set(eventSnapshot.val())
// });

/*
* query allows us to get every user and print their corresponsing data to the webpage as a test of sorts, this will
* allow us to search through all the users when we need to match up mentors. Don't forget method() or things break.
* Version 2 is going to be a table of the data!
*/

exports.query = functions.https.onRequest((request, response) => {
    return admin.database().ref('Users').once('value', (snapshot) => {
        /*
        * Iterate over every user in the database
        */
        var output = "";
        var count = 0;
        snapshot.forEach(function (user) {
            /*
            * Iterate over the child object and print all of its values
            */
            output += "Data for: " + user.key + "<br />";
            user.forEach(function (child) {
                output += child.key + ": " + child.val() + "<br /> ";
            });
            // <br /> here works better than os.EOL because it goes to a webpage
            output += "<br /><br />";
            count++;
        });
        response.send(output);
        console.log("Count: " + count);
    });
    // always end the https request or it will crash
    query.send();
});

// the table version just for fun

exports.queryTable = functions.https.onRequest((request, response) => {
    return admin.database().ref('Users').once('value', (snapshot) => {
        // create all the fun html stuff and css too!
        var output = "";
        output += "<html>\n";
        output += " <head>\n";
        output += " <style>\n";
        output += " table, th, td { \n  border: 1px solid black;\n }";
        output += " th, td { \n    padding: 10px;\n }";
        output += " </style>\n";
        output += " </head>\n";
        output += " <body>\n";
        /*
        * Create a well formatted table
        */
        output += "<table> \n";
        output += " <tr> \n";
        output += "     <th> UID \n";
        output += "     <th> Name \n";
        output += "     <th> Age \n";
        output += "     <th> Email \n";
        output += "     <th> Best Skill \n";
        output += "     <th> Description \n";
        output += "     <th> Mentor/Mentee \n";
        output += " </tr> \n";
        // iterate through every user
        snapshot.forEach(function (user) {
            // get and put all values of the child into a table row
            output += " <tr> \n";
            output += "     <td> " + user.key + " </td>\n";
            output += "     <td> " + user.child("First Name").val() +
                " " + user.child("Last Name").val() + " </td>\n";
            output += "     <td> " + user.child("Age").val() + " </td>\n";
            output += "     <td> " + "Being Implemented" + "</td>\n";
            output += "     <td> " + user.child("bestSkill").val() + "</td>\n";
            output += "     <td> " + user.child("Description").val() + "</td>\n";
            // find if they are a mentor or not, or neither if invalid entry
            var isMentor = "Mentor";
            if (user.child("isMentor").val() != true) {
                isMentor = "Mentee";
            }
            output += "     <td> " + isMentor + " </td>\n";
            output += " </tr>\n";
        });
        output += "</table>\n";
        output += "</body>\n";
        output += "</html>\n";
        response.send(output);
    });
    // always end the https request or it will crash
    queryTable.send();
});

/*
* This next functon includes basic searching of a
* mentor functionality based on a single keyword
*/
exports.findMentor = functions.https.onRequest((request, response) => {
    // get the uid of the specified user
    var id = request.body.uid;
    return admin.database().ref('Users').once('value', (snapshot) => {
        // first get the specified users best skill
        const user = snapshot.child(id);
        const userBestSkill = user.child('bestSkill').val();
        var matches = [];
        // iterate through every child and find a potential match
        snapshot.forEach(function(child) {
            /*
            * Only check skills if the child is a mentor....
            */
            // For some reason you have to cast to Boolean to work
            var isMentor = (Boolean)(child.child('isMentor').val());
            if (child.child('isMentor').val() == true) {
                const bestSkill = child.child('bestSkill').val();
                // put all those who match into an array, don't add yourself
                if (bestSkill === userBestSkill && id != child.key) {
                    matches.push(child.child('First Name').val());
                };
            }
        });
        // print out the matches or an error message
        var message = "";
        if (matches.length != 0) {
            message = "Mentors founds: "
            // append each item to a string
            matches.forEach(function(item) {
                message += item + ",";
            });
            message += ".";
        } else {
            message = "No mentor matches were found :(";
        }
        const name = user.child('First Name').val() +
         " " + user.child("Last Name").val();
        response.send(name + ": " + message);
    });
    findMentor.send();
});
