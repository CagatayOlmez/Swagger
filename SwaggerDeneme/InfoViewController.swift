import UIKit
import Alamofire
import SwiftyJSON

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var activityIndicator2: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var networkManager = NetworkManager()
    var dataManager = DataManager()
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshControl.tintColor = UIColor.red
        refreshControl.backgroundColor = UIColor.gray
        refreshControl.addTarget(self, action: #selector(Network), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.activityIndicator2.isHidden = true
        Network()
    }
    @objc func Network(){
        self.activityIndicator2.isHidden = false
        activityIndicator2.startAnimating()
        networkManager.getCommands()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.activityIndicator2.stopAnimating()
            self.activityIndicator2.isHidden = true
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            }
        }
    }
extension InfoViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.infoArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InfoTableViewCell
        cell.languageLabel?.text = DataManager.infoArray?[indexPath.row].text
        cell.tekstLabel?.text = DataManager.infoArray?[indexPath.row].language
        cell.detailLabel?.text = DataManager.infoArray?[indexPath.row].detail
        cell.idLabel?.text = DataManager.infoArray?[indexPath.row]._id
        cell.categoryLabel?.text = DataManager.infoArray?[indexPath.row].category
        cell.vLabel?.text = "\(DataManager.infoArray?[indexPath.row].__v ?? 0)"
        cell.selectionStyle = .none
        cell.shadowView.layer.cornerRadius = 20
        cell.shadowView.layer.shadowColor = UIColor.black.cgColor
        cell.shadowView.layer.shadowOpacity = 1
        cell.shadowView.layer.shadowRadius = 15
            return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 343
    }
}
