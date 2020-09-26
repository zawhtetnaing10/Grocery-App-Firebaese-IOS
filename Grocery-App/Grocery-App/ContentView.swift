//
//  ContentView.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var mGroceryViewModel = GroceryViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(mGroceryViewModel.groceries, id: \.name){ grocery in
                    
                    return HStack(){
                        
                        
                        WebImage(url: URL(string: grocery.image ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .frame(width: 120, height: 120, alignment: .center)
                       
                        
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
                            
                            HStack{
                                Button(action:{
                                    self.mGroceryViewModel.isPopOverShown = true
                                    self.mGroceryViewModel.onTapEditGrocery(groceryName: grocery.name ?? "", groceryDescription: grocery.description ?? "", groceryAmount: String(grocery.amount ?? 0))
                                },label: {
                                    Image(systemName: "pencil")
                                })
                                    .buttonStyle(PlainButtonStyle())
                                    .sheet(isPresented: self.$mGroceryViewModel.isPopOverShown){
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
                                
                                
                                
                                Button(action:{
                                    self.mGroceryViewModel.isShowImagePicker = true
                                    self.mGroceryViewModel.onGroceryItemChosen(grocery: grocery)
                                }){
                                    Image.init(systemName: "icloud.and.arrow.up")
                                }
                                .buttonStyle(PlainButtonStyle())
                                .sheet(isPresented: self.$mGroceryViewModel.isShowImagePicker) {
                                    ImagePicker(isPresented: self.$mGroceryViewModel.isShowImagePicker, onImageChosen: { image in
                                        self.mGroceryViewModel.onImageChosen(image: image)
                                        })
                                }
                            }
                            
                            
                            Spacer()
                            
                            Text(String(grocery.amount ?? 0))
                                .font(.headline)
                            
                        }
                    }.padding()
                    
                }
                .onDelete(perform: deleteItems)
            }
            .onTapGesture {
                return
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
        let chosenIndex = offsets.map{$0}.first ?? 0
        let chosenGrocery = mGroceryViewModel.groceries[chosenIndex]
        mGroceryViewModel.onDeleteGrocery(grocery: chosenGrocery)
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

struct ImagePicker : UIViewControllerRepresentable{
    
    @Binding var isPresented : Bool
    var onImageChosen : (UIImage) -> Void = { _ in}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    class Coordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        let parent : ImagePicker
        init(parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage{
                parent.onImageChosen(selectedImage)
            }
            parent.isPresented.toggle()
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePicker.UIViewControllerType, context: Context) {
        
    }
}

struct DummyView : UIViewRepresentable{
    func updateUIView(_ uiView: DummyView.UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let button = UIButton()
        button.setTitle("Dummy", for: .normal)
        button.backgroundColor = .red
        return button
        
    }
}


