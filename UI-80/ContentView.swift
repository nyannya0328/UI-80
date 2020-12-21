//
//  ContentView.swift
//  UI-80
//
//  Created by にゃんにゃん丸 on 2020/12/21.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    @State var canvas = PKCanvasView()
    @State var isdrawing = true
    
    @State var color : Color = .black
    
    @State var type : PKInkingTool.InkType = .pencil
    
    @State var colorpicker = false
    var body: some View{
        
        NavigationView{
            CanVasView(canvas: $canvas, isdrawing: $isdrawing,type: $type,color: $color)
                .navigationBarTitle("Title",displayMode: .inline)
                
                .navigationBarItems(leading: Button(action: {
                    saveimage()
                    
                }, label: {
                    
                    Image(systemName: "square.and.arrow.down.fill")
                    
                }),trailing: HStack(spacing:15){
                    
                    Button(action: {
                        isdrawing = false
                        
                    }) {
                        
                        Image(systemName: "pencil.slash")
                            .font(.title)
                        
                    }
                    
                    Menu(content: {
                        
                        
                        
                        Button(action: {
                            
                            colorpicker.toggle()
                            
                            
                        }) {
                            
                             Label {
                                 
                                 Text("color")
                                 
                                 
                             } icon: {
                                 
                                 Image(systemName: "eyedropper.full")
                                 
                             }
                            
                        }
                        
                        
                      
                        
                        Button(action: {
                            
                            isdrawing = true
                            type = .pencil
                        }) {
                            
                            
                             Label {
                                 
                                 Text("pencil")
                                 
                                 
                             } icon: {
                                 
                                 Image(systemName: "pencil")
                                 
                             }
                            
                            
                            
                            
                        }
                        
                        Button(action: {
                            
                            isdrawing = true
                            type = .pen
                        }) {
                            
                            
                             Label {
                                 
                                 Text("pen")
                                 
                                 
                             } icon: {
                                 
                                 Image(systemName: "pencil.tip")
                                 
                             }
                            
                            
                            
                            
                        }
                        
                        Button(action: {
                            
                            isdrawing = true
                            type = .marker
                            
                        }) {
                            
                            
                             Label {
                                 
                                 Text("Marker")
                                 
                                 
                             } icon: {
                                 
                                 Image(systemName: "highlighter")
                                 
                             }
                            
                            
                            
                            
                        }

                        
                        
                        
                        
                        
                    }) {
                        Image("m")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                   
                    
                })
                .sheet(isPresented: $colorpicker){
                    
                    VStack{
                        ColorPicker("Color", selection: $color)
                            .padding()
                    }
                    Spacer()
                    
                }
                
               
            
            
            
        }
        
    }
    func saveimage(){
        let image = canvas.drawing.image(from: canvas.bounds, scale: 1)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }
    
}

struct CanVasView : UIViewRepresentable {
    
    @Binding var canvas : PKCanvasView
    @Binding var isdrawing : Bool
    
    @Binding var type : PKInkingTool.InkType
    @Binding var color : Color
    
    var ink :PKInkingTool{
        
        
        PKInkingTool(type,color: UIColor(color))
       
    }
    
    
    let eraser = PKEraserTool(.bitmap)
    
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        
        canvas.tool = isdrawing ? ink : eraser
    
        
        return canvas
        
        
        
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        uiView.tool = isdrawing ? ink : eraser
        
    }
}
