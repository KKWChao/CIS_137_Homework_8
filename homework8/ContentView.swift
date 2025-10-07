//
//  ContentView.swift
//  homework8
//
//  Created by Kelvin Chao on 10/5/25.
//

/*
 *  CIS 137
 *  Kelvin Chao
 *  07/10/25
 *
 *  Modifications:
 *  - Added navigation links for each item to view image, discription and price
 *  - Created another JSON (test.json) for Cars with the menu.json as the base format
 *  - Created Car Model (Cars.swift) using Menu Model as framework
 *  - Added Cars and brands to the car menu navigation
 *  - Some styling choices
 */

import SwiftUI

let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
let cars = Bundle.main.decode([CarSection].self, from: "test.json")

struct CarDetail: View {
    var body: some View {
        List {
            ForEach(cars, id: \.id) { section in
                NavigationLink(destination: {
                    List {
                        ForEach(section.items, id: \.name) { item in
                            HStack {
                                Text(item.name)
                            }
                        }
                    }
                }) {
                    Text(section.name)
                }
            }
        }
    }
}

struct FoodDetail: View {
    var body: some View {
        List {
            ForEach(menu, id: \.id) { section in
                NavigationLink(destination: {
                    List {
                        ForEach(section.items, id: \.name) { item in
                            // Want another screen showing item and description
                            NavigationLink(destination: FoodItem(item: item)) {
                                HStack(spacing: 15) {
                                    Image(item.thumbnailImage)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                    Text(item.name)
                                }
                            }
 
                        }
                    }
                }) {
                    Text(section.name)
                }
            }
        }
    }
}


struct FoodItem: View {
    let item: MenuItem
    
    var body: some View {
        VStack(spacing: 30) {
            Text(item.name)
                .font(.system(size: 30))
            Text("$\(item.price)")
                .font(.system(size: 20))
            Image(item.mainImage)
            Text(item.description)

        }
        .padding(20)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView() {
            List {
                NavigationLink(destination: CarDetail()
                ) {
                    HStack {
                        Image(systemName: "car.fill")
                        Text("Cars")
                    }
                }
                HStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                HStack {
                    Image(systemName: "figure.run")
                    Text("Fitness")
                }
                NavigationLink(destination:FoodDetail()) {
                    HStack {
                        Image(systemName: "fork.knife")
                        Text("Food")
                    }
                }
            }.navigationTitle("Menu")
        }
    }
}

#Preview {
    ContentView()
}
