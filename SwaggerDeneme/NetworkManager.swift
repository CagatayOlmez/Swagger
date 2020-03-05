import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
var mainUrl = "https://terminalcommands.herokuapp.com/api/categories"
var jsonSer = ""
    func getCategories (){
        let parameters: Parameters = [
        "language": "TR"
        ]
        AF.request(URL(string: mainUrl ) ?? "", method: .get, parameters: parameters , encoding: URLEncoding.queryString, headers: nil, interceptor: nil).responseJSON {
            (response) in
        print(response)
        try! JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers)
        let apiResponse = try? JSONDecoder().decode([CategoryModel].self, from: response.data!)
            DataManager.categoryArray = apiResponse
            print(DataManager.categoryArray ?? 0)
        }
    }
    func getCommands (){
        AF.request(URL(string: mainUrl + "/" + (DataManager.categoryId ?? "") + "/commands") ?? "", method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil, interceptor: nil).responseJSON { (response) in
        print(response)
        try! JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers)
        let apiResponse = try? JSONDecoder().decode([InfoModel].self, from: response.data!)
            DataManager.infoArray = apiResponse!
            print(DataManager.infoArray ?? 0)
        }
    }
}
