//
//  ImageDownloaderTests.swift
//  TestAppTests
//

import XCTest
@testable import Marvel_Character

final class ImageDownloaderTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testImageIsDownloaded() {
        let imageDownloader = DefaultImageDownloader()
        let url = URL(string: "https://assets.revolut.com/media/about/about_phone.png")!
        let exp = expectation(description: "\(url) image is downloaded")

        imageDownloader.downloadImage(
            from: url
        ) { result in
            switch result {
            case .success(let image):
                XCTAssert(image.size != .zero, "Image is decoded")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 20.0) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
