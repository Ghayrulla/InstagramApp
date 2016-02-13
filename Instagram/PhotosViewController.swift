//
//  ViewController.swift
//  Instagram
//
//  Created by Gary Ghayrat on 2/4/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit
import AFNetworking


class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    
    var gary: [NSDictionary]!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let clientID = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientID)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                        NSLog("response: \(responseDictionary)")
                        self.gary = responseDictionary["data"] as! [NSDictionary]
                        
                        
                        self.tableView.dataSource = self
                        self.tableView.delegate = self
                        self.tableView.reloadData()
                }
        
            }
        });
        task.resume()
        
        
        tableView.rowHeight = 320;
        
        
    }
    
    var isMoreDataLoading = false
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
            isMoreDataLoading = true
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if let gary = gary {
                return gary.count
            } else {
                return 0
            }
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let Shakeel = tableView.dequeueReusableCellWithIdentifier("Shakeel", forIndexPath: indexPath) as! TableViewCell
            
            let link = gary![indexPath.row]
            let feed = link["images"]!["standard_resolution"]!!["url"] as! String
            //        let overview = movie["overview"] as! String
            //        let posterPath = movie["poster_path"] as! String
            
            
            //        let baseUrl = "http://image.tmdb.org/t/p/w500"
            
            let imageUrl = NSURL(string: feed)
            
            
            
            //        cell.titleLabel.text = title
            //        cell.overviewLabel.text = overview
//                    cell.posterView.setImageWithURL(imageUrl!)
            Shakeel.viewImage.setImageWithURL(imageUrl!)
            
            return Shakeel
        
            
}
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let imageURL = gary[(indexPath?.row)!]["images"]!["standard_resolution"]!!["url"] as! String
        
        vc.imageURL = imageURL
        //let link = gary![indexPath!.row]
        
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    

}

