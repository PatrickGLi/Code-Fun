// var text = 'outside';
// function logIt(){
//   console.log(text);
//   var text = 'inside';
// };
// logIt();

// this will output undefined due to variable hoisting
// variable declaration vs variable initialization

// var prizes = ['A Unicorn!', 'A Hug!', 'Fresh Laundry!'];
//
// for (var btnNum = 0; btnNum < prizes.length; btnNum++) {
//     // for each of our buttons, when the user clicks it...
//     document.getElementById('btn-' + btnNum).onclick = function(num) {
//         // tell her what she's won!
//         return function() {
//           alert(prizes[num])
//         }
//
//     }(btnNum);
// }
//

// process.stdin.resume();
// process.stdin.setEncoding('utf8');
// var util = require('util');
//
// process.stdin.on('data', function (text) {
//   console.log('received data:', util.inspect(text));
//   if (text === 'quit\n') {
//     done();
//   }
// });
//
// function done() {
//   console.log('Now that process.stdin is paused, there is nothing more to do.');
//   process.exit();
// }

var prompt = require('prompt');

  prompt.start();

  prompt.get(['username', 'email'], function (err, result) {
    if (err) { return onErr(err); }
    console.log('Command-line input received:');
    console.log('  Username: ' + result.username);
    console.log('  Email: ' + result.email);
  });

  function onErr(err) {
    console.log(err);
    return 1;
  }
