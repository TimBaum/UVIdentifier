////
////  SettingsPopup.swift
////  uv.identifier
////
////  Created by Tim Baum on 11.04.22.
////
//
//import SwiftUI
//
//struct LanguagePopup: View {
//    var title: String
//    var message: String
//    var buttonText: String
//
//    var body: some View {
//        ZStack {
//            if true {
//                // PopUp background color
//                Color.black.opacity(true ? 0.3 : 0).edgesIgnoringSafeArea(.all)
//
//                // PopUp Window
//                VStack(alignment: .center) {
//                    Text("Language")
//                        .font(.title)
//                        .foregroundColor(Color.white)
//                        
//                    
//                    Button(action: {
//                        // Dismiss the PopUp
//                        withAnimation(.linear(duration: 0.3)) {
//                            let show = false
//                        }_
//                    }, label: {
//                        Text(buttonText)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 54, alignment: .center)
//                            .foregroundColor(Color.white)
//                            .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
//                            .font(Font.system(size: 23, weight: .semibold))
//                    }).buttonStyle(PlainButtonStyle())
//                }
//                
//            }
//        }
//    }
//}
//
//struct LanguagePopup_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguagePopup(title: "Lanugage", message: "sdsd", buttonText: "ssd")
//    }
//}
