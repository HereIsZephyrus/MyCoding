import os
import json

def enumerate_files(folder_path):
    file_names = []
    for file_name in os.listdir(folder_path):
        if os.path.isfile(os.path.join(folder_path, file_name)):
            file_names.append(file_name)
    return file_names

folder_path = "./ParkGXML" 
with open('park_info.json', 'r') as file:
    json_data = file.read()

totalPark_json = json.loads(json_data)
totalPark = [f'{park["district"]}-{park["name"]}.xml' for park in totalPark_json]
existedPark = enumerate_files(folder_path)
untagPark = [park for park in totalPark if park not in existedPark]
filename = 'untag_park.txt'

with open(filename, 'w') as file:
    for park in untagPark:
        file.write(park[:-4] + '\n')