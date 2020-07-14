import numpy.matlib
import numpy as np

# weights: symmetrical matrix of size n*n
# pattern: array of size n
# return: updated pattern that has reached
# convergance for the given weight matrix
def hopfield(weights, pattern):
    #Until convergance
    while(True):
        #maintain the original pattern for each iteration of the loop
        converge = pattern
        for i in range(len(pattern)):
            #Initial sum is zero, and reset for each x_i in pattern
            s = 0
            for j in range(len(pattern)):
                #Summation of w_ij * x_j where i != j
                if(j != i):
                    s += weights[i][j]*pattern[j]
            #Update rule
            if(s < 0):
                pattern[i] = -1
            else:
                pattern[i] = 1
        #If the pattern has not changed for each x_i, then convergance
        if(np.array_equal(converge, pattern)):
            break
    return pattern

print("Tests for the Hopfield algortihm")

w0 = [[0, -1],
      [-1, 0]]
p0 = np.array([1, 1])
print("\nFor weight matrix =", w0)
print("and inital pattern =", p0)
print("converges to ", hopfield(w0, p0))     #[-1, 1]

w1 = [[0, 1, -1],
     [1, 0, 1],
     [-1, 1, 0]]
p1 = np.array([-1, 1, 1])
print("\nFor weight matrix =", w1)
print("and inital pattern =", p1)
print("converges to ", hopfield(w1, p1))     #[1, 1, 1]

w2 = [[0, -1, 1, -1, 1],
      [-1, 0, -1, 1, -1],
      [1, -1, 0, -1, 1],
      [-1, 1, -1, 0, -1],
      [1, -1, 1, -1, 0]]
p2 = np.array([1, 1, 1, 1, 1])
print("\nFor weight matrix =", w2)
print("and inital pattern =", p2)
print("converges to ", hopfield(w2, p2))     #[1, -1, 1, -1, 1]

w3 = [[0, -1, 1, -1, -1],
      [-1, 0, -1, 1, 1],
      [1, -1, 0, -1, -1],
      [-1, 1, -1, 0, 1],
      [-1, 1, -1, 1, 0]]
p3 = np.array([1, 1, 1, 1, -1])
print("\nFor weight matrix =", w3)
print("and inital pattern =", p3)
print("converges to ", hopfield(w3, p3))     #[1, -1, 1, -1, -1]
