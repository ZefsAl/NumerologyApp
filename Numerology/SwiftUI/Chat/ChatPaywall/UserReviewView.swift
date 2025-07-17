//
//  UserReviewView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.06.2025.
//

import SwiftUI

struct UserReviewView: View {
    
    let model: UserReviewModel
    
    // MARK: - body
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(model.text)
                .padding(EdgeInsets(
                    top: 12,
                    leading: 18,
                    bottom: 12,
                    trailing: 14)
                )
                .font(DS.SourceSerifProFont.footnote_Sb_13!.asCTFont())
                .background {
                    ZStack {
                        let bubble = BubbleShape(myMessage: true)
                        bubble.fill(Color(DS.Chat.question))
                    }
                }
            self.image(model.image)
        }
        .frame(width: UIScreen.main.bounds.width-64)
    }
    
    @ViewBuilder func image(_ string: String) -> some View {
        Image(string)
            .resizable()
            .frame(width: 115, height: 115)
            .overlay (
                Circle()
                    .strokeBorder(Color(DS.Chat.orange), lineWidth: 3)
            )
            .clipShape(Circle())
    }
}


#Preview {
    VStack {
        ForEach(userReview_dataSource, id: \.id) { model in
            UserReviewView(model: model)
        }
    }
}

let userReview_dataSource: [UserReviewModel] = [
    UserReviewModel(
        image: "Lisa",
        text: "This app is truly fantastic, and it has completely transformed my perspective on numerology. I highly recommend it to everyone seeking profound insights!"
    ),
    UserReviewModel(
        image: "Mike",
        text: "This app is truly fantastic, and it has completely transformed my perspective on numerology. I highly recommend it to everyone seeking profound insights!"
    ),
    UserReviewModel(
        image: "Emily",
        text: "This app is truly fantastic, and it has completely transformed my perspective on numerology. I highly recommend it to everyone seeking profound insights!"
    )
    
]
