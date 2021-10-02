import XCTest
import class Foundation.Bundle

final class HelloTests: XCTestCase {
    private func testFits(arguments : [String] ) throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Mac Catalyst won't have `Process`, but it is supported for executables.
        #if !targetEnvironment(macCatalyst)

        let fooBinary = productsDirectory.appendingPathComponent("Hello")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe
        
        process.arguments = arguments

        try process.run()
        process.waitUntilExit()
        
        // Should fit as represented by the zero exit code
        XCTAssertEqual(process.terminationStatus, 0)

        #endif
    }
    
    private func testFitsNot(arguments : [String] ) throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Mac Catalyst won't have `Process`, but it is supported for executables.
        #if !targetEnvironment(macCatalyst)

        let fooBinary = productsDirectory.appendingPathComponent("Hello")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe
        
        process.arguments = arguments

        try process.run()
        process.waitUntilExit()
        
        // Should fit as represented by the zero exit code
        XCTAssertEqual(process.terminationStatus, 1)

        #endif
    }
    
    // The case where no arguments are supplied
    func testEmpty() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        // Mac Catalyst won't have `Process`, but it is supported for executables.
        #if !targetEnvironment(macCatalyst)

        let fooBinary = productsDirectory.appendingPathComponent("Hello")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe
        
        process.arguments = []

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
        // Should contain Usage instructions
        XCTAssertTrue(((output?.contains("USAGE:")) != nil))
        XCTAssertEqual(process.terminationStatus, 64)

        #endif
    }
    
    func testFaceWeightFits() throws {
        let arguments = [
            "--placement", "face",
           "--weight", "0.4"
        ]
        try testFits(arguments: arguments)

    }
    
    func testFaceWeightFitsNot() throws {
        let arguments = [
            "--placement", "face",
           "--weight", "0.6"
        ]
        try testFitsNot(arguments: arguments)

    }
    
    func testForearmWeightFits() throws {
        let arguments = [
            "--placement", "forearm",
           "--weight", "0.49"
        ]
        try testFits(arguments: arguments)

    }
    
    func testForearmWeightFitsNot() throws {
        let arguments = [
            "--placement", "forearm",
           "--weight", "1"
        ]
        try testFitsNot(arguments: arguments)

    }
    
    func testBiceptWeightFits() throws {
        let arguments = [
            "--placement", "bicep",
           "--weight", "4.9"
        ]
        try testFits(arguments: arguments)

    }
    
    func testBiceptWeightFitsNot() throws {
        let arguments = [
            "--placement", "bicep",
           "--weight", "5.1"
        ]
        try testFitsNot(arguments: arguments)

    }
    
    func testWaistWeightFits() throws {
        let arguments = [
            "--placement", "waist",
           "--weight", "4.9"
        ]
        try testFits(arguments: arguments)

    }

    /// Specific device tests
    func testDevice_AppleWatchSeries6Alum40mm() throws {
        let arguments = [
            "--placement", "forearm",
            // 30.5 grams
           "--weight", "0.0672"
        ]
        try testFits(arguments: arguments)

    }
    
    func testDevice_GoogleGlass() throws {
        let arguments = [
            "--placement", "face",
            // ~46 grams https://en.wikipedia.org/wiki/Google_Glass
           "--weight", "0.1"
        ]
        try testFits(arguments: arguments)

    }
    
    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }
}
