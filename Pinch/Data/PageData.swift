    //
    //  PageData.swift
    //  Pinch
    //
    //  Created by Bülent TÜRÜDÜ on 20.08.2025.
    //

    import Foundation

    // MARK: - PageData
    // Bu dosya, uygulama içerisinde kullanılacak sayfa verilerini (görselleri) tutar.
    // "pagesData" sabiti, Page modelinden oluşan bir dizi döndürür.
    // Her bir Page, benzersiz bir ID ve görselin dosya adını içerir.
    // Bu sayede diğer bileşenler (örneğin DrawerView veya ContentView) buradaki verileri kullanarak
    // ilgili sayfaları gösterebilir.

    // Uygulamada kullanılacak olan sayfaların verileri (kapak ve arka kapak)
    let pagesData: [Page] = [
        // Ön kapak sayfası
        Page(id: 1, imageName: "magazine-front-cover"),

        // Arka kapak sayfası
        Page(id: 2, imageName: "magazine-back-cover")
    ]
