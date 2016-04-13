function isPalindrome(str) {
  for (var i = 0; i < Math.floor(str.length / 2); i++) {
    if (str[i] != str[str.length - i - 1]) {
      return false;
    }
  }

  return true;
}

// console.log(isPalindrome("hehsdf"))

Array.prototype.myMap = function(cb) {
  var result = [];
  this.forEach(function(element){
    result.push(cb(element));
  });

  return result;
};
