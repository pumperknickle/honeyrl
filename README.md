# HoneyRL

<p align="left">
  <a href="https://github.com/pumperknickle/honeyrl/actions?query=workflow%3ABuild"><img alt="GitHub Actions status" src="https://github.com/pumperknickle/honeyrl/workflows/Build/badge.svg"></a>
</p>

HoneyRL uses SARSA learning to determine a policy from a given list of states and actions taken - and a corresponding reward function.

In honeypot terms, an adverseries request can be considered a state, and the honeypot's response can be considered an action taken. SARSA learning is used to determine a policy from a given list of adversary interactions - a list of adversary requests and corresponding honeypot responses. The policy is a probability distribution of actions for any given state.

```swift
let policy = HoneyAgent().learn(episodes: episodes)
```

HoneyRL can also be configured to maximize information capture from attackers.

```swift
let policy = HoneyCaptureAgent().learn(episodes: episodes)
```

## Installation
### Swift Package Manager

Add honeyrl to the dependencies and the appropriate targets in Package.swift
```swift
.package(url: "https://github.com/pumperknickle/honeyrl.git", from: "1.0.0")
```
