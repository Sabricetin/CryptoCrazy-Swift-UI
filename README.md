# **CryptoCrazy-Swift-UI**

CryptoCrazy-Swift-UI, SwiftUI kullanarak kripto para birimlerinin piyasa verilerini listelemek ve görüntülemek için geliştirilmiş bir projedir. Bu proje, modern SwiftUI ve Combine özellikleriyle API kullanımı ve veri akışını öğrenmek isteyenler için ideal bir örnektir.

---

## **Özellikler**
- Binance API kullanılarak kripto para piyasası verilerini asenkron olarak çekme
- Liste görünümü (`List`) ile kripto para birimlerini görüntüleme
- `@Published` ve Combine ile veri akışını yönlendirme
- Kullanıcı dostu, minimalist ve SwiftUI tabanlı tasarım

---

## **Kullanılan Teknolojiler**
- **Swift**
- **SwiftUI**: Modern kullanıcı arayüzü tasarımı
- **Combine**: Reaktif veri işleme ve UI güncelleme
- **Binance API**: Kripto para piyasası verilerini sağlamak için
- **Configuration.plist**: API anahtarını güvenli bir şekilde saklamak için

---

## **Mimari**
CryptoCrazy-Swift-UI, MVVM (Model-View-ViewModel) mimari desenini kullanır:

- **Model**: Kripto para verilerini temsil eden `CryptoModel` yapısı.
- **View**: SwiftUI ile kullanıcı arayüzü tasarımı.
- **ViewModel**: API’den veri çekme, işleme ve View’a bağlama işlemleri.

---

## **API Kullanımı**
Projede kullanılan API, Binance’in hızlı bir şekilde kripto para bilgisi sunan bir API’sidir. API anahtarı `Configuration.plist` dosyasında saklanır ve kodda şu şekilde okunur:

```swift
if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
   let config = NSDictionary(contentsOfFile: path),
   let apiKey = config["APIKey"] as? String {
    let headers = [
        "x-rapidapi-key": apiKey,
        "x-rapidapi-host": "binance43.p.rapidapi.com"
    ]
}
```

---

## **Kurulum**
Bu projeyi kurmak için aşağıdaki adımları izleyin:

1. Bu depoyu klonlayın:
   ```bash
   git clone https://github.com/yourusername/CryptoCrazy-Swift-UI.git
   ```
2. Proje dizinine gidin:
   ```bash
   cd CryptoCrazy-Swift-UI
   ```
3. Bir `Configuration.plist` dosyası oluşturun ve API anahtarınızı ekleyin:
   ```xml
   <dict>
       <key>APIKey</key>
       <string>Your_API_Key_Here</string>
   </dict>
   ```
4. Projeyi Xcode ile açın:
   ```bash
   open CryptoCrazy-Swift-UI.xcodeproj
   ```
5. Uygulamayı çalıştırın.

---

## **Koddan Örnekler**

### **Model**
Kripto para birimlerini temsil eden yapı:
```swift
struct CryptoModel: Identifiable, Codable {
    let id = UUID()
    let symbol: String
    let priceChange: String
    let weightedAvgPrice: String
    let volume: String
}
```

### **ViewModel**
API’den veri indirme ve işleme:
```swift
class CryptoListViewModel: ObservableObject {
    @Published var cryptoList = [CryptoModel]()

    func downloadCryptos() {
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path),
           let apiKey = config["APIKey"] as? String {

            let headers = [
                "x-rapidapi-key": apiKey,
                "x-rapidapi-host": "binance43.p.rapidapi.com"
            ]
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://binance43.p.rapidapi.com/ticker/24hr")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if let error = error {
                    print("API Hatası: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("Veri bulunamadı!")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let cryptos = try decoder.decode([CryptoModel].self, from: data)
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos
                    }
                } catch {
                    print("JSON çözümleme hatası: \(error)")
                }
            }
            dataTask.resume()
        } else {
            print("Configuration.plist bulunamadı veya APIKey eksik!")
        }
    }
}
```

---

## **Ekran Görüntüleri**
![CryptoCrazy-Swfit-UI](https://github.com/user-attachments/assets/c46d831d-dc31-4254-bc81-e53bb3151f17)
