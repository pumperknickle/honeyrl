import Foundation
import Nimble
import Quick
import AwesomeDictionary
@testable import HoneyRL

final class CaptureAgentSpec: QuickSpec {
    override func spec() {
        describe("Agent learning") {
            let req1 = "Hello"
            let req2 = "How are you"
            let req3 = "Goodbye"
            let resp1 = "Howdy"
            let resp2 = "Hi"
            let resp3 = "Good morning"
            let resp4 = "Good"
            let resp5 = "Great"
            let resp6 = "Bad"
            let resp7 = "Fine"
            let resp8 = "OK"
            let resp9 = "Bye"
            let resp10 = "Adios"
            
            let requests = [req1, req2, req3]
            let responses = [resp1, resp2, resp3, resp4, resp5, resp6, resp7, resp8, resp9, resp10]

            let validResponsesToRequests =
            Mapping<String, String>()
            .setting(key: req1, value: resp1)
            .setting(key: req1, value: resp2)
            .setting(key: req2, value: resp4)
            .setting(key: req2, value: resp5)
            .setting(key: req2, value: resp7)
            .setting(key: req3, value: resp9)
            
            let maxResponsesToRequests =
            Mapping<String, String>()
            .setting(key: req1, value: resp3)
            .setting(key: req2, value: resp6)
            .setting(key: req2, value: resp8)
            .setting(key: req3, value: resp10)
            
            let validRequestResponsePairs = validResponsesToRequests.elements()
            let maxRequestResponsePairs = maxResponsesToRequests.elements()
            
            let fakeEpisodes = (0...10000).map { _ in
                return (0..<Int.random(in: 1..<20)).map { _ in
                    return [[validRequestResponsePairs.randomElement()!], [maxRequestResponsePairs.randomElement()!] + [("\(Int.random(in: 0...10000))", responses.randomElement()!)]].randomElement()! + [(requests.randomElement()!, responses.randomElement()!)]
                }.reduce([], +)
            }
            let trainedAgent = HoneyCaptureAgent().learn(episodes: fakeEpisodes)
            expect(fakeEpisodes).toNot(beNil())
            let validRequestResponsePair = validRequestResponsePairs.randomElement()!
            let maxRequestResponsePair = maxRequestResponsePairs.randomElement()!
            let qValueOfValidRequestResponsePair = trainedAgent.policy.qValue(for: validRequestResponsePair.0, action: validRequestResponsePair.1)
            let qValueOfMaxRequestResponsePair = trainedAgent.policy.qValue(for: maxRequestResponsePair.0, action: maxRequestResponsePair.1)
            expect(qValueOfValidRequestResponsePair).toNot(beNil())
            expect(qValueOfMaxRequestResponsePair).toNot(beNil())
            let qValueOfInvalidRequestResponsePair = trainedAgent.policy.qValue(for: req1, action: resp7)
            expect(qValueOfValidRequestResponsePair!).to(beGreaterThan(qValueOfInvalidRequestResponsePair ?? 0.0))
            expect(qValueOfMaxRequestResponsePair!).to(beGreaterThan(qValueOfValidRequestResponsePair!))
        }
    }
}
