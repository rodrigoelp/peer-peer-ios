import Foundation

enum MessageDirection {
    case incoming
    case outgoing
}

struct Message {
    let time: Date
    let content: String
    let direction: MessageDirection
    
    var description: String { get {
        let prefix = direction == .incoming ? "🔻" : "🔺"
        return "\(prefix) [\(self.time)]: \(self.content)"
        }
    }
    
    init(time: Date, content: String, direction: MessageDirection) {
        self.time = time
        self.content = content
        self.direction = direction
    }
    
    init(incoming: String) {
        self.init(time: Date(), content: incoming, direction: .incoming)
    }
    
    init(outgoing: String) {
        self.init(time: Date(), content: outgoing, direction: .outgoing)
    }
}
