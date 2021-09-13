
import Foundation

let BASE_URL = "https://api.nomics.com/v1/"
let API_KEY = "b370f56d3f77c121f9c6178856cbb9f497f4d47f"

func apiCall (currencies: String) -> String{
    var currencies_raw = "BTC,ETH,XRP,XLM,ADA,DOT,LTC,CHZ,HOT,BTT,WIN,TRX,THETA,ALGO,STX,BNB,FIL,MATIC,VET,ENJ,IOTA,ONT,ONE,XTZ,EOS"
    let currency_type = "USD" // can be BTC or ETH or any FIAT currencies.
    let url = BASE_URL + "currencies/ticker?key=" + API_KEY + "&ids=" + currencies + "&convert=" + currency_type
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    // request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared
    print("\nAPI RESPONSE: \n")
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        print(response!)                         
        do {
            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
            
            print(json)
        } catch {
            print("error")
        }
    })
    task.resume()
}






let params = ["username":"john", "password":"123456"] as Dictionary<String, String>


var request = URLRequest(url: URL(string: "http://localhost:8080/api/1/login")!)
request.httpMethod = "POST"
request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
request.addValue("application/json", forHTTPHeaderField: "Content-Type")

let session = URLSession.shared
let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
    print(response!)
    do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
        print(json)
    } catch {
        print("error")
    }
})

task.resume()
