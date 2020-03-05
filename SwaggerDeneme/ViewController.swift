import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var networkManager = NetworkManager()
    var dataManager = DataManager()
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshControl.tintColor = UIColor.red
        refreshControl.backgroundColor = UIColor.gray
        refreshControl.addTarget(self, action: #selector(Network), for: .valueChanged)
        TableView.addSubview(refreshControl)
        self.activityIndicator.isHidden = true
        }
    @IBAction func callNetworkButtonTapped(_ sender: Any) {
        Network()
    }
    @objc func Network(){
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        networkManager.getCategories()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.TableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.categoryArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.titleLabel?.text = DataManager.categoryArray?[indexPath.row].title
        cell.languageLabel?.text = DataManager.categoryArray?[indexPath.row].language
        cell.idLabel?.text = DataManager.categoryArray?[indexPath.row]._id
        cell.vLabel?.text = "\(DataManager.categoryArray?[indexPath.row].__v ?? 0)"
        cell.selectionStyle = .none
        cell.radioView.layer.cornerRadius = 20
        cell.radioView.layer.shadowColor = UIColor.black.cgColor
        cell.radioView.layer.shadowOpacity = 1
        cell.radioView.layer.shadowRadius = 15
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC : InfoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoVC") as! InfoViewController
        DataManager.categoryId = DataManager.categoryArray?[indexPath.row]._id ?? ""
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}
