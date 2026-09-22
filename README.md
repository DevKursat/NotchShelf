<div align="center">
  <img src="https://github.com/DevKursat/NotchShelf/blob/main/assets/icon.png?raw=true" width="128" alt="NotchShelf Icon"/>
  <h1>NotchShelf 🗂️</h1>
  <p><b>macOS'in eksik olan <i>en güçlü</i> gizli silahı.</b></p>
  
  <p>
    <a href="https://github.com/DevKursat/NotchShelf/releases/latest"><img alt="macOS 14.0+" src="https://img.shields.io/badge/macOS-14.0%2B-blue?style=for-the-badge&logo=apple" /></a>
    <img alt="Swift 5.10" src="https://img.shields.io/badge/Swift-5.10-orange?style=for-the-badge&logo=swift" />
    <img alt="Zero Dependencies" src="https://img.shields.io/badge/Dependencies-0-success?style=for-the-badge" />
    <img alt="License" src="https://img.shields.io/badge/License-GPL%203.0-green?style=for-the-badge" />
  </p>
</div>

<br/>

> 2026'nın en zarif, %0 boşta CPU tüketen, 30MB altı RAM kullanan efsanevi çentik aracı! 
> MacBook'unuzun çentiğini canlandırın, ekranınızı uçurun.

**NotchShelf**, ekranınızdaki atıl durumdaki "Çentik" (Notch) veya "Dinamik Ada"yı akıllı bir panele dönüştüren **%100 Native (AppKit + SwiftUI)** macOS aracıdır. *Electron yok, WebView yok, şişkinlik yok!*

---

## 🌟 Neden NotchShelf?

- 🧠 **Sıfır Bağımlılık (0 Dependencies):** Tamamen saf Swift ile Apple API'leri kullanılarak kodlandı.
- ⚡ **İnanılmaz Performans:** Arka planda çalışırken CPU kullanımı %0.
- 🎨 **Liquid Glassmorphism:** Gerçek 120Hz ProMotion uyumlu ultra-akıcı fiziksel yay animasyonları.
- 🚀 **Floating Island Desteği:** Eğer ekranınızda çentik yoksa veya harici monitördeyseniz, üst merkezde zarif bir yüzen ada (Dynamic Island) olarak çalışır.

## 🔥 İnanılmaz Özellikler

### 1. Akıllı Geçici Raf (NotchDrop)
Dosyaları (Görsel, PDF, Metin) tutup çentiğe doğru sürükleyin. NotchShelf onları yutar ve orada havada asılı tutar. Başka bir pencereye geçip dosyayı tekrar tutup istediğiniz yere bırakın!

### 2. Görsel Pano Yöneticisi (Visual Clipboard)
Kopyaladığınız son metinler ve görseller anında çentik hafızasında. `Cmd+C` yaptığınız her şey bir tık uzağınızda. 

### 3. Trackpad & Fare Sihri (Magic Gestures)
- **Çift Tık:** Rafı aç/kapat.
- **Scroll (Fare Tekerleği):** Çentiğin üzerindeyken tekerleği dikey kaydırarak sistem sesini değiştirin!
- **Haptic Feedback:** Çentiğe tıkladığınızda veya dosya bıraktığınızda Force Touch titreşim motoru ile fiziksel olarak tıklamayı *hissedin*.

---

## ⚙️ Hızlı Kurulum

$99 Apple Geliştirici lisansına ihtiyacınız yok! Özel olarak tasarlanan CI/CD akışımız size hazır bir `.dmg` sunar.

1. [Releases](../../releases) sayfasından en güncel `NotchShelf.dmg` dosyasını indirin.
2. DMG'yi açıp **NotchShelf** uygulamasını `Applications` klasörüne atın.
3. **Önemli:** Gatekeeper uyarısı almamak için Terminal'de şu komutu çalıştırın:
   ```bash
   xattr -cr /Applications/NotchShelf.app
   ```
4. Uygulamayı açın ve çentiğinize dokunun! 🎉

### 🛠 Kendi Xcode'unuzda Derleyin (Hacker'lar için)
NotchShelf UUID çakışmasını engellemek için `xcodegen` kullanır. Sadece 2 komutla projeyi sıfırdan oluşturun:
```bash
git clone https://github.com/DevKursat/NotchShelf.git
cd NotchShelf
brew install xcodegen
xcodegen generate
open NotchShelf.xcodeproj
```

---

<div align="center">
  <b>🌟 Beğendiniz mi? Bu projeyi desteklemek için sağ üstten bir "Yıldız (Star)" verin! 🌟</b>
  <br><br>
  <i>DevKursat ve AI tarafından Gururla Geliştirilmiştir (2026)</i>
</div>
