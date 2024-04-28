//
//  CameraView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/27.
//

import SwiftUI

struct CameraAppView: View {
    @State private var isActiveCamera = false
    @State private var image: UIImage?
    @Environment(\.displayScale) private var displayScale

    
    @MainActor
        func render(image:UIImage) -> UIImage? {
            let renderer = ImageRenderer(content: sampleView(image:image))

            renderer.scale = displayScale

            return renderer.uiImage
        }
    
    
    private func sampleView(image:UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
        }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action:{
                    isActiveCamera.toggle()
                }, label: {
                    Text("カメラを起動")
                        .padding()
                })
            }
            
            if let image = image {
                
                sampleView(image: image)
                
                Button {
                    if let render = render(image: image) {
                        UIImageWriteToSavedPhotosAlbum(render, nil, nil, nil)
                    }
                } label: {
                    Text("保存")
                }
            }
            
            Spacer()
                .navigationTitle("Camera")
                .sheet(isPresented: $isActiveCamera) {
                    NavigationStack {
                        VStack {
                            CameraView(image: $image).ignoresSafeArea()
                        }
                        .toolbar {
                            Button("Close", role: .cancel){
                                isActiveCamera.toggle()
                            }
                        }
                    }
                }
        }
    }
}

public struct CameraView: UIViewControllerRepresentable {
    @Binding private var image: UIImage?
    
    @Environment(\.dismiss) private var dismiss
    
    public init(image: Binding<UIImage?>) {
        self._image = image
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            viewController.sourceType = .camera
        }
        
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

extension CameraView {
    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                self.parent.image = uiImage
            }
            self.parent.dismiss()
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.dismiss()
        }
    }
}


#Preview {
    CameraAppView()
}
