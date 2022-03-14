//
//  ContentView.swift
//  AppleSauce2
//
//  Created by Christian Grinling on 27/12/2021.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var show: String = "ChooseAccount"
    @State private var video: String = ""
    @State private var showvideo = false

    var body: some View {
        VStack{
            if show == "ChooseAccount" {
                RootView(show: $show)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .transition(AnyTransition.move(edge: .leading)).animation(.none)
            }
            if show == "Home" {
                NextView(show: $show, video: $video, showvideo: $showvideo)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(hex: 0x141414))
                    .transition(AnyTransition.move(edge: .trailing)).animation(.none)
            }
            
            if show == "Player" {
                vidPlayerView(show: $show, video: $video)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct RootView: View {
    @Binding var show: String
    let photos = ["christian", "milo1","freya","pipy","milo2"]
    var body: some View {
        ZStack {
            Color(hex: 0x141414)
            
            VStack {
                HStack {
                    Image("FREYSTIANFLIX")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 40)
                        .padding()
                    Spacer()
                }
                Spacer()
            }
            VStack {
                Text("Who's Watching?")
                    .foregroundColor(.white)
                    .padding(.bottom,40)
                    .font(.system(size: 50, weight: .semibold, design: .default))

                    VStack {
                        HStack {
                        ForEach(photos.indices, id: \.self) { index in
                            VStack {
                            if index == 2 {
                                
                                Image(photos[index])
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 200, height: 200, alignment: .center)
                                   .padding()
                                   .gesture(
                                        TapGesture()
                                            .onEnded { _ in
                                                self.show = "Home"
                                           }
                                       )
 
                                
                                Text(photos[index])
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .regular, design: .default))

                            }
                            
                            else {
                                Image(photos[index])
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 200, height: 200, alignment: .center)
                                   .padding()
                                
                                Text(photos[index])
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .regular, design: .default))
                                
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


struct NextView: View {
    @Binding var show: String
    @Binding var video: String
    @Binding var showvideo: Bool
    @State private var showingSheet = false

    var body: some View {
        ScrollView {
            ZStack {
                Image("topImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.clear, Color(hex: 0x141414)]), startPoint: .center, endPoint: .bottom))
                
                VStack {
                    HStack {
                        let topPadding:CGFloat = 20
                        Image("FREYSTIANFLIX")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 40)
                            .padding(.leading,20)
                            .padding(.trailing,20)
                            .padding(.top,topPadding)
                        Text("Home")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .padding(.trailing,20)
                            .padding(.top,topPadding)
                        Text("TV Shows")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .padding(.trailing,20)
                            .padding(.top,topPadding)
                        Text("Movies")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .padding(.trailing,20)
                            .padding(.top,topPadding)
                        Text("New and Popular")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .padding(.trailing,20)
                            .padding(.top,topPadding)
                        Text("My List")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .padding(.trailing,20)
                            .padding(.top,topPadding)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(.trailing,20)
                            .padding(.top,topPadding)
                        Image(systemName: "bell.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(.trailing,20)
                            .padding(.top,topPadding)
                        Image(systemName: "square.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(.trailing,50)
                            .padding(.top,topPadding)
                    }
                    Spacer()
                }.frame(maxWidth: .infinity)


                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Image("N-Film")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 100,maxHeight: 0)
                                    .padding(.leading,80)
                                    .padding(.top,150)
                                
                                Text("A Year \nTogether")
                                    .foregroundColor(.white)
                                    .font(.system(size: 75, weight: .bold, design: .default))
                                    .padding(.leading,80)
                                    .padding(.top,10)
                                
                                Text("This romantic comedy follows the lives of \nChristian and Freya as they fall in love \nwith each other, whippets and orzo.")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .regular, design: .default))
                                    .padding(.leading,80)
                                
                                HStack(alignment: .center) {
                                    Button {
                                        //show view here
                                        showingSheet.toggle()
                                    
                                    } label: {
                                        Label("Play", systemImage: "play.fill")
                                        .frame(width: 80 , height: 30, alignment: .center)
                                        .sheet(isPresented: $showingSheet) {
                                            SeriesView(show: $show, video: $video, isPresented: $showingSheet)
                                            .frame(width: 900, height: 800, alignment: .center)
                                        }
                                        
                                    }.frame(width: 100, height: 60, alignment: .center) .padding(.leading,80) .niceButton(
                                        foregroundColor: .black,
                                        backgroundColor: .white,
                                        pressedColor: .gray
                                    ) .padding(.top,10)
                                    
                                    Button {print("More Info")} label: {
                                        Label("More Info", systemImage: "info.circle")
                                        .frame(width: 90 , height: 30, alignment: .center)
                                        
                                        
                                    }.frame(width: 100, height: 60, alignment: .center) .padding(.leading,10) .niceButton(
                                        foregroundColor: .white,
                                        backgroundColor: Color(hex: 0x504F4F),
                                        pressedColor: .white
                                      ) .padding(.top,10)
                                    
                                }
                            }
                        Spacer()
                        }
                    }.frame(maxWidth: .infinity)
                }
            
            //Continue Watching Area
            
            VStack {
                
                HStack{
                    comedyview(show: $show, video: $video)
                    Spacer()
                    }
                
                HStack{
                    romanticview(show: $show, video: $video)
                    Spacer()
                    }
                
                HStack{
                    cuteview(show: $show, video: $video)
                    Spacer()
                    }
                
                HStack{
                    tripview(show: $show, video: $video)
                    Spacer()
                    }
                }
            }
        }
    }




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct vidPlayerView: View {
    @Binding var show: String
    @Binding var video: String
    @State var isplaying = true
    
    var body: some View {
        
        ZStack {
            
            if let url = Bundle.main.url(forResource: video, withExtension: "mp4") {
            let player = AVPlayer(url: url)

            
            //AVPlayerControllerRepresented(player: player)
            VideoPlayer.init(player: player)
                .onAppear {
                    player.play()
                }
                .onDisappear {
                  player.pause()
                  player.seek(to: .zero)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
            VStack {
                HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .padding()
                            .gesture(
                                 TapGesture()
                                     .onEnded { _ in
                                         self.show = "Home"
                                    }
                                )
                    Spacer()
                }
                Spacer()
            }

//            Button {
//                if !player.isPlaying {
//                    player.play()
//                } else {
//                    player.pause()
//                }
//
//            } label: {
//                if player.isPlaying {
//                    Image(systemName: "pause.fill")
//                    .foregroundColor(.black)
//                }
//                else {
//                    Image(systemName: "play.fill")
//                        .foregroundColor(.black)
//                }
//            }
        }
    }
}

struct comedyview: View {
    @Binding var show: String
    @Binding var video: String
    @State private var overImage = -1
    
    let ComedyNames: [String] = ["comedy1", "comedy2", "comedy3", "comedy4", "comedy5","comedy6", "comedy7", "comedy8", "comedy9", "comedy10"]
    var body: some View {
        
VStack(alignment: .leading) {
    
    Text("Comedy")
        .foregroundColor(.white)
        .padding(.leading,80)
        .font(.system(size: 20, weight: .semibold , design: .default))

    ScrollView(.horizontal, showsIndicators: false) {
    HStack {
    ForEach(ComedyNames.indices, id: \.self) { index in
        if index == 0 {
            Image(ComedyNames[index])
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 230, height: 180, alignment: .center)
                   .padding(.leading,80)
                   .overlay(overImage == index ?
                            
                            Image(systemName: "play.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding()
                                :
                               
                               Image(systemName: "play.fill")
                               .font(.system(size: 35))
                               .foregroundColor(.clear)
                               .padding()

                   )
                   .onHover { over in
                       
                       overImage = index
                   }
                   .gesture(
                        TapGesture()
                            .onEnded { _ in
                                print(ComedyNames[index])
                                self.video = ComedyNames[index]
                                self.show = "Player"
                                }
                            )
        }
        else {
            Image(ComedyNames[index])
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 230, height: 180, alignment: .center)
                   .overlay(overImage == index ?
                            
                            Image(systemName: "play.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding()
                                :
                               
                               Image(systemName: "play.fill")
                               .font(.system(size: 35))
                               .foregroundColor(.clear)
                               .padding()

                   )
                   .onHover { over in
                       
                       overImage = index
                   }
                   .gesture(
                        TapGesture()
                            .onEnded { _ in
                                print(ComedyNames[index])
                                self.video = ComedyNames[index]
                                self.show = "Player"
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}

struct romanticview: View {
    @Binding var show: String
    @Binding var video: String
    @State private var overImage = -1
    
    let romanticNames: [String] = ["romantic1", "romantic2", "romantic3", "romantic4", "romantic5","romantic6"]
    var body: some View {
        
VStack(alignment: .leading) {
    
    Text("Romantic")
        .foregroundColor(.white)
        .padding(.leading,80)
        .font(.system(size: 20, weight: .semibold , design: .default))

    ScrollView(.horizontal, showsIndicators: false) {
    HStack {
    ForEach(romanticNames.indices, id: \.self) { index in
        if index == 0 {
            Image(romanticNames[index])
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 230, height: 180, alignment: .center)
                   .padding(.leading,80)
                   .overlay(overImage == index ?
                            
                            Image(systemName: "play.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding()
                                :
                               
                               Image(systemName: "play.fill")
                               .font(.system(size: 35))
                               .foregroundColor(.clear)
                               .padding()

                   )
                   .onHover { over in
                       
                       overImage = index
                   }
                   .gesture(
                        TapGesture()
                            .onEnded { _ in
                                print(romanticNames[index])
                                self.video = romanticNames[index]
                                self.show = "Player"
                                }
                            )
        }
        else {
            Image(romanticNames[index])
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 230, height: 180, alignment: .center)
                   .overlay(overImage == index ?
                            
                            Image(systemName: "play.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding()
                                :
                               
                               Image(systemName: "play.fill")
                               .font(.system(size: 35))
                               .foregroundColor(.clear)
                               .padding()

                   )
                   .onHover { over in
                       
                       overImage = index
                   }
                   .gesture(
                        TapGesture()
                            .onEnded { _ in
                                print(romanticNames[index])
                                self.video = romanticNames[index]
                                self.show = "Player"
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}

struct cuteview: View {
    @Binding var show: String
    @Binding var video: String
    @State private var overImage = -1
    
    let cuteNames: [String] = ["cute1", "cute2", "cute3", "cute4", "cute5","cute6", "cute7","cute8","cute9"]
    var body: some View {
        
VStack(alignment: .leading) {
    
    Text("Cute Videos")
        .foregroundColor(.white)
        .padding(.leading,80)
        .font(.system(size: 20, weight: .semibold , design: .default))

    ScrollView(.horizontal, showsIndicators: false) {
    HStack {
    ForEach(cuteNames.indices, id: \.self) { index in
        if index == 0 {
            Image(cuteNames[index])
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 230, height: 180, alignment: .center)
                   .padding(.leading,80)
                   .overlay(overImage == index ?
                            
                            Image(systemName: "play.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding()
                                :
                               
                               Image(systemName: "play.fill")
                               .font(.system(size: 35))
                               .foregroundColor(.clear)
                               .padding()

                   )
                   .onHover { over in
                       
                       overImage = index
                   }
                   .gesture(
                        TapGesture()
                            .onEnded { _ in
                                print(cuteNames[index])
                                self.video = cuteNames[index]
                                self.show = "Player"
                                }
                            )
        }
        else {
            Image(cuteNames[index])
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 230, height: 180, alignment: .center)
                   .overlay(overImage == index ?
                            
                            Image(systemName: "play.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding()
                                :
                               
                               Image(systemName: "play.fill")
                               .font(.system(size: 35))
                               .foregroundColor(.clear)
                               .padding()

                   )
                   .onHover { over in
                       
                       overImage = index
                   }
                   .gesture(
                        TapGesture()
                            .onEnded { _ in
                                print(cuteNames[index])
                                self.video = cuteNames[index]
                                self.show = "Player"
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}

struct tripview: View {
    @Binding var show: String
    @Binding var video: String
    @State private var overImage = -1
    
    let tripNames: [String] = ["trip1", "trip2", "trip3", "trip4", "trip5","trip6", "trip7", "trip8", "trip9", "trip10"]
    var body: some View {
        
VStack(alignment: .leading) {
    
    Text("Travel")
        .foregroundColor(.white)
        .padding(.leading,80)
        .font(.system(size: 20, weight: .semibold , design: .default))

    ScrollView(.horizontal, showsIndicators: false) {
    HStack {
    ForEach(tripNames.indices, id: \.self) { index in
        if index == 0 {
            Image(tripNames[index])
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 230, height: 180, alignment: .center)
                   .padding(.leading,80)
                   .overlay(overImage == index ?
                            
                            Image(systemName: "play.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding()
                                :
                               
                               Image(systemName: "play.fill")
                               .font(.system(size: 35))
                               .foregroundColor(.clear)
                               .padding()

                   )
                   .onHover { over in
                       
                       overImage = index
                   }
                   .gesture(
                        TapGesture()
                            .onEnded { _ in
                                print(tripNames[index])
                                self.video = tripNames[index]
                                self.show = "Player"
                                }
                            )
        }
        else {
            Image(tripNames[index])
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 230, height: 180, alignment: .center)
                   .overlay(overImage == index ?
                            
                            Image(systemName: "play.fill")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding()
                                :
                               
                               Image(systemName: "play.fill")
                               .font(.system(size: 35))
                               .foregroundColor(.clear)
                               .padding()

                   )
                   .onHover { over in
                       
                       overImage = index
                   }
                   .gesture(
                        TapGesture()
                            .onEnded { _ in
                                print(tripNames[index])
                                self.video = tripNames[index]
                                self.show = "Player"
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}



struct AVPlayerControllerRepresented : NSViewRepresentable {
    var player : AVPlayer
    
    func makeNSView(context: Context) -> AVPlayerView {
        let view = AVPlayerView()
        //view.controlsStyle = .none
        view.player = player
        return view
    }
    
    func updateNSView(_ nsView: AVPlayerView, context: Context) {
        
    }
}


struct SeriesView: View {
    @Binding var show: String
    @Binding var video: String
    @State private var overImage = -1
    let buttons: [String] = ["plus", "hand.thumbsup", "hand.thumbsdown"]
    
    @State var media = [
        
        episode(number: "1", thumbnail: "Jan", title: "January: Lockdown at the Rolt's", description: "Christian declares his love to freya and asks her to be his girlfriend.\nBritain is plunged into national lockdown and milo gets alot of walks.", time: "6m 29s"),
        
        episode(number: "2", thumbnail: "Feb", title: "February: Viral on TikTok", description: "Freya and Christian spend time together in lockdown.\nChristian makes a valentines day app for Freya and goes viral on TikTok. ", time: "3m 2s"),
        
        episode(number: "3", thumbnail: "Mar", title: "March: Back to London", description: "After an amazing lockdown together, the pair head back to London\nThere they complete their census, journey to Greenwich and fall in love with Toothles.", time: "4m 24s"),
        
        episode(number: "4", thumbnail: "Apr", title: "April: Return of the Boo Baa", description: "Christian and Freya return to Bristol for the Easter break. There they\nhang out and discover their love for sitting in the car and eating lunch.\nChristian also gets the best birthday gift.", time: "5m"),
        
        episode(number: "5", thumbnail: "May", title: "May: An unfortunate wait at Twickenham Gate.", description: "Stressed by the upcoming exams, Christian and Freya make sure to spend lots of time together in the sun (or playing pool).\n Anne Boleyn also makes a guest appearance and Le Garrick\ngains two new loyal customers...", time: "3m 40s"),
        
        episode(number: "6", thumbnail: "Jun", title: "June: The end of John Adams.", description: "After the success of their exams, the pair take to Hampstead Heath and Brighton to relax and enjoy the sun.\n They also move out of their uni accomodation and back to milo's waiting arms in Bristol.", time: "2m 32s"),
        
        episode(number: "7", thumbnail: "Jul", title: "July: Mind the Midgies!", description: "The pair journey to Dartmouth, Camping and Bath to soak up the blessed summer sun.\nFreya recieves her second jab and Milo eats Christians Egg sandwich.", time: "6m 22s"),
        
        episode(number: "8", thumbnail: "Aug", title: "August: Not in paris babes.", description: "After spending excrutiating time apart, Christian finally joins Freya in Paris for a romantic trip of love and mosquitos.\nThe pair also dip their feet in Castle Combe and Ogmore beach, and journey to Oxford for a quick row.", time: "3m 55s"),
        
        episode(number: "9", thumbnail: "Sep", title: "September: Footprints in the sand", description: "The pair move into their new second year houses.\nThey visit Greenwich, the Sky Garden and journey to Persia to revel in Rameses delight.", time: "1m 52s"),
        
        episode(number: "10", thumbnail: "Oct", title: "October: The London Dungeons", description: "Freya did not like the London Dungeons.", time: "1m"),
        
        episode(number: "11", thumbnail: "Nov", title: "November: The Snow Kingdom", description: "In order to get into the christmas spirit, Christian and Freya go to watch the Holiday and enjoy some Ice Skating.\nThey also take a break back to Bristol and enjoy the infine delights\nof the infinity room.", time: "1m 20s"),
        
        episode(number: "12", thumbnail: "Dec", title: "December: Hurrah! Arizona at last!", description: "Freya finally gets to meet Christian's family in Arizona. There they enjoys the sun, pipy and christmas.", time: "4m 39s")
        
        ]
    
    
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ScrollView{
        ZStack {
            
            Color(hex: 0x141414)
            
            Image("topImage")
                .resizable()
                .aspectRatio(contentMode: .fit)

            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(gradient: Gradient(colors: [.clear, Color(hex: 0x141414)]), startPoint: .center, endPoint: .bottom))


            VStack {
                HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .padding()
                            .gesture(
                                 TapGesture()
                                     .onEnded { _ in
                                         isPresented = false
                                    }
                                )
                    Spacer()
                }
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Spacer()
                HStack() {
                
                Text("A Year \nTogether")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .padding(.leading,80)
                    .padding(.top,10)
                    Spacer()
                }
                
                HStack {
                    
                    Button {print("play")} label: {
                        Label("Play", systemImage: "play.fill")
                        .frame(width: 90 , height: 20, alignment: .center)
                        
                    }.frame(width: 100, height: 60, alignment: .center) .padding(.leading,80) .niceButton(
                        foregroundColor: .black,
                        backgroundColor: .white,
                        pressedColor: .gray
                    )
                    
                    ForEach(buttons.indices, id: \.self) { index in
                        
                        Image(systemName: buttons[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .padding(.leading,10)

                    }.frame(width: 30, height: 30)
                        
                    Spacer()
                    }
                }
            }
            
            VStack {
                HStack {
                    
                    VStack(alignment: .leading)  {
                    Text("2021 1 Season HD")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .padding(.bottom,20)
                        .padding(.leading,80)
                        
                    Text("S1:E1 'January: Lockdown at the Rolt's' ")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .padding(.bottom,20)
                        .padding(.leading,80)
                    
                    Text("This romantic comedy follows the lives of \nChristian and Freya as they fall in love \nwith each other, whippets and orzo.")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .padding(.bottom,20)
                        .padding(.leading,80)
                        
                    Text("Episodes")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .padding(.top,30)
                        .padding(.leading,80)
                        
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Group {
                          (Text("Cast:").foregroundColor(.gray).font(.system(size: 14))
                           +
                            
                          Text(" Freya Rolt, \nChristian Grinling").foregroundColor(.white)
                            .font(.system(size: 14)))
                        }.padding(.bottom,10)
                        
                        Group {
                          (Text("Genres: ").foregroundColor(.gray).font(.system(size: 14))
                           +
                            
                          Text("Romantic, Comedy, \nThriller, Sexy").foregroundColor(.white)
                            .font(.system(size: 14)))
                        }.padding(.bottom,10)
                        
                        Group {
                          (Text("This show is: ").foregroundColor(.gray).font(.system(size: 14))
                           +
                            
                          Text("Romantic, Witty, \n Tear Jerking, Wholesome").foregroundColor(.white)
                            .font(.system(size: 14)))
                        }.padding(.bottom,10)
                        
                        Group {
                            
                            Text("Season 1")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .padding()
                                .frame(width: 150, height: 40, alignment: .center)
                                .border(.gray, width: 2)
                            
                        }.padding(.top,50)
                        

                        
                    }.padding()
                    
                    
                    
                    
                    
                }
            }
            

            VStack {
                
                        ForEach(media.indices, id: \.self) { index in
                            
                            Group {
                                Rectangle()
                            }
                            .frame(width: 780, height: 1)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            
                            HStack {
                                
                                Text(media[index].number)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                

                                    Image(media[index].thumbnail)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 80, alignment: .center)
                                        .padding()
                                        .overlay(overImage == index ?
                                                 
                                                 Image(systemName: "play.fill")
                                                     .font(.system(size: 35))
                                                     .foregroundColor(.white)
                                                     .padding()
                                                     :
                                                    
                                                    Image(systemName: "play.fill")
                                                    .font(.system(size: 35))
                                                    .foregroundColor(.clear)
                                                    .padding()
             
                                        )
                                        .onHover { over in
                                            
                                            overImage = index
                                        }
                                        .gesture(
                                             TapGesture()
                                                 .onEnded { _ in
                                                     self.video = media[index].thumbnail
                                                     print(self.video)
                                                     self.show = "Player"
                                                     }
                                                 )
                                    
                                
                                
                                VStack(alignment: .leading){
                                    
                                    Text(media[index].title)
                                        .foregroundColor(.white)
                                        .padding(.bottom,10)
                                    
                                    Text(media[index].description)
                                        .foregroundColor(.gray)

                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text(media[index].time)
                                        .foregroundColor(.white)
                                        .padding()
                                        .padding(.trailing,50)
                                        .padding(.top,5)
                                    Spacer()
                                }
                                
                        
                            }.padding(.leading,110)
                            
                        }
                    }
            
            
            
            
            
        }.background(Color(hex: 0x141414))
    }
}


struct episode {
    var number: String
    var thumbnail: String
    var title: String
    var description: String
    var time: String
    
    init(number: String, thumbnail: String, title: String, description: String, time: String ) {
        self.number = number
        self.thumbnail = thumbnail
        self.title = title
        self.description = description
        self.time = time
        
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
