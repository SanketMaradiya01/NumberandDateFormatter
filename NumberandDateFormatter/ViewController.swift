//
//  ViewController.swift
//  NumberandDateFormatter
//
//  Created by Nimap on 13/02/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    
    var TopView : UIView!
    var Datelabel : UILabel!
    var DateInputView : UIView!
    var DateInputTF : UITextField!
    var tableView : UITableView!
    var tableviewcell : UITableViewCell!
    var TitleLabel : UILabel!
    var FormatterBtn : UIButton!
    
    
    var dateFormats = ["yyyy-MM-dd", "dd-MM-yyyy", "MMMM d, yyyy", "E, d MMM yyyy"]
    var formattedDates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
    }
    
    func UI(){
        TopView = UIView()
        TopView.backgroundColor = .gray
        view.addSubview(TopView)
        TopView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            TopView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            TopView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            TopView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            TopView.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        TitleLabel = UILabel()
        TitleLabel.text = "Date Formatter"
        TitleLabel.textAlignment = .center
        TitleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        TitleLabel.textColor = .white
        TopView.addSubview(TitleLabel)
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            TitleLabel.topAnchor.constraint(equalTo: TopView.topAnchor),
            TitleLabel.leadingAnchor.constraint(equalTo: TopView.leadingAnchor),
            TitleLabel.trailingAnchor.constraint(equalTo: TopView.trailingAnchor),
            TitleLabel.bottomAnchor.constraint(equalTo: TopView.bottomAnchor)
        ])
        
        DateInputView = UIView()
        view.addSubview(DateInputView)
        DateInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            DateInputView.topAnchor.constraint(equalTo: TopView.bottomAnchor),
            DateInputView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            DateInputView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            DateInputView.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        DateInputTF = UITextField()
        DateInputTF.placeholder = "Enter Date DD/MM/YYYY"
        DateInputTF.borderStyle = .roundedRect
        DateInputTF.keyboardType = .default
        DateInputTF.delegate = self
        DateInputView.addSubview(DateInputTF)
        DateInputTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            DateInputTF.topAnchor.constraint(equalTo: DateInputView.topAnchor, constant: 3.0),
            DateInputTF.leadingAnchor.constraint(equalTo: DateInputView.leadingAnchor, constant: 3.0),
            DateInputTF.trailingAnchor.constraint(equalTo: DateInputView.trailingAnchor, constant: -3.0),
            DateInputTF.bottomAnchor.constraint(equalTo: DateInputView.bottomAnchor, constant: -3.0)
        ])
        
        
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: DateInputView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        FormatterBtn = UIButton(type: .system)
        FormatterBtn.frame = CGRect(x: 50, y: 100, width: 150, height: 50)
        FormatterBtn.setTitle("Format", for: .normal)
        FormatterBtn.setTitleColor(.white, for: .normal)
        FormatterBtn.backgroundColor = .black
        FormatterBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(FormatterBtn)
        FormatterBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            FormatterBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor , constant: 10.0),
            FormatterBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0),
            FormatterBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FormatterBtn.widthAnchor.constraint(equalToConstant: 200.0),
            FormatterBtn.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        
    }
    @objc func buttonPressed() {
        updateFormattedDates()
        tableView.reloadData()
    }
    
    func updateFormattedDates() {
        guard let enteredDateText = DateInputTF.text else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let enteredDate = dateFormatter.date(from: enteredDateText) {
            formattedDates = dateFormats.map { format in
                dateFormatter.dateFormat = format
                let formattedDate = dateFormatter.string(from: enteredDate)
                return formattedDate
            }
        }
        else
        {
            let alert = UIAlertController(title: "Date Formatter", message: "Please Enter date in dd/MM/yyyy or dd-MM-yyyy format", preferredStyle: .alert)
            let YesAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alert.addAction(YesAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formattedDates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = formattedDates[indexPath.row]
        cell.selectionStyle = .none
        print(formattedDates)
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DateInputTF.resignFirstResponder()
        return true
    }
}

