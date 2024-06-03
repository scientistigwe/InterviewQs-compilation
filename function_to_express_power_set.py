#Create a function that generates the power set given a set of values.
#For example, if you're given the following set: 
#set = {1, 2, 3}
#Your function should the corresponding power set (note this can be a formatted as a list of lists):
#power set = [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

from itertools import chain, combinations

def powerset(iterable):
    # Convert the set to a list to work with itertools
    list_of_elements = list(iterable)
    # Generate all possible subsets by iterating over all lengths from 0 to len(list_of_elements)
    subsets = [list(subset) for subset in chain(*[combinations(list_of_elements, r) for r in range(len(list_of_elements) + 1)])]
    return subsets

# Example usage
set = {1, 2, 3}
result = powerset(set)
print(result)
