
    //
    //  ControlImageView.swift
    //  Pinch
    //
    //  Created by Bülent TÜRÜDÜ on 21.08.2025.
    //

    import SwiftUI


    // MARK: - ControlImageView
    // Bu reusable (yeniden kullanılabilir) view, zoom kontrol butonlarında kullanılan SF Symbol ikonlarını gösterir.
    // Örneğin: "plus.magnifyingglass" veya "minus.magnifyingglass".
    struct ControlImageView: View {
        // Görüntülenecek SF Symbol ikonunun adı
        let icon: String

        // MARK: - [+] BEGIN: Body ------------------------->
        var body: some View {
            // İkonu SF Symbols üzerinden alır ve 36pt boyutunda gösterir
            Image(systemName: icon)
                .font(.system(size: 36))
        }
        // MARK: - [--] END: Body ------------------------->
    }

    // MARK: - Preview
    // Önizlemede ControlImageView'in nasıl görüneceğini test etmek için kullanılır.
    #Preview(traits: .sizeThatFitsLayout) {
        ControlImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .padding()
    }
