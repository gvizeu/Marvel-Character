//
//  CharacterDetailViewController.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

protocol CharacterDetailDisplayLogic: AnyObject {
    func displayDetails(_ detailModel: Character)
    func displayStories(stories: [Storie]?)
    func displayComics(comics: [Comic]?)
    func displayError(title: String?, msg: String?)
}

final class CharacterDetailViewController: BaseViewController, CharacterDetailDisplayLogic {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var comicsTitle: UILabel!
    @IBOutlet weak var comicsStackView: UIStackView!
    @IBOutlet weak var storiesTitle: UILabel!
    @IBOutlet weak var storiesStackView: UIStackView!
    
    var identifier: Int?
    var detailModel: Character?
    var presenter: CharacterDetailPresentationLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = self.identifier else {  return }
        self.presenter?.fetchData(from: id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func displayDetails(_ detailModel: Character) {
        self.detailModel = detailModel
        let image = detailModel.imagePath
        self.characterImage.getImage(from: image, rounded: 25, delegate: self)
        self.nameLabel.text = detailModel.name
    }
    
    func displayStories(stories: [Storie]?) {
        self.storiesTitle.text = "characterDetail.storiesTitle".localize
        stories?.forEach({ (story) in
            self.storiesStackView.addArrangedSubview(createUILabel(with: story.title))
        })
        
    }
    
    func displayComics(comics: [Comic]?) {
        self.comicsTitle.text = "characterDetail.comicsTitle".localize
        comics?.forEach({ (comic) in
            self.comicsStackView.addArrangedSubview(createUILabel(with: comic.title))
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
