import Foundation

enum MessageDirection {
    case incoming
    case outgoing
}

struct Message {
    let time: Date
    let content: String
    let direction: MessageDirection
    private let dateFormatter = DateFormatter()
    
    var description: String { get {
        let prefix = direction == .incoming ? "🔻" : "🔺"
        let printedDate = self.dateFormatter.string(from: self.time)
        return "\(prefix) [\(printedDate)]: \(self.content)"
        }
    }
    
    init(time: Date, content: String, direction: MessageDirection) {
        self.time = time
        self.content = content
        self.direction = direction
        
        dateFormatter.dateFormat = "HH:mm:ss"
    }
    
    init(incoming: String) {
        self.init(time: Date(), content: incoming, direction: .incoming)
    }
    
    init(outgoing: String) {
        self.init(time: Date(), content: outgoing, direction: .outgoing)
    }
}
