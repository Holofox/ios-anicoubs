//
//  VKController.swift
//  anicoubs
//
//  Created by Holofox on 23.01.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import SwiftyVK
import PromiseKit

final class VKController {

    class func authorize() -> Promise<RawParameters> {
        return Promise { completion in
            VK.sessions.default.logIn(
                onSuccess: { info in
                    print("SwiftyVK: success authorize with", info)
                    completion.fulfill(info)
            },
                onError: { error in
                    print("SwiftyVK: authorize failed with", error)
                    completion.reject(error)
            })
        }
    }
    
    class func logout() {
        VK.sessions.default.logOut()
        print("SwiftyVK: LogOut")
    }
    
    class func getServerTime() -> Promise<UtilsModel.ServerTime> {
        return Promise { completion in
            VK.API.Utils.getServerTime(.empty)
                .configure(with: Config.init(httpMethod: .GET))
                .onSuccess { response in
                    do {
                        let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .secondsSince1970
                        let response = try decoder.decode(UtilsModel.ServerTime.self, from: response)
                        
                        completion.fulfill(response)
                    } catch let error {
                        print("JSONDecoder: utils.\(#function) failed with \(error)")
                    }
                }
                .onError { error in
                    print("SwiftyVK: utils.\(#function) fail \n \(error)")
                    completion.reject(error)
                }
                .send()
        }
    }

    class func wallGet(owner_id: String, filter: String, offset: String, count: String) -> Promise<WallModel.Response> {
        return Promise { completion in
            VK.API.Wall.get([
                .ownerId: owner_id,
                .filter: filter,
                .offset: offset,
                .count: count,
                .extended: "1"
                ])
                .onSuccess { response in
                    do {
                        let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            decoder.dateDecodingStrategy = .secondsSince1970
                        
                        let posts = try decoder.decode(WallModel.Response.self, from: response)
                        completion.fulfill(posts)
                    } catch let error {
                        print("JSONDecoder: wall.get failed with \(error)")
                    }
                }
                .onError { error in
                    print("SwiftyVK: wall.get failed with \n \(error)")
                    completion.reject(error)
                }
                .send()
        }
    }

    class func wallGetById(posts: String) -> Promise<WallModel.Response> {
        return Promise { completion in
            VK.API.Wall.getById([
                .posts: posts,
                .extended: "1"
                ])
                .onSuccess { response in
                    do {
                        let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            decoder.dateDecodingStrategy = .secondsSince1970
                        
                        let posts = try decoder.decode(WallModel.Response.self, from: response)
                        completion.fulfill(posts)
                    } catch let error {
                        print("JSONDecoder: wall.get failed with \(error)")
                    }
                }
                .onError { error in
                    print("SwiftyVK: wall.get failed with \n \(error)")
                    completion.reject(error)
                }
                .send()
        }
    }
 
    class func videoSave(name: String, description: String?, link: String, groupId: Int, albumId: Int) -> Promise<VideoModel.Response> {
        return Promise { completion in
            VK.API.Video.save([
                .name: name,
                .description: description,
                .link: link,
                .groupId: String(groupId),
                .albumId: String(albumId)
                ])
                .onSuccess { response in
                    do {
                        let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let video = try decoder.decode(VideoModel.Save.self, from: response)
                        
                        completion.fulfill(video.response)
                    } catch let error {
                        print("JSONDecoder: video.save failed with \(error)")
                    }
                }
                .onError { error in
                    print("SwiftyVK: video.save failed with \n \(error)")
                    completion.reject(error)
                }
                .send()
        }
    }

    class func videoDelete(videoId: Int, ownerId: Int) -> Promise<VideoModel.Delete> {
        return Promise { completion in
            VK.API.Video.save([
                .videoId: String(videoId),
                .ownerId: String(ownerId)
                ])
                .onSuccess { response in
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(VideoModel.Delete.self, from: response)
                        
                        completion.fulfill(result)
                    } catch let error {
                        print("JSONDecoder: video.delete failed with \(error)")
                    }
                }
                .onError { error in
                    print("SwiftyVK: video.delete failed with \n \(error)")
                    completion.reject(error)
                }
                .send()
        }
    }
 
}
