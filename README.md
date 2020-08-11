# Divider

Given a dividend ‘a’ and a divisor ‘b’, the restoring division algorithm calculates the quotient ‘q’ and the remainder ‘r’ such that a = b xq + rand r < b, by subtracting bfrom the partial remainder (initially the MSB of a). If the result of the subtraction is not negative, we set the quotient bit to 1. Otherwise, bis added back to the result to restore the partial remainder. Then we shift the partial remainder with the remaining bits of ‘a’ to the left by one bit for the calculation of the next quotient bit. This procedure is repeated until all the bits of ‘a’ are shifted out.

