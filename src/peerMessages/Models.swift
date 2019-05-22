enum MessageDirection {
    case incoming
    case outgoing
}

struct Message {
    let time: Date
    let content: String
    let direction: MessageDirection
}
