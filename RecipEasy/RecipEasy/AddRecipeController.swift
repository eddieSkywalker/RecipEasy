//
//  AddRecipeController.swift
//  RecipEasy
//
//  Created by Eddie Schweitzer on 3/17/19.
//  Copyright © 2019 Modern App Development. All rights reserved.
//
import UIKit
import CoreData

class AddRecipeController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeBody: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Functions
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else
        {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set images to display the selected image.
        image.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    /// Adds the recipe to storage by putting data into data model and then storing it into core data.
    /// https://www.raywenderlich.com/7569-getting-started-with-core-data-tutorial#toc-anchor-004
    /// Website used for aid in setting up saving/loading of CoreData.
    @IBAction func Add_Recipe(_ sender: UIButton)
    {
        // context is scratchpad for working with managed objects
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: context)!
        // instance of NSManagedObject
        let recipe = NSManagedObject(entity: entity, insertInto: context)
        // With an NSManagedObject in hand, set attribute's using key-value coding
        recipe.setValue(recipeName.text, forKey: "name")
        recipe.setValue(recipeBody.text, forKey: "ingredients")
        
        do {
            //save context to Core Data
            try context.save()
            print("saved successfully \(recipeName.text) \(recipeBody.text)")
        } catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    /// Method to handle selecting photos from your phone before posting and storing.
    @IBAction func SelectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer)
    {
        // Hide the keyboard
        recipeName.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
}
