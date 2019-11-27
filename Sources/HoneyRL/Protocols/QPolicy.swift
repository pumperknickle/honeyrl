import Foundation
import AwesomeDictionary

/// A policy that determined by Q values - which intend to measure the quality of any given state in respect to the reward received
public protocol QPolicy: Policy {
    // The Q values that calculate the policy
    var qValues: Mapping<StateType, Mapping<ActionType, Float>> { get }
    
    /**
    Initializes a new q policy with provided q-values

    - Parameter qValues: The Q values to define the policy

    - Returns: A policy based on Q values that chooses an action for a given state
    */
    init(qValues: Mapping<StateType, Mapping<ActionType, Float>>)
    
    /**
    Initializes a new Q policy with provided Q-values

    - Parameters:
     - state: The state to change the Q values for
     - action: The action to change the Q value for
     - to: The q value that will be set

    - Returns: A new policy with the modified Q value
    */
    func changing(state: StateType, action: ActionType, to scalar: Float) -> Self
}

public extension QPolicy {
    func choose(for state: StateType) -> ActionType? {
        guard let stateProbabilities = probability(for: state) else { return nil }
        return Self.choose(elements: stateProbabilities.elements())
    }
    
    func changing(state: StateType, action: ActionType, to scalar: Float) -> Self {
        guard let stateProbabilities = qValues[state] else {
            return Self(qValues: qValues.setting(key: state, value: Mapping<ActionType, Float>().setting(key: action, value: scalar)))
        }
        return Self(qValues: qValues.setting(key: state, value: stateProbabilities.setting(key: action, value: scalar)))
    }
}

extension QPolicy {
    func qValues(for state: StateType) -> Mapping<ActionType, Float>? {
        return qValues[state]
    }
    
    func qValue(for state: StateType, action: ActionType) -> Float? {
        guard let qValueSet = qValues[state] else { return nil }
        return qValueSet[action]
    }

    func probability(for state: StateType) -> Mapping<ActionType, Float>? {
        return qValues(for: state)?.transformToProbabilities()
    }
    
    static func choose(elements: [(ActionType, Float)]) -> ActionType? {
        return Self.choose(runningValue: 0, chosenValue: Float.random(in: 0..<1), elements: elements)
    }

    static func choose(runningValue: Float, chosenValue: Float, elements: [(ActionType, Float)]) -> ActionType? {
        guard let firstElement = elements.first else { return nil }
        let newRunningValue = runningValue + firstElement.1
        if chosenValue < newRunningValue { return firstElement.0 }
        return Self.choose(runningValue: newRunningValue, chosenValue: chosenValue, elements: Array(elements.dropFirst()))
    }
}

public extension Mapping where Value == Float {
    func transformToProbabilities() -> Mapping<Key, Value> {
        let scalarValues = elements()
        let totalValue = scalarValues.map { $0.1 }.reduce(0, +)
        return scalarValues.reduce(Mapping<Key, Value>()) { (result, entry) -> Mapping<Key, Value> in
            return result.setting(key: entry.0, value: entry.1/totalValue)
        }
    }
}
