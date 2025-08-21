    //
    //  InfoPanelView.swift
    //  Pinch
    //
    //  Created by Bülent TÜRÜDÜ on 21.08.2025.
    //

    import SwiftUI

    // MARK: - InfoPanelView
    // Bu view, ekranda uzun basıldığında görünen bilgi panelini temsil eder.
    // Panelde zoom seviyesi (scale) ve görselin x/y eksenlerindeki offset değerleri gösterilir.
    struct InfoPanelView: View {
        // Görselin mevcut ölçeği (zoom seviyesi)
        var scale: CGFloat
        // Görselin ekrandaki kaydırma (x ve y offset) değerleri
        var offset: CGSize
        // Panelin görünüp görünmediğini kontrol eden state
        @State private var isInfoPanelVisible: Bool = false

        // MARK: - [+] BEGIN: Body ------------------------->
        var body: some View {
            HStack {
                // Kullanıcının uzun basarak bilgi panelini açmasını sağlayan ikon (hotspot).
                // 1 saniye basılı tutulunca panel görünür/gizlenir.
                Image(systemName: "circle.circle")
                    .symbolRenderingMode(.hierarchical)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onLongPressGesture(minimumDuration: 1) {
                        withAnimation(.easeOut) {
                            isInfoPanelVisible.toggle()
                        }
                    }
                // MARK: - [--] END: Hotspot ------------------------->

                Spacer()

                // MARK: - [+] BEGIN: Info Panel ------------------------->
                HStack(spacing: 2) {
                    // Zoom seviyesi (scale) bilgisini gösterir
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                    Text("\(scale)")

                    Spacer()

                    // Yatay kayma (offset.width) bilgisini gösterir
                    Image(systemName: "arrow.left.and.right")
                    Text("\(offset.width)")

                    Spacer()

                    // Dikey kayma (offset.height) bilgisini gösterir
                    Image(systemName: "arrow.up.and.down")
                    Text("\(offset.height)")

                    Spacer()
                }
                .font(.footnote)
                .padding(8)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 420)
                // Panel sadece kullanıcı hotspot’a uzun basınca görünür
                .opacity(isInfoPanelVisible ? 1 : 0)
                // MARK: - [--] END: Info Panel ------------------------->

                Spacer()
            }
        }
        // MARK: - [--] END: Body ------------------------->
    }

    // MARK: - Preview
    // Önizlemede InfoPanelView’in nasıl görüneceğini test etmek için kullanılır.
    #Preview (traits: .sizeThatFitsLayout) {
        InfoPanelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .padding()
    }
