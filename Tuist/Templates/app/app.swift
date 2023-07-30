import ProjectDescription
import ProjectDescriptionHelpers

private let nameAttribute: Template.Attribute = .optional("name", default: "App")

private let template = Template(
    description: "App Template",
    attributes: [
        nameAttribute,
        .optional("platform", default: "iOS")
    ],
    items: [
        // MARK: - Project.swift
        .file(path: "Projects/\(nameAttribute)/Project.swift", templatePath: "Contents/project.stencil"),
        // MARK: - Tests
        .string(path: "Projects/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift", contents:
                """
                import XCTest
                @testable import \(nameAttribute)

                final class \(nameAttribute)Tests: XCTestCase {

                    override func setUpWithError() throws {
                        // Put setup code here. This method is called before the invocation of each test method in the class.
                    }

                    override func tearDownWithError() throws {
                        // Put teardown code here. This method is called after the invocation of each test method in the class.
                    }

                    func testExample() throws {
                        // This is an example of a functional test case.
                        // Use XCTAssert and related functions to verify your tests produce the correct results.
                        // Any test you write for XCTest can be annotated as throws and async.
                        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
                        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
                    }

                    func testPerformanceExample() throws {
                        // This is an example of a performance test case.
                        self.measure {
                            // Put the code you want to measure the time of here.
                        }
                    }

                }
                """),
        .directory(path: "Projects/\(nameAttribute)/Tests", sourcePath: "Contents/Resources"),
        // MARK: - Sources
        .file(path: "Projects/\(nameAttribute)/Sources/Main\(nameAttribute).swift", templatePath: "Contents/main.stencil"),
        .file(path: "Projects/\(nameAttribute)/Sources/ContentView.swift", templatePath: "Contents/contentView.stencil"),
        .directory(path: "Projects/\(nameAttribute)/Sources", sourcePath: "Contents/Resources"),
    ]
)
