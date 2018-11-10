//
//  PhotosViewController.swift
//  
//
//  Created by administrator on 11/9/18.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource {
  
    //outlets && variables
    @IBOutlet weak var tableView: UITableView!
    var posts: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        refreshControl = UIRefreshControl()
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview( refreshControl, at: 0)
        runRequest()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
       runRequest()
    }

   

    func runRequest(){
    
    let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
    let task = session.dataTask(with: request){( data, response, error) in
        
    if let error = error {
    print(error.localizedDescription)
        
    }else if let data = data {
        
      let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
       let responses = dataDictionary["response"] as! [String: Any]
       self.posts = responses["posts"] as! [[String: Any]]
       let status = dataDictionary["meta"] as! [String: Any]
        

        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    }
    
    task.resume()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellTableViewCell", for: indexPath) as! photoCellTableViewCell
        let post = posts[indexPath.row]
       // let photos = post["photos"] as! [[String: Any]]
        
            // photos is NOT nil, we can use it!
        if let photos = post["photos"] as? [[String: Any]]{
            // TODO: Get the photo url
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            
            cell.img.af_setImage(withURL: url!)
        }else{
            
            print("!\n")
        }
        
        return cell
      
    }

    
}


