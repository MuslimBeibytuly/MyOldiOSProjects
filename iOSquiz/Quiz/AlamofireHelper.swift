import Foundation
import Alamofire

typealias JSON = [String: Any]

enum NetworkingError: Error {
    case badNetworkingStuff
}

class AlamofireHelper {
    static let shared = AlamofireHelper()
    private init() {}
    
    func getQuestions(with success: @escaping (GetQuestionsResponse) -> Void){
        Alamofire.request("https://jsonblob.com/api/ab269aeb-affd-11e7-b7f1-413c73058dea").responseJSON { (response) in
            guard let json = response.result.value as? JSON else { return }
            do {
                let getQuestionsResponse = try GetQuestionsResponse(json: json)
                success(getQuestionsResponse)
            }
            catch {}
        }
    }
}

class GetQuestionsResponse {
    let questions: [Question]
    
    init(json: JSON) throws {
        guard let results = json["content"] as? [JSON] else {
            throw NetworkingError.badNetworkingStuff
        }
        self.questions = results.map{ Question(with: $0) }.flatMap{ $0 }
    }
}
