    //
    //  PageImageView.swift
    //  Pinch
    //
    //  Created by Bülent TÜRÜDÜ on 20.08.2025.
    //

    import SwiftUI

    // MARK: - PageImageView
    // Bu view, sayfa görselini ekranda gösterir ve kullanıcı etkileşimlerini yönetir.
    // Kullanıcı bu view üzerinde yakınlaştırma, uzaklaştırma, sürükleme ve çift tıklama hareketlerini yapabilir.
    struct PageImageView: View {
        // Gösterilecek sayfanın görsel adı
        let imageName: String
        // Görselin görünürlüğünü animasyonlu olarak kontrol eden binding
        @Binding var isAnimating: Bool
        // Görselin ölçek (zoom) değeri
        @Binding var imageScale: CGFloat
        // Görselin sürüklenme (offset) değerleri
        @Binding var imageOffset: CGSize
        // Görseli başlangıç konumuna ve ölçeğine sıfırlayan fonksiyon
        let resetImageState: () -> Void

        // MARK: - [+] BEGIN: Body ------------------------->
        var body: some View {
            // Sayfa görselini ekrana yerleştirir
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(10)
                .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                .opacity(isAnimating ? 1 : 0)
                .offset(x: imageOffset.width, y: imageOffset.height)
                .scaleEffect(imageScale)

                // MARK: - [+] BEGIN: Page Image > Gestures ------------------------->
                // Kullanıcı görsele çift tıkladığında:
                // - Eğer zoom 1 ise görsel maksimuma (5x) büyütülür
                // - Değilse reset fonksiyonu çağrılır
                .onTapGesture(count: 2) {
                    if imageScale == 1 {
                        withAnimation(.spring()) {
                            imageScale = 5
                        }
                    } else {
                        resetImageState()
                    }
                }
                // Sürükleme hareketi (pan gesture):
                // Görseli parmak hareketiyle ekranda taşımaya yarar.
                // Eğer zoom <= 1 ise sürükleme bitince görsel sıfırlanır.
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = value.translation
                            }
                        }
                        .onEnded { _ in
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                )
                // Yakınlaştırma/uzaklaştırma hareketi (pinch gesture):
                // Kullanıcı iki parmakla zoom yapabilir.
                // Ölçek 1 ile 5 arasında sınırlıdır.
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                if imageScale >= 1 && imageScale <= 5 {
                                    imageScale = value
                                } else if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }
                        .onEnded { _ in
                            if imageScale > 5 {
                                imageScale = 5
                            } else if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                )
                // MARK: - [--] END: Page Image > Gestures ------------------------->
        }
        // MARK: - [--] END: Body ------------------------->
    }

    // MARK: - Preview
    // Önizlemede PageImageView’in nasıl görüneceğini test etmek için kullanılır.
    #Preview {
        PageImageView(
            imageName: "magazine-front-cover",
            isAnimating: .constant(true),
            imageScale: .constant(1),
            imageOffset: .constant(.zero),
            resetImageState: {}
        )
    }
