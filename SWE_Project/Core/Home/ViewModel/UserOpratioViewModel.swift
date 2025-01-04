//
//  UserOpratioViewModel.swift
//  SWE_Project
//
//  Created by Khalid R on 30/03/1446 AH.
//

import Foundation

class UserOprtionViewModel: ObservableObject {
    
    @Published  var user = UserService.shared.user
    @Published var savedPlaces: [PlaceModel] = []
    @Published var resrvations: [PlaceModel] = []
    init() {
        fetchBookmarks()
        fetchResrvations()
    }
    
    private func addToWatchList(place: PlaceModel) {
        guard let userID = UserService.shared.auth.currentUser?.uid else {
            return
        }

        do {
            // Add the place as a new document in the bookmarks collection
            let bookmarkRef = UserService.shared.firestore
                .collection("Users")
                .document(userID)
                .collection("bookmarks")
                .document(place.id.uuidString) // Use the place's ID as the document ID

            try bookmarkRef.setData(from: place) // Save the place model as a document
        } catch {
            print("DEBUG: error while adding to watch list \(error.localizedDescription)")
        }
    }


    private func removeFromWatchList(place: PlaceModel) {
        guard let userID = UserService.shared.auth.currentUser?.uid else { return }

        // Remove the place from the bookmarks collection
        let bookmarkRef = UserService.shared.firestore
            .collection("Users")
            .document(userID)
            .collection("bookmarks")
            .document(place.id.uuidString) // Use the place's ID as the document ID

        bookmarkRef.delete { error in
            if let error = error {
                print("DEBUG: error while removing from watch list \(error.localizedDescription)")
            } else {
                print("DEBUG: Successfully removed place from watch list")
            }
        }
    }


    
    func updateWatchListState(place: PlaceModel, existed: Bool){
        
        if existed {
            removeFromWatchList(place: place)
            
        } else {
            addToWatchList(place: place)
            
        }
        
    }
    
    func fetchBookmarks() {
        guard let userID = UserService.shared.auth.currentUser?.uid else { return }

        let bookmarkCollection = UserService.shared.firestore
            .collection("Users")
            .document(userID)
            .collection("bookmarks")

        bookmarkCollection.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: error while fetching bookmarks \(error.localizedDescription)")
                return
            }

            if let snapshot = snapshot {
                let places = snapshot.documents.compactMap { doc -> PlaceModel? in
                    return try? doc.data(as: PlaceModel.self)
                }
                DispatchQueue.main.async {
                    self.user.bookmarks = places
                    self.savedPlaces =  places
                }
            }
        }
    }

    
    // Resrvation Section

     func bookPlace(place: PlaceModel) {
        guard let userID = UserService.shared.auth.currentUser?.uid else {
            return
        }

        do {
            // Add the place as a new document in the bookmarks collection
            let bookmarkRef = UserService.shared.firestore
                .collection("Users")
                .document(userID)
                .collection("reservations")
                .document(place.id.uuidString) // Use the place's ID as the document ID

            try bookmarkRef.setData(from: place) // Save the place model as a document
        } catch {
            print("DEBUG: error while adding to resrvations list \(error.localizedDescription)")
        }
    }
    func fetchResrvations() {
        guard let userID = UserService.shared.auth.currentUser?.uid else { return }

        let bookmarkCollection = UserService.shared.firestore
            .collection("Users")
            .document(userID)
            .collection("reservations")

        bookmarkCollection.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: error while fetching reservations \(error.localizedDescription)")
                return
            }

            if let snapshot = snapshot {
                let places = snapshot.documents.compactMap { doc -> PlaceModel? in
                    return try? doc.data(as: PlaceModel.self)
                }
                DispatchQueue.main.async {
                    self.user.reservations = places
                    self.resrvations =  places
                }
            }
        }
    }

    
    
}
