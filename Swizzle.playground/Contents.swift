import Foundation
/*:
# Swizzle
 */
@objcMembers class Example {
  dynamic func originalMethod() -> String {
    return "OG"
  }
  
  dynamic func replacementMethod() -> String {
    return "Swizzle Swizzle Swizzle"
  }
}

let example = Example()

print(example.originalMethod())

guard
  let originalMethod = class_getInstanceMethod(Example.self, #selector(Example.originalMethod)),
  let swizzleMethod = class_getInstanceMethod(Example.self, #selector(Example.replacementMethod)) else {
    fatalError()
}

method_exchangeImplementations(originalMethod, swizzleMethod)

print(example.originalMethod())
