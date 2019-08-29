//
//  PostListWireFrame.swift
//  iOS-Viper-Architecture
//
//  Created by Amit Shekhar on 18/02/17.
//  Copyright © 2017 Mindorks NextGen Private Limited. All rights reserved.
//

import UIKit

class ListWireFrame: ListWireFrameProtocol {
    
    class func createPostListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "contactNavigationController")
        if let view = navController.children.first as? ViewController {
            let presenter: ListPresenterProtocol & ListInteractorOutputProtocol = ListPresenter()
            let interactor: ListInteractorInputProtocol & ListLocalDataManagerOutputProtocol = ListInteractor()
           // let localDataManager: ListLocalDataManagerInputProtocol = ListLocalDataManager()
            
            let wireFrame: ListWireFrameProtocol = ListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
           // interactor.localDatamanager = localDataManager
           // interactor.remoteDatamanager = localDataManager
            //localDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    

    
}
