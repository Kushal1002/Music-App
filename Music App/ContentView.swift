import SwiftUI

struct ContentView: View {
    
    @State private var expandSheet = false
    @Namespace private var animation
    @StateObject var songManager = SongManager()
    
    var body: some View {
        TabView {
            //Bottom Bar
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .environmentObject(songManager)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)
            // we add pages of search and Playlists in next videos
            // no just we add sample designs
            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .environmentObject(songManager)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)

            Text("Playlists")
                .tabItem {
                    Image(systemName: "play.rectangle.on.rectangle")
                    Text("Playlists")
                }
                .environmentObject(songManager)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)
        }
        .tint(.white)
        .safeAreaInset(edge: .bottom) {
            //Here we add Custom bottom Sheet
            //if no song selected the list hide automatically
            if !songManager.song.title.isEmpty {
                CustomBottomSheet()
            }
            
        }
        .overlay {
            if expandSheet {
                //Here we add music player expanded sheet
                MusicView(expandSheet: $expandSheet, animation: animation)
                    .environmentObject(songManager)
            }
        }
    }
    
    // Now we start design of CustomBottomSheet
    @ViewBuilder
    func CustomBottomSheet() -> some View {
        ZStack {
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            } else {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay {
                        // music info
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                            .environmentObject(songManager)
                    }
                    .matchedGeometryEffect(id: "BACKGROUNDVIEW", in: animation)
                    .clipShape(.rect(topLeadingRadius: 40,topTrailingRadius: 40))
            }
        }
        .frame(height: 80)
        .offset(y: -49)
        
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
