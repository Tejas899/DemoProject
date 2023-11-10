//
//  ContentView.swift
//  Demo Project
//
//  Created by Tejas Kashyap on 09/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedQueryIndex: Int = 0
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let profileImage = [ImageCollection.profile1,ImageCollection.profile2 ]
    @State var path: [String] = []
    
    
    var body: some View {
       NavigationStack(path: $path) {
            ScrollView(showsIndicators:false){
                VStack{
                    header
                    
                    videoview
                        .padding(.top,100)
                        .padding(.horizontal)
                    courseView
                        .padding(.top,20)
                        .padding(.horizontal)
                    fraturedSubjectView
                        .padding(.top,20)
                        .padding(.horizontal)
                    crashCourseView
                        .padding(.top,20)
                        .padding(.horizontal)
                    liveSessionView
                        .padding(.top,20)
                        .padding(.horizontal)
                    Spacer()
                    
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "CourseListView"{
                    CourseListView()
                }
            }
        }
    }
    
    var header: some View{
        VStack{
            VStack {
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Hey Shwet!")
                                .foregroundStyle(.black)
                                .font(.custom(CustomFonts.semiBold, size: 16))
                            
                            Text("Let’s learn something new today")
                                .foregroundStyle(.textColor1)
                                .font(.custom(CustomFonts.regular, size: 12))
                        }
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.leading,10)
                        
                        HStack{
                            Spacer()
                            Button {
                                print("notificationIcon")
                            } label: {
                                Image(ImageCollection.notificationIcon, bundle: .main)
                                    .resizable()
                                    .frame(width: 40 , height: 40)
                            }
                            .padding(.trailing,20)
                            Button {
                                print("searchIcon")
                            } label: {
                                Image(ImageCollection.searchIcon, bundle: .main)
                                    .resizable()
                                    .frame(width: 40 , height: 40)
                            }
                            .padding(.trailing)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                    .padding(.top,UIScreen.main.bounds.height * 0.1)
                    
                    subHeader
                        .padding(.top,30)
                    
                }
                .background(content: {
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [ColorsCollection.color1,.white]), startPoint: .top, endPoint: .bottom))
                })
                .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height * 0.3 )
                
            }
        }
    }
    
    var subHeader:  some View{
        VStack{
            TabView(selection: $selectedQueryIndex,
                    content:  {
                ForEach(0..<3 , id: \.self) { i in
                    VStack{
                        VStack(alignment: .leading){
                            VStack(alignment: .leading){
                                Text("Have any queries?")
                                    .foregroundStyle(.textColor2)
                                    .font(.custom(CustomFonts.medium, size: 16))
                                
                                Text("Talk to an academic counsellor for free")
                                    .zIndex(1)
                                    .foregroundStyle(.textColor2)
                                    .font(.custom(CustomFonts.light, size: 12))
                            }
                            .frame(maxWidth: .infinity,alignment: .topLeading)
                            .padding(.leading,30)
                            
                            Button(action: {
                                
                            }, label: {
                                VStack{
                                    Text("Call now")
                                        .foregroundStyle(.white)
                                        .font(.custom(CustomFonts.medium, size: 12))
                                    
                                }
                                .frame(width: 90, height: 30)
                                .background(ColorsCollection.color2)
                                .clipShape(Capsule())
                                .padding(.leading,30)
                                
                            })
                            .padding(.top)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 20 ,height: UIScreen.main.bounds.height * 0.2)
                    .background(ColorsCollection.color2.opacity(0.3))
                    
                    .clipShape(
                        .rect(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 20
                        )
                    )
                    .overlay(alignment: .trailing) {
                        Image(ImageCollection.bgImg, bundle: .main)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height * 0.25  ,height: UIScreen.main.bounds.height * 0.2)
                    }
                    .padding(.leading, i == 0 ? 5 : 0)
                    .padding(.trailing, i == 2 ? 5 : 0)
                }
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: UIScreen.main.bounds.width ,height: UIScreen.main.bounds.height * 0.2)
            
            HStack {
                ForEach(0..<3, id: \.self) { index in
                    Capsule()
                        .fill(selectedQueryIndex == index ? ColorsCollection.color4 : ColorsCollection.color3)
                        .frame(width: 26, height: 8)
                        .onTapGesture {
                            selectedQueryIndex = index
                        }
                }
            }
        }
    }
    
    var videoview: some View {
        VStack(alignment: .leading){
            
            Text("Resume from where you left")
                .foregroundStyle(.textColor4)
                .font(.custom(CustomFonts.medium, size: 14))
            
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text("Z Transform using EQN I")
                                .foregroundStyle(.textColor4)
                                .font(.custom(CustomFonts.semiBold, size: 14))
                            
                            Text("Digital Signal Processing")
                                .foregroundStyle(.textColor4)
                                .font(.custom(CustomFonts.regular, size: 12))
                        }
                        .frame(maxWidth: .infinity,alignment: .topLeading)
                        .padding(.leading)
                        
                        Button(action: {
                            
                        }, label: {
                            VStack{
                                Text("9mins left")
                                    .foregroundStyle(.color2)
                                    .font(.custom(CustomFonts.semiBold, size: 12))
                            }
                            .frame(width: 90, height: 30)
                        })
                        
                    }
                    Image(ImageCollection.image1, bundle: .main)
                        .resizable()
                        .frame(width: (UIScreen.main.bounds.width - 20 ) * 0.35 ,height: UIScreen.main.bounds.height * 0.15)
                    
                }
            }
            .frame(width: UIScreen.main.bounds.width - 20 ,height: UIScreen.main.bounds.height * 0.15)
            .background(.white)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 10,
                    bottomTrailingRadius: 10,
                    topTrailingRadius: 10
                )
            )
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
        }
    }
    
    var courseView : some View{
        VStack(alignment: .leading){
            
            topview("Explore courses", clouser: {
                print("courseView")
                path.append("CourseListView")
            })
            .padding(.leading,10)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<4, id: \.self) { item in
                    
                    switch item{
                    case 0:
                        CustomeCell(short: .constant("B.Tech"), name: .constant("2.4K Enrolled"),  img: ImageCollection.course2, showImg: true)
                    case 1:
                        CustomeCell(short: .constant("UPSC"), name: .constant("2.4K Enrolled"), img: ImageCollection.course7, showImg: true)
                    case 2:
                        CustomeCell(short: .constant("ISRO"), name: .constant("2.4K Enrolled"), img: ImageCollection.course9, showImg: true)
                    case 3:
                        CustomeCell(short: .constant("GATE"), name: .constant("2.4K Enrolled"), img:ImageCollection.course8, showImg: true)
                        
                    default:
                        CustomeCell(short: .constant("GATE"), name: .constant("2.4K Enrolled"), img: ImageCollection.course2)
                    }
                }
            }
        }
    }
    
    
    var fraturedSubjectView : some View{
        VStack(alignment: .leading){
            topview("Featured subjects", clouser: {
                print("fraturedSubjectView")
            })
            .padding(.leading,10)
            
            ScrollView(.horizontal,showsIndicators:false) {
                HStack{
                    ForEach(0..<3){ item in
                        HStack{
                            VStack(alignment:.leading){
                                Image(ImageCollection.profile1, bundle: .main)
                                    .resizable()
                                    .frame(width: (UIScreen.main.bounds.width - 20 ) * 0.35 ,height: UIScreen.main.bounds.height * 0.15)
                                
                                Text("B.TECH • ECE")
                                    .foregroundStyle(.textColor1)
                                    .font(.custom(CustomFonts.extraLight, size: 10))
                                    .padding(.top,5)
                                   
                                Text("Digital Signal Processing")
                                    .foregroundStyle(.textColor4)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.custom(CustomFonts.semiBold, size: 14))
                                    .padding(.top,5)
                                Text("By Hari Krishna")
                                    .foregroundStyle(.textColor1)
                                    .font(.custom(CustomFonts.extraLight, size: 10))
                                    .padding(.top,2)
                                HStack{
                                    Text("₹749")
                                        .foregroundStyle(.textColor4)
                                        .font(.custom(CustomFonts.semiBold, size: 14))
                                    Text("₹749")
                                        .foregroundStyle(.textColor1)
                                        .font(.custom(CustomFonts.extraLight, size: 10))
                                        .strikethrough()
                                }
                                .padding(.top,5)
                                
                                
                            }
                        }
                        .frame(width: 150)
                        .background(.white)
                        .clipShape(
                            .rect(
                                bottomLeadingRadius: 10,
                                bottomTrailingRadius: 10,
                                topTrailingRadius: 10
                            )
                        )
                    }
                }
            }
            
        }
    }
    
    var crashCourseView : some View{
        VStack(alignment: .leading){
            topview("Top crash courses", clouser: {
                print("fraturedSubjectView")
            })
            .padding(.leading,10)
            
            ScrollView(.horizontal,showsIndicators:false) {
                HStack{
                    ForEach(0..<3){_ in
                        VStack{
                            VStack(alignment: .leading){
                                VStack(alignment: .leading){
                                    Text("Have any queries?")
                                        .foregroundStyle(.textColor2)
                                        .font(.custom(CustomFonts.medium, size: 16))
                                    
                                    Text("Talk to an academic counsellor for free")
                                        .zIndex(1)
                                        .foregroundStyle(.textColor2)
                                        .font(.custom(CustomFonts.light, size: 12))
                                }
                                .frame(maxWidth: .infinity,alignment: .topLeading)
                                .padding(.leading,30)
                                
                                Button(action: {
                                    
                                }, label: {
                                    VStack{
                                        Text("Call now")
                                            .foregroundStyle(.white)
                                            .font(.custom(CustomFonts.medium, size: 12))
                                        
                                    }
                                    .frame(width: 90, height: 30)
                                    .background(ColorsCollection.color2)
                                    .clipShape(Capsule())
                                    .padding(.leading,30)
                                    
                                })
                                .padding(.top)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 20 ,height: UIScreen.main.bounds.height * 0.15)
                        .background(.red)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 10,
                                bottomLeadingRadius: 10,
                                bottomTrailingRadius: 10,
                                topTrailingRadius: 10
                            )
                        )
                    }
                }
            }
        }
    }
    
    var liveSessionView : some View{
        VStack(alignment: .leading){
            topview("Live sessions", clouser: {
                print("fraturedSubjectView")
            })
            .padding(.leading,10)
            
            ScrollView(.horizontal,showsIndicators:false) {
                HStack{
                    ForEach(0..<3){_ in
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    VStack(alignment: .leading){
                                        Text("Z Transform using EQN I")
                                            .foregroundStyle(.textColor4)
                                            .font(.custom(CustomFonts.semiBold, size: 14))
                                        
                                        Text("Digital Signal Processing")
                                            .foregroundStyle(.textColor4)
                                            .font(.custom(CustomFonts.regular, size: 12))
                                    }
                                    .frame(maxWidth: .infinity,alignment: .topLeading)
                                    .padding(.leading)
                                    
                                    Button(action: {
                                        
                                    }, label: {
                                        VStack{
                                            Text("9mins left")
                                                .foregroundStyle(.color2)
                                                .font(.custom(CustomFonts.semiBold, size: 12))
                                        }
                                        .frame(width: 90, height: 30)
                                    })
                                    
                                }
                                Image(ImageCollection.image1, bundle: .main)
                                    .resizable()
                                    .frame(width: (UIScreen.main.bounds.width - 20 ) * 0.35 ,height: UIScreen.main.bounds.height * 0.15)
                                
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 20 ,height: UIScreen.main.bounds.height * 0.15)
                        .background(.white)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 10,
                                bottomLeadingRadius: 10,
                                bottomTrailingRadius: 10,
                                topTrailingRadius: 10
                            )
                        )
                    }
                }
            }
        }
    }
    
    
    func topview(_ headingTitle:String, clouser:  @escaping (()->()) ) -> some View {
        HStack{
            Text(headingTitle)
                .foregroundStyle(.textColor4)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                clouser()
            } label: {
                Group{
                    Text("see all ") + Text(Image(ImageCollection.vector,bundle:.main))
                }
                .foregroundStyle(.textColor4)
                .font(.custom(CustomFonts.medium, size: 14))
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.trailing)
            
        }
    }
}


#Preview {
    ContentView()
}
