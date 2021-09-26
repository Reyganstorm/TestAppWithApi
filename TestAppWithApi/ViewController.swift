//
//  ViewController.swift
//  TestAppWithApi
//
//  Created by Руслан Штыбаев on 27.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageForCatView: UIImageView!
    
    @IBOutlet weak var getCatButton: UIButton!
    
    let link = "https://api.thecatapi.com/v1/images/search"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Cat].self, from: data)
                print(courses)
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.imageForCatView.image = image
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
            }

    @IBAction func getCat() {
        fetchImage()
    }
    
}

