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
        
        callGetMethod()
    }
    
        func callGetMethod(){
            
            Alamofire.request("http://apidev.accuweather.com/currentconditions/v1/202438.json?language=en&apikey=hoArfRosT1215").responseJSON {
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
                
                 do {
                    
//                    if let data = response.data {
//                        
//                        if let utf8Text = String(data: data, encoding: .utf8) {
//                            print("Data: \(utf8Text)") // original server data as UTF8 string
                    
                            
                         //   if let json = response.result.value {
                    
//                    var json: [Any]?
//                    do {
//                        json = try JSONSerialization.jsonObject(with: Res, options: <#T##JSONSerialization.ReadingOptions#>))
//                    } catch {
//                        print(error)
//                    }
//                    
//                                print("JSON: \(json)") // serialized json response
//                                
//                                guard let item = json as? [String: Any],
//                                    let person = item["person"] as? [String: Any],
//                                    let age = person["age"] as? Int else {
//                                        return
//                                }
//                                
                    
                                
                       //     }
                            
                            
                            
                            
                      //  }
                        
                   // }
                    
                    
                 } catch{
                    
                }
                

                
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

