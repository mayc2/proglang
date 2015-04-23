import argparse

__author__ = 'chris'

#Compute the pair of stars that minimize pairwise distance.
def ClosestNeighbors(Number,StarList):
    ans = "hi"
    return ans

#Compute the pair of stars that maximize pairwise distance.
def FarthestNeighbors(Number,StarList):
    ans = "hi"
    return ans

#Compute the star which minimizes the maximal distance to any other star.
def IdealHubStar(Number,StarList):
    ans = "hi"
    return ans

#Compute the star which maximizes the minimal distance to any other star.
def IdealJailStar(Number,StarList):
    ans = "hi"
    return ans

#Compute the star which minimizes the average distance to all other stars
def IdealCapitalStar(Number,StarList):
    ans = "hi"
    return ans


def ParseNumber(InputFile):
    number = InputFile.readline().strip()
    print "Number is " + number
    return number

#Parse Input
def ParseValues(InputFile):
    count = 0
    l = []
    for line in InputFile:
        #if count > 20:
        #   return l
        coordinates = line.strip().split(" ")
        #print coordinates
        l.append(coordinates)
        #count+=1
    print "StarList Length is " + str(len(l))
    return l

#Main Function
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("InputFile")
    args = parser.parse_args()

    InputFile = open(args.InputFile,'r')
    Number = ParseNumber(InputFile)
    StarList = ParseValues(InputFile)

    closest = ClosestNeighbors(Number,StarList)
    farthest = FarthestNeighbors(Number,StarList)
    iHub = IdealHubStar(Number,StarList)
    iJail = IdealJailStar(Number,StarList)
    iCapital = IdealCapitalStar(Number,StarList)

    print "d1 //minimal pairwise distance"
