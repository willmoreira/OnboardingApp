protocol EventLogging {
    func sendEvent(_ event: String)
    func sendEvent(_ event: String, parameters: [String: Any])
}

class ConsoleEventLogger: EventLogging {
    func sendEvent(_ event: String) {
        print("Evento: \(event) ")
    }

    func sendEvent(_ event: String, parameters: [String: Any]) {
        print("Evento: \(event) parâmetros: \(parameters)")
    }
}
