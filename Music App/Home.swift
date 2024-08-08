//
//  Home.swift
//  Music App
//
//  Created by kushal  on 25/06/24.


import SwiftUI

struct Home: View {
    // animation properties
    @State private var expandSheet = false
    @Namespace private var animation
    
    @EnvironmentObject var songManager: SongManager
    
    var body: some View {
        ScrollView {
            VStack {
                header
                
                TagsView()
                
                QuickPlay()
                
                LargeCards()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    //Header

    var header: some View {
        GeometryReader{ size in
            VStack(alignment: .leading) {
                HStack(spacing: 15) {
                    Text("Good morning moods ✨")
                        .font(.title2)
                    
                    Spacer()
                    
                    Image(systemName: "bell")
                        .imageScale(.large)
                    
                    Image("singer1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40 ,height: 40)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, getSafeAreaTop())
        .background(LinearGradient(colors: [Color.red, .clear], startPoint: .top, endPoint: .bottom))
        .frame(width: .infinity, height: getSafeAreaTop() * 2)
        
    }
    
    //tags view
    @ViewBuilder func TagsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(sampleTagList, id: \.id) { item in
                    Text(item.tag)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(RoundedRectangle(cornerRadius: 12).fill(.white.opacity(0.15)))
                }
            }
            .padding(.leading)
        }
    }
    
    //quick play songs
    @ViewBuilder func QuickPlay() -> some View {
        VStack {
            HStack {
                Text("Quick Play")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
            .padding(.all)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(60)), GridItem(.fixed(60)), GridItem(.fixed(60)), GridItem(.fixed(60))], content: {
                    // show list of songs
                    ForEach(sampleSongModel, id: \.id) { item in
                        HStack(spacing: 20, content: {
                            AsyncImage(url: URL(string: item.cover)) { img in
                                img.resizable()
                                    .scaledToFill()
                                    .clipShape(.rect(cornerRadius: 5))
                            } placeholder: {
                                ProgressView()
                                    .background(.white.opacity(0.1))
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(.rect(cornerRadius: 5))
                            
                            VStack(alignment: .leading){
                                Text("\(item.title)")
                                    .font(.headline)
                                Text("\(item.artist)")
                                    .font(.caption)
                            }
                            Spacer()
                        })
                        .onTapGesture {
                            songManager.playSong(song: item)
                        }
                    }
                })
                .padding(.horizontal)
            }
        }
    }
    
    // large card views -> new releases
    @ViewBuilder func LargeCards() -> some View {
        VStack {
            HStack {
                Text("New Releases")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15 ,content: {
                    ForEach(sampleSongModel, id: \.id) { item in
                        VStack(alignment: .leading, content: {
                            AsyncImage(url: URL(string: item.cover)) { img in
                                img.resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 160, height: 160)
                            .clipShape(.rect(cornerRadius: 10))
                            
                            Text("\(item.title)")
                                .font(.headline)
                            
                            Text("\(item.artist)")
                                .font(.caption)
                        })
                        .onTapGesture {
                            songManager.playSong(song: item)
                        }
                    }
                })
                .padding(.horizontal)
            }
        }
    }
    // here we create a function to get size of Top safe area
    func getSafeAreaTop() -> CGFloat {
        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first {
            
            return keyWindow.safeAreaInsets.top
        }
        return 0.0 // Return a default value in case keyWindow is nil
    }
}
#Preview {
    ContentView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
