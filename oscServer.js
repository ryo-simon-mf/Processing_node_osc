var osc = require('node-osc');

var sendCount = 0;
var oscClient = new osc.Client('127.0.0.1', 6000);
var oscServer = new osc.Server(5000);
oscServer.on("message", function (msg, rinfo) {

    console.log(msg);
    for(var i=0; i<msg.length; i++) {
        console.log(msg[i]);
    }
    var sendMsg =  new osc.Message('/address');
    sendMsg.append("test");
    sendMsg.append(sendCount);
    oscClient.send(sendMsg);
    sendCount++;
});