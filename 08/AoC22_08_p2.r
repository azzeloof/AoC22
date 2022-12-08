A = read.fwf("input.txt", integer(99)+1)

maxScore = 0

for (i in 1:ncol(A)) {
    for (j in 1:nrow(A)) {
        elem = A[i,j]
        scoreLeft = 0
        scoreRight = 0
        scoreUp = 0
        scoreDown = 0
        if (!(i == 1 || i == ncol(A) || j == 1 || j == nrow(A))) {
            left = rev(A[i,1:j-1])
            right = A[i,(j+1):nrow(A)]
            up = rev(A[1:i-1,j])
            down = A[(i+1):ncol(A),j]

            for (k in 1:length(left)) {
                scoreLeft = scoreLeft + 1
                if (left[k] >= elem) {
                    break
                }
            }
            for (k in 1:length(right)) {
                scoreRight = scoreRight + 1
                if (right[k] >= elem) {
                    break
                }
            }
            for (k in 1:length(up)) {
                scoreUp = scoreUp + 1
                if (up[k] >= elem) {
                    break
                }
            }
            for (k in 1:length(down)) {
                scoreDown = scoreDown + 1
                if (down[k] >= elem) {
                    break
                }
            }

            totalScore = scoreLeft * scoreRight * scoreUp * scoreDown
            if (totalScore > maxScore) {
                maxScore = totalScore
            }
        }
    }
}

print(maxScore)

