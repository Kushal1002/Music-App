//
//  Musicinfo.swift
//  Music App
//
//  Created by kushal  on 25/06/24.
//

import SwiftUI

struct MusicInfo: View {
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    @EnvironmentObject var songManager: SongManager
    
    var body: some View {
        HStack(spacing: 0) {
            //adding match geometry effect
            ZStack {
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        AsyncImage(url: URL(string: songManager.song.cover)) { img in
                            img.resizable()
                                .scaledToFill()
                                .clipShape(.rect(cornerRadius: 5))
                        } placeholder: {
                            ProgressView()
                                .background(.white.opacity(0.1))
                                .clipShape(.rect(cornerRadius: 5))
                        }
                            .frame(width: size.width, height: size.height)
                            .clipShape(.rect(cornerRadius: 30, style: .continuous))
                        
                        CirceProgressView(progress: 40)
                            .frame(width: size.width, height: size.height)
                    }
                    .matchedGeometryEffect(id: "SONGCOVER", in: animation)
                }
            }
            .frame(width: 55, height: 55)
            
            Text("\(songManager.song.title)")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 15)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title3)
                    .foregroundStyle(.black)
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal)
        .frame(height: 80)
        .onTapGesture {
            //expand bottom sheet
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

//here we create circularprogressbar
struct CirceProgressView: View {
    
    let progress: Double
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.clear,
                lineWidth: 4)
            
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(Color.white,
                        style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
        
    }
}
