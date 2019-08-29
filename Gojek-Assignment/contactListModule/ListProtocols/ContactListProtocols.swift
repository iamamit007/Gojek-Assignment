//
//  ContactListProtocols.swift
//  Gojek-Assignment
//
//  Created by Amit on 28/08/19.
//  Copyright © 2019 Amit. All rights reserved.
//

import Foundation
import UIKit
//protocol ListLocalDataManagerInputProtocol: class {
//    var remoteRequestHandler: ListLocalDataManagerOutputProtocol? { get set }
//
//    // INTERACTOR -> REMOTEDATAMANAGER
//    func retrieveList() ->[contactListResult]
//}

protocol ListLocalDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsRetrieved(_ posts: [contactListResult])
    func onError()
}
protocol ListPresenterProtocol: class {
    var view: ListViewProtocol? { get set }
    var interactor: ListInteractorInputProtocol? { get set }
    var wireFrame: ListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol ListViewProtocol: class {
    var presenter: ListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showPosts(with posts: [contactListResult])
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol ListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [contactListResult])
    func onError()
}

protocol ListInteractorInputProtocol: class {
    var presenter: ListInteractorOutputProtocol? { get set }
  //  var localDatamanager: ListLocalDataManagerInputProtocol? { get set }
    //var remoteDatamanager: ListLocalDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveAllContacts()
}

protocol ListWireFrameProtocol: class {
    static func createPostListModule() -> UIViewController
    // PRESENTER -> WIREFRAME
}
