//
//  DynamicProgramingCode.swift
//  MyLeetCode
//
//  Created by Argost on 2022/5/11.
//  Copyright © 2022 Argost. All rights reserved.
//

import Foundation

class DynamicProgramingCode: LeetCode {
    override func run() {
        super.run()
        
        let path=[
            [1, 1, 3],
            [2, 3, 2],
            [5, 1, 2],
            [10, 1, 5],
        ]
        
        let _=findMinimumPath(inPath: path)
    }
}

/*
 *一个Int型的二维数组（m*n），>0，每个值表明距离，左上角记为【0,0】，右下角记为【m，n】,每个数字只能向右或者向下进行，求出从【0，0】->【m,n】的最小路径。
 */
func findMinimumPath(inPath path: [[Int]]) -> Int {
    if path.count<=0 {
        return -1
    }
    
    var DP=[[Int]](repeating: [Int](repeating: 0, count: path[0].count), count: path.count)
    
    var rls=DP[0][0];
    
    var row=path[0][0]
    //初始化第一行DP
    for j in 1..<path[0].count {
        DP[0][j]=row+path[0][j]
        row=DP[0][j]
    }
    
    var col=path[0][0]
    //初始化第一列DP
    for i in 1..<path.count {
        DP[i][0]=col+path[i][0]
        col=DP[i][0]
    }
    
    //初始化剩余部分
    for i in 1..<path.count {
        for j in 1..<path[i].count {
            DP[i][j]=min(DP[i-1][j], DP[i][j-1])+path[i][j]
            rls=DP[i][j]
        }
    }
    
    print("findMinimumPath is: \(rls)")
    return rls;
}
