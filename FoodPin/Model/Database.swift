//
//  Database.swift
//  FoodPin
//
//  Created by Apple on 2018/8/11.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import Foundation
import SQLite3

struct Database {
    var db: OpaquePointer? = nil

    init() {
        connectDatabase()
    }

    //与数据库建立连接
    mutating func connectDatabase(filePath: String = "/Users/apple/Desktop") -> Void {
        let sqlFilePath = (filePath + "/testSqlit3/Restaurant.db").cString(using: .utf8)
        //打开数据库
        let open = sqlite3_open(sqlFilePath, &db)
        //打开数据库失败
        if open != SQLITE_OK {
            sqlite3_close(db)
            print("error!")
        }
    }
    
    //插入数据
    func addRestaurant(restaurant: Restaurants) -> Bool {
        //sql
        let sql = "INSERT INTO restaurant(summary, image, isVisited, location, name, phone, rating, type) VALUES (?, ?, '0', ?, ?, ?, '', ?);";
        //sql语句转换成cString
        let cSql = sql.cString(using: .utf8)
        //sqlite3_stmt指针
        var stmt:OpaquePointer? = nil
        //编译
        let prepare_result = sqlite3_prepare_v2(self.db, cSql!, -1, &stmt, nil)
        
        //判断如果失败，获取失败信息
        if prepare_result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if (sqlite3_errmsg(self.db)) != nil {
                let msg = "error!"
                print(msg)
            }
            return false
        }
        
        //绑定参数
        //第二个参数，索引从1开始
        //最后一个参数为函数指针
        sqlite3_bind_text(stmt, 0, restaurant.summary!.cString(using: .utf8), -1, nil)
        sqlite3_bind_blob(stmt, 1, [restaurant.image], -1, nil)
        //sqlite3_bind_text(stmt, 2, , -1, nil)
        sqlite3_bind_text(stmt, 3, restaurant.location!.cString(using: .utf8), -1, nil)
        sqlite3_bind_text(stmt, 4, restaurant.name!.cString(using: .utf8), -1, nil)
        sqlite3_bind_text(stmt, 5, restaurant.phone!.cString(using: .utf8), -1, nil)
        //sqlite3_bind_text(stmt, 6, restaurant.rating!.cString(using: .utf8), -1, nil)
        sqlite3_bind_text(stmt, 7, restaurant.type!.cString(using: .utf8), -1, nil)

        //step执行
        let step_result = sqlite3_step(stmt)
        
        //判断执行结果
        if step_result != SQLITE_OK && step_result != SQLITE_DONE {
            sqlite3_finalize(stmt)
            if (sqlite3_errmsg(self.db)) != nil {
                let msg = "error!!"
                print(msg)
            }
            
            return false
        }
        
        //finalize
        sqlite3_finalize(stmt)
        
        return true
    }

    //查询数据
    func readAllRestaurant() -> [Restaurants] {
        //声明一个Restaurant对象数组（查询的信息会添加到数组中）
        var restaurantMO = [Restaurants]()
        //查询sql语句
        let sql = ("Select * from restaurant;").cString(using: .utf8)
        //sqlite3_stmt指针
        var stmt: OpaquePointer? = nil

        let result = sqlite3_prepare_v2(self.db, sql, -1, &stmt, nil)

        if result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if (sqlite3_errmsg(self.db)) != nil {
                let msg = "error!"
                print(msg)
            }
        }

        while (sqlite3_step(stmt) == SQLITE_ROW) {
            let restaurant = Restaurants()

            let summary = UnsafePointer(sqlite3_column_text(stmt, 0))
            let image = sqlite3_column_blob(stmt, 1)
            let isVisited = sqlite3_column_text(stmt, 2)
            let location = sqlite3_column_text(stmt, 3)
            let name = sqlite3_column_text(stmt, 4)
            let phone = sqlite3_column_text(stmt, 5)
            let rating = sqlite3_column_text(stmt, 6)
            let type = sqlite3_column_text(stmt, 7)
            let size = sqlite3_column_bytes(stmt, 1)

            restaurant.summary = String.init(cString: summary!)
            restaurant.image = NSData.init(bytes: image, length: Int(size)) as Data
            restaurant.isVisited = Bool.init(booleanLiteral: (isVisited != nil))
            restaurant.location = String.init(cString: location!)
            restaurant.name = String.init(cString: name!)
            restaurant.phone = String.init(cString: phone!)
            restaurant.rating = String.init(cString: rating!)
            restaurant.type = String.init(cString: type!)

            restaurantMO += [restaurant]
        }

        sqlite3_finalize(stmt)

        return restaurantMO
    }

    //关闭数据库
}
