//
//  SearchViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation
import Combine

enum SearchCategory:CaseIterable{
    case posts
    case users
    
    var headerTitle:String{
        switch self {
        case .posts:
            return "posts"
        case .users:
            return "user"
        }
    }
    
    var title:String{
        switch self {
        case .posts:
            return "Post"
        case .users:
            return "User"
        }
    }
}
class SearchViewModel:ObservableObject{
    @Published var searchQuery:String = ""
    @Published var searchResult:[String] = []
    
    @Published var isFetching:Bool = false
    @Published var searchCategory:SearchCategory = .users
    private var cancellable = Set<AnyCancellable>()
    private let networkingService:NetworkingService = NetworkingService()
    
    func makeSearchQuery() async{
        DispatchQueue.main.async {
            self.isFetching = true
        }
        $searchQuery
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { searchText in
                Task{
                    switch self.searchCategory {
                    case .posts:
                        let searchResponse = try? await self.networkingService.getJSON(url: URLData.searchPost.rawValue, type: SearchPostResponseModel.self,
                                                                  authToken: UserRecordManager.userToken ?? "--",headerContent: ["searchString":searchText])
                        
                        if(searchResponse?.error == nil && searchResponse?.success == true){
                            DispatchQueue.main.async {
                                self.searchResult = searchResponse!.posts!
                                    .sorted(by: { $0.weight ?? 0 >= $1.weight ?? 0 })
                                    .compactMap{$0.title}
                            }
                        }
                    case .users:
                        let searchResponse = try? await self.networkingService.getJSON(url: URLData.searchUser.rawValue, type: SearchUserResponseModel.self,
                                                                  authToken: UserRecordManager.userToken ?? "--",headerContent: ["searchString":searchText])
                        
                        if(searchResponse?.error == nil && searchResponse?.success == true){
                            DispatchQueue.main.async {
                                self.searchResult = searchResponse!.users!
                                    .sorted(by: { $0.weight ?? 0 >= $1.weight ?? 0 })
                                    .compactMap{$0.username}
                            }
                        }
                    }
                }
            }
            .store(in: &cancellable)
    }

}
