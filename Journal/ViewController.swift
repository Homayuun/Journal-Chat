//
//  ViewController.swift
//  Journal
//
//  Created by Homayun on 11/14/1400 AP.
//

import UIKit

struct Post: Codable {
    let id: Int
    let title, body: String
}

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @objc fileprivate func fetchPosts() {
        Service.shared.fetchPosts { (res) in
            self.tableView.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let posts):
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    var posts = [Post]()
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
        tableView.refreshControl = rc
        tableView.delegate = self
        tableView.dataSource = self
        fetchPosts()
        
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        handleLogin()
    }
    
    @objc fileprivate func handleLogin() {
        print("Perform login and refetch posts")
        
        guard let url = URL(string: "http://192.168.1.234:1440/api/v1/entrance/login") else { return }
        
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "PUT"
        
        do {
            let params = ["emailAddress": "homayun@gmail.com", "password": "123456789"]
            loginRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            URLSession.shared.dataTask(with: loginRequest) { (data, resp, err) in
                
                if let err = err {
                    print("Failed to login:", err)
                    return
                }
                if err == nil {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Login Attempt", message: "Successfully logged in", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert,animated: true)
                        self.fetchPosts()
                    }
                }

            }.resume()
        } catch {
            print("Failed to serialize data:", error)
        }
        
        
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Delete post")
            let post = self.posts[indexPath.row]
            Service.shared.deletePost(id: post.id) { (err) in
                if let err = err {
                    print("Failed to delete:", err)
                    return
                }
                
                print("Successfully deleted post from server")
                self.posts.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    @IBAction func addPost(_ sender: Any) {
        let alert = UIAlertController(title: "Post", message: "add your post title & body", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter title..."
            field.returnKeyType = .next
        }
        alert.addTextField { field in
            field.placeholder = "Enter body..."
            field.returnKeyType = .default
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            
            guard let fields = alert.textFields, fields.count == 2 else {return}
            let titleField = fields[0]
            let bodyField = fields[1]
            guard let title = titleField.text , !title.isEmpty ,
                  let body = bodyField.text , !body.isEmpty else{return}
            Service.shared.createPost(title: title, body: body) { err in
                if let err = err {
                   print("failed to create post : \(err)")
                    return
                }
                self.fetchPosts()
            }
        }))
        present(alert,animated: true)
                        

    }
    
//    @objc fileprivate func handleCreatePost() {
//        print("Creating post")
//        Service.shared.createPost(title: "4444", body: "5555") { (err) in
//            if let err = err {
//                print("Failed to create post object:", err)
//                return
//            }
//
//            print("Finished creating post")
//            self.fetchPosts()
//        }
//    }


}

