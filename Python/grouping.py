
n = int(input())
k = int(input())
A = []
for i in input().split():
    A.append(int(i))

sum = [0] * (n + 1)
for i in range(1, n + 1):
    sum[i] = sum[i - 1] + A[i - 1]

list = [[[sum[j + 1] ** 3, 0] for i in range(k)] for j in range(n)]

# --------------------------------------------------------------------------

for s in range(1, k):
    for i in range(n):
        for j in range(i + 1):

            if list[i][s][0] > list[j][s - 1][0] + (sum[i + 1] - sum[j + 1]) ** 3:
                list[i][s][0] = list[j][s - 1][0] + (sum[i + 1] - sum[j + 1]) ** 3
                list[i][s][1] = j + 1

# ---------------------------------------------------------------------------

index = [n]
j = list[n - 1][k - 1][1]
c = k - 1
while list[j][c][1] != 0:
    index.append(j)
    c = c - 1
    j = list[j - 1][c][1]

index.append(0)
index = index[::-1]

print(list[n - 1][k - 1][0])
print(index)

'''
The code is divided into three parts: initialization, iterative updates, and backtracking.

I.The first part consists of two initialization loops. 

    The first loop regarding the array 'sum' has a complexity of O(n), 
    used to record the prefix sum of the input array to avoid 
    redundant calculations of consecutive sums during iterative updates. 
    
    The second loop, concerning the initialization of the 'list' array, 
    has a complexity of O(2nk) (which simplifies to O(nk)), 
    where dimension n is used to iterate over every possible insertion position for boundaries, 
    dimension k records the number of edges inserted before this boundary (s<k), 
    and the remaining constant 2 dimensions record the position of the last boundary for ease of backtracking operations


II.The second part updates the 'list' array with three nested loops, resulting in a complexity of O(knn). 
    
    Here, 's' represents the s-th boundary insertion, 
    'i' indicates the current update range of the 'list' (0, i), 
    and 'j' represents the desired insertion position of the s-th boundary. 
    
    The logic for updating is: 
        if the calculated values of various partial sums after inserting this boundary are less than 
        those before insertion or from the previous insertion scheme, 
        then replace it with the current scheme and record the position of the last insertion.

III.The third part involves backtracking to find the optimal coordinates for partitioning. 
    
    Using a while loop, the worst-case scenario is traversing n elements, making it O(n). 
    Each time finding the boundary inserted last under the current partition, 
    add the index to the 'index' array until reaching the far left of the input array. Finally, reverse the array (O(n))

'''
