//
//  main.swift
//  TypeErasure
//
//  Created by Lahari Ganti on 8/20/20.
//  Copyright © 2020 Lahari Ganti. All rights reserved.
//

import Foundation

//struct AnyEquatable: Equatable {
//  var item: Any
//  let equals: (AnyEquatable) -> Bool
//
//  init<T: Equatable>(_ item: T) {
//    self.item = item
//    self.equals = { item == $0.item as? T }
//  }
//
//  static func == (lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
//    lhs.equals(rhs)
//  }
//
//  static func==<Other: Equatable>(lhs: AnyEquatable, rhs: Other) -> Bool {
//    (lhs.item as? Other) == rhs
//  }
//
//  static func==<Other: Equatable>(lhs: Other, rhs: AnyEquatable) -> Bool {
//    (rhs.item as? Other) == lhs
//  }
//}
//
//
//print(AnyEquatable(1) == AnyEquatable("WUT"))
//print(AnyEquatable(12) == 1)
//print(AnyEquatable(12) == 12)

// https://github.com/apple/swift/blob/master/stdlib/public/core/ExistentialCollection.swift

protocol Cache {
  associatedtype Storage
  
  var status: String { get }
  
  mutating func add(item: Storage)
  func listItems() -> [Storage]
}

struct File {
  let name: String
}

struct LocalCache: Cache {
  var items = [File]()
  
  var status: String {
    if items.count == 10 {
      return "Full"
    } else {
      return "Open"
    }
  }
  
  mutating func add(item: File) {
    items.append(item)
  }
  
  func listItems() -> [File] {
    items
  }
}


struct DistributedCache: Cache {
  var items = [File]()
  
  var status: String {
    if items.count == 100 {
      return "Full"
    } else {
      return "Open"
    }
  }
  
  mutating func add(item: File) {
    items.append(item)
    synchronize()
  }
  
  func synchronize() {
    
  }
  
  func listItems() -> [File] {
    items
  }
}


// crashing parent class that conforms to the protocol
class _AnyCacheBox<Storage>: Cache {
  var status: String {
    fatalError("Must be overridden")
  }
  
  func add(item: Storage) {
   fatalError("Must be overridden")
  }
  
  func listItems() -> [Storage] {
    fatalError("Must be overridden")
  }
}

final class _CacheBox<C: Cache>: _AnyCacheBox<C.Storage> {
  private var _base: C
  
  override var status: String {
    _base.status
  }
  
  init(_ base: C) {
    self._base = base
  }
  
  override func add(item: C.Storage) {
    _base.add(item: item)
  }
  
  override func listItems() -> [C.Storage] {
    _base.listItems()
  }
}


struct AnyCache<Storage>: Cache {
  private let _box: _AnyCacheBox<Storage>
  
  var status: String {
    _box.status
  }
  
  init<C: Cache>(_ base: C) where C.Storage == Storage {
    _box = _CacheBox(base)
  }
  
  func add(item: Storage) {
    _box.add(item: item)
  }
  
  func listItems() -> [Storage] {
    _box.listItems()
  }
}


var caches = [AnyCache(LocalCache), AnyCache(DistributedCache)]

