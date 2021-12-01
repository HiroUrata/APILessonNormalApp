//
//  AlamofireProcess.swift
//  APILessonNormalApp
//
//  Created by UrataHiroki on 2021/12/01.
//

import Alamofire
import SwiftyJSON

class AlamofireProcess{
    
    private var resultItemDetailArray = [ItemDetailDatas]()
}

extension AlamofireProcess{
    
    public func getItemDetailData(searchKey:String?,completion: @escaping ([ItemDetailDatas]?,Error?) -> Void){
        
        guard let key = searchKey else { return }
        
        let apiKey = "https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?format=json&keyword=\(key.urlEncoded)&applicationId=アプリID"
        
        AF.request(apiKey, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {[self] response in
            
            switch response.result{
                
            case .success:
                
                resultItemDetailArray = []
                let detailDatas = JSON(response.data as Any)
                
                for dataCount in 0..<detailDatas["Items"].count{
                    
                    if let getMediumImageURL = detailDatas["Items"][dataCount]["Item"]["mediumImageUrls"][0]["imageUrl"].string,
                       let getItemName = detailDatas["Items"][dataCount]["Item"]["itemName"].string,
                       let getItemPrice = detailDatas["Items"][dataCount]["Item"]["itemPrice"].int{
                        
                        resultItemDetailArray.append(ItemDetailDatas(mediumImageUrl: getMediumImageURL,
                                                                     itemName: getItemName,
                                                                     itemPrice: getItemPrice))
                    }
                }
                completion(resultItemDetailArray, nil)
                
            case .failure(let error):
                
                completion(nil, error)
            }
        }
    }
}

extension String{

    var urlEncoded:String{

        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        let remove = removingPercentEncoding ?? self

        return remove.addingPercentEncoding(withAllowedCharacters: charset) ?? remove
    }
}
