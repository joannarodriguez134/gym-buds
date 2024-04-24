import consumer from "channels/consumer"

consumer.subscriptions.create("MatchChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('Connected to MatchChannel!');
    document.querySelector('#send-message-button').disabled = false;
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('Disconnected from MatchChannel');
    document.querySelector('#send-message-button').disabled = true;
  },

  received(data) {

    // Called when there's incoming data on the websocket for this channel
    console.log('Received data:', data);
    const messagesContainer = document.querySelector('#messages-container');
    messagesContainer.innerHTML += data.message;
    messagesContainer.scrollTop = messagesContainer.scrollHeight; // Keep scroll at the bottom
  }
});
