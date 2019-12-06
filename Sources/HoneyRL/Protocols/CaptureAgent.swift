import Foundation
import AwesomeDictionary

/// An agent that can be used for honeypots. It learns episodes or requests and responses, and learns how to respond based on SARSA learning and maximimizing information capture from the attackers. It essentially rewards transitioning into an unvisited state much more than transitioning into a visited state.
public protocol CaptureAgent: Agent {
    /// States that have been visited
    var visited: Set<StateType> { get }
    
    func add(state: StateType) -> Self
}

public extension CaptureAgent {
    func reward(s1: StateType, s2: StateType) -> RewardType {
        if !visited.contains(s2) { return RewardType(1) }
        return RewardType(0.01)
    }
    
    /**
    Visits state

    - Parameter state: State to visit

    - Returns: Agent after visiting state.
    */
    func visit(state: StateType) -> Self {
        return add(state: state)
    }
}
