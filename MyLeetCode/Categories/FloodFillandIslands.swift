//
//  FloodFillandIslands.swift
//  MyLeetCode
//
//  Created by Argost on 2023/5/28.
//  Copyright © 2023 Argost. All rights reserved.
//

import Foundation

class FloodFillandIslands: LeetCode {
    override func run() {
        super.run()
        
        let islands = [
            [1,1,0,0,0],
            [1,1,0,0,0],
            [0,0,1,0,0],
            [0,0,0,1,1]
        ]
        
        let _ = numIslands(islands)
    }
}

/*
 *给定一个1（陆地）和0（水）组成的二维网络，计算岛屿数量，一个岛被水包围，并且它是通过水平方向或者垂直方向上相邻的陆地连接而成的。你可以假设网格的四个边均被水包围。
 */
//func numIslands(_ grid: [[Character]]) -> Int {
//    var grid = grid
//    var count = 0
//    for i in 0..<grid.count {
//        for j in 0..<grid[i].count {
//            if grid[i][j] == "1" {
//                count += 1
//                dfs(&grid, i, j)
//            }
//        }
//    }
//    return count
//}
//
//func dfs(_ grid: inout [[Character]], _ i: Int, _ j: Int) {
//    if i < 0 || j < 0 || i >= grid.count || j >= grid[i].count || grid[i][j] == "0" {
//        return
//    }
//    grid[i][j] = "0"
//    dfs(&grid, i - 1, j)
//    dfs(&grid, i + 1, j)
//    dfs(&grid, i, j - 1)
//    dfs(&grid, i, j + 1)
//}

func numIslands(_ grid: [[Int]]) -> Int {
    var result = -1;
    //不动原数组
    var copyGrid = [[Int]].init(grid)

    var count = 0;
    
    for i in 0..<copyGrid.count {
        for j in 0..<copyGrid[i].count {
            if copyGrid[i][j] == 1 {
                //表明有岛或者是认识的朋友
                count += 1
                dfs(&copyGrid, i, j)
            }
        }
    }
    
    result = count

    print("numIslands is \(result)")
    return result;
}

func dfs(_ grid: inout [[Int]], _ i: Int, _ j: Int) {
    if i < 0 || j < 0 || i >= grid.count || j >= grid[i].count || grid[i][j] == 0 {
        //不管，啥也不做
        return
    }
    
    grid[i][j] = 0
    
    dfs(&grid, i, j - 1)
    dfs(&grid, i, j + 1)
    dfs(&grid, i - 1, j)
    dfs(&grid, i + 1, j)
}
