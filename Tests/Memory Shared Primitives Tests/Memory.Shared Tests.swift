import Testing

@testable import Memory_Shared_Primitives

extension Memory.Shared {
    @Suite struct Tests {
        @Test func `namespace is available`() {

            #expect(Bool(true))
        }
    }
}
