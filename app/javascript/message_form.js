
document.addEventListener("turbolinks:load", function() {
  const messageForm = document.getElementById("new_message_form");
  if (messageForm) {
    messageForm.addEventListener("submit", function(event) {
      event.preventDefault(); // Prevent the traditional form submission

      const body = document.querySelector("#new_message_form textarea").value;
      App.chat.speak({message: body}); // Assuming your Action Cable consumer setup has a "speak" method

      // Clear the textarea after sending
      document.querySelector("#new_message_form textarea").value = "";
    });
  }
});
