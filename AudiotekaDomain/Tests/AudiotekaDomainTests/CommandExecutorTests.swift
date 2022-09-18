import Foundation
import XCTest
@testable import AudiotekaDomain

final class CommandExecutorTests: XCTestCase {
    
    var sut: CommandExecutorImpl!
    var httpClientMock: HttpClientMock!
    
    override func setUp() {
        super.setUp()
        httpClientMock = HttpClientMock()
        sut = CommandExecutorImpl(httpClient: httpClientMock)
    }
    
    override func tearDown() {
        sut = nil
        httpClientMock = nil
        super.tearDown()
    }
    
    func test_pass_correct_dictionary_to_http_client() throws {
        let sampleCommand = ApiCommand(name: "Lorem")
        sampleCommand.params["key1"] = "value2"
        sampleCommand.params["key2"] = "value3"
        
        _ = try sut.execute(command: sampleCommand).data()
        
        XCTAssertTrue(httpClientMock.callRest_called)
        XCTAssertEqual(httpClientMock.callRest_params?["key1"], "value2")
        XCTAssertEqual(httpClientMock.callRest_params?["key2"], "value3")
    }
    
    func test_throw_error_from_http_client() {
        let sampleCommand = ApiCommand(name: "Lorem")
        httpClientMock.callRest_throw_error = SampleError()
        
        do {
            _ = try sut.execute(command: sampleCommand).data()
            XCTFail()
        } catch let error {
            XCTAssertTrue(error is SampleError)
        }
    }
}
