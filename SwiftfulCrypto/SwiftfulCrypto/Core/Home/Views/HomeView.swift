//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Pratik Hanchate on 5/26/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortFolio: Bool = false

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                homeheader
                columnTitles
                if !showPortFolio {
                    allCoinsList
                } else {
                    portfolioCoinsList
                }
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(DeveloperPreview.instance.homeVM)

}


extension HomeView {
    private var homeheader: some View {
            HStack {
                CircleButtonView(iconName: showPortFolio ? "plus" : "info")
                    .background(
                        CircleButtonAnimationView(animate: $showPortFolio)
                    )

                Spacer()
                Text( showPortFolio ? "Portfolio" : "Live Prices")
                    .animation(.none)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.theme.accent)
                Spacer()
                CircleButtonView(iconName: "chevron.right")
                    .rotationEffect(Angle(degrees: showPortFolio ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring) {
                            showPortFolio.toggle()
                        }
                    }
            }
            .padding(.horizontal)
    }

    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .leading))
    }

    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .trailing))
    }

    private var columnTitles: some View {
        HStack {
            Text("Coins")
            Spacer()
            if showPortFolio {
                Text("Holdings")
            }
            Text("Pricing")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
