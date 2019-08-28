//
//  ViewController.swift
//  Gojek-Assignment
//
//  Created by Amit on 28/08/19.
//  Copyright © 2019 Amit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList.delegate = self
        contactList.dataSource = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

