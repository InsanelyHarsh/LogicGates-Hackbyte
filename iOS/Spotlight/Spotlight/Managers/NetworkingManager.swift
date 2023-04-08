//
//  NetworkingManager.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation

protocol CustomErrorAlerts{
    
}

enum NetworkingError:Error,CustomErrorAlerts{
    case badURL
    case badResponse(response:String)
    case decodingFailed
    case unknownError
    
    case encodingFailed
    
    var alertTitle:String{
        switch self {
        case .badURL:
            return "Bad URL"
        case .badResponse:
            return "Bad Response"
        case .decodingFailed:
            return "Decoding Failed"
        case .unknownError:
            return "Unknown Error"
        case .encodingFailed:
            return "Encoding Failed"
        }
    }
    
    var alertDescription:String{
        switch self {
        case .badURL,.badResponse,.decodingFailed,.unknownError,.encodingFailed:
            return "Contact Developer"
        }
    }
}

protocol Networking{
    func postJSON<E:Encodable, D:Decodable>(url urlString:String,requestData:E,responseType:D.Type)async throws->D
    func postJSONFormData<D:Decodable>(url urlString:String,requestData:[String:Any],responseType:D.Type)async throws->D
    func getJSON<T:Decodable>(url urlString:String,type:T.Type)async throws -> T
}


protocol NetworkingHelper{
    func makeRequest(url urlString:String)throws ->URLRequest
    func decodeData<T:Decodable>(data:Data,type:T.Type)throws->T
    func getPostString(params:[String:Any]) -> String
}


/*
 Task --> .yield()
 Priority of Tasks
 
 Child task inherentane from parent task
 -> .detached() { DO NOT USE! }
 -> Task Group
 -> Cancel Task (or) use .task{ } modifier, it handles cancelling for tasks
    -> Check cancellation
 -> async let -> Multiple async at once, waiting for all
 
 */
//Actors are basically classes but thread Safe
//Probaly OverKill in this situation
class NetworkingService{
    
    ///POST REQUEST
    ///- INPUT --> URL,Data
    ///- OUTPUT --> Response
    func postJSON<E:Encodable, D:Decodable>(url urlString:String,requestData:E,responseType:D.Type,authToken:String = "")async throws->D{
        do{
            //Request
            var request = try makeRequest(url: urlString)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "content-Type")
            
            if(!authToken.isEmpty){
                request.setValue(authToken, forHTTPHeaderField: "authToken")
            }
            
            //Encoding
            request.httpBody = try encodeData(requestData: requestData)
            
            
            //URL Session..
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse else{
                throw NetworkingError.unknownError
            }
            
            if(!(200..<300).contains(res.statusCode)){
                Logger.logError("Bad Response: \(res.statusCode)")
                throw NetworkingError.badResponse(response: "\(res.statusCode)")
            }
            
            //Decoding Data
            let decodedData = try decodeData(data: data, type: D.self)
            return decodedData
        }
        catch(_){
            throw NetworkingError.unknownError
        }
    }
    
    
    func postJSONFormData<D:Decodable>(url urlString:String,requestData:[String:Any],responseType:D.Type,token:String = "")async throws->D{
        do{
            //Request
            var request = try makeRequest(url: urlString)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if !token.isEmpty{
                request.setValue( "\(token)", forHTTPHeaderField: "Token")
            }
            
            let postString = getPostString(params: requestData)
            request.httpBody = postString.data(using: .utf8)
            
            //URL Session..
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse else{
                throw NetworkingError.unknownError
            }
            
            //Handling Response Code
            if(!(200..<300).contains(res.statusCode)){
                Logger.logError("Bad Response: \(res.statusCode)")
                throw NetworkingError.badResponse(response: "\(res.statusCode)")
            }
            
            //Decoding Data
            let decodedData = try decodeData(data: data, type: D.self)
            return decodedData
        }
        catch(_){
            throw NetworkingError.unknownError
        }
    }
    
    func getJSON<T:Decodable>(url urlString:String,type:T.Type,authToken:String="")async throws -> T{
        
        do{
            var request = try makeRequest(url: urlString)
            
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if(!authToken.isEmpty){
                request.setValue(authToken, forHTTPHeaderField: "authToken")
            }
            
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse else{
                throw NetworkingError.unknownError
            }
            
            //Handling Response Code
            if(!(200..<300).contains(res.statusCode)){
                Logger.logError("Bad Response: \(res.statusCode)")
                throw NetworkingError.badResponse(response: "\(res.statusCode)")
            }
            
            let decodedData = try decodeData(data: data, type: T.self)
            return decodedData
        }
        
        catch(_){
            throw NetworkingError.unknownError
        }
    }
}




extension NetworkingService{
    
    private func makeRequest(url urlString:String)throws ->URLRequest {
        guard let url = URL(string: urlString)
        else {
            Logger.logError("Invalid URL")
            throw NetworkingError.badURL
        }
        
        return URLRequest(url: url)
    }
    
    private func encodeData<E:Encodable>(requestData:E)throws->Data{
        let encoder = JSONEncoder()
        do{
            let encodedData = try encoder.encode(requestData)
            return encodedData
        }
        catch{
            throw NetworkingError.encodingFailed
        }
    }
    
    private func decodeData<T:Decodable>(data:Data,type:T.Type)throws->T{
        let decoder = JSONDecoder()
        do{
            
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        }
        catch{
            Logger.logError("Decoding Failed")
            throw NetworkingError.decodingFailed
        }
    }
    
    private func getPostString(params:[String:Any]) -> String{
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}
