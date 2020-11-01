import Foundation
import Apollo

public final class Apollo {
    static let shared = Apollo()
    
    let client: ApolloClient?
    
    init() {
        guard let url = URL(string: "https://sec-server.hasura.app/v1/graphql") else {
            client = nil
            return
        }
        client = ApolloClient(url: url)
    }
}
