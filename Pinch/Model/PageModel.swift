    //
    //  PageModel.swift
    //  Pinch
    //
    //  Created by Bülent TÜRÜDÜ on 20.08.2025.
    //

    import Foundation

    // MARK: - Page Model
    // Uygulamadaki her sayfayı temsil eden veri modelidir.
    // Her Page nesnesi benzersiz bir id ve sayfaya ait görsel ismi içerir.
    // "Identifiable" protokolünü kullanarak SwiftUI listeleri veya ForEach yapılarında kolayca kullanılabilir.
    struct Page: Identifiable {
        // Sayfanın benzersiz kimliği (örneğin 1, 2, 3 ...)
        let id: Int
        // Sayfaya ait görselin dosya adı (ör. "magazine-front-cover")
        let imageName: String
    }

    // MARK: - Page Extension
    // Page modeline ek işlevler kazandırır.
    // Burada sayfanın küçük önizleme görseli (thumbnail) için bir özellik tanımlanmıştır.
    extension Page {
        // Sayfanın küçük önizleme görselinin adı.
        // Örn: imageName = "magazine-front-cover" ise
        // thumbnailName = "thumb-magazine-front-cover"
        var thumbnailName: String {
            return "thumb-" + imageName
        }
    }
