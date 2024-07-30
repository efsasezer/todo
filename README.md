# Todo App
Bu proje, Flutter ve Firebase kullanarak geliştirilmiş bir Todo uygulamasıdır. Uygulama, görev ekleme, listeleme, güncelleme ve silme gibi işlevleri destekler. Ayrıca görevlerin tamamlanma durumuna göre ayrılması ve arama özellikleri de içerir. Proje, GetX state management kullanarak geliştirilmiştir.

Özellikler
Görev Ekleme: Yeni görevler ekleyebilirsiniz.

Görev Listeleme: Görevleri tamamlanmamış ve tamamlanmış olarak iki sekmede listeleyebilirsiniz.

Görev Güncelleme: Görev başlığını güncelleyebilirsiniz.

Görev Silme: Görevleri silebilirsiniz.

Oturum Yönetimi: Kullanıcı girişi ve çıkışı yapabilirsiniz.

Kullanım

Görev Ekleme: Ana sayfadaki + butonuna tıklayarak yeni görev ekleyebilirsiniz.

Görevleri Görüntüleme: Görevler tamamlanmamış ve tamamlanmış olarak iki sekmede görüntülenir.

Görev Güncelleme: Görev başlığı üzerine tıklayarak düzenleme yapabilirsiniz.

Görev Silme: Görev üzerindeki sil butonuna tıklayarak görevleri silebilirsiniz.

Oturum Yönetimi: Kullanıcı giriş ve çıkışı yapabilirsiniz.

Kod Yapısı

main.dart: Uygulamanın başlangıç noktası.

home_page.dart: Görevlerin görüntülendiği ana sayfa.

add_task_page.dart: Yeni görev ekleme sayfası.

update_task_page.dart: Görev güncelleme sayfası.

task_service.dart: Firebase ile etkileşimde bulunan servis katmanı.

home_controller.dart: GetX state management için kontrolcü.
