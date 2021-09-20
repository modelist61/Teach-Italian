//
//  RatingStarsStack.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 01.09.2021.
//

import SwiftUI

struct RatingStarsStack: View {
    
//    @Binding var rating: Int
    let rating = 5

    
    let maximumRating = 5
    
    var offImage: Image?
    let onImage = Image(systemName: "star.fill")
    
    let offColor = Color.gray
    let onColor = Color("ratingStarColor")
    
    var body: some View {
        HStack {
            ForEach(0..<maximumRating) { star in
                image(for: star)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .foregroundColor(star > self.rating ? self.offColor : self.onColor)
//                    .onTapGesture {
//                        self.rating = star
//                    }
            }
        }
        
        
    }
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingStarsStack_Previews: PreviewProvider {
    static var previews: some View {
        RatingStarsStack()
    }
}
