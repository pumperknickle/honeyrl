import Foundation
import AwesomeDictionary

/// An agent that can be used for honeypots. It learns episodes or requests and responses, and learns how to respond based on SARSA learning and maximimizing interaction with the attacker.
public struct HoneyAgent: Codable { }

extension HoneyAgent: Agent {
    public func reward(s1: StateType, s2: StateType) -> RewardType {
        return RewardType(1)
    }
    
    public typealias PolicyType = HoneyPolicy
}

extension HoneyAgent: SARSAAgent { }
