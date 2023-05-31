//
//  LabelWithImageIcon.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import SwiftUI

/// Create a Label with a custom image which can have its color updated using the
/// `.foregroundColor(_)` funtion.
struct LabelWithImageIcon: View {
   /// The title which will be passed to the title attribute of the Label View.
   let title: String
   /// The name of the image to pass into the Label View.
   let image: String
   
   var body: some View {
       Label(title: {
           Text(self.title)
       }, icon: {
           Image(self.image)
               .renderingMode(.template)
       } )
   }
}

struct LabelExtensions_Previews: PreviewProvider {
   static var previews: some View {
       LabelWithImageIcon(title: "Hello World",
                          image: "icons8-icosahedron")
           .foregroundColor(.orange)
   }
}
