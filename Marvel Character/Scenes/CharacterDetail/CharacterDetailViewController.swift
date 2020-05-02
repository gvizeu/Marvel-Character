//
//  CharacterDetailViewController.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

protocol CharacterDetailDisplayLogic: class{
    func displayDetails(_ detailModel: CharactersList.DataRawValue)
    func displayStories(stories: CharactersList.Stories?)
    func displayComics(comics: CharactersList.Comics?)
    func displayError(title: String?, msg: String?)
}

class CharacterDetailViewController: BaseViewController, CharacterDetailDisplayLogic {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var comicsTitle: UILabel!
    @IBOutlet weak var comicsStackView: UIStackView!
    @IBOutlet weak var storiesTitle: UILabel!
    @IBOutlet weak var storiesStackView: UIStackView!
    
    
    
    var interactor: CharacterDetailBusinessLogic?
    var identifier: Int?
    var detailModel: CharactersList.DataRawValue?
    
    static func makeCharacterDetailView(id: Int?) -> CharacterDetailViewController{
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        newViewController.identifier = id
        return newViewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()

        
    }
    
    private func setup(){
        let viewController = self
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter()
        let worker = CharacterDetailWorker()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        
    }
    
    func getData(){
        guard let id = self.identifier else {  return }
        self.interactor?.getDetail(from: id)
    }
    
    func displayDetails(_ detailModel: CharactersList.DataRawValue) {
        self.detailModel = detailModel
        let image = detailModel.thumbnail
        self.characterImage.getImage(from: image?.path ?? "", fileExtension: image?.thumbnailExtension ?? "", rounded: 25, delegate: self)

        self.nameLabel.text = detailModel.name
    }
    
    func displayStories(stories: CharactersList.Stories?) {
        self.storiesTitle.text = "characterDetail.storiesTitle".localize
        stories?.items?.forEach({ (story) in
            self.storiesStackView.addArrangedSubview(createUILabel(with: story.name))
        })
        
    }
    
    func displayComics(comics: CharactersList.Comics?) {
        self.comicsTitle.text = "characterDetail.comicsTitle".localize
        comics?.items?.forEach({ (comic) in
            self.comicsStackView.addArrangedSubview(createUILabel(with: comic.name))
        })
    }
    
    func displayError(title: String?, msg: String?){
        self.navigationController?.popViewController(animated: false)
        self.presentError(title: title, message: msg)
    }
    
    func createUILabel(with text: String?) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = text
        label.numberOfLines = 0
        return label
    }
    

}

extension CharacterDetailViewController: UIImageViewCustomDataSoruce {
    func didSetImage(imgeView: UIImageView?) {
        self.view.backgroundColor = imgeView?.image?.averageColor?.lighter(by: 55)
    }
    
    
}
