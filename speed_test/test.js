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

function uniqueSubs(string) {
  if (string.length == 0) {
    return [[]];
  }

  var previous = uniqueSubs(string.substring(1, string.length));
  var new_elements = previous.map(function(el){
    return string[0] + el;
  });

  return previous.concat(new_elements);

};

// console.log(uniqueSubs("hey"));

function largestContiguousSum(array) {
  var largestSum = null;

  array.forEach(function(element) {
    if (typeof largestSum === "null") {
      largestSum = element;
      return;
    }

    largestSum += element;
    if (largestSum < element) {
      largestSum = element;
    }
  });

  return largestSum;
};

// console.log(largestContiguousSum([4,3,7,1,-1,-5,4,-15,20]))

function sillyYears(year) {
  var results = [];

  while (results.length < 10) {
    year ++;
    var stringYear = year.toString();
    var first = parseInt(stringYear.substring(0, 2)),
        second = parseInt(stringYear.substring(2, 4)),
        middle = parseInt(stringYear.substring(1, 3));

    if (first + second === middle) {
      results.push(year);
    }
  }

  return results;
};

// console.log(sillyYears(1990));

function pairSum(arr, k) {
  var seen = new Set();
  var pairs = new Set();

  arr.forEach(function(el) {
    if (seen.has(el)) {
      return;
    }

    if (seen.has(k - el)) {
      var pair = [Math.min(k - el, el), Math.max(k - el, el)];
      pairs.add(pair);
    }

    seen.add(el);
  });

  return pairs;
}

// console.log(pairSum([1,5,3,4,6,3], 4));
