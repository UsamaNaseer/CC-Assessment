//
//  ResturantViewController.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import UIKit

class ResturantViewController: UIViewController {
    var viewModel: ResturantViewModelDelegate?
    @IBOutlet weak var resturantTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel?.output = { [weak self] output in
            guard let self = self else { return }
            switch output {
            case .reloadData:
                self.resturantTableView.reloadData()
            case .error(let message):
                print(message)
            }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ResturantViewController {
    func initViews() {
        viewModel = ResturantViewModel(service: ResturantService())
        viewModel?.viewDidLoad()
        bindViewModel()
    }
}

extension ResturantViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel?.getCellViewModel(indexpath: indexPath) ?? ResturantCellViewModel()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resturantCell") as? ResturantTableViewCell else { let cell = ResturantTableViewCell(style: .default, reuseIdentifier: "resturantCell")
            return cell
        }
        
        cell.updateCell(model: cellModel)
        cell.selectionStyle = .none
        return cell
    }
    
    
}
