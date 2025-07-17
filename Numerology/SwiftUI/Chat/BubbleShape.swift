//
//  BubbleShape.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.06.2025.
//

import SwiftUI

struct BubbleShape: Shape {
    
    var myMessage : Bool
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        let corner: CGFloat = 18
        let corner_smooth: CGFloat = 8
        let tail_padding: CGFloat = 5
        
        let top_tail_corner: CGFloat = 25
        let top_tail_smooth: CGFloat = top_tail_corner/2
        
        let bezierPath = UIBezierPath()
        
        if !myMessage {
            // Start
            bezierPath.move(to: CGPoint(x: 20, y: height))
            // bottom trailing
            bezierPath.addLine(to: CGPoint(x: width - corner, y: height))
            
            bezierPath.addCurve(
                to: CGPoint(x: width, y: height - corner),
                controlPoint1: CGPoint(x: width - corner_smooth, y: height),
                controlPoint2: CGPoint(x: width, y: height - corner_smooth)
            )
            // top trailing
            bezierPath.addLine(to: CGPoint(x: width, y: corner))
            bezierPath.addCurve(
                to: CGPoint(x: width - corner, y: 0),
                controlPoint1: CGPoint(x: width, y: corner_smooth),
                controlPoint2: CGPoint(x: width - corner_smooth, y: 0)
            )
            // Top Leading
            bezierPath.addLine(to: CGPoint(x: top_tail_corner, y: 0))
            bezierPath.addCurve(
                to: CGPoint(x: tail_padding, y: corner),
                controlPoint1: CGPoint(x: top_tail_smooth, y: 0),
                controlPoint2: CGPoint(x: tail_padding, y: corner_smooth)
            )
            
            // Bottom leading - Tail
            bezierPath.addLine(to: CGPoint(x: tail_padding, y: height - 10))
            bezierPath.addCurve(
                to: CGPoint(x: 0, y: height),
                controlPoint1: CGPoint(x: 5, y: height - 1),
                controlPoint2: CGPoint(x: 0, y: height)
            )
            // tail
            bezierPath.addLine(to: CGPoint(x: 0, y: height))
            // Tail - deepening - 1
            bezierPath.addCurve(
                to: CGPoint(x: 12, y: height - 4),
                controlPoint1: CGPoint(x: 6, y: height + 1),
                controlPoint2: CGPoint(x: 8, y: height - 1)
            )
            // Tail - deepening - 2
            bezierPath.addCurve(
                to: CGPoint(x: 19.8, y: height),
                controlPoint1: CGPoint(x: 15, y: height),
                controlPoint2: CGPoint(x: 20, y: height)
            )
        } else {
            // Start
            bezierPath.move(to: CGPoint(x: width - 20, y: height))
            // Leading bottom
            bezierPath.addLine(to: CGPoint(x: corner, y: height))
            bezierPath.addCurve(
                to: CGPoint(x: 0, y: height - corner),
                controlPoint1: CGPoint(x: corner_smooth, y: height),
                controlPoint2: CGPoint(x: 0, y: height - corner_smooth)
            )
            // Leading top
            bezierPath.addLine(to: CGPoint(x: 0, y: corner))
            bezierPath.addCurve(
                to: CGPoint(x: corner, y: 0),
                controlPoint1: CGPoint(x: 0, y: corner_smooth),
                controlPoint2: CGPoint(x: corner_smooth, y: 0)
            )
            //  Trailing top
            bezierPath.addLine(to: CGPoint(x: width - top_tail_corner, y: 0))
            bezierPath.addCurve(
                to: CGPoint(x: width - tail_padding, y: corner),
                controlPoint1: CGPoint(x: width - top_tail_smooth, y: 0),
                controlPoint2: CGPoint(x: width - tail_padding, y: corner_smooth)
            )
            // Tail - Trailing Bottom
            bezierPath.addLine(to: CGPoint(x: width - tail_padding, y: height - 12))
            bezierPath.addCurve(
                to: CGPoint(x: width, y: height),
                controlPoint1: CGPoint(x: width - tail_padding, y: height - 1),
                controlPoint2: CGPoint(x: width, y: height + 0)
            )
            // Tail start
            bezierPath.addLine(to: CGPoint(x: width + 0, y: height + 0))
            // Tail - deepening - 1
            bezierPath.addCurve(
                to: CGPoint(x: width - 12, y: height - 4),
                controlPoint1: CGPoint(x: width - 6, y: height + 1),
                controlPoint2: CGPoint(x: width - 10, y: height - 1)
            )
            // Tail - deepening - 2
            bezierPath.addCurve(
                to: CGPoint(x: width - 19.8, y: height),
                controlPoint1: CGPoint(x: width - 15, y: height),
                controlPoint2: CGPoint(x: width - 20, y: height)
            )
        }
        return Path(bezierPath.cgPath)
    }
}


struct BubbleShape_TESTPREVIEW: View {
    var body: some View {
        VStack {
            //
            Text("You’ve hit the Free plan limit for GPT-4o. Responses will use another model until your limit resets after 10:11 PM.")
                .padding(EdgeInsets(
                    top: 8,
                    leading: 14,
                    bottom: 8,
                    trailing: 14
                ))
                .foregroundStyle(.white)
                .background {
                    ZStack {
                        let bubble = BubbleShape(myMessage: false)
                        bubble.fill(.green)
                    }
                }
                .frame(width: 300)
            //
            Text("You’ve hit the Free plan limit for GPT-4o. Responses will use another model until your limit resets after 10:11 PM.")
                .padding(EdgeInsets(
                    top: 8,
                    leading: 14,
                    bottom: 8,
                    trailing: 14
                ))
                .foregroundStyle(.white)
                .background {
                    ZStack {
                        let bubble = BubbleShape(myMessage: true)
                        bubble.fill(.green)
                    }
                }
                .frame(width: 300)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
    }
}

#Preview {
    BubbleShape_TESTPREVIEW()
}
