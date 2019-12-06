import Foundation
import Nimble
import Quick
import AwesomeDictionary
import AwesomeTrie
@testable import HoneyRL

final class CaptureAgentSpec: QuickSpec {
    override func spec() {
        describe("Agent learning") {
            typealias Episode = HoneyCaptureAgent.Episode
            typealias StateType = HoneyCaptureAgent.StateType
            typealias StateActionPair = HoneyCaptureAgent.StateActionPair
            let requests = Set((0...1000).map { _ in "\(Int.random(in: 0...100000))" })
            let responses = Set((0...1000).map { _ in "\(Int.random(in: 100001...200000))" })
            
            let validPairs = (0...100).reduce(TrieSet<String>()) { (result, entry) -> TrieSet<String> in
                let randomRequest = requests.randomElement()!
                let randomResponse = responses.randomElement()!
                return result.adding([randomRequest, randomResponse])
            }
            
            let maxPairs = (0...10).reduce(TrieSet<String>()) { (result, entry) -> TrieSet<String> in
                let randomRequest = requests.randomElement()!
                let randomResponse = responses.randomElement()!
                let pair = [randomRequest, randomResponse]
                if validPairs.contains(pair) { return result }
                return result.adding(pair)
            }
            
            let episodes = (0...1000).reduce(([], Set([]))) { (result, entry) -> ([Episode], Set<StateType>) in
                let episode = (0...Int.random(in: 0...20)).reduce(([], result.1)) { (res, ent) -> (Episode, Set<StateType>) in
                    let choice = ["valid", "max"].randomElement()
                    let unvisitedPair = validPairs.keySets().first(where: { !result.1.contains($0[0]) })
                    if choice == "max" && unvisitedPair != nil {
                        let maxPair = maxPairs.keySets().randomElement()!
                        let episode = res.0 + [StateActionPair((maxPair[0], maxPair[1]))] + [StateActionPair((unvisitedPair![0], unvisitedPair![1]))]
                        return (episode, res.1.union([unvisitedPair![0]]))
                    }
                    else {
                        let pair = validPairs.keySets().randomElement()!
                        let episode = res.0 + [StateActionPair((pair[0], pair[1]))]
                        return (episode, res.1.union([pair[0]]))
                    }
                }
                return (result.0 + [episode.0], episode.1)
            }.0
            let trainedAgent = HoneyCaptureAgent().learn(episodes: episodes)
            expect(episodes).toNot(beNil())
            let validRequestResponsePairs = validPairs.elements()
            let maxRequestResponsePairs = maxPairs.elements()
            let validRequestResponsePair = validRequestResponsePairs.randomElement()!
            let maxRequestResponsePair = maxRequestResponsePairs.randomElement()!
            let qValueOfValidRequestResponsePair = trainedAgent.policy.qValue(for: validRequestResponsePair.0[0], action: validRequestResponsePair.0[1])
            let qValueOfMaxRequestResponsePair = trainedAgent.policy.qValue(for: maxRequestResponsePair.0[0], action: maxRequestResponsePair.0[1])
            expect(qValueOfValidRequestResponsePair).toNot(beNil())
            expect(qValueOfMaxRequestResponsePair).toNot(beNil())
            expect(qValueOfMaxRequestResponsePair!).to(beGreaterThan(qValueOfValidRequestResponsePair!))
        }
    }
}
