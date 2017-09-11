//
//  FirstViewController.swift
//  Myexample
//
//  Created by Gaurav on 11/09/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

import UIKit
import Alamofire

var myArray = ["vl1","vl2","vl3","vl4"]

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mytbaleView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mytbaleView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //mytbaleView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        callPostMethod()
    }
    
        func callGetMethod(){
            
            Alamofire.request("http://apidev.accuweather.com/currentconditions/v1/202438.json?language=en&apikey=hoArfRosT1215",method:.get).responseJSON {
                response in
                
                switch response.result {
                case .success:
                    if let objJson = response.result.value as! NSArray! {
                        for element in objJson {
                            let data = element as! NSDictionary
                            
                            print(data["EpochTime"] ?? "noting")
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
                
            }
            
        }
    
    func callPostMethod(){
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.addSubview(activity)
        activity.center=view.center
        activity.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let parametersDic:Parameters = ["key":"cb784502bffab6e"]
        
        Alamofire.request("http://date.jsontest.com/",method:.post,parameters:parametersDic).responseJSON {
            response in
            
            print(response.result.value)
            
            switch response.result {
            case .success:
                if let objJson = response.result.value as! NSDictionary! {
                    
                    print(objJson["date"] ?? "nothing");
                    
                }
            case .failure(let error):
                print("Error: \(error)")
            }
            
            activity.stopAnimating()
            activity.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        
    }

    
    func convertToDictionary(from text: String) throws -> [String: String]? {
        guard let data = text.data(using: .utf8) else { return [:] }
        let anyResult: Any = try JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: String]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text=myArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let thirdvc = ThirdViewController()
//        thirdvc.stringPassed="hello"
//        navigationController?.pushViewController(thirdvc, animated: true)
        
        performSegue(withIdentifier: "pushtotbvc", sender: self)
        
        //tdvc.stri
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="pushtotbvc" {
            if let inpath = self.mytbaleView.indexPathForSelectedRow {
                let ctrl = segue.destination as! ThirdViewController
                ctrl.stringPassed = myArray[inpath.row]
                
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle==UITableViewCellEditingStyle.delete {
            myArray.remove(at: indexPath.row)
            self.mytbaleView.reloadData()
        }
    }


}

