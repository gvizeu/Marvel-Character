//
//  CharacterListInteractorTests.swift
//  Marvel CharacterTests
//
//  Created by Gonzalo Vizeu on 23/2/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import XCTest
@testable import Marvel_Character

class CharacterListInteractorTests: XCTestCase {

    var interactor = CharacterListInteractor(session: CharacterRepositoryMock(session: MockAPI()))
    var presenter = CharacterListPresenterMock()
    
    override func setUp() {
        super.setUp()
        interactor.presenter = presenter
    }
    
    func test_load_characteres_from_dto_model() {
        interactor.getCharacters(offset: nil, limit: nil, name: nil)
        
        let characters = presenter.characteres?.characters
        XCTAssertGreaterThan(presenter.characteres?.total ?? 0, 0)
        guard let name = characters?.first?.name else {
            XCTFail("Could not get the name")
            return
        }
        XCTAssertEqual(name, "3-D Man")
    }
    
    func test_load_characteres_from_bad_request() {
        interactor.getCharacters(offset: nil, limit: nil, name: "MockFail")
        XCTAssertTrue(presenter.didDisplayError)
    }
}

class CharacterListPresenterMock: CharacterListPresentersOutput {
    var characteres: Characters?
    var didDisplayError = false
    
    func displayFetchedCharacters(_ model: Characters) {
        characteres = model
    }
    func displayError(title: String?, msg: String?) {
        didDisplayError = true
    }
}
