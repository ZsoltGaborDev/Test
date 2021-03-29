////
////  NetworkRequest.swift
////  Stargazers
////
////  Created by zsolt on 28/03/2021.
////
//
//import UIKit
//
//protocol NetworkRequest: class {
//    associatedtype ModelType
//    var url: URL { get }
//    func deserialize(_ data: Data) -> ModelType?
//}
//
//extension NetworkRequest {
//    func execute(withCompletion completion: @escaping (ModelType?) -> Void) {
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            guard let data = data,
//                let value = self?.deserialize(data) else {
//                    completion(nil)
//                    return
//            }
//            completion(value)
//        })
//        task.resume()
//    }
//}
//
//class ImageRequest {
//    let url: URL
//
//    init(url: URL) {
//        self.url = url
//    }
//}
//
//extension ImageRequest: NetworkRequest {
//    func deserialize(_ data: Data) -> UIImage? {
//        return UIImage(data: data)
//    }
//}
//
//class ApiRequest<Resource : ApiResource> {
//    let resource: Resource
//
//    init(resource: Resource) {
//        self.resource = resource
//    }
//}
//
//extension ApiRequest: NetworkRequest {
//    var url: URL {
//        return resource.url
//    }
//
//    func deserialize(_ data: Data) -> [Resource.ModelType]? {
//        let wrapper = try? JSONDecoder().decode(Wrapper<Resource.ModelType>.self, from: data)
//        return wrapper?.items
//    }
//}
//
//enum UploadNotification: String {
//    case completed
//    case failed
//
//    var name: Notification.Name {
//        return Notification.Name(rawValue)
//    }
//}
