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


Array.prototype.mergeSort = function(){
  if (this.length <= 1) {
    return this;
  }

  var median = Math.floor(this.length / 2)

  var leftArray = this.slice(0, median),
      rightArray = this.slice(median, this.length);

  return merge(leftArray.mergeSort(), rightArray.mergeSort());
};

function merge(leftArray, rightArray) {

  var leftIndex = 0, rightIndex = 0, result = [];

  while (leftIndex < leftArray.length && rightIndex < rightArray.length) {
    if (leftArray[leftIndex] <= rightArray[rightIndex]) {
      result.push(leftArray[leftIndex]);
      leftIndex ++;
    } else {
      result.push(rightArray[rightIndex]);
      rightIndex ++;
    }
  }

  return result.concat(leftArray.slice(leftIndex, leftArray.length)).concat(rightArray.slice(rightIndex, rightArray.length));
};

// console.log([1,6,1,2,5,9,2,5].mergeSort());

function binarySearch(sortedArray, target) {
  if (sortedArray.length === 0) {
    return null;
  }

  var median = Math.floor(sortedArray.length / 2);

  var firstHalf = sortedArray.slice(0, median),
      rightHalf = sortedArray.slice(median + 1, sortedArray.length);

      console.log(rightHalf);
  if (sortedArray[median] === target) {
    return median;
  } else if (sortedArray[median] > target) {
    return binarySearch(firstHalf, target);
  } else {
    var result = binarySearch(rightHalf, target);
    if (result === null) {
      return null;
    }

    return result + median + 1;
  };
}

// console.log(binarySearch([1,2,5,7,9,10], 6.5));

function productify(arr) {
  var leftProd = [1];
  var i = 0;
  while (i < arr.length - 1) {
    leftProd.push(arr[i] * leftProd[leftProd.length - 1]);
    i++;
  }

  // console.log(leftProd);

};

// productify([1,2,4,5]);

function subsets(arr) {
  if (arr.length === 0) {
    return [[]];
  }

  var previous = subsets(arr.slice(1, arr.length));

  var newer = previous.map(function(combo) {
    return [arr[0]].concat(combo);
  })

  return previous.concat(newer);
};

// console.log(subsets([1,4,6,7]));

function palindrome(string) {
  var bestPalindromeStart = 0,
      palindromeLength = 1;

  var i = 0;
  while (i < string.length - palindromeLength) {
    if (isPalindrome(string.substring(i, i + palindromeLength + 1))) {
      palindromeLength ++;
      bestPalindromeStart = i;
    } else {
      i++;
    }
  }

  return [bestPalindromeStart, bestPalindromeStart + palindromeLength]
};

function isPalindrome(string) {
  for (var i = 0; i < Math.floor(string.length / 2); i++) {
    if (string[i] !== string[string.length - i - 1]) {
      return false;
    }
  };

  return true;
};

function sum(num) {
  while (typeof num !== "undefined") {
    function addNumber(nextNum) {
      if (typeof nextNum === "undefined") {
        return num;
      }
      num += nextNum;
      return addNumber;
    }

    return addNumber;
  }
}

// console.log(sum(3)(4)); // 7
// console.log(sum(3)(4)(3)(5)(-1)()); // 14

function canWin(arr, target) {
  var log = new Set();

  var queue = [[arr[0], 0]];

  while (queue.length > 0) {
    var firstValue = queue.drop;

    if (firstValue[0] === target) {
      return firstValue[1];
    }

    var leftIndex = firstValue[1] - firstValue[0],
        rightIndex = firstValue[1] + firstValue[1];

    if (leftIndex <= 0) {
      if (!log.include(arr[leftIndex])) {
        queue.push([arr[leftIndex], leftIndex]);
        log.add(arr[leftIndex]);
      }
    }

    if (rightIndex > arr.length) {
      if (!log.include(arr[rightIndex])) {
        queue.push([arr[rightIndex], rightIndex]);
        log.add(arr[rightIndex]);
      }
    }


  }

  return -1;
};

function moveZeros(arr) {
  var index = 0,
      numZeros = 0;

  while (index < arr.length - numZeros) {
    if (arr[index] === 0) {
      arr[index], arr[arr.length - 1 - numZeros] = arr[arr.length - 1 - numZeros], arr[index];
    } else {
      index ++;
    }
  }

  return arr;
};

function lookAndSay(arr) {
  var result = [];

  var index = 0;

  while (index < arr.length) {
    if (result.length === 0) {
      result.push([arr[index], 1]);
      index ++;
      continue;
    }

    if (arr[index] === result[result.length - 1][0]) {
      result[result.length - 1][1] ++;
    } else {
      result.push([arr[index], 1]);
    }

    index ++;
  }

  return result;
};

var Stack = function() {
  this.stack = [];
  this.min = [];
  this.max = [];
};

Stack.prototype.push = function(el) {
  this.stack.push(el);
  if (el > this.max[this.max.length - 1]) {
    this.max.push(el);
  } else {
    this.max.push(this.max[this.max.length - 1]);
  }
  return this.stack;
};

Stack.prototype.pop = function() {
  this.stack.pop();
  this.max.pop();
  this.min.pop();
  return this.stack;
};

Stack.prototype.max = function() {
  return this.max[this.max.length - 1];
};


var MinMaxStackQueue = function() {
  this.enqueue = new Stack();
  this.dequeue = new Stack();
};

MinMaxStackQueue.prototype.enqueue = function(el) {
  this.enqueue.push(el);
};

MinMaxStackQueue.prototype.dequeue = function() {

};

MinMaxStackQueue.prototype.max = function() {
  return [this.enqueue.max(), this.dequeue.max()].max;
};

function windowMaxedRange(arr, windowSize) {
  // use min max stack queue to queue until reaches windowssize
  // then continually enqueu and dequeue
  //the max and min can be found
};

function curriedSum(num) {
  if (typeof num === "undefined") {
    return null;
  }

  function _curriedSum(nextNum) {
    if (typeof nextNum === "undefined") {
      return num;
    }
    num += nextNum;
    return _curriedSum;
  };

  return _curriedSum;
};

// console.log(curriedSum(3)(4)(-1)(4)());


// console.log(lookAndSay([1, 2, 1, 1]));

//sums upon sums add all the numbers together and divide by total number of elements
// difference will equate to misisng number
