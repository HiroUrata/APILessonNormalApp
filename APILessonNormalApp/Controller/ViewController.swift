//
//  ViewController.swift
//  APILessonNormalApp
//
//  Created by UrataHiroki on 2021/12/01.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultTableView: UITableView!
    
    private let alamofireProcess = AlamofireProcess()
    private let dispatchGroup = DispatchGroup()
    private let dispatchQueue = DispatchQueue(label: "Process",attributes: .concurrent)

    private var cellContentsArray = [ItemDetailDatas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        resultTableView.delegate = self
//        resultTableView.dataSource = self
        
    }

    @IBAction func search(_ sender: UIButton) {
        
        dispatchGroup.enter()
        dispatchQueue.async {[self] in
            
            alamofireProcess.getItemDetailData(searchKey: searchTextField.text) { result, error in
                
                if error != nil{
                    
                    return
                }
                
                self.cellContentsArray = result!
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            
            self.resultTableView.reloadData()
        }
    }
    
}


