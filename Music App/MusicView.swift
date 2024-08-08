//
//  MusicView.swift
//  Music App
//
//  Created by kushal  on 25/06/24.
//

import SwiftUI

struct MusicView: View {
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    //view properties
    @State private var animateContent: Bool = false
    @State private var offsetY: CGFloat = 0
    
    @EnvironmentObject var songManager: SongManager
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(.black)
                    .overlay {
                        Rectangle()
                            .fill(.black)
                            .opacity(animateContent ? 1 : 0)
                    }
                    .overlay(alignment: .top) {
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                            .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                            .opacity(animateContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: "BACKGROUNDVIEW", in: animation)
                
                LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom)
                    .frame(height: .infinity)
                    .matchedGeometryEffect(id: "BACKGROUNDVIEW", in: animation)
                
                VStack(spacing: 10) {
                    HStack(alignment: .top) {
                        Image(systemName: "chevron.down")
                            .imageScale(.large)
                            .onTapGesture {
                                expandSheet = false
                                animateContent = false
                            }
                        
                        Spacer()
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                            Text("Playlist from album")
                                .opacity(0.5)
                                .font(.caption)
                            Text("Top Hits")
                                .font(.title2)
                        })
                        Spacer()
                        
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 80)
                    
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
                            .clipShape(RoundedRectangle(cornerRadius: animateContent ? 20 : 30, style: .continuous))
                    }
                    .matchedGeometryEffect(id: "SONGCOVER", in: animation)
                    .frame(height: size.width)
                    .padding(.vertical, size.height < 700 ? 30 : 20)
                    
                    
                    PlayerView(size)
                        .offset(y: animateContent ? 0 : size.height)
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .top)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        expandSheet.toggle()
                        animateContent.toggle()
                    }
                }
            }
            .contentShape(Rectangle())
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translationY = value.translation.height
                        offsetY = (translationY > 0 ? translationY : 0)
                    }).onEnded({ value in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            if offsetY > size.height * 0.4 {
                                expandSheet = false
                                animateContent = false
                            } else {
                                offsetY = .zero
                            }
                        }
                    })
            ).ignoresSafeArea(.container, edges: .all)
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            withAnimation(.easeInOut(duration: 0.35)) {
                animateContent = true
            }
        }
    }
    
    @State var value = 11.0
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader {
            let size = $0.size
            let spacing = size.height * 0.04
            
            //sizing t for more compact look
            VStack(spacing: spacing, content: {
                VStack(alignment: .center , spacing: 15 , content: {
                    VStack(alignment: .center, spacing: 5, content: {
                        Text("\(songManager.song.title)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("\(songManager.song.artist)")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    })
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    
                    Slider(value: $value, in: 0...100)
                    HStack {
                        Text("0:37")
                            .font(.caption)
                        
                        Spacer()
                        
                        Text("3:34")
                            .font(.caption)
                    }
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        Spacer()
                        Button{
                            
                        } label: {
                            Image(systemName: "shuffle")
                                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                .background(.clear)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button{
                            
                        } label: {
                            Image(systemName: "backward.end.fill")
                                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                .background(.clear)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button{
                            
                        } label: {
                            Image(systemName: "play.fill")
                                .imageScale(.large)
                                .padding()
                                .background(.white)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        Button{
                            
                        } label: {
                            Image(systemName: "forward.end.fill")
                                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                .background(.clear)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button{
                            
                        } label: {
                            Image(systemName: "repeat")
                                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                .background(.clear)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    })
                    Spacer()
                })
            })
        }
    }
}


#Preview {
    ContentView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

//extension for corner radius
extension View {
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            return 0
        }
        return 0
    }
}
