
    //
    //  ControlsView.swift
    //  Pinch
    //
    //  Created by Bülent TÜRÜDÜ on 20.08.2025.
    //

    import SwiftUI


    // MARK: - ControlsView
    // Bu view, ekrandaki zoom kontrol butonlarını (küçült, reset, büyüt) içerir.
    // Kullanıcı bu butonları kullanarak görseli yakınlaştırabilir, uzaklaştırabilir veya varsayılana döndürebilir.
    struct ControlsView: View {
        // Animasyonun çalışıp çalışmadığını kontrol eden binding
        @Binding var isAnimating: Bool
        // Görselin mevcut ölçeğini (zoom seviyesini) kontrol eden binding
        @Binding var imageScale: CGFloat
        // Görseli varsayılan durumuna sıfırlayan fonksiyon
        let resetImageState: () -> Void

        // MARK: - [+] BEGIN: Body ------------------------->
        var body: some View {
            Group {
                HStack {
                    // Küçültme butonu: Görselin ölçeğini 1 birim azaltır.
                    // Eğer ölçek <= 1 olursa reset fonksiyonu çağrılır.
                    // MARK: - [+] BEGIN: Scale Down Button ------------------------->
                    Button {
                        withAnimation(.spring()) {
                            if imageScale > 1 {
                                imageScale -= 1
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        }
                    } label: {
                        ControlImageView(icon: "minus.magnifyingglass")
                    }
                    // MARK: - [--] END: Scale Down Button ------------------------->

                    // Reset butonu: Görseli başlangıç değerine döndürür (zoom=1, offset=0).
                    // MARK: - [+] BEGIN: Reset Button ------------------------->
                    Button {
                        resetImageState()
                    } label: {
                        ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                    }
                    // MARK: - [--] END: Reset Button ------------------------->

                    // Büyütme butonu: Görselin ölçeğini 1 birim artırır.
                    // Maksimum ölçek değeri 5 ile sınırlandırılmıştır.
                    // MARK: - [+] BEGIN: Scale Up Button ------------------------->
                    Button {
                        withAnimation(.spring()) {
                            if imageScale < 5 {
                                imageScale += 1
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }
                    } label: {
                        ControlImageView(icon: "plus.magnifyingglass")
                    }
                    // MARK: - [--] END: Scale Up Button ------------------------->
                }
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                // isAnimating true olduğunda butonlar görünür, false olduğunda gizlenir
                .opacity(isAnimating ? 1 : 0)
            }
        }
        // MARK: - [--] END: Body ------------------------->
    }

    // MARK: - Preview
    // Önizlemede ControlsView’in nasıl görüneceğini test etmek için kullanılır.
    #Preview {
        ControlsView(
            isAnimating: .constant(true),
            imageScale: .constant(1),
            resetImageState: {}
        )
    }
