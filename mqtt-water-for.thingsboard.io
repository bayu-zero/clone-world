var mqtt = require('mqtt');
const ACCESS_TOKEN = process.argv[2];

var client  = mqtt.connect('mqtt://demo.thingsboard.io',{
    username: ACCESS_TOKEN
});

var waterData = {
    waterIncrement: Math.random(),
    water: 11583
}

client.on('connect', function () {
    console.log('connected');
    console.log('Uploading water data once per minute...');
    setInterval(publishTelemetry, 60000);
});

function publishTelemetry() {
    waterData.waterIncrement = Math.random();
    waterData.water += waterData.waterIncrement;
    client.publish('v1/devices/me/telemetry', JSON.stringify(waterData));
}
