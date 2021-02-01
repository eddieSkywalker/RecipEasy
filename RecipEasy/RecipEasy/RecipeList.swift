//
//  My_Recipes.swift
//  RecipEasy
//
//  Created by Eddie Schweitzer on 1/17/21.
//  Copyright © 2021 Modern App Development. All rights reserved.
//
import UIKit
import CoreData

class RecipeList: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var recipes: [NSManagedObject] = []
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    @IBOutlet weak var collectionViewObject: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRecipes()
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    /// tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
//        return self.items.count
        return recipes.count
    }
    
    /// make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.row] // The row value is the same as the index of the desired text within the array.
//        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("You selected cell #\(indexPath.item)!")                                                        // handle tap events
    }
    
    ///retrieve the count of how many recipes are stored
    private func loadRecipes()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext         // context is scratchpad container for working with managed objects
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Recipe")                              // fetches all objects of Recipe entity

        do {                                                                                                  // hand fetch request over to the context, returning an array of managed objects
            recipes = try context.fetch(fetchRequest)
            collectionViewObject.reloadData()
            print(recipes.count)
        } catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

