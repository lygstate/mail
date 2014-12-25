var app = require('app');  // Module to control application life.
var BrowserWindow = require('browser-window');  // Module to create native browser window.

// Report crashes to our server.
require('crash-reporter').start();

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the javascript object is GCed.
var mainWindow = null;

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  if (process.platform != 'darwin')
    app.quit();
});

function StartWindow() {
  // Create the browser window.
  mainWindow = new BrowserWindow({width: 800, height: 600,frame: false});

  // and load the index.html of the app.
  mainWindow.loadUrl('file://' + __dirname + '/index.html');

  // Emitted when the window is closed.
  mainWindow.on('closed', function() {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    mainWindow = null;
  });
}

function showGitLog() {
  var ngit = require('nodegit');
  var open = ngit.Repository.open;
  var dirName = __dirname;
  console.log(dirName);
  // Open the repository directory.
  open(dirName + "..")
    // Open the master branch.
    .then(function(repo) {
      return repo.getMasterCommit();
    })
    // Display information about commits on master.
    .then(function(firstCommitOnMaster) {
      // Create a new history event emitter.
      var history = firstCommitOnMaster.history();

      // Create a counter to only show up to 9 entries.
      var count = 0;

      // Listen for commit events from the history.
      history.on("commit", function(commit) {
        // Disregard commits past 9.
        if (++count >= 9) {
          return;
        }

        // Show the commit sha.
        console.log("commit " + commit.sha());

        // Store the author object.
        var author = commit.author();

        // Display author information.
        console.log("Author:\t" + author.name() + " <", author.email() + ">");

        // Show the commit date.
        console.log("Date:\t" + commit.date());

        // Give some space and show the message.
        console.log("\n    " + commit.message());
      });

      // Start emitting events.
      history.start();
    });
}

// This method will be called when atom-shell has done everything
// initialization and ready for creating browser windows.
app.on('ready', function() {
  console.log("Start");
  showGitLog();
});
