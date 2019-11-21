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
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
        // Do any additional setup after loading the view.
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
    }
}
