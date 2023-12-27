import XCTest
@testable import CalculatorEx

final class CalculatorViewModelTests: XCTestCase {

    private var viewModel: CalculatorViewModel!
    
    private var mockBrain: CalculateBrainMock!

    override func setUp() {
        mockBrain = CalculateBrainMock()
        viewModel = CalculatorViewModel(mockBrain)
    }

    func testAllCleanHandler() {
        let expectation = expectation(description: "AC completion hanlder")
        viewModel.allCleanCompletionHandler = {
            expectation.fulfill()
        }
        viewModel.cleanAllCalculation()
        waitForExpectations(timeout: 0.1)
    }

    func testAssistantHandler() {
        let resultFromAnotherSide = "910"
        let expectation = expectation(description: "AC completion hanlder")
        viewModel.assistantCompletionHandler = { val in
            XCTAssertEqual(val, resultFromAnotherSide)
            expectation.fulfill()
        }
        viewModel.addAssitantValue(resultFromAnotherSide)
        waitForExpectations(timeout: 0.1)
    }

    func testPerformResult() {
        mockBrain.mockResult = 54.2
        XCTAssertEqual(viewModel.getPerformResult(), mockBrain.mockResult)
    }
}
