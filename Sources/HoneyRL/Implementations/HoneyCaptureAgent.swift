import Foundation
import AwesomeDictionary

public struct HoneyCaptureAgent: Codable {
    private let rawPolicy: PolicyType!
    private let rawVisited: Set<StateType>!
    
    public init(policy: PolicyType = PolicyType(), visited: Set<StateType> = Set<StateType>()) {
        rawPolicy = policy
        rawVisited = visited
    }
}

extension HoneyCaptureAgent: Agent {
    public typealias PolicyType = HoneyPolicy
    public var policy: HoneyPolicy! { return rawPolicy }
    
    public func update(policy: HoneyPolicy) -> HoneyCaptureAgent {
        return Self(policy: policy, visited: visited)
    }
}

extension HoneyCaptureAgent: SARSAAgent { }

extension HoneyCaptureAgent: CaptureAgent {
    public var visited: Set<String> { return rawVisited }
    
    public func add(state: String) -> HoneyCaptureAgent {
        return Self(policy: policy, visited: visited.union([state]))
    }
}

