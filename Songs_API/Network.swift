//
//  Network.swift
//  Songs_API
//
//  Created by Rayan Taj on 16/11/2021.
//

import Foundation

class Network: ObservableObject {
    
     static let  shared = Network()
    @Published var songs = [Result]()
    
    
    init() {
        

        
    }
    
func loadData(artistName : String)-> [Result] {

        guard let url = URL(string: "https://itunes.apple.com/search?term=\(artistName)&entity=song") else {
            print("Invalid URL")
            return [Result]()
        }
        
        let request = URLRequest(url: url)

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
            
                    DispatchQueue.main.async {
                     
                        self.songs = decodedResponse.results
                        
                      
                    }

                    return
                }
            }
            print("Fetch faild !! 🙀")
   
        }.resume()
        return songs
    }
    
    
    
    
}
