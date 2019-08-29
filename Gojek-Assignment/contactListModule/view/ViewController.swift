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
    private let cellReuseIdentifier = "cell"
    var contactsList = [contactListResult]()
    var presenter: ListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList.delegate = self
        contactList.dataSource = self
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}



extension ViewController: ListViewProtocol {
    
    func showPosts(with posts: [contactListResult]) {
        print("===================> ",posts)
        contactsList = posts
     //   print(postList)
        contactList.reloadData()
    }
    
    func showError() {
        print("Error occured ")
    }
    
    func showLoading() {
    }
    
    func hideLoading() {
    }
    
}


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contactsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ContactListCollectionViewCell
        let name =  contactsList[indexPath.row].first_name! + " " +  contactsList[indexPath.row].last_name!
        cell!.contactName.text = name
        return cell!

    
    }

}
