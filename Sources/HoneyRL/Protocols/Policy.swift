import Foundation
import AwesomeDictionary

/// A policy chooses actions for given states
public protocol Policy: Codable {
    /// The state type of the policy
    associatedtype StateType: State
    /// The action type of the policy
    associatedtype ActionType: Action
    
    /**
    Chooses an action given a state

    - Parameter state: The input state

    - Returns: An action chosen by the policy
    */
    func choose(for state: StateType) -> ActionType?
}
