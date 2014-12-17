 require('node-shell')(function(err, api) { 
    var win = new api.BrowserWindow({}).loadUrl('http://google.com');
  });