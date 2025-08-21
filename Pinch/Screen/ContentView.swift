    //
    //  ContentView.swift
    //  Pinch
    //
    //  Created by Bülent TÜRÜDÜ on 20.08.2025.
    //

    import SwiftUI

    struct ContentView: View {
        // Bu view, uygulamanın ana ekranını temsil eder.
        // Kullanıcı burada sayfaları görebilir, yakınlaştırma/uzaklaştırma yapabilir,
        // ve Drawer üzerinden sayfa seçebilir.

        // MARK: - [+] BEGIN: PROPERTY ------------------------->
        // Görsellerin ve bazı animasyonların çalışıp çalışmadığını kontrol eder
        @State private var isAnimating: Bool = false
        // Görselin mevcut ölçeği (zoom seviyesi). Varsayılan 1 (orijinal boyut).
        @State private var imageScale: CGFloat = 1
        // Görselin sürükleme (pan) sonrası ekrandaki konumu
        @State private var imageOffset: CGSize = .zero
        // Drawer (küçük sayfa seçici panel) açık mı kapalı mı bilgisini tutar
        @State private var isDrawerOpen: Bool = false
        // Uygulamadaki tüm sayfa verileri (PageData.swift üzerinden alınır)
        let pages: [Page] = pagesData
        // O anda görüntülenen sayfanın index değeri (1'den başlar)
        @State private var pageIndex: Int = 1
        //-- [-] END: PROPERTY ------------------------->

        // MARK: - [+] BEGIN: FUNCTION ------------------------->
        // Görseli başlangıç haline döndürür (zoom = 1, konum = sıfır).
        // Animasyonlu şekilde çalışır.
        func resetImageState() {
            withAnimation(.spring()) {
                imageScale = 1
                imageOffset = .zero
            }
        }

        // Mevcut sayfanın görsel adını döndürür.
        // pageIndex üzerinden erişim yapar.
        func currentPage() -> String {
            return pages[pageIndex - 1].imageName
        }
        //-- [-] END: FUNCTION ------------------------->

        // MARK: - [+] BEGIN: Body ------------------------->
        var body: some View {
            NavigationView {
                ZStack {
                    // Arka plan rengi (transparent) — ZStack’in tabanı
                    Color.clear

                    // MARK: - [+] BEGIN: Page Image ------------------------->
                    // Sayfa görselini gösteren özel view.
                    // Kullanıcı yakınlaştırma, uzaklaştırma ve sürükleme hareketlerini burada yapar.
                    PageImageView(
                        imageName: currentPage(),
                        isAnimating: $isAnimating,
                        imageScale: $imageScale,
                        imageOffset: $imageOffset,
                        resetImageState: resetImageState
                    )
                    // MARK: - [--] END: Page Image ------------------------->
                }
                .navigationTitle("Pinch & Zoom")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    // View açıldığında animasyonlu şekilde isAnimating = true yapılır
                    withAnimation(.linear(duration: 1)) {
                        isAnimating = true
                    }
                }
                // MARK: - [+] BEGIN: Info Panel ------------------------->
                // Ekranın üst kısmında zoom seviyesi ve offset bilgilerini gösteren panel
                .overlay(
                    InfoPanelView(scale: imageScale, offset: imageOffset)
                        .padding(.horizontal)
                        .padding(.top, 30),
                    alignment: .top
                )
                // MARK: - [--] END: Info Panel ------------------------->
                // MARK: - [+] BEGIN: Controls ------------------------->
                // Alt kısımda zoom kontrol butonları (reset, büyüt, küçült)
                .overlay(
                    ControlsView(
                        isAnimating: $isAnimating,
                        imageScale: $imageScale,
                        resetImageState: resetImageState
                    )
                    .padding(.bottom, 30),
                    alignment: .bottom
                )
                // MARK: - [--] END: Controls ------------------------->
                // MARK: - [+] BEGIN: Drawer ------------------------->
                // Sağ üst köşede açılıp kapanabilen Drawer.
                // Küçük önizleme resimleri ile sayfa seçimini sağlar.
                .overlay(
                    DrawerView(
                        isAnimating: $isAnimating,
                        isDrawerOpen: $isDrawerOpen,
                        pageIndex: $pageIndex,
                        pages: pages
                    ),
                    alignment: .topTrailing
                )
                // MARK: - [--] END: Drawer ------------------------->
            }
            .navigationViewStyle(.stack)
        }
        // MARK: - [--] END: Body ------------------------->
    }

    #Preview {
        ContentView()
    }
