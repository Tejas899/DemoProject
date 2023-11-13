//
//  CustomeCell.swift
//  Demo Project
//
//  Created by Tejas Kashyap on 13/11/23.
//

import SwiftUI



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

struct CustomeCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomeCell(short: .constant(""), name: .constant(""), img: "")
    }
}

