//
//  ViewController.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = WeatherViewModel()
    @IBOutlet weak var tb:UITableView!
    @IBOutlet weak var inputTF:UITextField!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.vc = self
        
    }
    @IBAction func btnSubmit(sender:UIButton!){
        viewModel.sumbit(urlStr: Constant.shared.baseUrl, inputStr: self.inputTF.text ?? "")
    }

}


extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.numberRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? WeatherTableViewCell {
            cell.configureCell(userLocation: viewModel.userLocation)
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightRow()
    }
    
}

