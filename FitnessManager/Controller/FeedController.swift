//
//  FeedController.swift
//  FitnessManager
//
//  Created by Алишер Ахметжанов on 18.05.2022.
//

import UIKit
import MobileCoreServices



class FeedController: UIViewController {
    
    // свойства
    
    // жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // хелперс
        
    func configureUI() {
        view.backgroundColor = .fitGrey
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
