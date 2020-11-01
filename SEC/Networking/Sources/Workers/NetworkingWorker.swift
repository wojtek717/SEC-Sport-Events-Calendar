//
//  NetworkingWorker.swift
//  Networking
//
//  Created by Wojciech Konury on 26/10/2020.
//

import Foundation
import Apollo

public protocol NetworkingWorkerProtocol {
    func request<T: GraphQLQuery>(query: T,
                                  completion: ((Result<GraphQLResult<T.Data>, Error>) -> Void)?)
}

public final class NetworkingWorker {
    
    public init() {
        
    }
}

extension NetworkingWorker: NetworkingWorkerProtocol {
    public func request<T>(query: T,
                           completion: ((Result<GraphQLResult<T.Data>, Error>)
                                        -> Void)?) where T : GraphQLQuery {
        Apollo.shared.client?.fetch(query: query) { result in
            switch result {
            case .success(let result):
                completion?(.success(result))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
