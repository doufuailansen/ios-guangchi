//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Apple on 2018/7/31.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    //Model
    var restaurants: [Restaurants]!
    var restaurant: [RestaurantMO] = []
    var searchResult: [RestaurantMO] = []
    var OldRestaurants: [Restaurant] = [
        Restaurant.init(name: "肯德基", type: "快餐店", location: "南大街", phone: "1880523455" , address: "南通市崇川区濠北路529号", description: "肯德基（KentuckyFried Chicken，肯塔基州炸鸡），简称KFC，是美国跨国连锁餐厅之一，也是世界第二大速食及最大炸鸡连锁企业，1952年由创始人哈兰·山德士（Colonel Harland Sanders）创建，主要出售炸鸡、汉堡、薯条、盖饭、蛋挞、汽水等高热量快餐食品。", image: "肯德基", isVisited: false, rating: ""),
        Restaurant.init(name: "麦当劳", type: "快餐店", location: "文峰广场",  phone: "1350523455" , address: "南通市南大街3-21号文峰大世界一楼", description: "麦当劳（McDonald's）是全球大型跨国连锁餐厅，1955年创立于美国芝加哥，在世界上大约拥有3万间分店。主要售卖汉堡包，以及薯条、炸鸡、汽水、冰品、沙拉、水果等快餐食品。", image: "麦当劳", isVisited: false, rating: ""),
        Restaurant.init(name: "必胜客", type: "快餐店", location: "南通华联店",  phone: "1880242455" , address: "南通市崇川区人民中路145号", description: "必胜客是比萨专卖连锁企业之一，由法兰克·卡尼和丹·卡尼两兄弟在1958年，凭着由母亲借来的600美元于美国堪萨斯州威奇托创立首间必胜客餐厅。它的标识特点是把屋顶作为餐厅外观显著标志。必胜客属于百胜餐饮集团。", image: "必胜客", isVisited: false, rating: ""),
        Restaurant.init(name: "舞茶道", type: "饮品店", location: "南通万达", phone: "1880524775" , address: "崇川区人民中路106号金鹰国际购物中心一楼", description: "走近舞茶道TEABCKS，一股清爽的气息就会迎面袭来，淡绿色的标识，透明的奶茶杯，还有吧台师傅飘逸的摇茶姿势，处处透露出与众不同的“气质”。作为全国连锁奶茶店，坚持“舞茶道TEABCKS精神”，为你调制每一杯好心情。", image: "舞茶道", isVisited: false, rating: ""),
        Restaurant.init(name: "星巴克", type: "咖啡店", location: "圆融广场", phone: "1853523455" , address: "江苏省南通市崇川区工农路57号南通金鹰圆融购物中心", description: "星巴克（Starbucks）是美国一家连锁咖啡公司的名称，1971年成立，是全球最大的咖啡连锁店，其总部坐落美国华盛顿州西雅图市。星巴克旗下零售产品包括30多款全球顶级的咖啡豆、手工制作的浓缩咖啡和多款咖啡冷热饮料、新鲜美味的各式糕点食品以及丰富多样的咖啡机、咖啡杯等商品。", image: "星巴克", isVisited: false, rating: ""),
        Restaurant.init(name: "汉堡王", type: "快餐店", location: "时尚街",  phone: "1880520955" , address: "南通崇川区环城南路1号附1号", description: "“汉堡王”遍布于美国的各个角落，不论是大城市里、道路旁或甚至是不经意的街坊转角，都可以发现“汉堡王”餐厅的踪影。“汉堡王”在全球60多个国家和地区拥有超过1万家门店。",image: "汉堡王", isVisited: false, rating: ""),
        Restaurant.init(name: "热狗大亨", type: "快餐店", location: "姚港路",  phone: "1848056755" , address: "姚港路5号", description: "热狗（hot dog）是火腿肠的一种吃法。吃热狗的时候可以配上很多种类的配料。热狗还有其他种的变化。加起司的叫做“起司热狗”，或是直接叫“起司狗”。加了辣肉酱（chili）的叫做“辣狗”。前面两种全加的就叫“辣起司狗”。裹了玉米浆的油炸热狗，而且插了根小竹棒的叫做玉米狗。受各地方不同饮食习惯的影响，热狗会使用不同的材料，传统上使用法兰克福肠。",image: "热狗大亨", isVisited: false, rating: ""),
        Restaurant.init(name: "华莱士", type: "快餐店", location: "孩儿巷", phone: "1260523455" , address: "南通市崇川区孩儿巷北路19号附房附17室", description: "现烤汉堡是华莱士近期的一项全新尝试，改变以往通过面包厂供应汉堡胚的传统，将面包房搬到餐厅，直接在餐厅现场烘焙面包。华莱士全新推出的现烤全麦汉堡，营养健康、松软香甜，配上新鲜的馅料，加上清新的蔬菜，再撒上华莱士特制的秘制酱汁，一口咬下，外香里嫩，过瘾十足！", image: "华莱士", isVisited: false, rating: ""),
        Restaurant.init(name: "汉堡小子", type: "快餐店", location: "濠河店", phone: "1880586345" , address: "崇川区北濠桥路52号", description: "汉堡小子食品以自身丰富的实践经验，专业的食品研制配方，为客户创造出优质的产品，提供快捷优良的服务、整洁舒适的用餐环境，研制出一系列具有独特风味符合国人口味的产品，为消费者提供营养、健康、美味的食品，满足每一位投资者与消费者的需求。汉堡小子余姚文山路店位于余姚文山路480号，靠近余姚人民医院和嘉悦广场，地理位置优越，店内提供多种美味食品，欢迎广大姚城消费者光临。", image: "汉堡小子", isVisited: false, rating: ""),
        Restaurant.init(name: "德克士", type: "快餐店", location: "海门", phone: "1880523777" , address: "海门市海门街道长江南路99号龙信广场24号", description: "德克士是中国西式快餐特许加盟第一品牌，最大的加盟连锁舒食快餐企业，德克士炸鸡起源于美国南部的德克萨斯州，1994年出现在中国成都。1996年，顶新集团将德克士收购，并投入5000万美元，健全经营体系，完善管理系统，并重新建立了CIS系统，使其成为顶新集团继“康师傅”之后的兄弟品牌。虽然都是炸鸡，但是由于德克士炸鸡采用开口锅炸制，因此鸡块具有金黄酥脆、鲜美多汁的特点，并以此与肯德基炸鸡形成鲜明差别。德克士最有名的就是脆皮炸鸡，在中国快餐界其中最有名的三巨头：除了麦当劳、肯德基、还有就是德克士！", image: "德克士", isVisited: false, rating: ""),
        Restaurant.init(name: "豪客来", type: "快餐店", location: "名都广场",  phone: "1770523455" , address: "崇川区南大街118号名都广场豪010号（附院对面）", description: "豪客来的牛排价格在39-79人民币之间，配餐一般为一杯可无限续杯的红茶、每人2片法式烤面包、一份西式浓汤（奶油蘑菇汤或玉米浓汤）、一份可无限自助的新鲜水果沙拉、主食可有意大利面、米饭或土豆泥，辅食是煎鸡蛋或玉米粒，点餐的时候服务员会询问客人。",image: "豪客来", isVisited: false, rating: ""),
    ]
    
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "搜索餐厅..."
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor.init(red: 231, green: 76, blue: 60)
        
        return searchController
    }()
    
    @IBOutlet var emptyView: UIView!
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurant = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }
    
    func filterContent(for searchText: String) {
        searchResult = restaurant.filter({ (restaurant) -> Bool in
            if let name = restaurant.name, let type = restaurant.type {
                let isMatch = name.localizedCaseInsensitiveContains(searchText) || type.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            
            return false
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        //navigationItem.searchController = searchController
        tableView.backgroundView = emptyView
        tableView.backgroundView?.isHidden = true
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        fetchData()
        //tableView.estimatedRowHeight = 80
        //tableView.rowHeight = UITableView.automaticDimension
        //connectDatabase()
    }
    
//    func connectDatabase() {
//        let dbOperation = Database.init()
//        restaurants = dbOperation.readAllRestaurant()
//        for index in 0...(restaurants.count - 1) {
//            print("\(restaurants[index])")
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
        tableView.tableHeaderView?.isHidden = false
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if restaurant.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResult.count
        } else {
            return restaurant.count
        }
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = (searchController.isActive) ? searchResult[indexPath.row] :restaurant[indexPath.row]
                if let image = restaurant[indexPath.row].image {
                    destinationController.restaurantImage = UIImage(data: image as Data)
                }

                destinationController.nameString = restaurant[indexPath.row].name!
                destinationController.typeString = restaurant[indexPath.row].type!
                destinationController.locationString = restaurant[indexPath.row].address!
            }
        }
        
        self.searchController.dismiss(animated: true, completion: nil)
    }
    
    //显示cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = (searchController.isActive) ? searchResult : self.restaurant
        
        cell.nameLabel.text = restaurant[indexPath.row].name
        cell.locationLabel.text = restaurant[indexPath.row].address
        cell.typeLabel.text = restaurant[indexPath.row].type
        if let restaurantImage = restaurant[indexPath.row].image {
            cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
        }
        cell.accessoryView = restaurant[indexPath.row].isVisited ? UIImageView.init(image: UIImage(named: "heart-tick")) : .none
        
        return cell
    }
    
//    //选择cell
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let alertController = UIAlertController(title: nil, message: "你想做什么呢？", preferredStyle: .actionSheet)
//        let callAction = UIAlertAction(title: "8593045 + \(indexPath.row)", style: .default) { (action: UIAlertAction) -> Void in
//            let alertController = UIAlertController(title: "抱歉", message: "哎，我真的好想我的82哥哥，希望他早点回来！", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "返回", style: .destructive, handler: nil)
//
//            alertController.addAction(cancelAction)
//
//            self.present(alertController, animated: true, completion: nil)
//        }
//
//        var checkAction: UIAlertAction
//
//        if (!restaurantIsVisited[indexPath.row]) {
//            checkAction = UIAlertAction(title: "标记喜欢", style: .default) { (action: UIAlertAction) -> Void in
//                if let cell = tableView.cellForRow(at: indexPath) {
//                    cell.accessoryView = UIImageView(image: UIImage(named: "heart-tick"))
//                    self.restaurantIsVisited[indexPath.row] = true
//                }
//            }
//        } else {
//            checkAction = UIAlertAction(title: "取消标记", style: .default) { (action: UIAlertAction) -> Void in
//                if let cell = tableView.cellForRow(at: indexPath) {
//                    cell.accessoryView = .none
//                    self.restaurantIsVisited[indexPath.row] = false
//                }
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//
//        alertController.addAction(callAction)
//        alertController.addAction(checkAction)
//        alertController.addAction(cancelAction)
//
//        present(alertController, animated: true, completion: nil)
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
    //右扫
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //删除一行数据
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            
            //delete from the data store
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                
                appDelegate.saveContext()
            }
            
            //self.restaurant.remove(at: indexPath.row)
            
//            self.restaurantNames.remove(at: indexPath.row)
//            self.restaurantLocation.remove(at: indexPath.row)
//            self.restaurantType.remove(at: indexPath.row)
//            self.restaurantIsVisited.remove(at: indexPath.row)
            
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
            
            let activityViewController: UIActivityViewController
            
            let defaultMessage = "宝宝你回来之后我带你去吃好吃的OAO！"
            
            if let restaurantImage = self.restaurant[indexPath.row].image, let image = UIImage(data: restaurantImage as Data){
                activityViewController = UIActivityViewController(activityItems: [defaultMessage, image], applicationActivities: nil)
            } else {
                activityViewController = UIActivityViewController(activityItems: [defaultMessage], applicationActivities: nil)
            }
            
            self.present(activityViewController, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.init(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1)
        deleteAction.image = UIImage(named:"delete")
        shareAction.backgroundColor = UIColor.init(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1)
        shareAction.image = UIImage(named: "share")
        
        let trailingConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return trailingConfiguration
    }
    
    //左扫
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let checkAction: UIContextualAction
        
        if(!restaurant[indexPath.row].isVisited) {
            checkAction = UIContextualAction(style: .normal, title: "", handler: { (action, view, completionHandler) in
            
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryView = UIImageView(image: UIImage(named: "heart-tick"))
                    
                    self.restaurant[indexPath.row].isVisited = true
                }
                
                 completionHandler(true)
            })
            
            checkAction.image = UIImage(named: "tick")
        } else {
            checkAction = UIContextualAction(style: .normal, title: "", handler: { (action, view, completionHandler) in
                
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryView = .none
                    
                    self.restaurant[indexPath.row].isVisited = false
                }
                
                 completionHandler(true)
            })
            
            checkAction.image = UIImage(named: "undo")
        }
        
        checkAction.backgroundColor = UIColor(red: 38/255, green: 162/255, blue: 77/255, alpha: 1)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let leadingConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        
        return leadingConfiguration
    }

    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            restaurant = fetchedObjects as! [RestaurantMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
