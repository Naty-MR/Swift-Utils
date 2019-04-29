//
//  DownloadsViewController.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 26/12/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

class DownloadViewController: UIViewController {
    @IBOutlet weak var downloadsTable: UITableView!
    var downloads = [String]()
    let reuseIdentifier = "downloadsTableViewCell"
    let webViewSegueIdentifiere = "webViewIdentifier"
    var filesPath: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadsTable.register(UINib(nibName: "DownloadTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        filesPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        filesPath!.appendPathComponent("filePath/")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoadingView()
        getFiles()
        downloadsTable.reloadData()
        self.hideLoadingView()
    }
    
    func getFiles() {
        downloads.removeAll()
        let fileManager = FileManager.default
        let properties: [URLResourceKey] = [.localizedNameKey,
                                            .creationDateKey,
                                            .contentModificationDateKey,
                                            .localizedTypeDescriptionKey]
        
        var attributesDictionary: [URLResourceKey : Any]?
        var dateLastModified: Date
        var urlDictionary = [URL:Date]()
        
        do {
            let urlArray = try fileManager.contentsOfDirectory(at: filesPath!, includingPropertiesForKeys: properties, options: .skipsHiddenFiles)
            
            for URLs in urlArray {
                attributesDictionary = try! (URLs as NSURL).resourceValues(forKeys: properties)
                dateLastModified = attributesDictionary?[URLResourceKey.contentModificationDateKey] as! Date
                urlDictionary[URLs] = dateLastModified
            }
            
            //Ordeno de manera descendiente las fechas de creación de los archivos
            let finalUrls = urlDictionary.sorted{$0.1.compare($1.1) == .orderedDescending }.map{$0.0}.map{$0.lastPathComponent}
            downloads = finalUrls.filter({$0.hasSuffix(".pdf")})
            print("Archivos listados: \(downloads)")
        }
        catch let error as NSError {
            print("Se produjo un error al intentar listar los archivos: \(error)")
        }
    }
    
    @objc func openPDF(_ sender: AnyObject?) {
        performSegue(withIdentifier: webViewSegueIdentifiere, sender: sender)
    }
    
    @objc func deletePDF(_ sender: AnyObject?) {
        self.showAlertMessage(title: "¿Seguro que desea eliminar el archivo de su dispositivo?",
                              okActionTitle: "Si",
                              okAction: {(_) in
                                var filePath = self.filesPath
                                filePath!.appendPathComponent(self.downloads[sender!.tag])
                                do {
                                    try FileManager.default.removeItem(atPath: filePath!.path)
                                    self.showAlertMessage(title: "El Archivo fue borrado exitosamente",
                                                          showCancelAction: false)
                                    self.downloads.remove(at: sender!.tag)
                                    self.downloadsTable.reloadData()
                                } catch let error as NSError{
                                    print (error)
                                }
                                
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == webViewSegueIdentifiere {
            let webView = segue.destination as! CustomWebViewController
            var filePath = self.filesPath
            filePath!.appendPathComponent(self.downloads[(sender! as! UIButton).tag])
            webView.filePath = filePath
        }
    }
}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DownloadTableViewCell
        cell.fileName.text = downloads[indexPath.row]
        cell.openBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.openBtn.addTarget(self, action: #selector(openPDF(_:)), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(deletePDF(_:)), for: .touchUpInside)
        return cell
    }
    
    
}
