
class ListInteractor: ListInteractorInputProtocol {
    weak var presenter: ListInteractorOutputProtocol?
   // var localDatamanager: ListLocalDataManagerInputProtocol?
    
    
    func retrieveAllContacts(){
        do {
            
            
            SchoolinkApiClient().getAllContacts(from: .contacts) {  result in
                
                switch result {
                case .success(let res):
                    
                    print("@post api result-->",res)
                    self.presenter?.didRetrievePosts(res)
                    
                case .failure(let error):
                    print("the error \(error)")
                }
            }


        } catch {
            presenter?.didRetrievePosts([])
        }
    }
    

}

extension ListInteractor: ListLocalDataManagerOutputProtocol {

    func onPostsRetrieved(_ posts: [contactListResult]) {
        presenter?.didRetrievePosts(posts)

        
    }

    func onError() {
        presenter?.onError()
    }

}
