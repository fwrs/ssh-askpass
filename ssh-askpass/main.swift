import LocalAuthentication

guard ProcessInfo.processInfo.environment["SSH_ASKPASS_PROMPT"] == "confirm" else { exit(1) }

let agentOutput = /Allow use of key (.+)\?\nKey fingerprint \S+\.(\npublic key authentication request for user ".*" to listed host)?/
let suffix = if CommandLine.arguments.count == 2, let match = CommandLine.arguments[1].wholeMatch(of: agentOutput) {
    " at \(match.1)"
} else {
    ""
}

do {
    try await LAContext().evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "use an SSH key\(suffix)")
} catch {
    exit(1)
}
