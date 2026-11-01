import LocalAuthentication

guard ProcessInfo.processInfo.environment["SSH_ASKPASS_PROMPT"] == "confirm" else { exit(1) }

do {
    try await LAContext().evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Confirm the use of an SSH key")
} catch {
    exit(1)
}
