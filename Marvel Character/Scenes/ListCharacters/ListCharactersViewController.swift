//
//  ListCharactersViewController.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

protocol ListCharactersDisplayLogic: class {
    func displayCharacters(characters: [CharactersList.DataRawValue], total: Int)
    func displayError(title: String?, msg: String?)
}

class ListCharactersViewController: BaseViewController, ListCharactersDisplayLogic {
    
    private var characterList: [CharactersList.DataRawValue]?
    @IBOutlet weak var tableView: UITableView!
    
    var isDataLoading:Bool=false
    let limit:Int=20
    var offset:Int=0 //pageNo*limit
    var total: Int?
    var didEndReached:Bool=false
    var filteredName: String? {
        get {
            if isSearchBarEmpty {
                return nil
            } else {
                return searchController.searchBar.text
            }
        }
    }
    
    var timer = Timer()
    var searchController : UISearchController!
    
    var filteredCharacters: [CharactersList.DataRawValue]? = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var interactor: ListCharactersBusinessLogic?
    var router: ListCharacterRoutingLogic?
    
    private func setup(){
        let viewController = self
        let interactor = ListCharactersInteractor()
        let worker = ListCharactersWorker()
        let presenter = ListCharactersPresenter()
        let router = ListCharactersRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.worker = worker
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.tableView.tableHeaderView = self.searchController.searchBar
        tableView.register(UINib(nibName: "CharacterTVC", bundle: nil), forCellReuseIdentifier: "CharacterTVC")
        tableView.delegate = self
        tableView.dataSource = self
        
        interactor?.getCharacters(offset: self.offset, limit: self.limit, name: self.filteredName)
    }
    
    func displayCharacters(characters: [CharactersList.DataRawValue], total: Int) {
        self.total = total
        
        if isFiltering {
            if filteredCharacters == nil {
                filteredCharacters = characters
            } else {
                filteredCharacters?.append(contentsOf: characters)
            }
        } else {
            if characterList == nil {
                characterList = characters
                
            } else {
                characterList?.append(contentsOf: characters)
                
            }
        }
        tableView.reloadData()
        hideTableViewLoader(tableView: self.tableView)
    }
    
    func displayError(title: String?, msg: String?) {
        if self.searchController.isFirstResponder {
            self.searchController.resignFirstResponder()
        }
        presentError(title: title, message: msg)
        hideTableViewLoader(tableView: self.tableView)
    }
    

}

extension ListCharactersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCharacters?.count ?? 0
        } else {
            return characterList?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTVC", for: indexPath) as! CharacterTVC
        
        if isFiltering {
            if let model = filteredCharacters?[indexPath.row] {
                cell.delegate = self
                cell.configureCell(model: model)
            }
        } else {
            if let model = characterList?[indexPath.row] {
                cell.delegate = self
                cell.configureCell(model: model)
            }
        }
        
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDataLoading = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height){
            if !isDataLoading  {
                isDataLoading = true
                if isFiltering {
                    
                    self.offset = self.filteredCharacters?.count ?? 0
                } else {
                    self.offset = self.characterList?.count ?? 0
                }
                
                if ((self.total ?? 0) - self.offset) > 0  {
                    showTableViewLoader(tableView: self.tableView)
                    self.interactor?.getCharacters(offset: self.offset, limit: self.limit, name: self.filteredName)
                }
                
                
                
            }
        }
        
    }
}

extension ListCharactersViewController: CharacterTVCDelegate {
    func didSelectCell(with: Int) {
        self.router?.navigateToCharacterDetail(with: with)
    }
}

extension ListCharactersViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.offset = 0
        self.filteredCharacters?.removeAll()
        interactor?.getCharacters(offset: self.offset, limit: self.limit, name: nil)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ListCharactersViewController.output), userInfo: searchText, repeats: false)
        
    }
    
    @objc func output(){

        if timer.userInfo != nil {
            self.offset = 0
            self.filteredCharacters?.removeAll()
            self.tableView.reloadData()
            interactor?.getCharacters(offset: self.offset, limit: self.limit, name: self.filteredName)
        }
        timer.invalidate()
    }
    
    
}
