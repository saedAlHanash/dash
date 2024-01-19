importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");
//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
  apiKey: 'AIzaSyARO4cr5YLVo_sUgvE-vsIFJUvdEyTYChg',
  appId: '1:92692714826:web:20205958a38d44a8dc5db3',
  messagingSenderId: '92692714826',
  projectId: 'qareeb-29b73',
  authDomain: 'qareeb-29b73.firebaseapp.com',
  storageBucket: 'qareeb-29b73.appspot.com',
  measurementId: 'G-C5BQ0PPL1T',
});


const messaging = firebase.messaging();
messaging.onBackgroundMessage((message) => {
 fetch("assets/sounds/peen.mp3")
      .then(function(response) {
        return response.arrayBuffer();
      })
      .then(function(buffer) {
        // Decode the audio data
        return self.audioContext.decodeAudioData(buffer);
      })
      .then(function(decodedData) {
        // Create an AudioBufferSourceNode and play the audio
        var source = self.audioContext.createBufferSource();
        source.buffer = decodedData;
        source.connect(self.audioContext.destination);
        source.start();
      })

  const notificationTitle = message.notification.title;

  const notificationOptions = {
    body: message.notification.body,
    icon: "https://for-delete-c0d5f.web.app/assets/assets/icons/logo_png.png",
    sound: "https://for-delete-c0d5f.web.app/assets/assets/sounds/peen.mp3"
    // Add more options as needed
  };
  self.registration.showNotification('notificationTitle', notificationOptions);

});