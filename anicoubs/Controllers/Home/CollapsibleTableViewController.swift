//
//  CollapsibleTableViewController.swift
//  anicoubs
//
//  Created by Holofox on 10.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit
import PromiseKit

protocol BaseItemDelegateProtocol : AnyObject {
    func didChangeField(text: String)
    func didChangeSegment(index: Int, title: String)
    func didChangeStatus(isOn: Bool)
    func didChangeDate(date: Date)
}

class CollapsibleTableViewController: UITableViewController {
    
    var sections = [SectionModel]()
    var preferences = PostPreference(link: "", category: 0, postponed: true, date: Date())
    
    let categories = ["cool", "fun", "sad", "nice", "scary"]
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()

    }
    
    private func setupTableView() {

        sections.append(SectionModel(name: "Main info", items: [FieldModel(name: "Link", placeholder: "https://coub.com/view/aabbcc"), SegmentedControlModel(items: categories)]))
        sections.append(SectionModel(name: "Publish time", items: [ToggleModel(name: "Postponed", active: preferences.postponed), DatePickerModel(date: preferences.date)], collapsed: true))
        
        tableView.registerHeaderFooterViews([
            (CollapsibleTableViewHeader.self, CellType.header.rawValue)
            ])
        
        tableView.registerCells([
            (FieldTableViewCell.self, CellType.field.rawValue),
            (SegmentedControlTableViewCell.self, CellType.segment.rawValue),
            (ToggleViewTableCell.self, CellType.toggle.rawValue),
            (DatePickerTableViewCell.self, CellType.datePicker.rawValue)
            ])
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.tintColor = .gray
        
        navigationItem.title = "New post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
       // navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func addTapped() {
        
        switch preferences.postponed {
        case true where preferences.date > Date():
            print("Postponed publish is OK")
            break
        case true where preferences.date < Date():
            print("Postponed publish is not OK")
            break
        default:
            print("Publish in real time")
            break
        }
        
    }
    
}

extension CollapsibleTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sections[indexPath.section].items[indexPath.row]
        let cellIdentifier = cellModel.type.rawValue
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCellProtocol
            cell.configure(withModel: cellModel)
            cell.delegate = self
        
        return cell as! UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellType.header.rawValue) as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: CellType.header.rawValue)
        
            header.nameLabel.text = sections[section].name
            header.setCollapsed(sections[section].collapsed)
        
            header.section = section
            header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
}

extension CollapsibleTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CollapsibleTableViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}

// NOTE: Do the work

extension CollapsibleTableViewController: BaseItemDelegateProtocol {
    
    func didChangeField(text: String) {
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        if text.lowercased() ~= "^((https|http)://)coub.com/view/((\\w|-)+)" {
            navigationItem.rightBarButtonItem?.isEnabled = true
            preferences.link = text
        }
        
        print("\(#function): \(text)")
    }
    
    func didChangeSegment(index: Int, title: String) {
        preferences.category = index
        print("\(#function): \(index) \(title)")
    }
    
    func didChangeStatus(isOn: Bool) {
        preferences.postponed = isOn
        print("\(#function): \(isOn)")
    }
    
    func didChangeDate(date: Date) {
        preferences.date = date
        print("\(#function): \(date)")
    }
    

}
