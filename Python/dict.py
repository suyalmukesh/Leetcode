students = {
     'Alice':85,
     'Bob':92,
     'Charlie':75,
     'Diana':95,
     'Eve':88
     }

# create new dictinery of students scoring more then 90

result = {key:value for key,value in students.items() if value > 90 }

print(result)