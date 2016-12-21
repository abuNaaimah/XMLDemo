//
//  ViewController.swift
//  XMLDemo
//
//  Created by tops on 12/21/16.
//  Copyright © 2016 tops. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {

    var data = [team]()
    var objTeam = team()
    var strRoot = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://api.kivaws.org/v1/lenders/jeremy/teams.xml")
        let xmlParser = XMLParser(contentsOf: url as! URL)
        xmlParser?.delegate = self
        xmlParser?.shouldResolveExternalEntities = true
        xmlParser?.parse()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        strRoot = elementName
        if elementName == "team" {
            objTeam = team()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if strRoot == "id" {
            objTeam.id += string
        }
        if strRoot == "name" {
            objTeam.name += string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "team" {
            data.append(objTeam)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = data[indexPath.row].id
        cell.detailTextLabel?.text = data[indexPath.row].name
        
        return cell
    }
    

}

class team
{
    var id: String = ""
    var name: String = ""
}

