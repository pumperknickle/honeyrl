import Foundation
import Nimble
import Quick
import AwesomeDictionary
@testable import HoneyRL

final class QPolicySpec: QuickSpec {
    override func spec() {
        describe("math") {
            it("should transform scalars to probabilities") {
                let x = "a"
                let y = "b"
                let z = "c"
                let scalars = Mapping<String, Float>().setting(key: x, value: 1.0).setting(key: y, value: 2.0).setting(key: z, value: 7.0)
                let probs = scalars.transformToProbabilities()
                expect(probs[x]).to(equal(0.1))
                expect(probs[y]).to(equal(0.2))
                expect(probs[z]).to(equal(0.7))
            }
        }
    }
}
