import Foundation

func fibonacci(_ number: Int) -> Int {
  number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
}

func memoize<Input: Hashable, Output>(_ function: @escaping (Input) -> Output) -> (Input) -> Output {
  var storage = [Input: Output]()
  
  return { input in
    if let cached = storage[input] {
      return cached
    }
    
    let result = function(input)
    storage[input] = result
    return result
  }
}

func recursiveMemoize<Input: Hashable, Output>(_ function: @escaping ((Input) -> Output, Input) -> Output) -> (Input) -> Output {
  var storage = [Input: Output]()
  var memo: ((Input) -> Output)!
  
  memo = { input in
    if let cached = storage[input] {
      return cached
    }
    
    let result = function(memo, input)
    storage[input] = result
    return result
  }
  
  return memo
}

func measure() {
  let start = CFAbsoluteTimeGetCurrent()
  //  let memoizedFib = memoize(fibonacci)
  let memoizedFibonacci = recursiveMemoize { fibonacci, number in
    number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
  }
  
  (0...40).forEach { i in
    print(memoizedFibonacci(i))
  }
  
  
  let diff = CFAbsoluteTimeGetCurrent() - start
  print("Took \(diff) seconds")
}

measure()
