//
//  RecepieCell.swift
//  KitchenHelper
//
//  Created by dfg on 18.09.2022.
//

import Foundation
import UIKit
import CoreData

protocol NetworkServiceProtocol {
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> () )
    func fetchCategoryContent(for category: String, completion: @escaping (Result<CategoryContentResponse, Error>) -> () )
    
    func fetchRecepieDetails(for id: String, completion: @escaping (Result<RecepieDetailsResponse, Error>) -> () )
    
}

class NetworService: NetworkServiceProtocol {

    static let shared = NetworService()
    
    let baseUrl = "https://www.themealdb.com/api/json/v1/1"
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> () ) {
        let urlString = "\(baseUrl)/categories.php"
        fetchData(urlString: urlString, isDecode: true, completion: completion)
    }
    
    func fetchCategoryContent(for category: String, completion: @escaping (Result<CategoryContentResponse, Error>) -> () ) {
        let urlString = "\(baseUrl)/filter.php?c=\(category)"
        fetchData(urlString: urlString, isDecode: true, completion: completion)
    }
    
    func fetchRecepieDetails(for id: String, completion: @escaping (Result<RecepieDetailsResponse, Error>) -> () ) {
        let urlString = "\(baseUrl)/lookup.php?i=\(id)"
        fetchData(urlString: urlString, isDecode: true, completion: completion)
    }

    
    func fetchData<T: Decodable>(urlString: String, isDecode: Bool, completion: @escaping (Result<T, Error>) -> () ) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            guard let data = data else { return }
            
            do {
                if (isDecode) {
                    let decoded: T = try data.decoded()
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.success(data as! T))
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func updateImageCoreData(imageUrl: String, imageData: Data) {
        let context = Heplers.shared.getContext()
        let imageCoreData = getItemByUrlCoreData(imageUrl: imageUrl)
        imageCoreData.imageData = imageData
        do {
            try context.save()
        }
        catch {
            print("error updating image CoreData")
        }
    }
    
    func getAllImageItemsCoreData() -> [DownloadedImage] {
        let context = Heplers.shared.getContext()
        do {
          let savedImages = try context.fetch(DownloadedImage.fetchRequest())
            return savedImages
        }
        catch {
            print("error getting all images from CoreData")
        }
        return []
    }
    
    func getItemByUrlCoreData(imageUrl: String) -> DownloadedImage {
        let context = Heplers.shared.getContext()
        do {
            
            let fetchRequest : NSFetchRequest<DownloadedImage> = DownloadedImage.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "imageUrlStr %@", imageUrl)

            do {
                let fetchedResults = try context.fetch(fetchRequest)
                if (fetchedResults.count > 0) {
                    return fetchedResults[0]
                }
            }
            catch {
                print("error getting image from CoreData")
            }
            
            
            let newItem = DownloadedImage(context: context)
            newItem.imageUrlStr = imageUrl
            newItem.imageData = Data()
            return newItem
        }
    }
    
}

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
