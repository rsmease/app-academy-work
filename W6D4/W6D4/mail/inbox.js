// let messageStore = require("./message_store.js");
//
// let Inbox = {
//   render: function() {
//     let inboxMessages = messageStore.getInboxMessages();
//     let container = document.createElement('div');
//     inboxMessages.forEach(function(el){
//       let renderedMessage = Inbox.renderMessage(el);
//       container.appendChild(renderedMessage);
//     });
//     return container;
//   },
//
//   renderMessage: function(message){
//     let newLi = document.createElement('li');
//     newLi.className = "message";
//
//     newLi.innerHTML =`
// <span class='from'>${message.from}</span>
// <span class="subject">${message.subject}</span> -
// <span class="body">${message.body}</span>
// `;
//
//
//     return newLi;
//
//   }
//
//
// };
//
//
//module.exports = Inbox;




const MessageStore = require('./message_store');

module.exports = {
  renderMessage(message) {
    let messageEl = document.createElement("li");
    messageEl.className = "message";
    messageEl.innerHTML =`
    <span class='from'>${message.from}</span>
    <span class="subject">${message.subject}</span> -
    <span class="body">${message.body}</span>
    `;
    return messageEl;
  },
  render() {
    let container = document.createElement("ul");
    container.className = "messages";
    let messages = MessageStore.getInboxMessages();
    messages.forEach(message => {
      container.appendChild(this.renderMessage(message));
    });
    return container;
  }
};
