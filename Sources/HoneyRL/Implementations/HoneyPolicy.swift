import Foundation
import AwesomeDictionary
import Bedrock

/// A policy that can be used for honeypots to respond to requests
public struct HoneyPolicy: Codable {
    private let rawQValues: Mapping<StateType, Mapping<ActionType, Float>>!
    
    public init(qValues: Mapping<StateType, Mapping<ActionType, Float>> = Mapping<StateType, Mapping<ActionType, Float>>()) {
        rawQValues = qValues
    }
}

extension HoneyPolicy: Policy {
    public typealias StateType = String
    public typealias ActionType = String
}

extension HoneyPolicy: QPolicy {
    public var qValues: Mapping<String, Mapping<String, Float>> { return rawQValues }
}

extension String: State { }
extension String: Action { }
