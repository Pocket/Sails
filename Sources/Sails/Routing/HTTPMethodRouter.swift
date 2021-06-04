import NIOHTTP1
import Foundation

public class HTTPMethodRouter<ValueT> {
    private var routers: [HTTPMethod: Router<ValueT>]
    
    public init() {
        routers = [:]
    }
    
    public func add(_ method: HTTPMethod, uri: String, value: ValueT) {
        getOrAddRouter(for: method).add(uri: uri, value: value)
    }
    
    public func route(_ method: HTTPMethod, uri: String) -> RouteResult<ValueT> {
        let saneURI = URL(string: uri)?.pathComponents.joined(separator: "/") ?? uri
        return getOrAddRouter(for: method).route(uri: saneURI)
    }
    
    private func getOrAddRouter(for method: HTTPMethod) -> Router<ValueT> {
        if let router = routers[method] {
            return router
        }
        
        routers[method] = Router<ValueT>()
        return routers[method]!
    }
}
