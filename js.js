// var text = 'outside';
// function logIt(){
//   console.log(text);
//   var text = 'inside';
// };
// logIt();

// this will output undefined due to variable hoisting
// variable declaration vs variable

var prizes = ['A Unicorn!', 'A Hug!', 'Fresh Laundry!'];

for (var btnNum = 0; btnNum < prizes.length; btnNum++) {
    // for each of our buttons, when the user clicks it...
    document.getElementById('btn-' + btnNum).onclick = function(num) {
        // tell her what she's won!
        return function() {
          alert(prizes[num])
        }

    }(btnNum);
}
