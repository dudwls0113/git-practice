//
//  CreateInteractor.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/11.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class CreateInteractor: CreateInputInteractorProtocol {
    
    var presenter: CreateOutputInteractorProtocol?
    
    var title: String!
    var subTitle: String?
    var filteredContents: [TempContents] = []
    
    var numOfImagesToUpload: Int!
    var numOfImagesUploaded: Int = 0
    
    func postStory(title: String, contents tempContents: [TempContents]) {
        self.title = title
        numOfImagesToUpload = (tempContents.filter() { $0.type == .Image && $0.image != nil }).count
        
        var index: Int = 0
        for cont in tempContents {
            if cont.type == .LargeText && index == 0 {
                subTitle = cont.contents
            }
            else if cont.type == .Image {
                if let image = cont.image {
                    filteredContents.append(TempContents(type: .Image))
                    uploadImage(image, index: index)
                    index += 1
                }
            }
            else if cont.contents != nil {
                filteredContents.append(cont)
                index += 1
            }
        }

        
        if numOfImagesToUpload == 0 {
            requestPostStory()
        }
    }
    
    func uploadImage(_ image: UIImage, index: Int) {
        let email = Auth.auth().currentUser!.email!
        let date = Date(timeIntervalSinceNow: 0)
        let filePath = "\(email)/\(date.toDetailString())/\(index).png"

        let data = image.pngData()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let dataRef = storageRef.child(filePath)
        dataRef.putData(data!, metadata: nil) { (metadata, error) in
            if let error = error {
                self.presenter?.failedToPostStory(error)
                return
            }
            if metadata == nil {
                self.presenter?.failedToPostStory(nil)
                return
            }
            dataRef.downloadURL { (url, error) in
                if let error = error {
                    self.presenter?.failedToPostStory(error)
                    return
                }
                guard let url = url else {
                    self.presenter?.failedToPostStory(nil)
                    return
                }
                self.filteredContents[index].contents = url.description
                
                if self.numOfImagesToUpload == self.numOfImagesUploaded + 1 {
                    self.requestPostStory()
                } else {
                    self.numOfImagesUploaded += 1
                }
            }
        }
    }
    
    func requestPostStory() {
        var contents: [Dictionary<String, String>] = []
        for cont in filteredContents {
            var tempContents = Dictionary<String, String>()
            tempContents["types"] = cont.type.rawValue
            tempContents["contents"] = cont.contents ?? "Separator"
            contents.append(tempContents)
        }
        
        var parameters = Parameters()
        parameters["title"] = title
        parameters["contents"] = contents
        if let subTitle = subTitle {
            parameters["subTitle"] = subTitle
        }
        
        Alamofire
            .request("\(AppDelegate.baseUrl)/story", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.presenter?.didPostStory(0)
//                    if let data = response.result.value as? [String:Any] {
//                        if let storyId = data["storyId"] as? Int {
//                            self.presenter?.didPostStory(storyId)
//                        }
//                        self.presenter?.failedToPostStory(nil)
//                    } else {
//                        self.presenter?.failedToPostStory(nil)
//                    }
                    break
                case .failure(let error):
                    self.presenter?.failedToPostStory(error)
                    break
                }
        }
    }
}
