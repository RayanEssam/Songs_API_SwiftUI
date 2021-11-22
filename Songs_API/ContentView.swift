//
//  ContentView.swift
//  Songs_API
//
//  Created by Rayan Taj on 15/11/2021.
//

import SwiftUI






struct ContentView: View {
    
    @State private var results = [Result]()
    @State  var text: String = ""
    @State private var isEditing = false

    func loadData(artistName : String) {

        guard let url = URL(string: "https://itunes.apple.com/search?term=\(artistName)&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
            
                    DispatchQueue.main.async {
                     
                        self.results = decodedResponse.results
                        print( self.results)
                    }

                    return
                }
            }
            print("Fetch faild !! 🙀")
   
        }.resume()
        
    }
    
    
    
    
    
    
    var body: some View {
        VStack {
            HStack {
     
                TextField("Search ...", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
     
                    Button(action: {
               
                        loadData(artistName: text)
//                   results =   Network.shared.loadData(artistName: text)
//
//
//                        print(Network.shared.loadData(artistName: text))
                    }) {
                        Text("Search")
                    }
                    .padding(.trailing, 10)
         
      
              
            }
            List(results, id: \.trackId) { item in
                HStack{
                    AsyncImage(url: item.artworkUrl60)
                        .cornerRadius(15)
                        .frame(width: 60 , height: 60)
    //                Image(item.artworkUrl30)
                    
                    VStack(alignment: .leading) {
                        Text(item.trackName)
                            .font(.headline)
                        Text("\(item.collectionName) Album")
                        Text(item.artistName)
                    }
                }
              
            }
        }
           
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      
        ContentView()

    }
}
