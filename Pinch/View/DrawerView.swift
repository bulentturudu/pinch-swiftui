    //
    //  DrawerView.swift
    //  Pinch
    //
    //  Created by Bülent TÜRÜDÜ on 20.08.2025.
    //

    import SwiftUI

    // MARK: - DrawerView
    // Bu view, ekranın sağ üst köşesinde bulunan Drawer panelini temsil eder.
    // Drawer içinde küçük sayfa önizlemeleri (thumbnail) bulunur.
    // Kullanıcı Drawer’ı açıp kapatabilir ve küçük resimlere tıklayarak sayfa seçebilir.
    struct DrawerView: View {
        // Uygulamadaki animasyon durumunu kontrol eden binding
        @Binding var isAnimating: Bool
        // Drawer'ın açık mı kapalı mı olduğunu belirleyen binding
        @Binding var isDrawerOpen: Bool
        // O anda görüntülenen sayfanın index numarası
        @Binding var pageIndex: Int
        // Drawer içinde gösterilecek tüm sayfa verileri
        let pages: [Page]

        // MARK: - [+] BEGIN: Body ------------------------->
        var body: some View {
            HStack(spacing: 12) {
                // Drawer açma/kapama butonu (chevron ikonları)
                // Tıklanınca isDrawerOpen değişkeni animasyonlu olarak değişir
                Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(8)
                    .foregroundStyle(.secondary)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isDrawerOpen.toggle()
                        }
                    }
                // MARK: - [--] END: Drawer Handle ------------------------->

                // Drawer içinde tüm sayfaların küçük önizlemeleri (thumbnails) listelenir
                ForEach(pages) { item in
                    Image(item.thumbnailName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .opacity(isDrawerOpen ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isDrawerOpen)
                        // Kullanıcı küçük resme tıkladığında:
                        // - isAnimating true yapılır
                        // - Seçilen sayfanın id’si pageIndex’e atanır
                        .onTapGesture {
                            isAnimating = true
                            pageIndex = item.id
                        }
                }
                // MARK: - [--] END: Thumbnails ------------------------->

                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .opacity(isAnimating ? 1 : 0)
            .frame(width: 260)
            .padding(.top, UIScreen.main.bounds.height / 12)
            // Drawer’ın ekran üzerindeki konumu.
            // Açıkken hafif sola (20), kapalıyken sağa (215) kayar.
            .offset(x: isDrawerOpen ? 20 : 215)
        }
        // MARK: - [--] END: Body ------------------------->
    }

    // MARK: - Preview
    // Önizlemede DrawerView’in nasıl çalışacağını test etmek için kullanılır.
    #Preview {
        DrawerView(
            isAnimating: .constant(true),
            isDrawerOpen: .constant(true),
            pageIndex: .constant(1),
            pages: [Page(id: 1, imageName: "magazine-front-cover")]
        )
    }
