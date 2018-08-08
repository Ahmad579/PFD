//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper


class UserResponse: Mappable {
    
    var success                          :       Bool?
    var message                          :       String?
    var response_code                    :       Int?
    var data                             :       UserInformation?
    var authOfLogin                      :       AuthLogin?
    var listOfRestaurant                 :       [AllRestaurantList]?
    var restaurantDetail                 :       [RestaurantDetailObject]?
    var orderList                        :       [OrderListObject]?
    var listOfDealItem                   :       [DealData]?
    var order                            :       [UserOrder]?
    var recipeList                       :       [ReceipeObject]?
    var dealList                         :       [DealList]?

    

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        response_code <- map["response_code"]
        data    <- map["data"]
        authOfLogin <- map["data"]
        listOfRestaurant <- map["data"]
        restaurantDetail <- map["data"]
        orderList        <- map["data"]
         listOfDealItem        <- map["data"]
        order             <- map["data"]
        recipeList        <- map["data"]
        dealList        <- map["data"]

        
        
    }
}

class AuthLogin : Mappable {
    
    var login: Bool?
    var register: Bool?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        login <- map["login"]
        register <- map["register"]
    }
}



class UserInformation : Mappable {
    
    var id: Int?
    var api_token: String?
    var name: String?
    var email: String?
    var is_verified : Bool?
    var is_accepted : Bool?
    var type : String?
    var lat     : String?
    var lng     : String?
    var phone : String?
    var address : String?
    var verification_code : Int?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        api_token <- map["api_token"]
        name <- map["name"]
        verification_code <- map["verification_code"]
        email <- map["email"]
        is_verified <- map["is_verified"]
        is_accepted <- map["is_accepted"]
        type <- map["type"]
        lat <- map["latitude"]
        lng <- map["longitude"]
        phone <- map["phone"]
        address <- map["address"]



    }
}

class DealData : Mappable {
    
    var menuOfRestaurantOfDeal : RestaurantMenu?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        menuOfRestaurantOfDeal <- map["menu"]
    }
}



class ReceipeObject : Mappable {
    
    var id: Int?
    var user_id: String?
    var title: String?
    var instructions: String?
    var ingredients : Bool?
    var time_to_cook : Bool?
    var image_url : String?
    var tags     : String?
    var user                : UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        title <- map["title"]
        instructions <- map["instructions"]
        ingredients <- map["ingredients"]
        time_to_cook <- map["time_to_cook"]
        image_url <- map["image_url"]
        user <- map["user"]
        tags <- map["tags"]
        
        
        
        
    }
}

class UserOrder : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var user_id: String?
    var order_status: String?
    var payment_date : String?
    var order_date : String?
    var sub_total : String?
    var coupon_code     : String?
    var discount     : String?
    var delivery_charges     : String?
    var tax     : String?
    var total_payment     : String?
    var address     : String?
    var reservation     : String?
    var totalperson     : String?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id <- map["resturant_id"]
        user_id <- map["user_id"]
        order_status <- map["order_status"]
        payment_date <- map["payment_date"]
        order_date <- map["order_date"]
        sub_total <- map["sub_total"]
        coupon_code <- map["coupon_code"]
        discount <- map["discount"]
        tax <- map["tax"]
        total_payment <- map["total_payment"]
        address <- map["address"]
        reservation <- map["reservation"]
        totalperson <- map["totalperson"]

        
        
        
        
    }
}

class OrderListObject : Mappable {
    
    var id: Int?
    var coupon_code: String?
    var order_date: String?
    var order_status: String?
    var payment_date : Bool?
    var reservation : Bool?
    var resturant_id : String?
    var total_payment     : String?
    var user_id     : String?
    var restaurent                       :  AllRestaurantList?
    var userInfo                         :  UserInformation?
    var items                            :  [RestaurantMenu]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        coupon_code <- map["coupon_code"]
        order_date <- map["order_date"]
        order_status <- map["order_status"]
        payment_date <- map["payment_date"]
        reservation <- map["reservation"]
        resturant_id <- map["resturant_id"]
        total_payment <- map["total_payment"]
        user_id <- map["user_id"]
        restaurent <- map["resturant"]
        items <- map["items"]


        
        
        
    }
}

class DealList : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var deal_name: String?
    var deal_type: String?
    var deal_description : String?
    var deal_price : String?
    var image : String?
    
    var restaurent                       :   AllRestaurantList?
    var userInfo                         :   UserInformation?
    var dealItemList                     :   [DealItem]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id <- map["resturant_id"]
        deal_name <- map["deal_name"]
        deal_type <- map["deal_type"]
        deal_description <- map["deal_description"]
        deal_price <- map["deal_price"]
        image <- map["image"]
        restaurent <- map["resturant"]
        userInfo <- map["customer"]
        dealItemList <- map["deal_items"]
    }
}

class DealItem : Mappable {
    
    var id: Int?
    var deal_id: String?
    var menu_item_id: String?
    var quantity: String?
    var menu    : RestaurantMenu?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        deal_id <- map["deal_id"]
        menu_item_id <- map["menu_item_id"]
        quantity <- map["quantity"]
        menu <- map["menu"]
    }
}


class AllRestaurantList : Mappable {
    
    
    var id: Int?
    var category_id: String?
    var name: String?
    var phone_no: String?
    var location: String?
    var latitude : String?
    var longitude : String?
    var image_url : String?
    var do_delivery     : Int?
    var about     : Int?
    var opening_time : String?
    var closing_time : String?

    var distance : String?
    var timings : String?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        category_id <- map["category_id"]
        name    <- map["name"]
        phone_no    <- map["phone_no"]
        location    <- map["location"]
        latitude    <- map["latitude"]
        longitude    <- map["longitude"]
        image_url    <- map["image_url"]
        do_delivery    <- map["do_delivery"]
        about    <- map["about"]
        opening_time    <- map["opening_time"]
        closing_time    <- map["closing_time"]
        distance    <- map["distance"]
        timings    <- map["timings"]


    }
}

class RestaurantDetailObject : Mappable {
    
    var id: Int?
    var category_id: String?
    var resturant_id: String?
    var slug: String?
    var category_name: String?
    var restaurentInfo : AllRestaurantList?
    var menuOfRestaurant : [RestaurantMenu]?
    var menu             : RestaurantMenu?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        category_id <- map["category_id"]
        resturant_id    <- map["resturant_id"]
        slug    <- map["slug"]
        category_name <- map["category_name"]
        restaurentInfo <- map["resturant"]
        menuOfRestaurant <- map["menu"]
        menu  <- map["menu"]
        

    }
}


class MenuCategory : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var slug: String?
    var category_name: String?
    var menuOfRestaurant : [RestaurantMenu]?
    
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id    <- map["resturant_id"]
        slug    <- map["slug"]
        category_name <- map["category_name"]
        menuOfRestaurant <- map["menu"]
        
        
    }
}


class RestaurantMenu : Mappable {
    
    var id: Int?
    var menu_category_id: String?
    var menu_item_id    : String?
    var item_name: String?
    var description: String?
    var available: String?
    var price: String?
    var order_id : String?
    var quantity : String?
    var menuItem : MenuItem?
    var menuCategory : RestaurantDetailObject?


    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        menu_category_id <- map["menu_category_id"]
        menu_item_id     <- map["menu_item_id"]
        item_name <- map["item_name"]
        description <- map["description"]
        available <- map["available"]
        price <- map["price"]
        order_id <- map["order_id"]
        quantity <- map["quantity"]
        menuCategory <- map["menu_category"]
        menuItem <- map["menu_item"]

    }
}


class MenuItem : Mappable {
    
    var id                  :       Int?
    var menu_category_id              :       String?
    var item_name              :       String?
    var description              :       String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        menu_category_id <- map["menu_category_id"]
        item_name <- map["item_name"]
        description <- map["description"]

    }
}



class UserProfileObject : Mappable {
    
    var image                  :       String?
    var imageName              :       String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        imageName <- map["imagename"]
    }
}












class UserData : Mappable {
    
    var user: UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        
    }
    
}





