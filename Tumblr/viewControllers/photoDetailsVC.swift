//
//  photoDetailsVC.swift
//  Tumblr
//
//  Created by XCodeClub on 2018-11-17.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit
import AlamofireImage

class photoDetailsVC: UIViewController {
    
    
    @IBOutlet weak var photoIMG: UIImageView!
    public var url: URL?
    
    
     override func viewDidLoad() {
        super.viewDidLoad()


        photoIMG.af_setImage(withURL: url!)
    }
}
