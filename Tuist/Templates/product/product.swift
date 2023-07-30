//
//  product.swift
//  ProjectDescriptionHelpers
//
//  Created by 정종인 on 2023/07/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let nameAttribute: Template.Attribute = .required("name")

private let template = Template(
    description: "Product Template",
    attributes: [
        nameAttribute,
        .optional("platform", default: "iOS")
    ],
    items: [
        // MARK: - Project.swift
        .file(path: "Projects/\(nameAttribute)/Project.swift", templatePath: "Contents/project.stencil"),
        // MARK: - Example
        .file(path: "Projects/\(nameAttribute)/Example/\(nameAttribute)Example.swift", templatePath: "Contents/example.stencil"),
        .file(path: "Projects/\(nameAttribute)/Example/ContentView.swift", templatePath: "Contents/contentView.stencil"),
        .directory(path: "Projects/\(nameAttribute)/Example", sourcePath: "Contents/Resources"),
        // MARK: - Tests
        .string(path: "Projects/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift", contents:
                """
                import XCTest
                @testable import \(nameAttribute)Testing

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
        // MARK: - Testing
        .string(path: "Projects/\(nameAttribute)/Testing/\(nameAttribute)Testing.swift", contents:
                """
                import Foundation
                
                struct \(nameAttribute)Testing {}
                """),
        // MARK: - Sources
        .string(path: "Projects/\(nameAttribute)/Sources/\(nameAttribute).swift", contents:
                """
                import Foundation
                
                struct \(nameAttribute) {}
                """),
        .directory(path: "Projects/\(nameAttribute)/Sources", sourcePath: "Contents/Resources"),
        // MARK: - Interface
        .string(path: "Projects/\(nameAttribute)/Interface/\(nameAttribute)Interface.swift", contents:
                """
                import Foundation
                
                protocol \(nameAttribute)Interface {}
                """),
    ]
)
