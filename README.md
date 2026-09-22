<div align="center">
  <img src="https://github.com/DevKursat/NotchShelf/blob/main/assets/icon.png?raw=true" width="128" alt="NotchShelf Icon"/>
  <h1>NotchShelf 🗂️</h1>
  <p><b>macOS's missing <i>most powerful</i> secret weapon.</b></p>
  
  <p>
    <a href="https://github.com/DevKursat/NotchShelf/releases/latest"><img alt="macOS 14.0+" src="https://img.shields.io/badge/macOS-14.0%2B-blue?style=for-the-badge&logo=apple" /></a>
    <img alt="Swift 5.10" src="https://img.shields.io/badge/Swift-5.10-orange?style=for-the-badge&logo=swift" />
    <img alt="Zero Dependencies" src="https://img.shields.io/badge/Dependencies-0-success?style=for-the-badge" />
    <img alt="License" src="https://img.shields.io/badge/License-GPL%203.0-green?style=for-the-badge" />
  </p>
</div>

<br/>

> The most elegant, legendary notch tool of 2026, consuming 0% idle CPU and under 30MB of RAM! 
> Bring your MacBook's notch to life, and let your screen fly.

**NotchShelf** is a **100% Native (AppKit + SwiftUI)** macOS tool that turns your idle "Notch" or "Dynamic Island" into a smart panel. *No Electron, no WebView, no bloat!*

**[Try it out quickly on our GitHub Pages site!](https://devkursat.github.io/NotchShelf/)**

---

## 🌟 Why NotchShelf?

- 🧠 **Zero Dependencies:** Coded entirely in pure Swift using Apple APIs.
- ⚡ **Incredible Performance:** 0% CPU usage while running in the background.
- 🎨 **Liquid Glassmorphism:** Ultra-smooth physical spring animations with true 120Hz ProMotion support.
- 🚀 **Floating Island Support:** If your screen doesn't have a notch or you are on an external monitor, it works as an elegant floating island at the top center.

## 🔥 Amazing Features

### 1. Smart Temporary Shelf (NotchDrop)
Drag files (Images, PDFs, Text) towards the notch. NotchShelf swallows them and keeps them hovering there. Switch to another window, grab the file again, and drop it wherever you want!

### 2. Visual Clipboard Manager (Visual Clipboard)
Your recently copied texts and images are instantly in the notch memory. Everything you `Cmd+C` is just a click away.

### 3. Trackpad & Mouse Magic (Magic Gestures)
- **Double Click:** Open/close the shelf.
- **Scroll (Mouse Wheel):** Change the system volume by vertically scrolling while hovering over the notch!
- **Haptic Feedback:** *Feel* the physical click with the Force Touch vibration motor when you click the notch or drop a file.

---

## 🔒 Unlock NotchShelf (The Viral Loop)

To keep this amazing tool free and growing, we kindly ask for your support! To fully unlock and use NotchShelf, you must **Star this repository** and **Follow the developer** on GitHub. 

When you launch the app, it will verify your support! Spread the word and help us build the ultimate macOS utility! 🚀

---

## ⚙️ Quick Setup

You don't need a $99 Apple Developer license! Our custom CI/CD pipeline provides you with a ready-to-use `.dmg`.

1. Download the latest `NotchShelf.dmg` from the [Releases](../../releases) page.
2. Open the DMG and drag the **NotchShelf** application into the `Applications` folder.
3. **Important:** To avoid the Gatekeeper warning, run the following command in the Terminal:
   ```bash
   xattr -cr /Applications/NotchShelf.app
   ```
4. Open the app and touch your notch! 🎉

### 🛠 Build in Your Own Xcode (For Hackers)
NotchShelf uses `xcodegen` to prevent UUID conflicts. Generate the project from scratch with just 2 commands:
```bash
git clone https://github.com/DevKursat/NotchShelf.git
cd NotchShelf
brew install xcodegen
xcodegen generate
open NotchShelf.xcodeproj
```

---

<div align="center">
  <b>🌟 Did you like it? Please drop a "Star" from the top right to support this project! 🌟</b>
  <br><br>
  <i>Proudly Developed by DevKursat and AI (2026)</i>
</div>
