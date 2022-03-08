//
//  CharacterListViewController.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 19/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {
    func displayCharacters(_ characters: [Character])
    func displayAppendingCharacters(_ characters: [Character])
    func displayError(title: String?, msg: String?)
    func showTableViewLoader()
}

class CharacterListViewController: BaseViewController {
    
    private var characterList: [Character]?
    @IBOutlet weak private var tableView: UITableView!
    private var searchController : UISearchController!
    fileprivate var timer = Timer()
    
    var presenter: CharacterListPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        
        presenter?.getCharacters()
    }
    
    fileprivate func setupSearchBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
    }
    
    fileprivate func setupTableView() {
        tableView.tableHeaderView = self.searchController.searchBar
        tableView.register(UINib(nibName: "CharacterTVC", bundle: nil), forCellReuseIdentifier: "CharacterTVC")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func reloadTableView() {
        tableView.reloadData()
        hideTableViewLoader(tableView: self.tableView)
    }
}

extension CharacterListViewController: CharacterListDisplayLogic {
    func displayCharacters(_ characters: [Character]) {
        characterList = characters
        reloadTableView()
    }
    
    func displayAppendingCharacters(_ characters: [Character]) {
        characterList?.append(contentsOf: characters)
        reloadTableView()
    }
    
    func displayError(title: String?, msg: String?) {
        if self.searchController.isFirstResponder {
            self.searchController.resignFirstResponder()
        }
        presentError(title: title, message: msg)
        hideTableViewLoader(tableView: self.tableView)
    }
    
    func showTableViewLoader() {
        showTableViewLoader(tableView: tableView)
    }
    
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return characterList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTVC", for: indexPath) as! CharacterTVC
            if let model = characterList?[indexPath.row] {
                cell.delegate = self
                cell.configureCell(model: model)
            }
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.presenter?.setDataLoading(false)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height){
            self.presenter?.getMoreCharacters(loadedCharateres: characterList?.count ?? 0,
                                              name: searchController.searchBar.text ?? "")
        }
    }
}

extension CharacterListViewController: CharacterTVCDelegate {
    func didSelectCell(with: Int) {
        self.presenter?.navigateToCharacterDetail(with: with)
    }
}

extension CharacterListViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text,
           text.isEmpty,
           searchController.becomeFirstResponder() {
            self.presenter?.didFinishFiltering()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter?.didFinishFiltering()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] _ in
            self.characterList?.removeAll()
            self.tableView.reloadData()
            self.presenter?.getCharacters(by: searchBar.text ?? "")
            
            timer.invalidate()
        })
        
    }
}
