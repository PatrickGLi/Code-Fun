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

function isShuffle (str1, str2, str3) {
  var seen = new Hash();
  candidates = [[0, 0]];

  while (candidates.length > 0) {
    var candidate = candidates.shift();
    var firstNum = str1[candidate[0]];
    var secondNum = str2[candidate[1]];

    if (candidate[0] + candidate[1] === str3.length) {
      return true;
    }

    if (firstNum === str3[0]) {
      if (!seen[firstNum]) {
        candidates.push([candidate[0] + 1, candidate[1]]);
      }

      seen[firstNum] = true;
    }

    if (secondNum === str3[1]) {
      if (!seen[secondNum]) {
        candidates.push([candidate[0], candidate[1] + 1]);
      }
    }
  }

  return false;
};

function binary(num) {
  var result = ""
  while (!num == 0) {
    result += (num % 2).toString();

    num = Math.floor(n / 2);
  }

  return result;
};

function isBinaryTree(node, min, max) {

  var leftTree = node.left(),
      rightTree = node.right();

      if (leftTree >= min && leftTree <= max ||
      typeof max === "undefined") {
        var next = isBinaryTree(leftTree, min, node);

        if (next) {
          return true;
        }
      }

      if (rightTree >= min && rightTree <= max ||
      typeof min === "undefined") {
        var next = isBinaryTree(rightTree, node, min);

        if (next) {
          return true;
        }
      }


      return false;
};

function findCommonAncestor (root, nodeA, nodeB) {
  var currentNode = root;

  while (currentNode) {
    if (currentNode === nodeA || currentNode === nodeB) {
      return currentNode;
    }

    if (nodeA.value < currentNode.value && nodeB.value < currentNode.value) {
      currentNode = currentNode.left();
    } else if (nodeA.value > currentNode.value && nodeB.value > currentNode.value) {
      currentNode = currentNode.right();
    } else {
      return currentNode;
    }
  };

  return null;
};

var romanNumbers = [["M", 1000], ["D", 500], ["C", 100], ["L", 50], ["X", 10], ["V", 5], ["I", 1]];
var floors = [["C", 100], ["X", 10], ["I", 1]];

function romanNumerals(num, romanNumbers, floors) {
  if (num <= 0) {
    return "";
  }

  var result = "";

  while (num >= romanNumbers[0][1]) {
    result += romanNumbers[0][0];
    num -= romanNumbers[0][1];
  }

  var currentFloor = romanNumbers[0][1] === floors[0][1] ? floors.slice(1) : floors;

  if (currentFloor.length > 0) {
    var exception = romanNumbers[0][1] - currentFloor[0][1];

    if (num >= exception) {
      num -= exception;
      result += currentFloor[0][0] + romanNumbers[0][0];
    }
  }

  result += romanNumerals(num, romanNumbers.slice(1), currentFloor);

  return result;
};

// console.log(romanNumerals(900, romanNumbers, floors));

function makeChange(target, coins, cache) {
  if (target <= 0) {
    return [];
  }

  var bestChange = null;

  coins.forEach(function(coin) {
    if (coin > target) {
      return;
    }

    var remainder = target - coin;

    cache[remainder] = cache[remainder] || makeChange(remainder, coins, cache);
    var currentChange = cache[remainder].concat([coin]) ;

    if (bestChange === null || currentChange.length < bestChange.length) {
      bestChange = currentChange;
    }
  });

  cache[target] = bestChange;
  return bestChange;
};

// console.log(makeChange(14, [5,3,1], {}));

function numberOfWays(grid) {
  var directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  var queue = [[[0, 0], {}]];
  var numWays = 0;

  function inBounds(coordinates) {
    return coordinates[0] >= 0 && coordinates[0] < grid[0].length
    && coordinates[1] >= 0 && coordinates[1] < grid.length;
  };

  while (queue.length > 0) {
    var currentPosition = queue.shift();

    directions.forEach(function(direction) {
      var nextLocation = [currentPosition[0][0] + direction[0], currentPosition[0][1] + direction[1]];

      if (!inBounds(nextLocation)) {
        return;
      }

      // console.log("hey", grid[0].length - 1, grid.length - 1);

      if (nextLocation[0] === grid[0].length - 1 &&
          nextLocation[1] === grid.length - 1) {
        numWays ++;
        return;
      }

      var newMemo = {};

      for (var k in currentPosition[1]) {
        newMemo[k] = true;
      };

      if (!newMemo[nextLocation]) {
        newMemo[currentPosition[0]] = true;
        queue.push([nextLocation, newMemo]);
      }
    });
  }

  return numWays;
};

// console.log(numberOfWays([[1, 1, 1,1,1,1],[1,1,1,1,1,1],[1, 1, 1,1,1,1],[1,1,1,1,1,1,1], [1,1,1,1,1,1], [1,1,1,1,1,1]]));

function curriedSum(num){
  var currentSum = 0;

    function _curriedSum(nextNum) {
      if (typeof nextNum === "undefined") {
        return currentSum;
      }

      currentSum += nextNum;
      return _curriedSum;
    }

    return _curriedSum(num);
};

// console.log(curriedSum(3)(5)(-2)());

Array.prototype.insertionSort = function() {
  for (var partition = 1; partition < this.length; partition++) {
    var decrement = partition;
    while (decrement > 0) {
      if (this[decrement] < this[decrement - 1]) {
        var smaller = this[decrement];
        this[decrement] = this[decrement - 1];
        this[decrement - 1] = smaller;
        decrement --;
      } else {
        break;
      }
    }
  }

  return this;
};

// console.log([8,4,8,3,2,1,5].insertionSort());

function greatestProduct(num, adjacentDigits) {
  var greatestProduct = 0;

  var numString = num.toString();
  console.log(numString);
  for (var i = 0; i < numString.length - adjacentDigits - 1; i++) {
    var currentProduct = 1;
    for (var j = i; j < i + adjacentDigits; j++) {
      currentProduct = currentProduct * parseInt(numString[j]);
    }

    if (currentProduct > greatestProduct) {
      greatestProduct = currentProduct;
    }
  }

  return greatestProduct;
}

// console.log(greatestProduct(73167176531335, 4));
// sum the first n fibonacci numbers

function sumOfFibonacci(num) {
  var firstFib = 1;
  var secondFib = 1;
  var sum = firstFib + secondFib;
  for (var i = 0; i < num - 2; i++) {
    var tempFib = secondFib;
    secondFib = firstFib + secondFib;
    firstFib = tempFib;
    sum += secondFib;
  }

  return sum;
};

// console.log(sumOfFibonacci(4));

function recursiveFib(num) {
  if (num === 2) {
    return [1, 1]
  }

  var previousFibNumbers = recursiveFib(num - 1)

  var nextNumber = previousFibNumbers[previousFibNumbers.length - 1] + previousFibNumbers[previousFibNumbers.length - 2]

  return previousFibNumbers.concat([nextNumber]);
}

// console.log(recursiveFib(5));

Array.prototype.quickSort = function() {
  if (this.length <= 0) {
    return [];
  }

  var pivot = this.shift();

  var smallerArray = [],
      largerArray = [];
  for (var i = 0; i < this.length; i++) {
    if (this[i] >= pivot) {
      largerArray.push(this[i]);
    } else {
      smallerArray.push(this[i]);
    }
  }


  return smallerArray.quickSort().concat([pivot]).concat(largerArray.quickSort());
};

// console.log([5,3,2,6,7,3,8,9,4,2,6,8,5,5].quickSort());

Array.prototype.inPlaceQuicksort = function () {

  var queue = [{ start: 0, length: this.length }];

  // console.log(queue);

  while (queue.length > 0) {
    var currentSort = queue.shift();
    var pivot = this[currentSort.start];

    var startIndex = currentSort.start + 1;

    while (startIndex < currentSort.start + currentSort.length) {
      if (this[startIndex] < pivot) {

      }
    }


    console.log(this);
  }

};

[11,2,10,12,3, 9].inPlaceQuicksort();
[12, 2, 10, 11, 3, 9]
[3,2,10,11,12,9]


function recursiveSum(num) {
  if (num === 0) {
    return 0;
  }

  return num + recursiveSum(num - 1);
}

// console.log(recursiveSum(4));
