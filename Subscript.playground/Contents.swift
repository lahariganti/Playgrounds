import Foundation
/*:
# Subscripting
*/
extension Array {
  subscript(safe index: Int) -> Element? {
    return index < endIndex ? self[index] : nil
  }
}

let tasks: [String] = ["1", "2", "3", "4", "5"]
print(tasks[safe: 5])


struct Matrix {
  enum Element: String{
    case empty = "⬜️"
    case run = "🏃‍♀️"
    case lift = "🏋️‍♀️"
    case wings = "🍗"
  }

  typealias Coordinate = (x: Int, y: Int)

  private var elements: [[Element]] = [[ .empty, .run,   .empty, .run,   .empty, .run,   .empty, .run],
                                       [ .run,   .empty, .run,   .empty, .run,   .empty, .run,   .empty ],
                                       [ .lift, .empty, .lift, .empty, .lift, .empty, .lift, .empty  ],
                                       [ .run,   .empty, .run,   .empty, .run,   .empty, .run,   .empty ],
                                       [ .lift, .empty, .lift, .empty, .lift, .empty, .lift, .empty ],
                                       [ .lift, .empty, .lift, .empty, .lift, .empty, .lift, .empty ],
                                       [ .empty, .lift, .empty, .lift, .empty, .lift, .empty, .lift ],
                                       [ .lift, .empty, .lift, .empty, .lift, .empty, .lift, .empty ]]
  subscript(coordinate: Coordinate) -> Element {
    get {
      return elements[coordinate.x][coordinate.y]
    }

    set {
      elements[coordinate.x][coordinate.y] = newValue
    }
  }
}

extension Matrix: CustomStringConvertible {
  var description: String {
    return elements.map { row in
      row.map {
        $0.rawValue
      }.joined(separator: "")
    }.joined(separator: "\n") + "\n"
  }
}

var matrix = Matrix()
print(matrix)

let coordinate = (x: 3, y: 3)
matrix[coordinate] = .wings
print(matrix)
