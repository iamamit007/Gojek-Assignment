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
        setUpNavigationBar()
        contactList.delegate = self
        contactList.dataSource = self
        presenter?.viewDidLoad()
        print(Date().startOfMonth())     // "2018-02-01 08:00:00 +0000\n"
        print(Date().endOfMonth())
        
    }
    private  func setUpNavigationBar (){
        let title_label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 21))
        // title_label.center = CGPoint(x: 160, y: 285)
        title_label.textAlignment = .left
        title_label.text = "Contacts"
        title_label.isUserInteractionEnabled = true
       // title_label.textColor =  UIColor(hexString: "#78DABD")
        navigationItem.titleView  = title_label
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .left
        label.text = "Groups"
        label.isUserInteractionEnabled = true
        label.textColor =  UIColor(hexString: "#78DABD")
        navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: label)
        
        
        let pluslabel = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 21))
        pluslabel.center = CGPoint(x: 160, y: 285)
        pluslabel.textAlignment = .right
        pluslabel.text = "+"
        pluslabel.font = pluslabel.font.withSize(30)
        pluslabel.isUserInteractionEnabled = true
        pluslabel.textColor =  UIColor(hexString: "#78DABD")
        navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: pluslabel)
        
       
        
        //hexStringToUIColor("7BDFC2")
    }
    
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(4.0)
        )
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
        
        let isFav = contactsList[indexPath.row].favorite!
        if(isFav == true){
            cell?.makeFavImage.image = UIImage(named:"home_favourite" )
        }
        if let profile_pic = contactsList[indexPath.row].profile_pic {
            getImageFromUrl(profile_pic,cell!.contactImage)
        }
        return cell!

    
    }
    
    
    func getImageFromUrl(_ imgurl:String ,_ targetImage:UIImageView) {
        DispatchQueue.global().async {
            let url = URL(string: imgurl)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                 let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    targetImage.image = image
                    let anyAvatarImage:UIImage = image!
                    targetImage.maskCircle(anyImage: anyAvatarImage)
                }
               
            }
        }
       
    }

}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
}
