import csv

def getpoints():
    with open('points.csv', mode="r") as csv_file:
        reader = csv.reader(csv_file)

        a = []
        for item in reader:
            a.append(item)
        
    x_points, y_points = [[(int(i)+2600)*0.115 for i in a[0]],[(int(i)+2600)*0.115 for i in a[1]]]
    
    return x_points, y_points


