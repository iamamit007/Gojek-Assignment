

class ListPresenter: ListPresenterProtocol {
    weak var view: ListViewProtocol?
    var interactor:ListInteractorInputProtocol?
    var wireFrame: ListWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveAllContacts()
    }
    
    

}

extension ListPresenter: ListInteractorOutputProtocol {
    
    func didRetrievePosts(_ posts: [contactListResult]) {
        view?.hideLoading()
        view?.showPosts(with: posts)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
    
}


