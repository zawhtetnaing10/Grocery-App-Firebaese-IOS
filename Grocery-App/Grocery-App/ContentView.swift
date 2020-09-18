//
//  ContentView.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mGroceryViewModel = GroceryViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(mGroceryViewModel.groceries, id: \.name){ grocery in
                    
                    return HStack(){
                        
                        VStack(alignment: .leading){
                            Text(grocery.name ?? "")
                                .fontWeight(.bold)
                                .font(.title)
                            
                            Text(grocery.description ?? "")
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .padding(.top, 20)
                            
                        }
                        Spacer()
                        VStack{
                            Button(action:{
                                self.mGroceryViewModel.isPopOverShown = true
                            }){
                                Image(systemName: "pencil")
                            }.sheet(isPresented: self.$mGroceryViewModel.isPopOverShown){
                                VStack(spacing: 24){
                                    TextField("Grocery Name", text: self.$mGroceryViewModel.groceryName )
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Grocery Desription", text: self.$mGroceryViewModel.groceryDescription)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Grocery Amount" , text:
                                        self.$mGroceryViewModel.groceryAmount)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Button(action:{
                                        self.mGroceryViewModel.onTapAddGrocery()
                                        self.mGroceryViewModel.isPopOverShown = false
                                    }){
                                        Text("Add Grocery")
                                    }
                                }.padding()
                            }
                            Spacer()
                            Text(String(grocery.amount ?? 0) ?? "")
                                .font(.headline)
                            
                        }
                    }.padding()
                    
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle(Text("Grocery App"))
            .navigationBarItems(trailing: Button("Add New"){
                self.mGroceryViewModel.isPopOverShown = true
                
            }.sheet(isPresented: $mGroceryViewModel.isPopOverShown){
                VStack(spacing: 24){
                    TextField("Grocery Name", text: self.$mGroceryViewModel.groceryName )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Grocery Desription", text: self.$mGroceryViewModel.groceryDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Grocery Amount" , text:
                        self.$mGroceryViewModel.groceryAmount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action:{
                        self.mGroceryViewModel.onTapAddGrocery()
                        self.mGroceryViewModel.isPopOverShown = false
                    }){
                        Text("Add Grocery")
                    }
                }.padding()
                }
                
            )
                .navigationBarColor(UIColor.init(named: "grocery-color"))
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        //groceries.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
    
}

struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
        
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}


