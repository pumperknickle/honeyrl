# HoneyRL

HoneyRL uses SARSA learning to determine a policy from a given list of states and actions taken - and a corresponding reward function.

In honeypot terms, an adverseries request can be considered a state, and the honeypot's response can be considered an action taken. SARSA learning is used to determine a policy from a given list of adversary interactions - a list of adversary requests and corresponding honeypot responses. The policy is a probability distribution of actions for any given state.

```swift
let policy = HoneyAgent().learn(episodes: episodes)
```
