//
//  CharacterListPresenterTests.swift
//  Marvel CharacterTests
//
//  Created by Gonzalo Vizeu on 24/2/22.
//  Copyright © 2022 Gonzalo Vizeu. All rights reserved.
//

import XCTest
@testable import Marvel_Character

class CharacterListPresenterTests: XCTestCase {
    
    var presenter  = CharaterListPresenter()
    var interactor = CharactersListInteractorMock()
    var interface = CharacterListInterfaceMock()

    override func setUp() {
        super.setUp()
        presenter.interactor = interactor
        presenter.viewController = interface
    }
    
    func test_load_characteres_when_load_page() {
        presenter.getCharacters()
        XCTAssertTrue(interactor.didGetCharacters)
        XCTAssertNil(interactor.charName)
    }
    
    func test_get_characters_by_name() {
        let name = "Juan"
        presenter.getCharacters(by: "Juan")
        XCTAssertTrue(interactor.didGetCharacters)
        XCTAssertEqual(interactor.charName, name)
    }
    
    func test_get_more_characters() {
        let name = ""
        let nCharacteres = 20
        presenter.displayFetchedCharacters(CharacteresMock.getFullCharacteres())
        presenter.getMoreCharacters(loadedCharateres: nCharacteres, name: name)
        XCTAssertTrue(interactor.didGetCharacters)
        XCTAssertNil(interactor.charName)
        XCTAssertEqual(interactor.nCharacteres, nCharacteres)
    }
    
    func test_get_more_characters_when_data_is_loading() {
        let name = ""
        let nCharacteres = 20
        presenter.setDataLoading(true)
        presenter.getMoreCharacters(loadedCharateres: nCharacteres, name: name)
        
        XCTAssertNil(interactor.nCharacteres)
        XCTAssertNil(interactor.charName)
        XCTAssertFalse(interactor.didGetCharacters)
    }
    
    func test_when_user_ends_filtering() {
        presenter.didFinishFiltering()
        XCTAssertTrue(interactor.didGetCharacters)
        XCTAssertNil(interactor.charName)
    }
    
    func test_display_characteres_when_has_characteres() {
        presenter.displayFetchedCharacters(CharacteresMock.getFullCharacteres())
        XCTAssertTrue(interface.didDisplayCharacteres)
    }
    
    func test_display_characteres_when_nil_characteres() {
        presenter.displayFetchedCharacters(CharacteresMock.getNilCharacteres())
        XCTAssertTrue(interface.didDisplayError)
    }
    
    func test_display_characteres_when_load_more_characteres() {
        presenter.getMoreCharacters(loadedCharateres: 30, name: "")
        presenter.displayFetchedCharacters(CharacteresMock.getFullCharacteres())
        XCTAssertTrue(interface.didDisplayAppendingCharacteres)
    }

}

class CharactersListInteractorMock: CharaterListBusinessLogic {
    var didGetCharacters: Bool = false
    var charName: String? = nil
    var nCharacteres: Int? = nil
    func getCharacters(offset: Int?, limit: Int?, name: String?) {
        didGetCharacters = true
        charName = name
        nCharacteres = limit
    }
    
    
}

class CharacterListInterfaceMock: CharacterListDisplayLogic {
    var didDisplayCharacteres = false
    var didDisplayAppendingCharacteres = false
    var didDisplayError = false
    var didShowTableViewLoader = false
    
    
    func displayCharacters(_ characters: [Character]) {
        didDisplayCharacteres = true
    }
    
    func displayAppendingCharacters(_ characters: [Character]) {
        didDisplayAppendingCharacteres = true
    }
    
    func displayError(title: String?, msg: String?) {
        didDisplayError = true
    }
    
    func showTableViewLoader() {
        didShowTableViewLoader = true
    }
    
    
}
