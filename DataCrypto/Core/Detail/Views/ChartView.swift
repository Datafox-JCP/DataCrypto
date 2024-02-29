//
//  ChartView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 29/02/24.
//

import SwiftUI

struct ChartView: View {
    
    // MARK: Properties
    @State private var percentage: CGFloat = 0
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    init(coin: Coin) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .dcGreen : .dcRed
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    // MARK: View
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartLabels.padding(.horizontal, 4), alignment: .leading)
            
            shortDateLabels
                .padding(.horizontal, 4)
        } // VStack
        .font(.caption)
        .foregroundStyle(.dcSecondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1
                } // Animation
            } // Dispatch
        } // Appear
    }
}

// MARK: - Previews
#Preview("Light") {
    ChartView(coin: MockData.coin)
}

#Preview("Dark") {
    ChartView(coin: MockData.coin)
        .preferredColorScheme(.dark)
}

// MARK: Extensions

extension ChartView {
    
    // MARK: Chart
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            } // Path
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 5, x: 0.0, y: 5)
            .shadow(color: lineColor.opacity(0.5), radius: 5, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.2), radius: 5, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.1), radius: 5, x: 0.0, y: 30)
        } // Geometry
    }
    
    // MARK: Chart background
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    // MARK: Chart labels
    private var chartLabels: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            
            Spacer()
            
            let midPrice = ((maxY + minY) / 2).formattedWithAbbreviations()
            Text(midPrice)
            
            Spacer()
            
            Text(minY.formattedWithAbbreviations())
        } // VStack
    }
    
    // MARK: Date labels
    private var shortDateLabels: some View {
        HStack {
            Text(startingDate.toShortDateString())
            
            Spacer()
            
            Text(endingDate.toShortDateString())
        } // HStack
    }
}
