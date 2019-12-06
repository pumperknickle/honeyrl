import Foundation

/// An agent learns a (possibly rewarding) policy given training data (episodes) and a reward function
public protocol Agent: Codable {
    /// The policy type the agent will learn
    associatedtype PolicyType: Policy
    /// The reward type the agent uses
    typealias RewardType = Float
    /// The action type the agent uses
    typealias ActionType = PolicyType.ActionType
    /// The state type the agent uses
    typealias StateType = PolicyType.StateType
    /// A state and an action
    typealias StateActionPair = (StateType, ActionType)
    /// An array of state action pairs
    typealias Episode = [StateActionPair]
    
    /// The agent's learned policy
    var policy: PolicyType! { get }
    
    /**
    Gets the reward for transitioning between two given states

    - parameters:
        - s1: the previous state
        - s2: the next state

    - returns: The reward for transitioning between s1 and s2
    */
    func reward(s1: StateType, s2: StateType) -> RewardType
    
    /**
    Learns given episodes

    - Parameter episodes: Training dataset of episodes

    - Returns: Agent after learning episodes
    */
    func learn(episodes: [Episode]) -> Self
    
    /**
    Updates the agent's learned policy

    - Parameter policy: Policy to update agent

    - Returns: Agent with newly updated policy
    */
    func update(policy: PolicyType) -> Self
    
    /**
    Transitions the agent with visiting a state

    - Parameter state: State to visit

    - Returns: Agent after visiting state
    */
    func visit(state: StateType) -> Self
}
