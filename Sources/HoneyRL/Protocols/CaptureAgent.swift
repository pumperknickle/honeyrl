import Foundation
import AwesomeDictionary

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
    
    func visit(state: StateType) -> Self {
        return add(state: state)
    }
}
