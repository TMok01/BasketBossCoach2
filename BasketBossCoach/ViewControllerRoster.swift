
import UIKit
struct Player: Codable{
    var name : String
    var number : Int
}

class AppData{
    //static because only one will need to exist
    static var apname = ""
    static var apnumber = 0
    static var playa = [Player]()
}
class ViewControllerRoster: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var nameOut: UITextField!
    @IBOutlet weak var rostaView: UITableView!
    @IBOutlet weak var numberOut: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rostaView.delegate = self
        rostaView.dataSource = self
        
        if let items = UserDefaults.standard.data(forKey: "TheSquad") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Player].self, from: items) {
                AppData.playa = decoded
            }
            for p in AppData.playa{
                print(p.name)
            }
        }
        rostaView.reloadData()
    }
    
    
    @IBAction func submitButt(_ sender: UIButton) {
        let namer = nameOut.text!
        let numberr = Int(numberOut.text!)!
        
        var p1 = Player(name: namer,number: numberr )
        AppData.playa.append(p1)
        
        rostaView.reloadData()
        
        let  encoder = JSONEncoder()
        if let encoded = try? encoder.encode(AppData.playa) {
            defaults.set(encoded, forKey: "TheSquad")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppData.playa.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rostaCell")!
        cell.textLabel?.text = "Name :\(AppData.playa[indexPath.row].name)  Number : \(AppData.playa[indexPath.row].number)"
        return cell
        
    }
    
}
