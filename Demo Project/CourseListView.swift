//
//  CourseListView.swift
//  Demo Project
//
//  Created by Tejas Kashyap on 10/11/23.
//

import SwiftUI

struct CourseListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var viewModel = UsersViewModel()
    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let imgCollection = [ImageCollection.course1,
                         ImageCollection.course2,
                         ImageCollection.course3,
                         ImageCollection.course4,
                         ImageCollection.course5,
                         ImageCollection.course6]
    @State private var searchEnabled = false
    @State private var searchData:[Branch] = []
    
    var body: some View {
        VStack{
           
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(ImageCollection.backBtn, bundle: .main)
                            .resizable()
                            .frame(width: 36,height: 36)
                            .padding(.leading,10)
                    })
                    
                    Spacer()
                }
                VStack(alignment: .leading){
                    Text("All B.Tech Courses")
                        .foregroundStyle(.white)
                        .font(.custom(CustomFonts.semiBold, size: 16))
                    
                    Text("Find your branch")
                        .foregroundStyle(.white)
                        .font(.custom(CustomFonts.regular, size: 12))
                }
                .frame(maxWidth: .infinity,alignment: .topLeading)
                .padding(.leading,10)
                
                
              
               
            if  viewModel.courseData.status != ""{
                VStack{
                    HStack{
                        Image(ImageCollection.magnifyIcon, bundle: .main)
                            .resizable()
                            .frame(width: 26,height: 26)
                            .padding(.leading,10)
                        
                        TextField("Search course, program", text: $searchText)
                            .foregroundStyle(.textColor1)
                            .font(.custom(CustomFonts.regular, size: 12))
                        
                            .onChange(of: searchText) {
                                
                                if searchText == ""{
                                    searchData.removeAll()
                                    searchEnabled = false
                                } else {
                                    searchData = viewModel.courseData.branches.filter { data in
                                        return data.name.lowercased().contains(searchText.lowercased()) ||  data.short.lowercased().contains(searchText.lowercased())
                                    }
                                    searchEnabled = true
                                    
                                    print("searchData - ",searchData)
                                    print("searchData searchText - ",searchText)
                                }
                            }
                    }
                }
                .frame(width: UIScreen.main.bounds.width  - 20, height: 45)
                .background(content: {
                    Capsule()
                        .foregroundStyle(.white)
                })
                .padding(.top)
                scrollDataView()
                    .padding(.top)
                
            } else{
                VStack{
                    EmptyView()
                    Spacer()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(content: {
            VStack{
                Image(ImageCollection.bgImg2, bundle: .main)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height * 0.3, alignment: .top )
                    .ignoresSafeArea()
                Spacer()
            }
            
        })
        .onAppear(){
            viewModel.fetchUsers()
        }
        .navigationBarHidden(true)
        
    }
    
    func scrollDataView() -> some View {
        ScrollView(showsIndicators: false){
            LazyVGrid(columns: columns, spacing: 20) {
                if searchEnabled{
                               ForEach(0..<searchData.count, id: \.self) { index in
                                   if index < searchData.count {
                                       CustomeCell(short:  $searchData[index].short, name:   $searchData[index].name, img: imgCollection.randomElement()!)
                                   }
                               }
                           } else{
                               ForEach(0..<viewModel.courseData.branches.count, id: \.self) { index in
                                   CustomeCell(short:  $viewModel.courseData.branches[index].short, name:  $viewModel.courseData.branches[index].name, img: imgCollection.randomElement()!)
                               }
                           }
            }
            .padding(.horizontal,10)
        }
        
    }
}

#Preview {
    CourseListView()
}



struct CustomeCell: View {
    @Binding var short : String
    @Binding var name : String
    var img : String
    var showImg = false
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack(){
                    Image(img, bundle: .main)
                    
                    Text(short)
                        .foregroundStyle(.textColor3)
                        .font(.custom(CustomFonts.bold, size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Group{
                    ( showImg ? Text(Image(ImageCollection.image2, bundle: .main)) : Text("") ) +
                    Text(" " + name)
                }
                .foregroundStyle(.black)
                .font(.custom(CustomFonts.regular, size: 12))
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
        }
        .frame(width: (UIScreen.main.bounds.width ) * 0.45, height: ((UIScreen.main.bounds.width ) * 0.45) * 0.7)
        .background(.white)
        .clipShape(
            .rect(
                topLeadingRadius: 20,
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20,
                topTrailingRadius: 20
            )
        )
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
        .overlay (alignment:.topTrailing){
            if showImg{
                VStack{
                    Text("20 % OFF")
                        .foregroundStyle(.color2)
                        .font(.custom(CustomFonts.extraBold, size: 12))
                    
                }
                .frame(width: 70, height: 30)
                .background(ColorsCollection.color2.opacity(0.4))
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 20
                    )
                )
            }
            
        }
    }
}
