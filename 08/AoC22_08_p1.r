A = read.fwf("input.txt", integer(99)+1)

count = 0

for (i in 1:ncol(A)) {
    for (j in 1:nrow(A)) {
        elem = A[i,j]
        if (i == 1 || i == ncol(A) || j == 1 || j == nrow(A)) {
            count = count + 1
        } else {
            left = A[i,1:j-1]
            right = A[i,(j+1):nrow(A)]
            up = A[1:i-1,j]
            down = A[(i+1):ncol(A),j]
            if (elem > max(left) || elem > max(right) || elem > max(up) || elem > max(down)) {
                count = count + 1
            }
        }
    }
}

count
