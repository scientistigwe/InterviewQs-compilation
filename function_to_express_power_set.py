#Create a function that generates the power set given a set of values.
#For example, if you're given the following set: 
#set = {1, 2, 3}
#Your function should the corresponding power set (note this can be a formatted as a list of lists):
#power set = [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

from itertools import chain, combinations

# Initialise variables
set = {1, 2, 3}
powerset = []

# Iterate and addpossible combinations of set to powerset list
for i in range(len(set) + 1):
    powerset.extend(combinations(set, i))

# Populate each combinations as a chained list
powerset_list = []
for subset in powerset:
    powerset_list.append(list(subset))

#Preview output
print(powerset_list) 
