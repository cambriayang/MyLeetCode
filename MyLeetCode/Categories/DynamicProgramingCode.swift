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
        
//        let path = [
//            [1, 1, 3],
//            [2, 3, 2],
//            [5, 1, 2],
//            [10, 1, 5],
//        ]
//
//        let _ = findMinimumPath(inPath: path)
//
//        let coins = [1,6,7 ]
//
//        let _ = coinsChangeOrGotoFloorMinStep(coins: coins, change: 30)
//        let word1 = "horse"
//        let word2 = "ros"
//        let word1 = "intention"
//        let word2 = "execution"
//
//        let _ = minEditDistanc(word1: word1, word2: word2)
        
        let triangle = [
            [2],
            [3, 4],
            [6, 5, 7],
            [4, 1, 8, 3],
        ]

        let _ = minimumTotal(triangle)
    }
}

/*
 *给定一个三角形数组，找到从上到下最小的sum的路径
 *[2]
 *[3, 4]
 *[6, 5, 7]
 *[4, 1, 8, 3]
 *最小的path sum is 11（i.e. 2+3+5+1=11）
 */
func minimumTotal(_ triangle: [[Int]]) -> Int {
    var path = ""
    var rlt = minimumTotalHelper(triangle, 0, 0, &path)
    
    print("rls is \(rlt)")
    
    return rlt;
}

func minimumTotalHelper(_ triangle: [[Int]], _ row: Int, _ col: Int, _ path: inout String) -> Int {
    //terminator
    if row == triangle.count - 1 {
        return triangle[row][col]
    }
        
    //process
    
    //drill down
    let left = minimumTotalHelper(triangle, row+1, col, &path)
    let right = minimumTotalHelper(triangle, row+1, col+1, &path)
    
    //clear states
    //no need here
    
    return triangle[row][col] + min(left, right)
}

//func minimumTotal(inTriangle triangle: [[Int]]) -> Int {
//    if (triangle.count == 0 || triangle[0].count == 0) {
//        return 0;
//    }
//
//    var pathStr = "";
//    var sum = 0;
//
//    return _dfs(inTriangle: triangle, inRow: 0, inCol: 0, path: &pathStr, sum: &sum);
//}
//
//func _dfs(inTriangle triangle: [[Int]], inRow i: Int, inCol j: Int, path: inout String, sum: inout Int) -> Int {
//    //terminator
//    if i == triangle.count-1 {
//        path += triangle[i][j].description + "#";
//        sum += triangle[i][j];
//        print(path + "with sum: \(sum))");
//        return sum;
//    }
//
//    //process
//    path += triangle[i][j].description + "->";
//    sum += triangle[i][j];
//
//    //drill down
//    var leftResult = _dfs(inTriangle: triangle, inRow: i+1, inCol: j, path: &path, sum: &sum);
//    var rightResult = _dfs(inTriangle: triangle, inRow: i+1, inCol: j+1, path: &path, sum: &sum);
//
//    //clear states
//    //no need here
//
//    return sum;
//}

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

/*
 *零钱兑换:有若干面值的硬币，如：[1,6,7] , 求组成特定面值，如：30，的最小硬币数。
 *类似到达特定楼层比如30层，step可选1,6,7，最少需要多少次
 */
func coinsChangeOrGotoFloorMinStep(coins: [Int], change: Int) -> Int {
    var result = -1
    
    if coins.count<=0 || change<=0 {
        return result
    }
    
    var DP = [Int](repeating: Int.max, count: change+1)
    DP[0] = 0
    
    for i in 1...change {
        for j in 0..<coins.count {
            if i>=coins[j] {
                DP[i]=min(DP[i], DP[i-coins[j]]+1)
            }
        }
    }
    
    if DP[change]>0 {
        result=DP[change]
        
        print("coinsChangeOrGotoFloorMinStep is: \(result)")
        return result
    }
    
    print("coinsChangeOrGotoFloorMinStep cannot be found")
    
    return result;
}

/*
 *Edit Distance
 *word1(m)->word2(n)需要的最短步骤
 *horse->ros, intention->nation
 */
func minEditDistanc(word1: String, word2: String) -> Int {
    var result = -1;
    
    let m = word1.count
    let n = word2.count
    
    //Initial the two-dimension array
    var dp = [[Int]](repeating: [Int](repeating: 0, count: n+1), count: m+1)
    

    for i in 0...m {
        //第一个单词前面的i个字符，第二个单词有0个字符，那需要匹配多少个次呢？当然是第一个i个字符全部删除
        dp[i][0]=i
    }
    
    //同理
    for j in 0...n {
        dp[0][j]=j
    }
    
    for i in 1...m {
        for j in 1...n {
            if word1[i-1]==word2[j-1] {
                dp[i][j]=dp[i-1][j-1]
            } else {
                //+1是肯定需要操作一次，然后是取3个中间的最小值：删除word2的j，删除word1的i个字符，两个都需要删除，重新替换
                //这就是这3个比较的由来，由于是轮换对称的，不必纠结删除哪个，新增另一个word的字符，等价的
                dp[i][j]=1+min(dp[i][j-1], dp[i-1][j], dp[i-1][j-1])
            }
        }
    }
    
    result=dp[m][n]
    print("minEditDistanc in \(word1) & \(word2) is: \(result)")
    return result;
}

